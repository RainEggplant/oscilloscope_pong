module dual_slope_adc(
         clk, reset, is_neg_v, select_v_ref, digit_val
       );
input clk;
input reset;
input is_neg_v;
output reg [7:0] digit_val;
output reg select_v_ref;

reg [7:0] counter;

always @ (posedge clk)
  begin
    if (reset)
      begin
        select_v_ref <= 0;
        counter <= 0;
      end
    else
      begin
        if (~select_v_ref)
          begin
            // integrate the signal to be tested
            if (counter == 8'd255)
              begin
                counter <= 8'd0;
                select_v_ref <= 1;
              end
            else
              begin
                counter <= counter + 1;
              end
          end
        else
          begin
            if (~is_neg_v)
              begin
                select_v_ref <= 0;
                digit_val <= counter;
                counter <= 0;
              end
            else
              begin
                counter <= counter + 1;
              end
          end
      end
  end

endmodule
