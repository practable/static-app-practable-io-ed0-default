// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// sens — verbose testbench
//
// slide 3-14
//
// The verbose bench for sens.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_sens.v is the short version, and is the one the lecture shows.
//
// This design is deliberately wrong. The transcript shows the
// simulation ignoring sel; a synthesiser would build the
// multiplexer anyway.
//
// Running it prints 20 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     the same assignment under always @*.
//
// Run it:
//     iverilog -o tbv_sens.out sens.v tbv_sens.v
//     vvp tbv_sens.out
`timescale 1ns/1ns
module tbv_sens;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_sens);
    end
    reg a, b, sel; wire y;
    sens u (.a(a), .b(b), .sel(sel), .y(y));
    initial begin
        $display("sens -- always @(a or b), and the block reads sel too.");
        $display("Watch the third column against the fourth: y is only");
        $display("ever right just after the block has been woken.");
        $display("");
        $display("  time  a  b  sel | y | should be | what woke the block");
        $display("  ------+--+--+-----+---+-----------+--------------------");
        a = 0; b = 1; sel = 0;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | a and b were set          ",
                    $time, a, b, sel, y, sel ? b : a);
        sel = 1;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | nothing: sel is not named ",
                    $time, a, b, sel, y, sel ? b : a);
        a = 1;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | a changed, so the block ran",
                    $time, a, b, sel, y, sel ? b : a);
        b = 0;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | b changed, so it ran again ",
                    $time, a, b, sel, y, sel ? b : a);
        sel = 0;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | nothing: wrong again      ",
                    $time, a, b, sel, y, sel ? b : a);
        $display("");
        $display("Two of the five lines have y disagreeing with what the");
        $display("assignment says it should be, and both are lines where");
        $display("only sel moved.");
        $display("");
        $display("The sensitivity list is a trigger condition for the");
        $display("simulator and nothing else. A synthesiser reads the");
        $display("assignment instead and builds the multiplexer, so the");
        $display("board would do what column five says and the simulation");
        $display("does what column four says.");
        $display("");
        $display("This example is wrong on purpose. See act1_fixed.v for");
        $display("the same assignment under always @*.");
    end
endmodule
