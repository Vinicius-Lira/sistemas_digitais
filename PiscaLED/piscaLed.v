module PiscaLed (
	input CLOCK_50,
	output [1:0] LEDG
);

	reg [32:0] counter;
	reg state;

	assign LEDG[0] = state;
	assign LEDG[1] = state;

	always @ (posedge CLOCK_50) begin
    	counter <= counter + 1;
		if(counter == 100000000) begin
			state <= ~state;
			counter <= 0;
		end
	end

endmodule
