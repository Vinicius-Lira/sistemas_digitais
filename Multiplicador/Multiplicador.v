module Multiplicador(
	input CLOCK_50,
    input [9:0] SW,
    output [7:0] LEDG,
    output [7:0] LEDR
);

    reg i = 5;
    reg deslocamento = 0;
    reg [9:0] aux;
    reg [10:0] result;
    reg [9:0] Cout;

	assign LEDG[7:0] = result[7:0];
	assign LEDR[2:0] = result[10:8];

    always @(CLOCK_50) begin

		while(i < 10) begin
			//Multiplica com todos
			aux <= SW[i] & {SW[0], SW[1], SW[2], SW[3], SW[4]};

			aux <= aux << deslocamento;

			result[0] <= aux[0] ^ result[0];
			Cout[0] <= aux[0] & result[0];

			result[1] <= (aux[1] ^ result[1]) ^ Cout[0];
			Cout[1] <= (((aux[1] ^ result[1]) & Cout[0]) ^ (aux[1] & result[1]));

			result[2] <= (aux[2] ^ result[2]) ^ Cout[1];
			Cout[2] <= (((aux[1] ^ result[2]) & Cout[1]) ^ (aux[2] & result[2]));

			result[3] <= (aux[3] ^ result[3]) ^ Cout[2];
			Cout[3] <= (((aux[3] ^ result[3]) & Cout[2]) ^ (aux[3] & result[3]));

			result[4] <= (aux[4] ^ result[4]) ^ Cout[3];
			Cout[4] <= (((aux[4] ^ result[4]) & Cout[3]) ^ (aux[4] & result[4]));

			result[5] <= (aux[5] ^ result[5]) ^ Cout[4];
			Cout[5] <= (((aux[5] ^ result[5]) & Cout[4]) ^ (aux[5] & result[5]));

			result[6] <= (aux[6] ^ result[6]) ^ Cout[5];
			Cout[6] <= (((aux[6] ^ result[6]) & Cout[5]) ^ (aux[6] & result[6]));

			result[7] <= (aux[7] ^ result[7]) ^ Cout[6];
			Cout[7] <= (((aux[7] ^ result[7]) & Cout[6]) ^ (aux[7] & result[7]));

			result[8] <= (aux[8] ^ result[8]) ^ Cout[7];
			Cout[8] <= (((aux[8] ^ result[8]) & Cout[7]) ^ (aux[8] & result[8]));

			result[9] <= (aux[9] ^ result[9]) ^ Cout[8];
			Cout[9] <= (((aux[9] ^ result[9]) & Cout[8]) ^ (aux[9] & result[9]));

			deslocamento <= deslocamento + 1;
			i = i + 1;
		end

    end

endmodule

module test;
	reg CLOCK_50;

	reg [9:0] SW;

	wire [7:0] LEDG;
	wire [7:0] LEDR;

	Multiplicador M(CLOCL_50, SW, LEDG, LEDR);

	initial begin
		$dumpvars(0, M);

		#1 CLOCK_50 <= 0;
		#1 CLOCK_50 <= 1;
		#1 CLOCK_50 <= 0;
		#1 CLOCK_50 <= 1;
		#1 CLOCK_50 <= 0;
		#1 CLOCK_50 <= 1;
		#1 CLOCK_50 <= 0;
		#1 CLOCK_50 <= 1;
		#1 CLOCK_50 <= 0;
		#1 CLOCK_50 <= 1;

		$finish;
	end

endmodule
