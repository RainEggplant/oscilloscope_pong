module plate_view(
         clk, y_p_mid, x_p, y_p
       );
input clk;
input [7:0] y_p_mid;
output [7:0] x_p;
output reg [7:0] y_p;

parameter Y_MAX = 220;
parameter PLATE_HALFWIDTH = 15;

// plate range
wire [7:0] y_p_max;
wire [7:0] y_p_min;
assign y_p_max = y_p_mid <= Y_MAX - PLATE_HALFWIDTH ? y_p_mid + PLATE_HALFWIDTH : Y_MAX;
assign y_p_min = y_p_mid >= PLATE_HALFWIDTH ? y_p_mid- PLATE_HALFWIDTH : 0;

assign x_p = 8'd255;

always @ (posedge clk)
  begin
    if (y_p >= y_p_min && y_p < y_p_max)
      y_p <= y_p + 1;
    else
      y_p <= y_p_min;
  end

endmodule
