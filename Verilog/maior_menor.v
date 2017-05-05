module maior_menor(input [7:0] A,
             input [7:0] B,
             output [7:0] C);

    wire m;
    assign m = A < B;
    reg [7:0] C_reg;
    assign C = C_reg;
    always @(m, A, B) begin
        if(m) begin
            C_reg <= B;
        end
        else begin
            C_reg <= A;
        end
    end
endmodule


module test;
    reg [7:0] A;
    reg [7:0] B;
    wire [7:0] C;

    maior_menor M(A, B, C);

    initial begin
        $dumpvars (0, B, A, C);

        #2; A <= 4; B <= 5;
        #2; A <= 3; B <= 1;
        #2;

    end

endmodule
