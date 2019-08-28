// module top(
//          sysclk, reset, y_p_mid, x, y, ssd, ssd_bit
//        );

module top(
         sysclk, reset, x, y, ssd, ssd_bit
       );
input sysclk;
input reset;
// input [7:0] y_p_mid;

output [7:0] x;
output [7:0] y;
output [6:0] ssd;
output [2:0] ssd_bit;

wire clk_ctr;
wire clk_scan;
wire [7:0] x_b;
wire [7:0] y_b;
wire [7:0] x_p;
wire [7:0] y_p;
wire [7:0] score;
wire reset_d;

/* BEGIN debug */
wire [7:0] y_p_mid;
assign y_p_mid = 8'd128;
/* END debug */

debounce debounce_0(.clk(sysclk), .key_i(reset), .key_o(reset_d));
clk_gen clk_gen_0(.sysclk(sysclk), .clk_ctr(clk_ctr), .clk_scan(clk_scan));
game_ctr game_ctr_0(.clk(clk_ctr), .reset(reset_d), .y_p_mid(y_p_mid), .x_b(x_b), .y_b(y_b), .score(score));
plate_view plate_view_0(.clk(sysclk), .y_p_mid(y_p_mid), .x_p(x_p), .y_p(y_p));
output_view output_view_0(.clk(clk_scan), .x_b(x_b), .y_b(y_b), .x_p(x_p), .y_p(y_p), .x(x), .y(y));
ssd_display ssd_display_0(.clk(clk_scan), .bin(score), .ssd(ssd), .ssd_bit(ssd_bit));

endmodule
