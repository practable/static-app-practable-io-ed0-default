`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.8(a), corrected: solution
//
// Fault: blocking assignments (=) in a clocked block. Each line sees the
// value just written by the line above, so d passes through all three bits
// in one clock: the transcript shows 111 after one clock.
// Fix: non-blocking assignments (<=). All three right-hand sides are read
// before any bit changes, so each bit takes its neighbour's old value and
// the one moves one place per clock.
module shift3 (input clk, rst, en, input d, output reg [2:0] q);
    always @(posedge clk)
        if (rst) q <= 3'b000;
        else if (en) begin
            q[0] <= d;
            q[1] <= q[0];
            q[2] <= q[1];
        end
endmodule
