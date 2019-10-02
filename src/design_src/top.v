module top(
         sysclk, reset, is_neg_v, x, y, select_v_ref, ssd, ssd_bit
       );
input sysclk;
input reset;
input is_neg_v;
output [7:0] x;
output [7:0] y;
output select_v_ref;
output [6:0] ssd;
output [2:0] ssd_bit;

wire clk_100k;
wire clk_ctr;
wire clk_refresh;
wire [7:0] x_b;
wire [7:0] y_b;
wire [7:0] x_p;
wire [7:0] y_p;
wire [7:0] y_p_mid;
wire [7:0] x_border;
wire [7:0] y_border;
wire [7:0] score;
wire reset_d;

clk_gen clk_gen_0(.sysclk(sysclk), .clk_100k(clk_100k), .clk_ctr(clk_ctr), .clk_refresh(clk_refresh));
dual_slope_adc dual_slope_adc_0(
                 .clk(clk_100k), .reset(reset), .is_neg_v(is_neg_v), .select_v_ref(select_v_ref), .digit_val(y_p_mid)
               );
game_ctr game_ctr_0(.clk(clk_ctr), .reset(reset), .y_p_mid(y_p_mid), .x_b(x_b), .y_b(y_b), .score(score));
plate_view plate_view_0(.clk(clk_100k), .y_p_mid(y_p_mid), .x_p(x_p), .y_p(y_p));
border_view border_view_0(.clk(clk_100k), .x_border(x_border), .y_border(y_border));
output_view output_view_0(
              .clk(clk_refresh),
              .x_b(x_b), .y_b(y_b), .x_p(x_p), .y_p(y_p), .x_border(x_border), .y_border(y_border),
              .x(x), .y(y)
            );
ssd_display ssd_display_0(.clk(clk_ctr), .bin(score), .ssd(ssd), .ssd_bit(ssd_bit));

endmodule
