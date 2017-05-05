module LED (
	input CLOCK_50,
	output LEDG
);

	reg [32:0] counter;
	reg state;

	assign LEDG = state;

	always @ (posedge CLOCK_50) begin
    	counter <= counter + 1;
    	state <= counter[24];
	end

endmodule
