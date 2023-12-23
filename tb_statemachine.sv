module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
`timescale 1 ps / 1 ps

logic tb_slow_clock, tb_resetb;
logic [3:0] tb_dscore, tb_pscore, tb_pcard3;
logic tb_load_pcard1, tb_load_pcard2, tb_load_pcard3, tb_load_dcard1, tb_load_dcard2, tb_load_dcard3;
logic tb_player_win_light, tb_dealer_win_light;



statemachine DTU(.slow_clock(tb_slow_clock), .resetb(tb_resetb),
                    .dscore(tb_dscore), .pscore(tb_pscore), .pcard3(tb_pcard3),
                    //output
                    .load_pcard1(tb_load_pcard1), .load_pcard2(tb_load_pcard2), .load_pcard3(tb_load_pcard3),
                    .load_dcard1(tb_load_dcard1), .load_dcard2(tb_load_dcard2), .load_dcard3(tb_load_dcard3),
                    .player_win_light(tb_player_win_light), .dealer_win_light(tb_dealer_win_light));


//slow_clock cycling in the background. slow_clock is used to progress through the game
initial begin 
	slow_clock = 0;
	forever
	#2 slow_clock =~ slow_clock;
end


    initial begin
	err = 0;
	{slow_clock, resetb, pscore_out, dscore_out} = 4'b0100; //testing reset
	#10;
        resetb = 0; 
	#10;
	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0) 
	else begin $display("Error1"); 
    err = 1; 
    end
   	
	#15;

        resetb = 1; #10; //releast reset

   	assert(load_pcard1 == 1 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0) //now start distributing cards in order
	else begin $display("Error2"); 
    err = 1; 
    end
	 #10;

   	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 1 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error3"); 
    err = 1; 
    end
	#10;

    	assert(load_pcard1 == 0 && load_pcard2 == 1 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error4"); 
    err = 1; 
    end
	#10;
       assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 1 && load_dcard3 == 0)
	else begin $display("Error5"); 
    err = 1; 
    end
	#10;

       //Check for win condition 
       pscore_out = 8; #15;
        	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0) //should all be 0 in this stage
	else begin $display("Error6"); 
    err = 1; 
    end
    #10;


	//Player gets card3
        resetb = 0;
	#20;
        resetb = 1;
	#45;
        pscore_out = 0;
	dscore_out = 7;
	#5
        	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error7"); 
    err = 1; 
    end
       
	#10;

         	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 1 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error8"); 
    err = 1; 
    end
	#5;
        

	//player gets card3, dealer only gets card3 if player card is >= 4
        resetb = 0;
	#15;
        resetb = 1;
	#30;
        pscore_out = 4; 
	dscore_out = 5;
	#25;
	pcard3_out = 4;
	#10;
       assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 1 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error"); 
    err = 1; 
    end

	//player gets card3, dealer gets card if player card is >= 2, <=7 
        resetb = 0;
	#15;
        resetb = 1;
	#30;
        pcard3_out = 7; 
        pscore_out = 3; 
        dscore_out = 3; 
        #25;
        #10;
   	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 1 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error9"); 
    err = 1; 
    end
    #10; 
   	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error10"); 
    err = 1; 
    end;
#15;


 //ponly dealer gets the card3
        resetb = 0;
	#20;
        resetb = 1;
	#30;
        pcard3_out = 1;
        pscore_out = 6;
	dscore_out = 5;
	#35;
   	assert(load_pcard1 == 0 && load_pcard2 == 0 && load_pcard3 == 0 && load_dcard1 == 0 && load_dcard2 == 0 && load_dcard3 == 0)
	else begin $display("Error11"); 
    err = 1; 
    end
#15;
   	if(err == 0)
	$display("Test passed! Testbench ends!");
	else
	$display("err occured! Testbench ends!");
        $stop;
    end
endmodule