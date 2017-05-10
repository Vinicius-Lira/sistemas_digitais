module sing(
      input [9:0] px,
      input [9:0] py,
      input selPonto,
      output LEDG
);

      reg [9:0] p1x;
      reg [9:0] p1y;
      reg [9:0] p2x;
      reg [9:0] p2y;
      reg [9:0] p3x;
      reg [9:0] p3y;
      reg [9:0] ptx;
      reg [9:0] pty;
      reg [2:0] state = 1'b0;
      wire [9:0] sing;
      wire [10:0] p1;
      wire [10:0] p2;
      wire [10:0] p3;
      wire [10:0] p4;

      assign p1 = p1x - p3x;
      assign p2 = p2y - p3y;
      assign p3 = p2x - p3x;
      assign p4 = p1y - p3y;
      assign sing = p1 * p2 - p3 * p4;

      always @(selPonto) begin
              if (state == 1'b0) begin
                      p1x <= px;
                      p1y <= py;
                      state <= 1'b1;
              end else if (state == 1'b1) begin
                      p2x <= px;
                      p2y <= py;
                      state <= 2'b10;
              end else if (state == 2'b10) begin
                      p3x <= px;
                      p3y <= py;
                      state <= 2'b11;
              end else if (state == 2'b11) begin
                      ptx <= px;
                      pty <= py;
                      state <= 3'b100;
              end else begin
                      state <= 1'b0;
              end
      end

endmodule

module PointInTriangle();
        
endmodule

module test();
        reg [9:0] px;
        reg [9:0] py;
        reg selPonto;
        wire led;

        sing sinal(px, py, selPonto, led);

        initial begin
                $dumpvars(0, sinal);
                #2 selPonto = 0;
                #2
                px <= 2; py <= 2; selPonto = 1;
                #2 selPonto = 0;
                #2
                px <= 0; py <= 0; selPonto = 1;
                #2 selPonto = 0;
                #2
                px <= 4; py <= 0; selPonto = 1;
                #2 selPonto = 0;
                #2
                px <= 3; py <= 1; selPonto = 1;
        end
endmodule
