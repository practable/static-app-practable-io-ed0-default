`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.2: solution
//
// Four-bit 2-to-1 multiplexer. Only the declarations changed from 3.1:
// a, b and y gained a [3:0] range. The assign line is identical, because
// ?: works on whole vectors. sel is still one bit: there are still only two
// choices, each of them is just wider.
module ps3_mux2x4 (
    input  [3:0] a,     // selected when sel = 0
    input  [3:0] b,     // selected when sel = 1
    input        sel,   // still one bit
    output [3:0] y
);
    assign y = sel ? b : a;
endmodule
