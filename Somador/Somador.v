module Somador(
    input [9:0] SW,
    input [2:0] KEY,
    output [5:0] LEDR
);
    wire [4:0] Cout;
    meioSomador S1(SW[0], SW[5], Cout[0], LEDR[0]);
    somadorCompleto S2(SW[1], SW[6], Cout[0], Cout[1], LEDR[1]);
    somadorCompleto S3(SW[2], SW[7], Cout[1], Cout[2], LEDR[2]);
    somadorCompleto S4(SW[3], SW[8], Cout[2], Cout[3], LEDR[3]);
    somadorCompleto S5(SW[4], SW[9], Cout[3], Cout[4], LEDR[4]);

    assign LEDR[5] = Cout[4];
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
