module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
    reg [3:0] tb_card1;
    reg [3:0] tb_card2;
    reg [3:0] tb_card3;
    wire [3:0] tb_total;

    scorehand test_scorehand(.card1(tb_card1), .card2(tb_card2), .card3(tb_card3), .total(tb_total));
    initial begin
        tb_card1 = 4'b0100;
        tb_card2 = 4'b0001;
        tb_card3 = 4'b0000;
        #10; // 5

        tb_card1 = 4'b0001;
        tb_card2 = 4'b0001;
        tb_card3 = 4'b1000;
        #10; // 10

        tb_card1 = 4'b0010;
        tb_card2 = 4'b0001;
        tb_card3 = 4'b1000;
        #10; // 11

        tb_card1 = 4'b0010;
        tb_card2 = 4'b0010;
        tb_card3 = 4'b1000;
        #10; // 12

        tb_card1 = 4'b0100;
        tb_card2 = 4'b0001;
        tb_card3 = 4'b1000;
        #10; // 13

        tb_card1 = 4'b1100;
        tb_card2 = 4'b0001;
        tb_card3 = 4'b1010;
        #10; // 23

        // for (i=0; i<50 ; i=i+1) begin 
        //     for(j=0; j<50; j=j+1) begin 
        //         for(k=0; k<50; k=k+1) begin 
        //             tb_card1 = i;
        //             tb_card2 = j;
        //             tb_card3 = k;
        //             #10; // 5
        //         end
        //     end 
        // end
    end						


    // use loop to test every cases until 50. 			
endmodule

