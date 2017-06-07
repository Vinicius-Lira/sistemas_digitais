module PointTriangle(
    input CLOCK_50,

    input [11:0] PointPx,
    input [11:0] PointPy,

    input [11:0] PointAx,
    input [11:0] PointAy,

    input [11:0] PointBx,
    input [11:0] PointBy,

    input [11:0] PointCx,
    input [11:0] PointCy

);

    reg [11:0] x;
    reg [11:0] y;

    reg enable = 1;

    wire inTriangle;

    PointInTriangle in(PointAx, PointAy, PointBx, PointBy, PointCx, PointCy, PointPx, PointPy, inTriangle);

    reg auxLeftX = 0;
    reg auxRigth = 0;
    reg auxTopY = 0;

    reg [31:0] PointMen;

    always @(*) begin
        while(enable) begin
            if(inTriangle) begin
                if(auxLeftX == 0) begin
                    PointMen[11:0] <= x;
                    auxLeftX <= 1;
                end
                else begin
                    PointMen[21:12] <= x;
                end

                if(auxTopY == 0) begin
                    PointMen[31:22] <= y;
                    auxTopY <= 1;
                end
            end

            if(x == 1505) begin
                x <= 0;
                auxLeftX <= 0;

                if(y == 480) begin
                    y <= 0;
                    enable <= 0;
                end
                else begin
                    y <= y + 1;
                end

            end
            else begin
                x <= x + 1;
            end
        //Fim while
        end
    //Fim always
    end

endmodule

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
