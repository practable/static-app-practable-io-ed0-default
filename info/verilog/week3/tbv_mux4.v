// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// mux4 — verbose testbench
//
// slide 3-11
//
// The verbose bench for mux4.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_mux4.v is the short version, and is the one the lecture shows.
//
// Running it prints 13 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: all four selections correct
//
// Run it:
//     iverilog -o tbv_mux4.out mux4.v tbv_mux4.v
//     vvp tbv_mux4.out
`timescale 1ns/1ps
module tbv_mux4;
    reg [3:0] d; reg [1:0] sel; wire y; integer i, bad;
    mux4 u (.d(d), .sel(sel), .y(y));
    initial begin
        bad = 0;
        d = 4'b1010;
        $display("mux4 -- a case statement with every branch written.");
        $display("d is held at %b, so d[3] is 1 and d[0] is 0.", d);
        $display("");
        $display("   sel  | picks | y   | assigned by");
        $display("  ------+-------+-----+-------------");
        for (i = 0; i < 4; i = i + 1) begin
            sel = i[1:0];
            #1;
            $display("   %b   | d[%0d]  | %b   | its own branch",
                     sel, sel, y);
            if (y !== d[sel]) bad = bad + 1;
        end
        $display("");
        $display("Four values of sel, four branches, and y assigned on");
        $display("every path through the block. That is what makes it");
        $display("combinational: the block can never be entered and left");
        $display("without y having been given a value.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: all four selections correct");
    end
endmodule
