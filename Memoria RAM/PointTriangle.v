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

    reg enable = 1;

    wire inTriangle;

    PointInTriangle in(PointAx, PointAy, PointBx, PointBy, PointCx, PointCy, PointPx, PointPy, inTriangle);

    reg auxLeftX = 0;
    reg auxRigth = 0;
    reg auxTopY = 0;

    reg [21:0] PointX;
	reg [8:0] PointTopY;

    always @(*) begin
        while(enable) begin
            if(inTriangle) begin
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

            if(x == 1505) begin
                x <= 0;
                auxLeftX <= 0;

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
            end
        //Fim while
        end
    //Fim always
    end

endmodule

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

module MemoriaRAM(
    input CLOCK_50,
    output [7:0] LEDG,//leds
    output [7:0] LEDR,//leds
    output [17:0] SRAM_ADDR,//Endereço memoria onde vai ser gravado o SRAM_DQ
    inout [15:0] SRAM_DQ,//Valor a ser passado para a memoria
    output SRAM_WE_N,//Sinal para gravar na memoria (write)
    output SRAM_OE_N,//Sinal para ler a memoria(read)
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_CE_N
);

	wire [15:0] output_leds;

	assign LEDR[7:0] = output_leds[7:0];
	assign LEDG[7:0] = output_leds[7:0];

	assign output_leds = SRAM_DQ;
	
	assign SRAM_CE_N = 0;

	reg [3:0] state;


	reg [17:0] addr_reg;
	reg [15:0] data_reg;

	assign SRAM_ADDR = addr_reg;
	assign SRAM_DQ = data_reg;


	reg we, oe, ub, lb; //, ce;

	assign SRAM_WE_N = we;
	assign SRAM_OE_N = oe;
	assign SRAM_UB_N = ub;
	assign SRAM_LB_N = lb;


	always @(posedge CLOCK_50) begin

		case (state)
			0: begin
				state <= 1;
				addr_reg <= 13;
				data_reg <= 2;
				we <= 0;
				oe <= 1;
				ub <= 0;
				lb <= 0;
			end
			2: begin
				state <= 0;
				addr_reg <= 13;
				data_reg <= 16'bzzzzzzzzzzzzzzzz;
				we <= 0;
				oe <= 1;
				ub <= 0;
				lb <= 0;
			end
		endcase

	end

endmodule
