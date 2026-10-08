// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// fa_gate — verbose testbench
//
// slide 3-9
//
// The verbose bench for fa_gate.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_fa_gate.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 18 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: all eight cases equal a + b + cin
//
// Run it:
//     iverilog -o tbv_fa_gate.out fa_gate.v tbv_fa_gate.v
//     vvp tbv_fa_gate.out
`timescale 1ns/1ps
module tbv_fa_gate;
    reg a, b, cin; wire s, cout; integer i, bad;
    fa_gate u (.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
    initial begin
        bad = 0;
        $display("fa_gate -- five gate primitives, with the internal nets");
        $display("that join them. p is a^b; g1 and g2 are the two ways a");
        $display("carry can be generated.");
        $display("");
        $display("   a b cin | p g1 g2 | s cout | a+b+cin");
        $display("  ---------+---------+--------+---------");
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i[2:0];
            #1;
            $display("   %b %b  %b  | %b  %b  %b | %b   %b  |    %0d",
                     a, b, cin, u.p, u.g1, u.g2, s, cout,
                     {1'b0, a} + b + cin);
            if ({cout, s} !== a + b + cin) bad = bad + 1;
        end
        $display("");
        $display("cout is g1 or g2: either both addends were 1, or exactly");
        $display("one was and the carry in was. The structure is fixed by");
        $display("the text -- five gates and three named nets -- which is");
        $display("what gate level means.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: all eight cases equal a + b + cin");
    end
endmodule
