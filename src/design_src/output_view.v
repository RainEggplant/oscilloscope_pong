module output_view(
         clk, x_b, y_b, x_p, y_p, x_border, y_border, x, y
       );
input clk;
input [7:0] x_b;
input [7:0] y_b;
input [7:0] x_p;
input [7:0] y_p;
input [7:0] x_border;
input [7:0] y_border;
output reg [7:0] x;
output reg [7:0] y;

reg [1:0] i;

always @ (posedge clk)
  begin
    case (i)
      2'd0:
        begin
          x <= x_b;
          y <= y_b;
          i <= 2'd1;
        end
      2'd1:
        begin
          x <= x_p;
          y <= y_p;
          i <= 2'd2;
        end
      2'd2:
        begin
          x <= x_border;
          y <= y_border;
          i <= 2'd0;
        end
      default:
        i <= 2'd0;
    endcase
  end

endmodule
