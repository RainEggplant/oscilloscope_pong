module output_view(
         clk, x_b, y_b, x_p, y_p, x, y
       );
input clk;
input [7:0] x_b;
input [7:0] y_b;
input [7:0] x_p;
input [7:0] y_p;
output reg [7:0] x;
output reg [7:0] y;

reg switch;

always @ (posedge clk)
  begin
    x <= switch ? x_b : x_p;
    y <= switch ? y_b : y_p;
    switch <= ~switch;
  end

endmodule
