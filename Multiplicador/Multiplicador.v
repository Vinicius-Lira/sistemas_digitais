module Multiplicador(
	 input CLOCK_50,
    input [9:0] SW,
    output [7:0] LEDG,
    output [7:0] LEDR
);

    reg [9:0] S;
	
	//mult m(CLOCK_50, SW[4:0], SW[9:5], S);
	
	//assign LEDG[7:0] = S[7:0];
	assign LEDG[7:0] = 1 & 1;
	assign LEDR[1:0] = S[9:8];

endmodule

module mult(
	input enable,
	input [4:0] A,
	input [4:0] B,
	output [9:0] resultado
);
	reg i = 5;
   reg deslocamento = 0;
	
	reg [9:0] aux;
	wire [9:0] r;
	
	assign resultado = r;
	
	somador soma10bits( r, aux, r);
	
	always @(posedge enable) begin
		if(i < 10) begin
		
			aux <= B[i] & {A[0], A[1], A[2], A[3], A[4]};

			aux <= aux << deslocamento;
			
			deslocamento = deslocamento + 1;
			i = i + 1;
			
		end

    end
	
endmodule


module somador(
	input [9:0] result,
	input [9:0] aux,
	output [9:0] S
);
		wire [8:0] Cout;
		
		assign S[0] = aux[0] ^ result[0];
		assign Cout[0] = aux[0] & result[0];

		assign S[1] = (aux[1] ^ result[1]) ^ Cout[0];
		assign Cout[1] = (((aux[1] ^ result[1]) & Cout[0]) ^ (aux[1] & result[1]));

		assign S[2] = (aux[2] ^ result[2]) ^ Cout[1];
		assign Cout[2] = (((aux[1] ^ result[2]) & Cout[1]) ^ (aux[2] & result[2]));

		assign S[3] = (aux[3] ^ result[3]) ^ Cout[2];
		assign Cout[3] = (((aux[3] ^ result[3]) & Cout[2]) ^ (aux[3] & result[3]));

		assign S[4] = (aux[4] ^ result[4]) ^ Cout[3];
		assign Cout[4] = (((aux[4] ^ result[4]) & Cout[3]) ^ (aux[4] & result[4]));

		assign S[5] = (aux[5] ^ result[5]) ^ Cout[4];
		assign Cout[5] = (((aux[5] ^ result[5]) & Cout[4]) ^ (aux[5] & result[5]));

		assign S[6] = (aux[6] ^ result[6]) ^ Cout[5];
		assign Cout[6] = (((aux[6] ^ result[6]) & Cout[5]) ^ (aux[6] & result[6]));

		assign S[7] = (aux[7] ^ result[7]) ^ Cout[6];
		assign Cout[7] = (((aux[7] ^ result[7]) & Cout[6]) ^ (aux[7] & result[7]));

		assign S[8] = (aux[8] ^ result[8]) ^ Cout[7];
		assign Cout[8] = (((aux[8] ^ result[8]) & Cout[7]) ^ (aux[8] & result[8]));

		assign S[9] = Cout[8];
	
endmodule
