module scorehand(input [3:0] card1, input [3:0] card2, input [3:0] card3, output [3:0] total);

// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout.  Be sure to review the section
// on representing numbers in the lecture notes.

  reg [3:0] num1;
  reg [3:0] num2;
  reg [3:0] num3;

  always @(card1 or card2 or card3) begin

    if (card1 >= 10 ) begin 
      num1 = 0;
    end
    else begin
      num1 = card1;
    end

    if (card2 >= 10 ) begin
      num2 = 0;
    end
    else begin
      num2 = card2;
    end

    if (card3 >= 10 ) begin
      num3 = 0;
    end
    else begin
      num3 = card3;
    end

  end

  assign total = (num1 + num2 + num3) % 10;


endmodule


module reg4(input logic [3:0] new_card, input logic load_card, input logic resetb, input logic slow_clock, output logic [3:0] out_card); 

  always @(negedge slow_clock) begin
    if(resetb == 0)
      out_card <= 0;
    else
      out_card <= load_card ? new_card:out_card;
  end

endmodule