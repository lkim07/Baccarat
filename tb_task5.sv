module tb_task5();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").
`timescale 1 ps / 1 ps

    logic err, CLOCK_50;
    logic [3:0] KEY;
    logic [9:0] LEDR;
    logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    task5 DUT (.CLOCK_50(CLOCK_50), 
               .KEY(KEY), 
               .LEDR(LEDR), 
               .HEX5(HEX5), 
               .HEX4(HEX4), 
               .HEX3(HEX3), 
               .HEX2(HEX2), 
               .HEX1(HEX1), 
               .HEX0(HEX0));

    //fast clock
  initial begin
    CLOCK_50 = 1'b0; #10;
    forever begin
        #25 CLOCK_50 =~CLOCK_50; 
        end
    end

    //slow clock
    initial begin
        KEY[0] = 1'b0; #11;
        forever begin
        #50 CLOCK_50 =~CLOCK_50; 
        end
    end

    initial begin
    err = 0;
        KEY[3] = 1'b0; //reset
        #15; //simulate real design
        
        KEY[3] = 1'b1; // release reset 
    #155

    assert(HEX0 !== 8'b11111111) //display player_card1
    else begin $display("error 1"); 
        err=1; 
        end;

    #5

    assert(LEDR !== 0)
    else begin $display("error 2"); 
        err = 1; 
        end 

    #125 

    assert((HEX3 !== 8'b11111111) && (HEX0 !== 8'b11111111) && (LEDR !== 0)) //display player_card1 & dealer_card1
    else begin $display("error 3"); 
        err=1; 
        end;

    #75

    assert((HEX3 !== 8'b11111111) && (HEX0 !== 8'b11111111) && (HEX1 != 8'b11111111) && (LEDR !== 0)) //add player_card2
    else begin $display("error 4"); 
        err=1; 
        end;

    #100

    assert((HEX3 !== 8'b11111111) && (HEX4 != 8'b11111111) && (HEX0 !== 8'b11111111) && (HEX1 != 8'b11111111) && (LEDR !== 0)) //check each player have two cards
    else begin $display("error 5"); 
        err=1; 
        end;

        #1500; 
        KEY[3] = 1'b0; // reset
        #50
        KEY[3] = 1'b1; //reset
        #50;
    
    if(err == 0)
    $display("Test passed! Testbench ends!");
    else
    $display("Error occured! Testbench ends!");
        $stop;
    end

endmodule


