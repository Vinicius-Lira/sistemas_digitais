module testeMemoria(
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
// assign SRAM_CE_N = ce;


always @(posedge CLOCK_50) begin

	case (state)
		0: begin
			state <= 2;
			addr_reg <= 13;
			data_reg <= 2;
			we <= 0;
			oe <= 1;
			ub <= 0;
			lb <= 0;
		end
		2: begin
			state <= 2;
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

module teste;
    reg clk;
    wire [7:0] LEDG;
    wire [7:0] LEDR;
    wire [17:0] SRAM_ADDR;
    wire [15:0] SRAM_DQ;
    wire SRAM_WE_N;
    wire SRAM_OE_N;
    wire SRAM_UB_N;
    wire SRAM_LB_N;
    wire SRAM_CE_N;

    reg [15:0] data;
    reg [17:0] addr;

    assign SRAM_DQ = data;
    assign SRAM_ADDR = addr;

    testeMemoria A(clk, LEDG, LEDR, SRAM_ADDR, SRAM_DQ, SRAM_WE_N, SRAM_OE_N, SRAM_UB_N, SRAM_LB_N, SRAM_CE_N);

    initial begin
        $dumpvars(0, A);
        #1
        clk <= 0;
        #2
        clk <= 1;
        addr <= 13;
        data <= 50;
        #2
        clk <= 0;
        #2
        clk <= 1;
        addr <= 13;
        data <= 0;
    end
endmodule
