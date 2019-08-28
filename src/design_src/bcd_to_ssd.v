module bcd_to_ssd(bcd, ssd);
input [3:0] bcd;
output [6:0] ssd;

assign ssd =
       (bcd == 4'h0) ? 7'b0111111 :
       (bcd == 4'h1) ? 7'b0000110 :
       (bcd == 4'h2) ? 7'b1011011 :
       (bcd == 4'h3) ? 7'b1001111 :
       (bcd == 4'h4) ? 7'b1100110 :
       (bcd == 4'h5) ? 7'b1101101 :
       (bcd == 4'h6) ? 7'b1111101 :
       (bcd == 4'h7) ? 7'b0000111 :
       (bcd == 4'h8) ? 7'b1111111 :
       (bcd == 4'h9) ? 7'b1101111 :
       7'b0;
endmodule
