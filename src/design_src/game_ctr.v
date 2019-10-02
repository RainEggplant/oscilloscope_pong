module game_ctr(
         clk, reset, y_p_mid, x_b, y_b, score
       );
input clk;
input reset;
input [7:0] y_p_mid;
output reg [7:0] x_b;
output reg [7:0] y_b;
output reg [7:0] score;

parameter X_MAX = 255;
parameter Y_MAX = 220;
parameter PLATE_HALFWIDTH = 21;

// the lower, the harder
wire [3:0] cycle_between_step;
assign cycle_between_step = score < 8'd15 ? 4'd15 - score[3:0] : 4'd1;
reg [3:0] counter;

// plate range
wire [7:0] y_p_max;
wire [7:0] y_p_min;
assign y_p_max = y_p_mid <= Y_MAX - PLATE_HALFWIDTH ? y_p_mid + PLATE_HALFWIDTH : Y_MAX;
assign y_p_min = y_p_mid >= PLATE_HALFWIDTH ? y_p_mid- PLATE_HALFWIDTH : 0;

// v_x, v_y: 0-left/down, 1-right/up
reg v_x;
reg v_y;

reg gameover;
reg [10:0] tick;

always @ (posedge clk or posedge reset)
  begin
    if (reset)
      begin
        tick <= 0;
        gameover <= 1;
      end
    else if (gameover)
      begin
        if (tick == 11'd2047)
          begin
            gameover <= 0;
            x_b <= X_MAX / 2;
            y_b <= Y_MAX / 2;
            v_x <= 1;
            v_y <= 1;
            counter <= 0;
            score <= 8'd0;
            tick <= 0;
          end
        else
          tick <= tick + 1;
      end
    else
      begin
        if (counter >= cycle_between_step)
          begin
            counter <= 0;
            if ((y_b == 0 && ~v_y) || (y_b == Y_MAX && v_y))
              // reach top or bottom
              v_y <= ~v_y;
            else
              y_b <= y_b + (v_y ? 1 : -1);

            if (x_b == 0 && ~v_x)
              // reach left boarder
              v_x <= ~v_x;
            else if (x_b == X_MAX && v_x)
              begin
                if (y_b >= y_p_min && y_b <= y_p_max)
                  begin
                    // hit
                    score <= score + 1;
                    v_x <= ~v_x;
                  end
                else
                  // miss
                  gameover <= 1;
              end
            else
              x_b <= x_b + (v_x ? 1 : -1);
          end
        else
          counter <= counter + 1;
      end
  end

endmodule
