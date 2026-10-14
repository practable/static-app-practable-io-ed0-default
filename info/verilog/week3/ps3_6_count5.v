`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.6: solution
//
// Five-bit up counter with synchronous reset.
// After 31 (5'b11111) the next count is 0. Nothing extra had to be written:
// q + 1 is 32, which needs six bits, and assigning it to the five-bit q
// keeps only the low five bits, which are 00000. The wrap-around comes from
// the width of q.
module ps3_count5 (
    input            clk,
    input            rst,   // synchronous: only acts on a rising clock edge
    output reg [4:0] q
);
    always @(posedge clk)
        if (rst) q <= 5'd0;
        else     q <= q + 1'b1;
endmodule
