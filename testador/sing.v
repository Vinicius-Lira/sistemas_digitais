module sing(
    input [11:0] PTX,
    input [11:0] PTY,

    input [11:0] P1X,
    input [11:0] P1Y,

    input [11:0] P2X,
    input [11:0] P2Y,

    output sin
);

    wire signed [11:0] Sub1;
    wire signed [11:0] Sub2;
    wire signed [11:0] Sub3;
    wire signed [11:0] Sub4;

    wire signed [22:0] Sub5;

    wire signed [22:0] Mult1;
    wire signed [22:0] Mult2;

    //Calculo para ver se um ponto está dentro de um triangulo
    assign Sub1 = PTX - P2X;
    assign Sub2 = P1Y - P2Y;
    assign Sub3 = P1X - P2X;
    assign Sub4 = PTY - P2Y;

    assign Mult1 = Sub1 * Sub2;
    assign Mult2 = Sub3 * Sub4;

    assign Sub5 = Mult1 - Mult2;

    assign sin = (Sub5 >= 0) ? 1 : 0;

endmodule

module PointInTriangle(
    input [11:0] P1X,
    input [11:0] P1Y,

    input [11:0] P2X,
    input [11:0] P2Y,

    input [11:0] P3X,
    input [11:0] P3Y,

    input [11:0] PTX,
    input [11:0] PTY,

    output inTriangle
);
    wire sin1;
    wire sin2;
    wire sin3;

    sing S1(PTX, PTY, P1X, P1Y, P2X, P2Y, sin1);
    sing S2(PTX, PTY, P2X, P2Y, P3X, P3Y, sin2);
    sing S3(PTX, PTY, P3X, P3Y, P1X, P1Y, sin3);

    assign inTriangle = (sin1 == sin2 && sin2 == sin3) ? 1 : 0;

endmodule

module test;

    reg [11:0] P1X;
    reg [11:0] P1Y;

    reg [11:0] P2X;
    reg [11:0] P2Y;

    reg [11:0] P3X;
    reg [11:0] P3Y;

    reg [11:0] PTX;
    reg [11:0] PTY;

    wire InTriangle;

    PointInTriangle P(P1X, P1Y, P2X, P2Y, P3X, P3Y, PTX, PTY, InTriangle);

    integer in, out, mon;
    integer status;
    reg clk = 0;

    initial begin
        clk = 0;
        in = $fopen("a.in", "r");
        out = $fopen("singVerilog.txt", "w");
    end

    always # 1 clk = ~clk;

    initial begin
        repeat (10) @ (posedge clk);
        while(!$feof(in)) begin
            @(negedge clk);
            //Lê o arquivo para pegar os pontos
            status = $fscanf(in, "%d %d\n", P1X, P1Y);
            status = $fscanf(in, "%d %d\n", P2X, P2Y);
            status = $fscanf(in, "%d %d\n", P3X, P3Y);
            status = $fscanf(in, "%d %d\n", PTX, PTY);
            @(negedge clk);
        end
        repeat (10) @ (posedge clk);
        if(InTriangle == 1) begin
            $fwrite(out, "True\n");
        end else begin
            $fwrite(out, "False\n");
        end
        $fclose(in);
        $fclose(out);
        #100 $finish;
    end
endmodule
