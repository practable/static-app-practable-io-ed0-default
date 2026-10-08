// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// adder4 — design
//
// slide 3-20
//
// Four instances of one module; exhaustively checked.
//
// Modules in this file: fa_data, adder4. adder4 is the design; the
// other is what it instantiates.
//
// Run it:
//     iverilog -o adder4.out adder4.v tb_adder4.v
//     vvp adder4.out

module fa_data (input a, b, cin, output s, cout);
    assign {cout, s} = a + b + cin;
endmodule

module adder4 (input [3:0] a, b, input cin,
               output [3:0] s, output cout);
    wire [2:0] c;
    fa_data f0 (a[0], b[0], cin,  s[0], c[0]);
    fa_data f1 (a[1], b[1], c[0], s[1], c[1]);
    fa_data f2 (a[2], b[2], c[1], s[2], c[2]);
    fa_data f3 (a[3], b[3], c[2], s[3], cout);
endmodule
