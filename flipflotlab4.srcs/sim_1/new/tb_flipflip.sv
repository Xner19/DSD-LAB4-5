`timescale 1ns / 1ps

module flipflip_tb;
    reg D;
    reg reset;
    reg clk;
    wire Q;
    wire Qbar;

    flipflip uut (
        .D(D),
        .reset(reset),
        .clk(clk),
        .Q(Q),
        .Qbar(Qbar)
    );

    always begin
        clk = 1'b0; #10;
        clk = 1'b1; #10;
    end

    initial begin
        D = 0;
        reset = 1;
        #20 reset = 0;
        #10 D = 1;
        #10 D = 0;
        #10 reset = 1;
        #10 D = 1;
        #10 reset = 0;
        #10 D = 0;
        #10 D = 1;
        #10 reset = 1;
        #10 D = 0;
        #10 reset = 0;
        #10 D = 1;
        #10 D = 0;
        #50 $stop;
    end
endmodule
