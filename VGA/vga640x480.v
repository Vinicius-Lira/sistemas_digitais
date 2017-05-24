`timescale 1ns / 1ps

module vga640x480(
	input wire dclk,	//pixel clock: 25MHz
	input wire clr,		//asynchronous reset
	output wire hsync,	//horizontal sync out
	output wire vsync,	//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [1:0] blue	//blue vga output
);

// video structure constants
parameter hpixels = 800;// horizontal pixels per line
parameter vlines = 521; // vertical lines per frame
parameter hpulse = 96; 	//comprimento do pulso hsync
parameter vpulse = 2; 	//comprimento do pulso vsync
parameter hbp = 144; 	// fim horizontal, costas varanda
parameter hfp = 784; 	//Inicio da varanda frontal horizontal
parameter vbp = 31; 	// Fim vertical, costas, varanda
parameter vfp = 511; 	// Inicio da varanda frontal vertical
// Vídeo horizontal ativo é, portanto: 784 - 144 = 640
// Vídeo vertical ativo é, portanto: 511 - 31 = 480

//Registradores para armazenar os contadores horizontais e verticais
reg [9:0] hc;
reg [9:0] vc;

//Contadores horizontais e verticais
// Esta é a forma como manter o controle de onde estamos na tela.
// ------------------------
// Seqüencial "always block", que é um bloco que é
// apenas acionado em transições de sinal ou "bordas".
// Posedge = borda ascendente & negedge = borda descendente
// As instruções de atribuição só podem ser usadas no tipo "reg" e precisam ser do tipo "não bloqueador": <=

always @(posedge dclk or posedge clr) begin
	// reseta contador horizontal e vertical
	if (clr == 1) begin
		hc <= 0;
		vc <= 0;
	end
	else begin
		// Continue contando até o final da linha
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// Quando atingimos a extremidade da linha, restabelece a posição horizontal
		// counter e incrementar o contador vertical.
		// Se o contador vertical estiver no final do frame, então
		// reset que um também.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end

	end
end


// geram pulsos de sincronização (baixa ativa)
// ----------------
// "assign" declarações são uma maneira rápida de
// dá valores a variáveis ​​de tipo: wire
assign hsync = (hc < hpulse) ? 0:1;
assign vsync = (vc < vpulse) ? 0:1;

// exibir barras de cores de saturação de 100%
// ------------------------
// Combinacional "always block", que é um bloco que é
// disparado quando algo na "lista de sensibilidade" muda.
// O asterisco implica que tudo o que é capaz de acionar o bloco
// é automaticamente incluído na lista de sensibilidade. Neste caso, seria
// equivalente ao seguinte: always @ (hc, vc)
// As instruções de atribuição só podem ser usadas no tipo "reg" e devem ser do tipo "bloqueio": =
always @(*) begin
	// primeiro verifique se estamos dentro do intervalo de vídeo ativo vertical
	if (vc >= vbp && vc < vfp) begin
		// agora exibem cores diferentes a cada 80 pixels
		// enquanto estamos dentro da faixa horizontal ativa
		// -----------------
		// exibir barra branca
		if (hc >= hbp && hc < (hbp+80)) begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b11;
		end

		// exibir barra amarela
		else if (hc >= (hbp+80) && hc < (hbp+160)) begin
			red = 3'b111;
			green = 3'b111;
			blue = 2'b00;
		end
		// display cyan bar
		else if (hc >= (hbp+160) && hc < (hbp+240)) begin
			red = 3'b000;
			green = 3'b111;
			blue = 2'b11;
		end
		// display green bar
		else if (hc >= (hbp+240) && hc < (hbp+320)) begin
			red = 3'b000;
			green = 3'b111;
			blue = 2'b00;
		end
		// display magenta bar
		else if (hc >= (hbp+320) && hc < (hbp+400)) begin
			red = 3'b111;
			green = 3'b000;
			blue = 2'b11;
		end
		// display red bar
		else if (hc >= (hbp+400) && hc < (hbp+480)) begin
			red = 3'b111;
			green = 3'b000;
			blue = 2'b00;
		end
		// display blue bar
		else if (hc >= (hbp+480) && hc < (hbp+560)) begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b11;
		end
		// display black bar
		else if (hc >= (hbp+560) && hc < (hbp+640)) begin
			red = 3'b000;
			green = 3'b000;
			blue = 2'b00;
		end
		// estamos fora da faixa horizontal ativa para exibir preto
		else begin
			red = 0;
			green = 0;
			blue = 0;
		end
	end
	// estamos fora da faixa vertical ativa para exibir preto
	else begin
		red = 0;
		green = 0;
		blue = 0;
	end
end

endmodule
