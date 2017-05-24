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


    initial begin
        $dumpvars(0, P);

        #1
        P1X <= -2;
        P1Y <= 1;
        #1
        P2X <= 6;
        P2Y <= 1;
        #1
        P3X <= 1;
        P3Y <= -3;
        #1
        PTX <= 1;
        PTY <= -1;

        #10
        P1X <= 0;
        P1Y <= 1;
        #1
        P2X <= 6;
        P2Y <= 1;
        #1
        P3X <= 3;
        P3Y <= 4;
        #1
        PTX <= 6;
        PTY <= 4;

        #1
        P1X <= 0;
        P1Y <= 1;
        #1
        P2X <= 6;
        P2Y <= 1;
        #1
        P3X <= 3;
        P3Y <= 4;
        #1
        PTX <= 8;
        PTY <= 2;


        #10
        $finish;
    end
endmodule
