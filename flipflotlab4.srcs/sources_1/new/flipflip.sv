`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 02:51:38 PM
// Design Name: 
// Module Name: flipflip
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


module flipflip(input D,input reset,input select, input clk,output Q, output Qbar);
wire qm,qmbar,w0,w1;
dlatch u1 (D, reset, clk,qm,qmbar);
dlatch u2 (qm, reset, ~clk,w0,w1);
    nand(Q,w0,reset);
    and(Qbar, w1, ~reset);   


endmodule