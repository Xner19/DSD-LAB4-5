`timescale 1ns / 1ps

module dlatch_tb;
    reg s;
    reg reset;
    reg clk;
    reg enable;
    wire q;
    wire qbar;

    dlatch uut (
        .s(s),
        .reset(reset),
        .enable(enable),
        .clk(clk),
        .q(q),
        .qbar(qbar)
    );

    always begin
        clk = 1'b0; #10;
        clk = 1'b1; #10;
    end

    initial begin
        s = 0;
        reset = 1;
        enable = 0;

        #20 reset = 0;
        #10 enable = 1;
        #10 s = 1;
        #20 s = 0;

        #10 reset = 1;
        #20 reset = 0;

        #30 s = 1;
        #20 s = 0;
        #10 enable = 0;

        #50 $stop;
    end
endmodule
