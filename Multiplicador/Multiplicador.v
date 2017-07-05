module Multiplicador(
    input [9:0] SW,
    output [7:0] LEDG,
    output [7:0] LEDR
);

		wire [9:0] aux1;
		wire [9:0] aux2;
		wire [9:0] aux3;

		wire [9:0] S;

		assign LEDG[7:0] = S[7:0];
		assign LEDR[1:0] = S[9:8];

		wire [9:0] linha1;
		wire [9:0] linha2;
		wire [9:0] linha3;
		wire [9:0] linha4;
		wire [9:0] linha5;

		assign linha1[0] = SW[0] & SW[5];
		assign linha1[1] = SW[1] & SW[5];
		assign linha1[2] = SW[2] & SW[5];
		assign linha1[3] = SW[3] & SW[5];
		assign linha1[4] = SW[4] & SW[5];

		assign linha2[0] = SW[0] & SW[6];
		assign linha2[1] = SW[1] & SW[6];
		assign linha2[2] = SW[2] & SW[6];
		assign linha2[3] = SW[3] & SW[6];
		assign linha2[4] = SW[4] & SW[6];

		assign linha3[0] = SW[0] & SW[7];
		assign linha3[1] = SW[1] & SW[7];
		assign linha3[2] = SW[2] & SW[7];
		assign linha3[3] = SW[3] & SW[7];
		assign linha3[4] = SW[4] & SW[7];

		assign linha4[0] = SW[0] & SW[8];
		assign linha4[1] = SW[1] & SW[8];
		assign linha4[2] = SW[2] & SW[8];
		assign linha4[3] = SW[3] & SW[8];
		assign linha4[4] = SW[4] & SW[8];

		assign linha5[0] = SW[0] & SW[9];
		assign linha5[1] = SW[1] & SW[9];
		assign linha5[2] = SW[2] & SW[9];
		assign linha5[3] = SW[3] & SW[9];
		assign linha5[4] = SW[4] & SW[9];

		somador S1(linha1, linha2, aux1);
		somador S2(linha3, linha4, aux2);
		somador S3(aux1, aux2, aux3);
		somador S4(aux3, linha5, S);

endmodule


module somador(
	input [9:0] A,
	input [9:0] B,
	output [9:0] S
);
		wire [8:0] Cout;

		assign S[0] = B[0] ^ A[0];
		assign Cout[0] = B[0] & A[0];

		assign S[1] = (B[1] ^ A[1]) ^ Cout[0];
		assign Cout[1] = (((B[1] ^ A[1]) & Cout[0]) ^ (B[1] & A[1]));

		assign S[2] = (B[2] ^ A[2]) ^ Cout[1];
		assign Cout[2] = (((B[1] ^ A[2]) & Cout[1]) ^ (B[2] & A[2]));

		assign S[3] = (B[3] ^ A[3]) ^ Cout[2];
		assign Cout[3] = (((B[3] ^ A[3]) & Cout[2]) ^ (B[3] & A[3]));

		assign S[4] = (B[4] ^ A[4]) ^ Cout[3];
		assign Cout[4] = (((B[4] ^ A[4]) & Cout[3]) ^ (B[4] & A[4]));

		assign S[5] = (B[5] ^ A[5]) ^ Cout[4];
		assign Cout[5] = (((B[5] ^ A[5]) & Cout[4]) ^ (B[5] & A[5]));

		assign S[6] = (B[6] ^ A[6]) ^ Cout[5];
		assign Cout[6] = (((B[6] ^ A[6]) & Cout[5]) ^ (B[6] & A[6]));

		assign S[7] = (B[7] ^ A[7]) ^ Cout[6];
		assign Cout[7] = (((B[7] ^ A[7]) & Cout[6]) ^ (B[7] & A[7]));

		assign S[8] = (B[8] ^ A[8]) ^ Cout[7];
		assign Cout[8] = (((B[8] ^ A[8]) & Cout[7]) ^ (B[8] & A[8]));

		assign S[9] = Cout[8];

endmodule
