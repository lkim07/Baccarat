module tb_datapath();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
`timescale 1 ps / 1 ps
    
    logic slow_clock, fast_clock, resetb, err; 
    logic load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3;
    logic [3:0] pcard3_out, pscore_out, dscore_out;
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

datapath dp(.slow_clock(slow_clock),
            .fast_clock(fast_clock),
            .resetb(resetb),
            .load_pcard1(load_pcard1),
            .load_pcard2(load_pcard2),
            .load_pcard3(load_pcard3),
            .load_dcard1(load_dcard1),
            .load_dcard2(load_dcard2),
            .load_dcard3(load_dcard3),
            .pcard3_out(pcard3_out),
        .pscore_out(pscore_out),
        .dscore_out(dscore_out),
            .HEX5(HEX5),
            .HEX4(HEX4),
            .HEX3(HEX3),
            .HEX2(HEX2),
            .HEX1(HEX1),
            .HEX0(HEX0));

    
    initial forever begin
    fast_clock =~fast_clock;
    #5;
    end

    initial begin
    err = 0; 
    fast_clock = 0; slow_clock = 1; resetb = 1;
    load_pcard1 = 0; load_pcard2 = 0; load_pcard3 = 0;  
    load_dcard1 = 0; load_dcard2 = 0; load_dcard3 = 0;

    #2;

    resetb = 0; //reset

    slow_clock = 0;
    #5;
    slow_clock = 1; //press and release slow_clock
    #5;


    resetb = 1; //release reset

    assert(((load_pcard1 | load_pcard2 | load_pcard3) == 0) && ((load_dcard1 | load_dcard2 | load_dcard3) == 0))
    else begin $display("Error"); 
    err = 1; 
    end

        $display("%d %d %d %d %d %d", load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3); //check whether they are 0

    
    slow_clock = 0; //reset
    load_pcard1 = 1;  for each reg progressively, 6 in all, 3 for player, 3 for dealer
    #10;
    
    slow_clock = 1;
    load_pcard1 = 0; 
        assert((dp.new_card !== 0) && (dp.PCard1 !== 0) )
    else begin $display("Error"); 
    err = 1; 
    end


    $display("%d %d", dp.new_card, dp.PCard1); //make sure they aren't 0
    #10;


    slow_clock = 0; //reset
    load_pcard2 = 1; 
    #10;
    
    slow_clock = 1;
    load_pcard2 = 0;
    assert((dp.new_card !== 0) && (dp.PCard2 !== 0) )
    else begin $display("Error"); 
    err = 1; 
    end
    $display("%d %d", dp.new_card, dp.PCard2); //make sure they aren't 0
    #10;


    slow_clock = 0; //reset
    load_pcard3 = 1; 
    #10;
    
    slow_clock = 1;
    load_pcard3 = 0; 
    assert((dp.new_card !== 0) && (dp.pcard3_out !== 0) )
    else begin $display("Error"); err = 1; end
    $display("%d %d", dp.new_card, dp.pcard3_out); //make sure they aren't 0
    #10;


    $display("%b %b %b %b %b %b" , HEX0, HEX1, HEX2, HEX3, HEX4, HEX5); //check they match HEX value

    $display ("%d %d", pscore_out, dscore_out); //check they match each score

slow_clock = 0; //reset
    load_dcard1 = 1; 
    #10;
    
    slow_clock = 1;
    load_dcard1 = 0;
    assert((dp.new_card !== 0) && (dp.DCard1 !== 0) )
    else begin $display("Error"); 
    err = 1; 
    end
    $display("%d %d", dp.new_card, dp.DCard1); //make sure they aren't 0
    #10;


    slow_clock = 0; //reset
    load_dcard2 = 1; 
    #10;
    
    slow_clock = 1;
    load_dcard2 = 0; //disable
    assert((dp.new_card !== 0) && (dp.DCard2 !== 0) )
    else begin $display("Error"); 
    err = 1; 
    end
    $display("%d %d", dp.new_card, dp.DCard2); //make sure they aren't 0
    #10;



    slow_clock = 0; //reset
    load_dcard3 = 1; 
    #10;
    
    slow_clock = 1;
    load_dcard3 = 0; 
    assert((dp.new_card !== 0) && (dp.DCard3 !== 0) )
    else begin $display("Error"); 
    err = 1; 
    end
    $display("%d %d", dp.new_card, dp.DCard3); //make sure they aren't 0
    #10;

    $display("%b %b %b %b %b %b" , HEX0, HEX1, HEX2, HEX3, HEX4, HEX5); //check they match HEX value

    $display ("%d %d", pscore_out, dscore_out); //check they match each score
    
    if(err == 0) begin //check err signal again
      $display("Test passed! Testbench ends!");
    end
    else begin
      $display("Error occured! Testbench ends!");
    end

   $stop;

    end
endmodule

