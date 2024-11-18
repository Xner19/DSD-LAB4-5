module top(
    input [3:0] D,  // Input data
    input clk,      // Clock signal
    input reset,    // Reset signal
    output [6:0] seg // 7-segment display
);
    wire [3:0] Q;
    wire [3:0] Qbar;

    // Instantiate register
    registerbeh reg_inst (
        .D(D),
        .clk(clk),
        .reset(reset),
        .Q(Q),
        .Qbar(Qbar)
    );

    sev_seg seg_inst (
        .bin(Q),
        .seg(seg)
    );
endmodule
