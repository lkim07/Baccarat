module datapath(input slow_clock, input fast_clock, input resetb,
                input load_pcard1, input load_pcard2, input load_pcard3,
                input load_dcard1, input load_dcard2, input load_dcard3,
                output [3:0] pcard3_out,
                output [3:0] pscore_out, output [3:0] dscore_out,
                output[6:0] HEX5, output[6:0] HEX4, output[6:0] HEX3,
                output[6:0] HEX2, output[6:0] HEX1, output[6:0] HEX0);
    
// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code.


    wire [3:0] pcard1, pcard2, dcard1, dcard2, dcard3, new_card;

    dealcard gen_card(.clock(fast_clock), .resetb(resetb), .new_card(new_card));

    reg4 pCard1(.new_card(new_card), .load_card(load_pcard1), .resetb(resetb), .slow_clock(slow_clock), .out_card(pcard1));
    reg4 PCard2(.new_card(new_card), .load_card(load_pcard2), .resetb(resetb), .slow_clock(slow_clock), .out_card(pcard2));
    reg4 PCard3(.new_card(new_card), .load_card(load_pcard3), .resetb(resetb), .slow_clock(slow_clock), .out_card(pcard3_out));
    reg4 dCard1(.new_card(new_card), .load_card(load_dcard1), .resetb(resetb), .slow_clock(slow_clock), .out_card(dcard1));
    reg4 dCard2(.new_card(new_card), .load_card(load_dcard2), .resetb(resetb), .slow_clock(slow_clock), .out_card(dcard2));
    reg4 dCard3(.new_card(new_card), .load_card(load_dcard3), .resetb(resetb), .slow_clock(slow_clock), .out_card(dcard3));



    card7seg player_card1(.card(pcard1), .seg7(HEX2));
    card7seg player_card2(.card(pcard2), .seg7(HEX1));
    card7seg player_card3(.card(pcard3_out), .seg7(HEX0));
    card7seg dealer_card1(.card(dcard1), .seg7(HEX5));
    card7seg dealer_card2(.card(dcard2), .seg7(HEX4));
    card7seg dealer_card3(.card(dcard3), .seg7(HEX3));

    scorehand player_score(.card1(pcard1), .card2(pcard2), .card3(pcard3_out), .total(pscore_out));
    scorehand dealer_score(.card1(dcard1), .card2(dcard2), .card3(dcard3), .total(dscore_out));


endmodule
