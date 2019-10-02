module clk_gen(sysclk, clk_100k, clk_ctr, clk_refresh);
input sysclk;
output reg clk_100k;
output reg clk_ctr;
output reg clk_refresh;

reg [8:0] count_100k; // 100 kHz
reg [15:0] count_ctr; // 1 kHz
reg [13:0] count_refresh; // 5 kHz

always @ (posedge sysclk)
  begin
    if (count_100k >= 9'd499)
      begin
        clk_100k <= ~clk_100k;
        count_100k <= 0;
      end
    else
      count_100k <= count_100k + 1;

    if (count_ctr >= 16'd49_999)
      begin
        clk_ctr <= ~clk_ctr;
        count_ctr <= 0;
      end
    else
      count_ctr <= count_ctr + 1;

    if (count_refresh >= 13'd9_999)
      begin
        clk_refresh <= ~clk_refresh;
        count_refresh <= 0;
      end
    else
      count_refresh <= count_refresh + 1;

  end
endmodule
