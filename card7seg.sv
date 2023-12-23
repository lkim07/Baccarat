module card7seg(input [3:0] card, output[6:0] seg7);

   // your code goes here

// input is register. if the register is 2-9, display 2-9. 
   reg [6:0] hex;

   always_comb begin : card7seg
      case (card)
            4'b0000: hex = 7'b1111111; // blank
            4'b0001: hex = 7'b0001000;
            4'b0010: hex = 7'b0100100;
            4'b0011: hex = 7'b0110000;
            4'b0100: hex = 7'b0011001;
            4'b0101: hex = 7'b0010010;
            4'b0110: hex = 7'b0000010;
            4'b0111: hex = 7'b1111000; // 7
            4'b1000: hex = 7'b0000000;
            4'b1001: hex = 7'b0010000;
            4'b1010: hex = 7'b1000000; // 10 0
            4'b1011: hex = 7'b1100001; // jack J
            4'b1100: hex = 7'b0011000; // queen q
            4'b1101: hex = 7'b0001001; // king H
            4'b1110: hex = 7'b1111111;
            4'b1111: hex = 7'b1111111;
            default: hex = 7'b1111111;
	   endcase      
   end

   assign seg7 = hex;

endmodule

