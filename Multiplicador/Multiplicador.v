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
		meioSomador aux3_l3_1(aux1[1], linha3[1],Cout2[0], aux2[1]);
		somadorCompleto aux2_l3_2(aux1[2], linha3[2],Cout2[0], Cout2[1], aux2[2]);
		somadorCompleto aux2_l3_3(aux1[3], linha3[3],Cout2[1], Cout2[2], aux2[3]);
		somadorCompleto aux2_l4_4(aux1[4], linha3[4],Cout2[2], Cout2[3], aux2[4]);
		somadorCompleto aux2_l5_5(aux1[5], linha3[5],Cout2[3], Cout2[4], aux2[5]);
		somadorCompleto aux2_l6_6(aux1[6], linha3[6],Cout2[4], Cout2[5], aux2[6]);
		somadorCompleto aux2_l7_7(aux1[7], linha3[7],Cout2[5], Cout2[6], aux2[7]);
		assign aux2[8] = Cout2[6];
		
		assign aux3[0] = aux2[0];
		meioSomador aux3_l4_1(aux2[1], linha4[1],Cout3[0], aux3[1]);
		somadorCompleto aux3_l4_2(aux2[2], linha4[2],Cout3[0], Cout3[1], aux3[2]);
		somadorCompleto aux3_l4_3(aux2[3], linha4[3],Cout3[1], Cout3[2], aux3[3]);
		somadorCompleto aux3_l4_4(aux2[4], linha4[4],Cout3[2], Cout3[3], aux3[4]);
		somadorCompleto aux3_l4_5(aux2[5], linha4[5],Cout3[3], Cout3[4], aux3[5]);
		somadorCompleto aux3_l4_6(aux2[6], linha4[6],Cout3[4], Cout3[5], aux3[6]);
		somadorCompleto aux3_l4_7(aux2[7], linha4[7],Cout3[5], Cout3[6], aux3[7]);
		assign aux3[8] = Cout3[6];
		
		assign S[0] = aux3[0];
		meioSomador S_l5_1(aux3[1], linha5[1],Cout4[0], S[1]);
		somadorCompleto S_l5_2(aux3[2], linha5[2],Cout4[0], Cout4[1], S[2]);
		somadorCompleto S_l5_3(aux3[3], linha5[3],Cout4[1], Cout4[2], S[3]);
		somadorCompleto S_l5_4(aux3[4], linha5[4],Cout4[2], Cout4[3], S[4]);
		somadorCompleto S_l5_5(aux3[5], linha5[5],Cout4[3], Cout4[4], S[5]);
		somadorCompleto S_l5_6(aux3[6], linha5[6],Cout4[4], Cout4[5], S[6]);
		somadorCompleto S_l5_7(aux3[7], linha5[7],Cout4[5], Cout4[6], S[7]);
		somadorCompleto S_l5_8(aux3[8], linha5[8],Cout4[6], Cout4[7], S[8]);
		assign S[9] = Cout4[7];
		
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
