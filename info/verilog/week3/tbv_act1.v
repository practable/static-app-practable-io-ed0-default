// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// act1 — verbose testbench
//
// slide 3-22
//
// The verbose bench for act1.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_act1.v is the short version, and is the one the lecture shows.
//
// This is the activity module, as set. The transcript shows the
// fault; act1_fixed.v is the correction.
//
// Running it prints 16 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     the same bench against the correction.
//
// Run it:
//     iverilog -o tbv_act1.out act1.v tbv_act1.v
//     vvp tbv_act1.out
`timescale 1ns/1ns
module tbv_act1;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_act1);
    end
    reg a, b, sel; wire y;
    sel2 u (.a(a), .b(b), .sel(sel), .y(y));
    initial begin
        $display("sel2 as set -- always @(a or sel). b is assigned inside");
        $display("the block but is not in the list.");
        $display("");
        $display("  time  a  b  sel | y | should be | what woke the block");
        $display("  ------+--+--+-----+---+-----------+--------------------");
        sel = 1; a = 0; b = 0;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | sel and a were set",
                    $time, a, b, sel, y, sel ? b : a);
        b = 1;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | nothing: b is not named",
                    $time, a, b, sel, y, sel ? b : a);
        a = 1;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | a changed, so the block ran",
                    $time, a, b, sel, y, sel ? b : a);
        b = 0;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | nothing again",
                    $time, a, b, sel, y, sel ? b : a);
        $display("");
        $display("With sel held at 1 the output should follow b, and it");
        $display("only does so when a happens to move as well. What this");
        $display("text describes is not a multiplexer: it is a multiplexer");
        $display("with a latch on one input, because a signal that is read");
        $display("but not followed has to be remembered from the last time");
        $display("the block ran.");
        $display("");
        $display("This is the activity module as set. tbv_act1_fixed.v is");
        $display("the same bench against the correction.");
    end
endmodule
