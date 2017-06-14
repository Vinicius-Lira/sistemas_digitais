module MenRam(
    input CLOCK_50,
    input [2:0] KEY,
    output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B,
	output VGA_HS,
	output VGA_VS,
    output reg [7:0] LEDG,//leds
    output [7:0] LEDR,//leds
    output [17:0] SRAM_ADDR,//Endereço memoria onde vai ser gravado o SRAM_DQ
    inout [15:0] SRAM_DQ,//Valor a ser passado para a memoria
    output SRAM_WE_N,//Sinal para write(0)/read(1)
    output SRAM_OE_N,//Sinal Output enable
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_CE_N
);

//-----------------RAM--------------------------------
    //-------------WIRE's RAM-----------------------
        wire [7:0] output_leds;

    //-------------REG's RAM------------------------
        reg [3:0] state;

        reg [17:0] addr_reg;
        reg [23:0] data_reg;

        reg we;		  

    //---------------ASSIGN's RAM------------------
        assign output_leds[7:0] = SRAM_DQ[7:0];

        //assign SRAM_ADDR = addr_reg;
		  assign SRAM_ADDR = {x,y};
        assign SRAM_DQ = data_reg;

        assign LEDR[7:0] = output_leds[7:0];

        assign SRAM_WE_N = we;
        assign SRAM_OE_N = ~we;

        assign SRAM_UB_N = 0;
        assign SRAM_LB_N = 0;
        assign SRAM_CE_N = 0;

//----------------FIM RAM--------------------

//-----------------VGA-----------------------------
    //---------------WIRE's VGA--------------------
        wire [11:0] x;
        wire [11:0] y;

        wire [11:0] P1X = 100;
        wire [11:0] P1Y = 250;

        wire [11:0] P2X = 500;
        wire [11:0] P2Y = 250;

        wire [11:0] P3X = 500;
        wire [11:0] P3Y = 100;

        wire [11:0] PTX;
        wire [11:0] PTY;
		  
		  wire [11:0] pt_x = 470;
		  wire [11:0] pt_y = 185;

        wire InTriangle;

        wire visible;

    //------------------------------------------

    //-----------------REG's VGA-------------------
        reg [30:0] h_count = 0;
        reg [30:0] v_count = 0;

        reg [3:0] R = 4'hf;
        reg [3:0] G = 4'h0;
        reg [3:0] B = 4'h0;

    //-----------------------------------------

    //-------------ASSIGN's VGA-----------------
        //assign LEDG = 4'b1111;

        assign VGA_HS = ~(h_count < 190);
        assign VGA_VS = ~(v_count < 2);

        assign x = h_count - 285;
        assign y = v_count - 35;

        assign PTX = x;
        assign PTY = y;

        assign visible = (v_count > 35) & (v_count < 515) & (h_count > 285) & (h_count < 1505);
											
       /* assign VGA_R = visible ? (Triangle ? R : 4'hf) : 4'h0;
        assign VGA_G = visible ? (Triangle ? G : 4'hf) : 4'h0;
        assign VGA_B = visible ? (Triangle ? B : 4'hf) : 4'h0;*/
		   assign VGA_R = visible ? SRAM_DQ[3:0] : 4'h0;
        assign VGA_G = visible ? SRAM_DQ[7:4] : 4'h0;
        assign VGA_B = visible ? SRAM_DQ[11:8] : 4'h0;

//-----------------FIM VGA----------------------

//----------Outros REG's e WIRE's, ASSIGN---------------
    reg auxDesenha;
//----------------------------------------------


//Estacia de outros modulos
    //Calcula para desenhar o triangulo no VGA
    PointInTriangle pt( P1X, P1Y, P2X, P2Y, P3X, P3Y, PTX, PTY, InTriangle);

    //Calcula para achar se o ponto está no triangulo
    PointInTriangle PointPT( P1X, P1Y, P2X, P2Y, P3X, P3Y, pt_x, pt_y, PointTriangle);

//---------------------------------------

//--------------ALWAYS VGA------------------------
    always @(posedge CLOCK_50) begin
    	if(h_count == 1585) begin
        	h_count <= 0;
        	if(v_count == 525) begin
            	v_count <= 0;
        	end
        	else begin
            	v_count <= v_count + 1;
        	end
    	end
    	else begin
        	h_count <= h_count + 1;
    	end
    end
//--------FIM always VGA--------------------------

//-----------Always Memoria RAM-------------------
    always @(posedge CLOCK_50) begin

        if(auxDesenha) begin
				//Lê a memoria
				data_reg <= 12'hzzz;
				we <= 1;
        end
		  
		  if(~auxDesenha) begin
				//Escreve na memoria
				data_reg <= PointTriangle ? 12'hfff : 12'h000;
				if(PointTriangle) begin
					data_reg <= PointTriangle ? 12'hfff : 12'h000;
				end
				else begin
					data_reg <= InTriangle ? 12'h00f : 12'hff0;
				end
				we <= 0;
		  end
    end

    always @(KEY) begin
			//Bot~ao para desenhar o triangulo na tela
        if(~KEY[0]) begin
            auxDesenha <= 0;
				LEDG <= 4'ha;	
        end
		  //Bot~ao para apagar o triangulo da tela
		  if(~KEY[1]) begin
				auxDesenha <= 1;
				LEDG <= 4'b1100;
        end
    end
//--------------------------------------------------

endmodule



//Modulo para calculo do ponto do triangulo
module sing(
    input [11:0] PTX,
    input [11:0] PTY,

    input [11:0] P1X,
    input [11:0] P1Y,

    input [11:0] P2X,
    input [11:0] P2Y,

    output sin
);

    wire signed [11:0] Sub1;
    wire signed [11:0] Sub2;
    wire signed [11:0] Sub3;
    wire signed [11:0] Sub4;

    wire signed [22:0] Sub5;

    wire signed [22:0] Mult1;
    wire signed [22:0] Mult2;


    assign Sub1 = PTX - P2X;
    assign Sub2 = P1Y - P2Y;
    assign Sub3 = P1X - P2X;
    assign Sub4 = PTY - P2Y;

    assign Mult1 = Sub1 * Sub2;
    assign Mult2 = Sub3 * Sub4;

    assign Sub5 = Mult1 - Mult2;

    assign sin = (Sub5 >= 0) ? 1 : 0;

endmodule

module PointInTriangle(
    input [11:0] P1X,
    input [11:0] P1Y,

    input [11:0] P2X,
    input [11:0] P2Y,

    input [11:0] P3X,
    input [11:0] P3Y,

    input [11:0] PTX,
    input [11:0] PTY,

    output inTriangle
);
    wire sin1;
    wire sin2;
    wire sin3;

    sing S1(PTX, PTY, P1X, P1Y, P2X, P2Y, sin1);
    sing S2(PTX, PTY, P2X, P2Y, P3X, P3Y, sin2);
    sing S3(PTX, PTY, P3X, P3Y, P1X, P1Y, sin3);

    assign inTriangle = (sin1 == sin2 && sin2 == sin3) ? 1 : 0;

endmodule
