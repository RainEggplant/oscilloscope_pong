module border_view(
         clk, x_border, y_border
       );
input clk;
output reg [7:0] x_border;
output reg [7:0] y_border;

parameter X_MAX = 255;
parameter Y_MAX = 220;

reg [1:0] i;

always @ (posedge clk)
  begin
    case (i)
      2'd0:
        begin
          x_border <= X_MAX;
          y_border <= 8'd0;
          i <= 2'd1;
        end
      2'd1:
        begin
          if (x_border > 8'd0)
            x_border <= x_border - 1;
          else
            i <= 2'd2;
        end
      2'd2:
        begin
          if (y_border < Y_MAX)
            y_border <= y_border + 1;
          else
            i <= 2'd3;
        end
      2'd3:
        begin
          if (x_border < X_MAX)
            x_border <= x_border + 1;
          else
            i <= 2'd0;
        end
    endcase
  end


endmodule
