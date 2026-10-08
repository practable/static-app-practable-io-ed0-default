// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// width — design
//
// slide 3-19
//
// The target width extends an addition, but not inside a
// concatenation.
//
// Run it:
//     iverilog -o width.out width.v tb_width.v
//     vvp width.out

module widths (input [3:0] a, b,
               output [3:0] narrow,
               output [4:0] wide, boxed, extended);
    assign narrow   = a + b;              // 4 bits: the carry is lost
    assign wide     = a + b;              // 5 bits: the target widens it
    assign boxed    = {a + b};            // 4 bits: self-determined in {}
    assign extended = {1'b0, a} + b;      // 5 bits: operand widened
endmodule
