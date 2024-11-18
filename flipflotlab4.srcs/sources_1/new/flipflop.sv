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
/*
module reg4bit(
input [3:0] D,   
    input clk,        
    input reset,      
    input enable, 
    output [3:0] Q,  
    output [3:0] Qbar
    );
    always @(posedge clk , negedge reset)
    begin
        if (reset) begin
            Q <= 4'b0000;
            Qbar <= 4'b1111;
        end 
        else
      begin
    */




//7sgements
module top_module(
    input wire CLK100MHZ,     // Clock signal
    input wire CPU_RESETN,    // Active-low reset
    input wire [15:0] SW,     // Switch inputs
    input wire BTNC,          // Button press (clock signal)
    output wire CA1, CB1, CC1, CD1, CE1, CF1, CG1, DP1,  // 7-segment outputs for register 1
    output wire CA2, CB2, CC2, CD2, CE2, CF2, CG2, DP2,  // 7-segment outputs for register 2
    output wire [7:0] AN      // Digit enable signals
);

    wire [7:0] Q1, Q2;   // Outputs from both registers
    
    // Instantiate the two registers
    registerbeh reg1 (
        .D(SW[7:0]),         // Data from switches
        .clk(BTNC),          // Clock from button press
        .reset(CPU_RESETN),  // Active-low reset
        .Q(Q1),
        .Qbar()              // Not used here
    );

    registerbeh reg2 (
        .D(SW[7:0]),         // Data from switches
        .clk(BTNC),          // Clock from button press
        .reset(CPU_RESETN),  // Active-low reset
        .Q(Q2),
        .Qbar()              // Not used here
    );

    // Instantiate the 7-segment display for register 1
    sev_seg_top display1 (
        .CLK100MHZ(CLK100MHZ),
        .CPU_RESETN(CPU_RESETN),
        .CA(CA1), .CB(CB1), .CC(CC1), .CD(CD1), .CE(CE1), .CF(CF1), .CG(CG1), .DP(DP1),
        .AN(AN),
        .SW(Q1)  // Use the output of register 1 for the display
    );

    sev_seg_top display2 (
        .CLK100MHZ(CLK100MHZ),
        .CPU_RESETN(CPU_RESETN),
        .CA(CA2), .CB(CB2), .CC(CC2), .CD(CD2), .CE(CE2), .CF(CF2), .CG(CG2), .DP(DP2),
        .AN(AN),
        .SW(Q2)  
    );

endmodule




