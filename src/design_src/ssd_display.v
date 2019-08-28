module ssd_display(clk, bin, ssd, ssd_bit);
input clk;
input [7:0] bin;
output [6:0] ssd;
output [2:0] ssd_bit;

reg [1:0] state;
reg [6:0] ssd;
reg [2:0] ssd_bit;
wire [3:0] hundreds;
wire [3:0] tens;
wire [3:0] ones;
wire [6:0] ssd_all[2:0];

bin_to_bcd bcd_to_ssd_0(.bin(bin), .hundreds(hundreds), .tens(tens), .ones(ones));
bcd_to_ssd bts_hundreds(.bcd(hundreds), .ssd(ssd_all[2]));
bcd_to_ssd bts_tens(.bcd(tens), .ssd(ssd_all[1]));
bcd_to_ssd bts_ones(.bcd(ones), .ssd(ssd_all[0]));

always @ (posedge clk)
  begin
    case (state)
      0:
        begin
          ssd <= ssd_all[2];
          ssd_bit[0] <= 1;
          ssd_bit[1] <= 0;
          ssd_bit[2] <= 0;
        end
      1:
        begin
          ssd <= ssd_all[1];
          ssd_bit[0] <= 0;
          ssd_bit[1] <= 1;
          ssd_bit[2] <= 0;
        end
      2:
        begin
          ssd <= ssd_all[0];
          ssd_bit[0] <= 0;
          ssd_bit[1] <= 0;
          ssd_bit[2] <= 1;
        end
    endcase
  end

always @ (posedge clk)
  begin
    if (state == 2)
      state <= 0;
    else
      state <= state + 1;
  end
endmodule
