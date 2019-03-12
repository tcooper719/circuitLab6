`timescale 1ns / 1ns 

module testbench; 

wire [15:0] A_count;
wire oFlow;
reg [15:0] dataIn;
reg up;
reg down;
reg load;
reg clear;
reg CLK;

counterUpDown counter1(
                        A_count,
                        oFlow,
                        dataIn,
                        up,
                        down,
                        load,
                        clear,
                        CLK);

initial
    begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

initial
    begin
            clear = 0;
        #10

            load = 0;
        #30

            clear = 1;
            up = 1;
            down = 0;
        #656000 //count up from zero past overflow
            
            up = 0;
            down = 1;
        #1000 //count down and overflow

            clear = 0;
        #20 //reset the counter

            clear = 1;
            up = 1;
            down = 0;
        #100 //let run after clear

            load = 1;
            dataIn = 16'b1000000000000000;
        #20 //load data in and start counting up

            load = 0;
        
    end


initial
   $monitor($stime,, A_count,, oFlow,, dataIn,, up,, down,, load,, clear,, CLK);
endmodule 