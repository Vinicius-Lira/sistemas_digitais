module PointTriangle(
    input CLOCK_50,

    input [10:0] PointPx,
    input [10:0] PointPy,

    input [10:0] PointAx,
    input [10:0] PointAy,

    input [10:0] PointBx,
    input [10:0] PointBy,

    input [10:0] PointCx,
    input [10:0] PointCy

);

    reg [10:0] x;
    reg [10:0] y;

    reg enable;

    wire inTriangle;

    reg auxLeftX = 0;
    reg auxRigth = 0;
    reg auxTopY = 0;

    reg [21:0] PointX;
	reg [8:0] PointTopY;

    reg [17:0] addr_in;//endereço na memoria
    wire [30:0] data_in;//dado entrada
    wire [30:0] data;
    wire [17:0] addr;
    wire we = 0;
    wire oe = 1;
    wire ub = 0;
    wire lb = 0;
    wire ce = 0;
    wire [7:0] ledg;
    wire [7:0] ledr;

    //Ativa e desativa o a captura das coordenadas do triangulo
    reg auxMen = 1;

    reg clk = 0;

    reg grava;//Auxiliar para a gravação dos pontos na memoria quando quebra a linha horizontal
    reg existPoint; //Se existir pontos na linha horizontal é igual 1


    //PointInTriangle ponto(PointAx, PointAy, PointBx, PointBy, PointCx, PointCy, PointPx, PointPy, inTriangle);

    PointInTriangle triangle(PointAx, PointAy, PointBx, PointBy, PointCx, PointCy, x, y, inTriangle);

    //Grava na memoria
    MemoriaRAM Men(clk, addr_in, data_in, addr, data, we, oe, ub, lb, ce, ledg, ledr);

    assign data_in[10:0] = PointX[10:0];
    assign data_in[21:11] = PointX[21:11];
    assign data_in[30:22] = PointTopY[8:0];

    always @(*) begin
        while(enable) begin
            if(auxMen) begin
                if(inTriangle) begin
                    existPoint <= 1;
                    if(auxLeftX == 0) begin
                        PointX[10:0] <= x;
                        auxLeftX <= 1;
                    end
                    else begin
                        PointX[21:11] <= x;
                    end

                    if(auxTopY == 0) begin
                        PointTopY[8:0] <= y;
                        auxTopY <= 1;
                    end
                end
                else begin
                    existPoint <= 0;
                end

                if(x == 1505) begin
                    x <= 0;
                    auxLeftX <= 0;
                    //Quando x chegar em 1505 grava os pontos left e rigth do x do triangulo
                    grava <= 1;
                    if(y == 480) begin
                        y <= 0;
                        enable <= 0;
                    end
                    else begin
                        y <= y + 1;
                    end
                end
                else begin
                    x <= x + 1;
                    grava <= 0;
                end

                //Fim auxMen
            end
        //Fim while
        end
    //Fim always
    end

    always @(posedge CLOCK_50) begin
        if(grava && existPoint) begin
            auxMen <=0;
            clk <= 1;
            clk <= 0;
            clk <= 1;
            clk <= 0;
            auxMen <= 1;
        end
    end

endmodule


module MemoriaRAM(
    CLOCK_50,
    ADDR_IN, //Entrada para o endereço memoria
    DATA_IN, //Dado de entrada
    ADDR,//Endereço memoria onde vai ser gravado o SRAM_DQ
    DATA,//Valor a ser passado para a memoria
    WE,//Write Enable(0)/ Read Enable(1)
    OE,//Output Enable
    UB,
    LB,
    CE,
    LEDG,//leds
    LEDR//leds
);
    //------------Declaração Portas-------------
        //----------------Entradas------------------
        input CLOCK_50;
        input [17:0] ADDR_IN;
        input [30:0] DATA_IN;
        //------------Portas inout-----------------
        inout [30:0] DATA;
        //------------------Saidas------------------
        output [17:0] ADDR;
        output WE;
        output OE;
        output UB;
        output LB;
        output CE;
        output [7:0] LEDG;//leds
        output [7:0] LEDR;//leds

    //-------------Variaveis internas-----------
	wire [15:0] output_leds;

    reg [3:0] state;

    reg [15:0] data_reg;

    reg we, oe;

    //--------------Assign------------------------
	assign LEDR[7:0] = output_leds[7:0];
	assign LEDG[7:0] = output_leds[7:0];

	assign output_leds = DATA;

	assign CE = 0;

	assign ADDR = ADDR_IN;

	assign WE = we;
	assign OE = oe;
	assign UB = 0;
	assign LB = 0;

    //-----------------Always---------------------

	always @(posedge CLOCK_50) begin

		case (state)
			0: begin
				state <= 1;
				data_reg <= DATA_IN;
				we <= 0;
				oe <= 1;
			end
			1: begin
				state <= 2;
				data_reg <= 16'bzzzzzzzzzzzzzzzz;
				we <= 0;
				oe <= 1;
			end
		endcase

	end

endmodule



module sing(
    input [10:0] PTX,
    input [10:0] PTY,

    input [10:0] P1X,
    input [10:0] P1Y,

    input [10:0] P2X,
    input [10:0] P2Y,

    output sin
);

    wire signed [10:0] Sub1;
    wire signed [10:0] Sub2;
    wire signed [10:0] Sub3;
    wire signed [10:0] Sub4;

    wire signed [21:0] Sub5;

    wire signed [21:0] Mult1;
    wire signed [21:0] Mult2;


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
    input [10:0] P1X,
    input [10:0] P1Y,

    input [10:0] P2X,
    input [10:0] P2Y,

    input [10:0] P3X,
    input [10:0] P3Y,

    input [10:0] PTX,
    input [10:0] PTY,

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
