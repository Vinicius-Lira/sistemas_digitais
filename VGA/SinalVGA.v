module VGA(
	input CLOCK_50,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B,
   	output [3:0] LEDG,
	output VGA_HS,
	output VGA_VS
);


reg [30:0] h_count = 0;
reg [30:0] v_count = 0;

reg [3:0] R;
reg [3:0] G;
reg [3:0] B;

assign LEDG = 4'b1111;

assign VGA_HS = ~(h_count < 190);
assign VGA_VS = ~(v_count < 2);

wire [12:0] x;
wire [12:0] y;

assign x = h_count - 285;
assign y = v_count - 35;

wire q = (x >= 0) & (x < 1300) & (y >= 0) & (y < 505);

wire [11:0] P1X = 200;
wire [11:0] P1Y = 100;

wire [11:0] P2X = 500;
wire [11:0] P2Y = 300;

wire [11:0] P3X = 500;
wire [11:0] P3Y = 100;

wire [11:0] PTX;
wire [11:0] PTY;

assign PTX = x;
assign PTY = y;

wire InTriangle;

PointInTriangle pt( P1X, P1Y, P2X, P2Y, P3X, P3Y, PTX, PTY, InTriangle);

wire visible;

assign visible = (v_count > 35) & (v_count < 515) & (h_count > 285) & (h_count < 1505);

assign VGA_R = visible ? R : 0;
assign VGA_G = visible ? G : 0;
assign VGA_B = visible ? B : 0;

always @(posedge CLOCK_50) begin
	if(h_count == 1585) begin
    	h_count <= 0;
    	if(v_count == 525) begin
        	v_count <= 0;
    	end
    	else begin
        	v_count <= v_count + 1;
    	end
	end
	else begin
    	h_count <= h_count + 1;
	end
end

always@(*) begin
	if(InTriangle) begin
		R <= 4'hf;
		G <= 4'h0;
		B <= 4'h0;
	end
	else begin
		R <= 4'hf;
		G <= 4'hf;
		B <= 4'hf;
	end
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
