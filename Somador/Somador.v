module Somador(
    input [9:0] SW,
    input [1:0] KEY,
    output reg [5:0] LEDG
);		
		wire [5:0] leds;
    wire [4:0] Cout;
   
	  meioSomador S1(SW[0], SW[5], Cout[0], leds[0]);
    somadorCompleto S2(SW[1], SW[6], Cout[0], Cout[1], leds[1]);
    somadorCompleto S3(SW[2], SW[7], Cout[1], Cout[2], leds[2]);
    somadorCompleto S4(SW[3], SW[8], Cout[2], Cout[3], leds[3]);
    somadorCompleto S5(SW[4], SW[9], Cout[3], Cout[4], leds[4]);
	assign leds[5] = Cout[4];
	
	always @(*) begin
		if(~KEY[0]) begin
			LEDG = leds;
		end
	end
	 
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
