`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 03:41:45 PM
// Design Name: 
// Module Name: register_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module register_tb;
    reg [3:0] D;
    reg clk;
    reg reset;
    wire [3:0] Q;
    wire [3:0] Qbar;

    registerbeh uut (
        .D(D),
        .clk(clk),
        .reset(reset),
        .Q(Q),
        .Qbar(Qbar)
    );

    always begin
        clk = 1'b0; #10;
        clk = 1'b1; #10;
    end

    initial begin
        D = 4'b0000;
        reset = 1;
        #20 reset = 0;
        #10 D = 4'b1111;
        #10 D = 4'b1010;
        #10 reset = 1;
        #10 reset = 0;
        #10 D = 4'b1100;
        #10 D = 4'b0101;
        #50 $stop;
    end
endmodule

