module testeMemoria(
    input CLOCK_50,
    output [7:0] LEDG,//leds
    output [7:0] LEDR,//leds
    output [17:0] SRAM_ADDR,//Endereço memoria onde vai ser gravado o SRAM_DQ
    inout [15:0] SRAM_DQ,//Valor a ser passado para a memoria
    output SRAM_WE_N,//Sinal para write(0)/read(1)
    output SRAM_OE_N,//Sinal Output enable
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_CE_N
);

    //-------------WIRE's----------------
    wire [15:0] output_leds;


    //-------------REG's-----------------
    reg [3:0] state;

    reg [17:0] addr_reg;
    reg [15:0] data_reg;

    reg we, oe;

    //---------------ASSIGN's------------------
    assign output_leds = SRAM_DQ;

    assign SRAM_ADDR = addr_reg;
    assign SRAM_DQ = data_reg;

    assign LEDR[7:0] = output_leds[7:0];
    assign LEDG[7:0] = output_leds[7:0];

    assign SRAM_WE_N = we;
    assign SRAM_OE_N = oe;

    assign SRAM_UB_N = 0;
    assign SRAM_LB_N = 0;
    assign SRAM_CE_N = 0;


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
