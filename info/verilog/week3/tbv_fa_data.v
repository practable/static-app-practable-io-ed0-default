// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// fa_data — verbose testbench
//
// slide 3-9
//
// The verbose bench for fa_data.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_fa_data.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 18 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: all eight cases equal a + b + cin
//
// Run it:
//     iverilog -o tbv_fa_data.out fa_data.v tbv_fa_data.v
//     vvp tbv_fa_data.out
`timescale 1ns/1ps
module tbv_fa_data;
    reg a, b, cin; wire s, cout; integer i, bad;
    fa_data u (.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
    initial begin
        bad = 0;
        $display("fa_data -- the same full adder as one assignment:");
        $display("assign {cout, s} = a + b + cin;");
        $display("");
        $display("   a b cin | a+b+cin | {cout,s} | cout s");
        $display("  ---------+---------+----------+-------");
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i[2:0];
            #1;
            $display("   %b %b  %b  |    %0d    |    %b    |  %b   %b",
                     a, b, cin, {1'b0, a} + b + cin,
                     {cout, s}, cout, s);
            if ({cout, s} !== a + b + cin) bad = bad + 1;
        end
        $display("");
        $display("The concatenation names the two outputs as one two-bit");
        $display("value, which is exactly what a sum and its carry are.");
        $display("Nothing here says how the adder is built; the synthesiser");
        $display("chooses, and for anything larger than one bit it will");
        $display("choose better than a hand-written netlist.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: all eight cases equal a + b + cin");
    end
endmodule
