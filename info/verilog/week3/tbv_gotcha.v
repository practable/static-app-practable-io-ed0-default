// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// gotcha — verbose testbench
//
// slide 3-18
//
// The verbose bench for gotcha.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_gotcha.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 34 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//          testbench therefore compares with === or !==.
//
// Run it:
//     iverilog -o tbv_gotcha.out gotcha.v tbv_gotcha.v
//     vvp tbv_gotcha.out
`timescale 1ns/1ps
module tbv_gotcha;
    reg  [3:0] a, b, u4;
    reg  [4:0] wide;
    reg signed [3:0] p;
    initial begin
        $display("");
        $display("(The seven lines above are printed by gotcha.v itself:");
        $display("it is a module with no ports and an initial block of");
        $display("its own. This bench cannot drive it, so it recomputes");
        $display("the same expressions and shows the working.)");
        $display("");
        $display("The seven results, with the intermediate values that");
        $display("explain them.");
        $display("");
        $display("1. Subtraction in four unsigned bits");
        a = 4'd3; b = 4'd5;
        $display("     a = %0d = %b,  b = %0d = %b", a, a, b, b);
        $display("     a - b as five bits = %b", {1'b0, a} - {1'b0, b});
        $display("     a - b as four bits = %b = %0d", a - b, a - b);
        $display("     The borrow is discarded, so 3 - 5 reads as 14.");
        $display("");
        $display("2. An average that is not an average");
        a = 4'd9; b = 4'd9;
        $display("     a + b in four bits  = %b = %0d", a + b, a + b);
        $display("     shifted right       = %b = %0d",
                 (a + b) >> 1, (a + b) >> 1);
        wide = a + b;
        $display("     a + b in five bits  = %b = %0d", wide, wide);
        $display("     shifted right       = %b = %0d", wide >> 1, wide >> 1);
        $display("     The width came from the operands, not the target.");
        $display("");
        $display("3. Arithmetic shift, twice");
        u4 = 4'b1110; p = 4'sb1110;
        $display("     unsigned reg 1110 >>> 1 = %b", u4 >>> 1);
        $display("     signed   reg 1110 >>> 1 = %b", p >>> 1);
        $display("     >>> sign-extends only when the operand is signed.");
        $display("");
        $display("4. An unknown bit is not a false one");
        $display("     4'b0x01 ==  4'b0001 = %b   (neither true nor false)",
                 4'b0x01 == 4'b0001);
        $display("     4'b0x01 === 4'b0x01 = %b   (compares x as a value)",
                 4'b0x01 === 4'b0x01);
        $display("     if (a == b) takes the else branch when either side");
        $display("     has an x, without the values being different. A");
        $display("     testbench therefore compares with === or !==.");
    end
endmodule
