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
