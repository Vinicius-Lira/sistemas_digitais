module Multilpicador(
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
		
		wire [9:0] Cout1;
		wire [9:0] Cout2;
		wire [9:0] Cout3;
		wire [9:0] Cout4;

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
		
		assign aux1[0] = linha1[0];
		meioSomador l1_l2_1(linha1[1], linha2[0],Cout1[0], aux1[1]);
		somadorCompleto l1_l2_2(linha1[2], linha2[1],Cout1[0], Cout1[1], aux1[2]);
		somadorCompleto l1_l2_3(linha1[3], linha2[2],Cout1[1], Cout1[2], aux1[3]);
		somadorCompleto l1_l2_4(linha1[4], linha2[3],Cout1[2], Cout1[3], aux1[4]);
		somadorCompleto l1_l2_5(linha1[5], linha2[4],Cout1[3], Cout1[4], aux1[5]);
		assign aux1[6] = Cout1[4];
		
		assign aux2[0] = aux1[0];
		assign aux2[1] = aux1[1];
		meioSomador aux3_l3_1(aux1[2], linha3[1],Cout2[0], aux2[3]);
		somadorCompleto aux2_l3_2(aux1[3], linha3[2],Cout2[0], Cout2[1], aux2[4]);
		somadorCompleto aux2_l3_3(aux1[4], linha3[3],Cout2[1], Cout2[2], aux2[5]);
		somadorCompleto aux2_l3_4(aux1[5], linha3[4],Cout2[2], Cout2[3], aux2[6]);
		assign aux2[7] = Cout2[3];
		
endmodule

module meioSomador(
    input a,
    input b,
    output Cout,
    output S
);
    assign S = a ^ b;
    assign Cout = a & b;
endmodule

module somadorCompleto(
    input a,
    input b,
    input Cin,
    output Cout,
    output S
);
    assign S = (a ^ b) ^ Cin;
    assign Cout = (((a ^ b) & Cin) ^ (a & b));

endmodule
