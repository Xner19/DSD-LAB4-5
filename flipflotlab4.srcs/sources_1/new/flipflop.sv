`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 01:50:29 PM
// Design Name: 
// Module Name: flipflop
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
module dlatch(input s, reset, clk, output q, qbar);
    wire w0, w1,w2, reset_n;
    
    assign reset_n = ~reset;

    nand(w0, s, clk);
    nand(w1, ~s, clk);
    nand(w2, w0, qbar);
    and(q,w2,reset_n);
    nand(qbar, w1, q, reset_n);  
endmodule

module flipflip(input D, input reset, input clk, output Q, output Qbar);
    wire qm, qmbar;
    dlatch master (.s(D), .reset(reset), .clk(clk), .q(qm), .qbar(qmbar));
    dlatch slave  (.s(qm), .reset(reset),.clk(~clk), .q(Q), .qbar(Qbar));
endmodule


/*
module register(
    input [3:0] D,   
    input clk,        
    input reset,      
    output [3:0] Q,  
    output [3:0] Qbar 
);
    flipflip u0( D[0], reset, clk, Q[0], Qbar[0]);
    flipflip u1( D[1], reset, clk, Q[1], Qbar[1]);
    flipflip u2( D[2], reset, clk, Q[2], Qbar[2]);
    flipflip u3( D[3], reset, clk, Q[3], Qbar[3]);

endmodule*/
module registerbeh(
    input [3:0] D,
    input clk,
    input reset,
    output reg [3:0] Q,
    output reg [3:0] Qbar
);
    always @(posedge clk , posedge reset) 
    begin
        if (reset) begin
            Q <= 4'b0000;
            Qbar <= 4'b1111;
        end 
        else
      begin
      Q <= D;
       Qbar <= ~D;
     end
    end
endmodule

