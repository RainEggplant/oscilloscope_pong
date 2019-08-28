module clk_gen(sysclk, clk_ctr, clk_scan);
input sysclk;
output clk_ctr, clk_scan;

reg clk_ctr, clk_scan;
reg [16 : 0] count_ctr; // 500 Hz
reg [13 : 0] count_scan; // 5 kHz

always @ (posedge sysclk)
  begin
    if (count_ctr >= 99_999)
      begin
        clk_ctr <= ~clk_ctr;
        count_ctr <= 0;
      end
    else
      count_ctr <= count_ctr + 1;

    if (count_scan >= 9_999)
      begin
        clk_scan <= ~clk_scan;
        count_scan <= 0;
      end
    else
      count_scan <= count_scan + 1;
  end
endmodule
