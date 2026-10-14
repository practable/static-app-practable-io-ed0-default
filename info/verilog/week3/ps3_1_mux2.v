`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.1: solution
//
// One-bit 2-to-1 multiplexer: y = a when sel = 0, y = b when sel = 1.
// Every port here is a wire. Inputs are always wires, and y is driven by a
// continuous assignment, so it is a wire too. Nothing in this module is
// assigned inside an always block, so nothing needs to be a reg.
module ps3_mux2 (
    input  a,       // selected when sel = 0
    input  b,       // selected when sel = 1
    input  sel,     // select line
    output y        // output (a wire, driven by assign)
);
    assign y = sel ? b : a;
endmodule
