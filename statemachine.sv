`define ST1 4'b0110 //reset 
`define ST2 4'b0000 //player gets 1st card
`define ST3 4'b0001 //dealer gets 1st card
`define ST4 4'b0010 //player gets 2nd card
`define ST5 4'b0011 //dealer gets 2nd card
`define ST6 4'b0100 //choose next state
`define ST7 4'b0101 //player gets 3rd card
`define ST8 4'b0111 //dealer gets 3rd card
`define ST9 4'b1000 //calculate score
  
  
module statemachine(input slow_clock, input resetb,
                    input [3:0] dscore, input [3:0] pscore, input [3:0] pcard3,
                    output load_pcard1, output load_pcard2,output load_pcard3,
                    output load_dcard1, output load_dcard2, output load_dcard3,
                    output player_win_light, output dealer_win_light);

 reg [3:0] current_state, next_state;

  always_ff @(negedge slow_clock)begin 
    case(current_state)
      `ST1: next_state = `ST2;
      `ST2: next_state = `ST3;
      `ST3: next_state = `ST4;
      `ST4: next_state = `ST5;
      `ST5: next_state = `ST6; 
      `ST6: if(pscore == 8 || pscore == 9 || dscore == 8 || dscore == 9)
             next_state = `ST9;
           else if(pscore >= 0 && pscore <= 5)
             next_state = `ST7;
           else if((pscore == 6 || pscore == 7) && dscore < 6)
             next_state = `ST8;
           else 
             next_state = `ST9;
      `ST7: if(dscore == 7)
             next_state = `ST9;
           else if(dscore == 6 && (pcard3 == 6 || pcard3 == 7))
             next_state = `ST8;
           else if(dscore == 5 &&(pcard3 >= 4 && pcard3 <= 7))
             next_state = `ST8;
           else if(dscore == 4 && (pcard3 >= 2 && pcard3 <= 7))
             next_state = `ST8;
           else if(dscore == 3 && pcard3 !== 8)
             next_state = `ST8;
           else if(dscore >= 0 && dscore <= 2)
             next_state = `ST8;
           else
             next_state = `ST9;
      `ST8: next_state = `ST9;
      `ST9: next_state = `ST9;
   endcase

    if(resetb == 0) 
      current_state <= `ST1;
    else
      current_state <= next_state;
  end

 always_comb begin 

    case(current_state)
      `ST1: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b00000000; 
      `ST2: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b10000000; 
      `ST3: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b00010000;
      `ST4: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b01000000;
      `ST5: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b00001000;
      `ST6: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b00000000; 
      `ST7: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b00100000;
      `ST8: 
        {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,player_win_light,dealer_win_light} = 8'b00000100;
      
      `ST9: begin 
	     {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3} = 6'b000000; 
              if(pscore > dscore) begin 
                player_win_light = 1;
	              dealer_win_light = 0;
	            end
              else if(dscore > pscore) begin
                dealer_win_light = 1;
	              player_win_light = 0;
	            end
              else begin
               player_win_light = 1;
               dealer_win_light = 1;
              end
           end
      
             
    endcase
  end 
endmodule







