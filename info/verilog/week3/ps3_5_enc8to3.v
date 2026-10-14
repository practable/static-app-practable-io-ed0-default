`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.5: solution
//
// 8-to-3 binary encoder from the truth table: exactly one input high,
// and y gives its position.
//
// The other 248 inputs (none high, or more than one high) are not in the
// table. Here the default branch makes y = xxx for all of them: an explicit
// "don't care", which synthesis may fill in however gives the least logic,
// and which shows up as x in simulation. That is a choice made in the code.
// If the default were left out, the language would choose instead: y would
// not be assigned on those paths, so it would keep its old value and a
// latch would be inferred. A design that must give a defined answer for
// every input would use a priority encoder, or add a "valid" output.
module ps3_enc8to3 (
    input      [7:0] a,     // a[7] .. a[0]
    output reg [2:0] y
);
    always @* begin
        case (a)
            8'b0000_0001: y = 3'd0;
            8'b0000_0010: y = 3'd1;
            8'b0000_0100: y = 3'd2;
            8'b0000_1000: y = 3'd3;
            8'b0001_0000: y = 3'd4;
            8'b0010_0000: y = 3'd5;
            8'b0100_0000: y = 3'd6;
            8'b1000_0000: y = 3'd7;
            default:      y = 3'bxxx;   // the other 248 inputs: don't care
        endcase
    end
endmodule
