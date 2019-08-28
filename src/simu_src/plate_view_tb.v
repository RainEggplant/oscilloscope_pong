`timescale 1ns / 1ns
module plate_view_tb();
reg clk;
reg [7:0] y_p_mid;
wire [7:0] x_p;
wire [7:0] y_p;

plate_view plate_view_0(.clk(clk), .y_p_mid(y_p_mid), .x_p(x_p), .y_p(y_p));

initial
  begin
    y_p_mid = 8'd128;
    clk = 1;
  end

always #50 clk = ~clk;

endmodule
