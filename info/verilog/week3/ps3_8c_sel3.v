`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.8(c), corrected: solution
//
// Fault: incomplete case. sel = 2'b11 has no branch, so on that path y is
// not assigned and keeps its previous value: an inferred latch. In the
// transcript y stays at 1 for sel = 11, even after d changes.
// Fix: a default branch so y is assigned on every path. With only three
// inputs, 0 is a sensible value for the unused select code.
module sel3 (input [2:0] d, input [1:0] sel, output reg y);
    always @* begin
        case (sel)
            2'b00:   y = d[0];
            2'b01:   y = d[1];
            2'b10:   y = d[2];
            default: y = 1'b0;
        endcase
    end
endmodule
