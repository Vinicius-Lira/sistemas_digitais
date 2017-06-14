module MenRam(
    input CLOCK_50,
    input BTN_DESENHA,
    output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B,
	output VGA_HS,
	output VGA_VS,
    output [7:0] LEDG,//leds
    output [7:0] LEDR,//leds
    output [17:0] SRAM_ADDR,//Endereço memoria onde vai ser gravado o SRAM_DQ
    inout [21:0] SRAM_DQ,//Valor a ser passado para a memoria
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

        //Reg que conta o numero de pontos no triangulo
        reg [17:0] count = 15;

    //---------------ASSIGN's RAM------------------
        assign output_leds[7:0] = SRAM_DQ[7:0];

        assign SRAM_ADDR = addr_reg;
        assign SRAM_DQ = data_reg;

        assign LEDR[7:0] = output_leds[7:0];

        assign SRAM_WE_N = we;
        assign SRAM_OE_N = 1;

        assign SRAM_UB_N = 0;
        assign SRAM_LB_N = 0;
        assign SRAM_CE_N = 0;

//----------------FIM RAM--------------------

//-----------------VGA-----------------------------
    //---------------WIRE's VGA--------------------
        wire [11:0] x;
        wire [11:0] y;

        wire [11:0] P1X = 200;
        wire [11:0] P1Y = 100;

        wire [11:0] P2X = 500;
        wire [11:0] P2Y = 300;

        wire [11:0] P3X = 500;
        wire [11:0] P3Y = 100;

        wire [11:0] PTX;
        wire [11:0] PTY;

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
        assign LEDG = 4'b1111;

        assign VGA_HS = ~(h_count < 190);
        assign VGA_VS = ~(v_count < 2);

        assign x = h_count - 285;
        assign y = v_count - 35;

        assign PTX = x;
        assign PTY = y;

        assign visible = (v_count > 35) & (v_count < 515) & (h_count > 285) & (h_count < 1505);

        assign VGA_R = visible ? (Triangle ? R : 4'hf) : 4'hf;
        assign VGA_G = visible ? (Triangle ? G : 4'hf) : 4'hf;
        assign VGA_B = visible ? (Triangle ? B : 4'hf) : 4'hf;

//-----------------FIM VGA----------------------

//----------------REG's Ponto no Triangulo------
        reg PointTriagle;
//----------------------------------------------

//----------------WIRE's Ponto no Triangulo------
        reg [11:0] ptx = 430;
        reg [11:0] pty = 175;

//----------------------------------------------

//----------Outros REG's e WIRE's, ASSIGN---------------
    reg auxDesenha;

    reg auxTela;

    reg [17:0] countAux = 15;

    wire [11:0] readX;
    wire [11:0] readY;

    assign readX = SRAM_DQ[11:0];
    assign readY = SRAM_DQ[23:12];

    wire Triangle;

    assign Triangle = (readX == x) & (readY == y);
//----------------------------------------------


//Estacia de outros modulos
    //Calcula para desenhar o triangulo no VGA
    PointInTriangle pt( P1X, P1Y, P2X, P2Y, P3X, P3Y, PTX, PTY, InTriangle);

    //Calcula para achar se o ponto está no triangulo
    PointInTriangle PointPT( P1X, P1Y, P2X, P2Y, P3X, P3Y, ptx, pty, PointTriangle);

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
            addr_reg <= countAux;
            data_reg = 22'bzzzzzzzzzzzzzzzzzzzzzz;
            we <= 1;
            if(countAux <= count) begin
                countAux <= countAux + 1;
            end
        end
        else begin
            if(InTriangle) begin
                addr_reg <= count;
                data_reg[11:0] <= x;
                data_reg[23:12] <= y;
                we <= 0;
                count <= count + 1;
            end
        end

    end

    always @(*) begin
        if(BTN_DESENHA & auxTela) begin
            auxDesenha <= 1;
        end
        else begin
            auxDesenha <= 0;
        end
    end
//--------------------------------------------------

    always @ (*) begin
        if((x == 1220) & (y == 480)) begin
            auxTela <= 1;
        end
        else begin
            auxTela <= 0;
        end
    end

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
