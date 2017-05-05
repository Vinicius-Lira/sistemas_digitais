//00 -> invalido
//01 -> Pedra
//10 -> Papel
//11 -> Tesoura

module ppt(
        input [1:0] j1,
        input [1:0] j2,
        output j1_w,
        output j2_w);
    reg j1_w1;
    reg j2_w2;

    assign j1_w = j1_w1;
    assign j2_w = j2_w2;

    always @(j1, j2) begin
        if(j1 == 2'b01 ) begin
            if(j2 == 2'b01) begin
                j1_w1 <= 1;
                j2_w2 <= 1;
            end
            else if(j2 == 2'b10)begin
                j1_w1 <= 0;
                j2_w2 <= 1;
            end
            else if(j2 == 2'b11) begin
                j1_w1 <= 1;
                j2_w2 <= 0;
            end
        end
        else if(j1 == 2'b10) begin
            if(j2 == 2'b01) begin
                j1_w1 <= 1;
                j2_w2 <= 0;
            end
            else if(j2 == 2'b10)begin
                j1_w1 <= 1;
                j2_w2 <= 1;
            end
            else if(j2 == 2'b11) begin
                j1_w1 <= 0;
                j2_w2 <= 1;
            end
        end
        else if(j1 == 2'b11) begin
            if(j2 == 2'b01) begin
                j1_w1 <= 0;
                j2_w2 <= 1;
            end
            else if(j2 == 2'b10)begin
                j1_w1 <= 1;
                j2_w2 <= 0;
            end
            else if(j2 == 2'b11) begin
                j1_w1 <= 1;
                j2_w2 <= 1;
            end
        end

    end
endmodule


module test;
    reg [1:0] j1;
    reg [1:0] j2;
    wire j1_w;
    wire j2_w;

    ppt p(j1, j2, j1_w, j2_w);
    initial begin
        $dumpvars(0, test);
        #2 
    end


endmodule
