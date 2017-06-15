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

        //Ponto 1
        wire [11:0] P1X1 = 440;
        wire [11:0] P1Y1 = 60;

        wire [11:0] P2X1 = 440;
        wire [11:0] P2Y1 = 140;

        wire [11:0] P3X1 = 520;
        wire [11:0] P3Y1 = 140;

        wire [11:0] PTX;
        wire [11:0] PTY;

        //Ponto 2
		wire [11:0] P1X2 = 440;
        wire [11:0] P1Y2 = 140;

        wire [11:0] P2X2 = 520;
        wire [11:0] P2Y2 = 140;

        wire [11:0] P3X2 = 520;
        wire [11:0] P3Y2 = 220;

        //Ponto 3
        wire [11:0] P1X3 = 520;
        wire [11:0] P1Y3 = 220;

        wire [11:0] P2X3 = 690;
        wire [11:0] P2Y3 = 220;

        wire [11:0] P3X3 = 690;
        wire [11:0] P3Y3 = 400;

        //Ponto 4
        wire [11:0] P1X4 = 690;
        wire [11:0] P1Y4 = 220;

        wire [11:0] P2X4 = 690;
        wire [11:0] P2Y4 = 350;

        wire [11:0] P3X4 = 818;
        wire [11:0] P3Y4 = 350;

        //Ponto 5
        wire [11:0] P1X5 = 690;
        wire [11:0] P1Y5 = 220;

        wire [11:0] P2X5 = 870;
        wire [11:0] P2Y5 = 220;

        wire [11:0] P3X5 = 870;
        wire [11:0] P3Y5 = 400;

        //Ponto 6
        wire [11:0] P1X6 = 870;
        wire [11:0] P1Y6 = 220;

        wire [11:0] P2X6 = 1094;
        wire [11:0] P2Y6 = 220;

        wire [11:0] P3X6 = 982;
        wire [11:0] P3Y6 = 125;

        //Ponto 7
        wire [11:0] P1X7 = 870;
        wire [11:0] P1Y7 = 220;

        wire [11:0] P2X7 = 870;
        wire [11:0] P2Y7 = 55;

        wire [11:0] P3X7 = 982;
        wire [11:0] P3Y7 = 125;

        //Ponto 8
        wire [11:0] P1X8 = 982;
        wire [11:0] P1Y8 = 125;

        wire [11:0] P2X8 = 1094;
        wire [11:0] P2Y8 = 55;

        wire [11:0] P3X8 = 1094;
        wire [11:0] P3Y8 = 220;

        //Ponto 9
        wire [11:0] P1X9 = 870;
        wire [11:0] P1Y9 = 220;

        wire [11:0] P2X9 = 982;
        wire [11:0] P2Y9 = 125;

        wire [11:0] P3X9 = 1094;
        wire [11:0] P3Y9 = 220;

        wire InTriangle;

        wire visible;

    //------------------------------------------

    //-----------------REG's VGA-------------------
        reg [30:0] h_count = 0;
        reg [30:0] v_count = 0;

    //-----------------------------------------

    //-------------ASSIGN's VGA-----------------
        assign VGA_HS = ~(h_count < 190);
        assign VGA_VS = ~(v_count < 2);

        assign x = h_count - 285;
        assign y = v_count - 35;

        assign PTX = x;
        assign PTY = y;

        assign visible = (v_count > 35) & (v_count < 515) & (h_count > 285) & (h_count < 1505);

	    assign VGA_R = visible ? SRAM_DQ[3:0] : 4'h0;
        assign VGA_G = visible ? SRAM_DQ[7:4] : 4'h0;
        assign VGA_B = visible ? SRAM_DQ[11:8] : 4'h0;

//-----------------FIM VGA----------------------

//----------Outros REG's e WIRE's, ASSIGN---------------
        reg auxDesenha;

        wire T1, T2, T3, T4, T5, T6, T7, T8, T9;
//----------------------------------------------


        assign InTriangle = T1 | T2 | T3 | T4 | T5 | T6 | T7 | T8 | T9;


//Estacia de outros modulos
        //Calcula para desenhar o triangulo no VGA
        PointInTriangle pt1( P1X1, P1Y1, P2X1, P2Y1, P3X1, P3Y1, PTX, PTY, T1);
	    PointInTriangle pt2( P1X2, P1Y2, P2X2, P2Y2, P3X2, P3Y2, PTX, PTY, T2);
	    PointInTriangle pt3( P1X3, P1Y3, P2X3, P2Y3, P3X3, P3Y3, PTX, PTY, T3);
	    PointInTriangle pt4( P1X4, P1Y4, P2X4, P2Y4, P3X4, P3Y4, PTX, PTY, T4);
	    PointInTriangle pt5( P1X5, P1Y5, P2X5, P2Y5, P3X5, P3Y5, PTX, PTY, T5);
	    PointInTriangle pt6( P1X6, P1Y6, P2X6, P2Y6, P3X6, P3Y6, PTX, PTY, T6);
        PointInTriangle pt7( P1X7, P1Y7, P2X7, P2Y7, P3X7, P3Y7, PTX, PTY, T7);
        PointInTriangle pt8( P1X8, P1Y8, P2X8, P2Y8, P3X8, P3Y8, PTX, PTY, T8);
        PointInTriangle pt9( P1X9, P1Y9, P2X9, P2Y9, P3X9, P3Y9, PTX, PTY, T9);

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
				data_reg <= InTriangle ? 12'h00f : 12'hff0;
				we <= 0;
		  end
    end

    always @(KEY) begin
			//Botão para desenhar o triangulo na tela
        if(~KEY[0]) begin
            auxDesenha <= 0;
				LEDG <= 4'ha;
        end
		  //Botão para apagar o triangulo da tela
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
