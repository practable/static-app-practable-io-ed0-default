`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.8(b), corrected: solution
//
// Fault: operand width. In (a + b) > 4'd15 every operand is four bits, so
// a + b is worked out in four bits and the carry is lost before the
// comparison. A four-bit value is never greater than 15, so cout is always
// 0 (the transcript shows cout = 0 for 9 + 9 and for 15 + 1).
// Fix: make the result five bits wide by concatenating cout and sum on the
// left-hand side. The addition is then done in five bits and bit 4 is the
// carry.
module add4 (input [3:0] a, b, output [3:0] sum, output cout);
    assign {cout, sum} = a + b;
endmodule
