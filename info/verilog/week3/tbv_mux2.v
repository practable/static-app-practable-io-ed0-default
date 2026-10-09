// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// mux2 — verbose testbench
//
// The verbose bench for mux2.v. It prints every step, the
// internal signals where an internal signal is the mechanism,
// and a sentence at the end saying what was shown.
//
// Running it prints 16 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: all eight cases correct
//
// Run it:
//     iverilog -o tbv_mux2.out mux2.v tbv_mux2.v
//     vvp tbv_mux2.out
`timescale 1ns/1ps
module tbv_mux2;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_mux2);
    end
    reg a, b, sel; wire y; integer i, bad;
    mux2 u (.a(a), .b(b), .sel(sel), .y(y));
    initial begin
        bad = 0;
        $display("mux2 -- a two-input multiplexer as one continuous");
        $display("assignment. Watch which input the output follows.");
        $display("");
        $display("   sel   a   b  |   y   | following");
        $display("  --------------+-------+-----------");
        for (i = 0; i < 8; i = i + 1) begin
            {sel, b, a} = i[2:0];
            #1;
            $display("    %b    %b   %b  |   %b   | %s",
                     sel, a, b, y, sel ? "b" : "a");
            if (y !== (sel ? b : a)) bad = bad + 1;
        end
        $display("");
        $display("The output tracks a while sel is 0 and b while sel is 1,");
        $display("and nothing else. There is no clock and no block, so");
        $display("there is nothing that could hold a value.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: all eight cases correct");
    end
endmodule
