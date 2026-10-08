// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// act1_fixed — verbose testbench
//
// slide 3-23
//
// The verbose bench for act1_fixed.v. It prints every step rather
// than the three the slide has room for, the internal signals where
// an internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_act1_fixed.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 12 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: y follows sel ? b : a at every step
//
// Run it:
//     iverilog -o tbv_act1_fixed.out act1_fixed.v tbv_act1_fixed.v
//     vvp tbv_act1_fixed.out
`timescale 1ns/1ns
module tbv_act1_fixed;
    reg a, b, sel; wire y; integer bad;
    sel2 u (.a(a), .b(b), .sel(sel), .y(y));
    initial begin
        bad = 0;
        $display("sel2 corrected -- always @*, which derives the list from");
        $display("the block. The same four steps as tbv_act1.v.");
        $display("");
        $display("  time  a  b  sel | y | should be | what woke the block");
        $display("  ------+--+--+-----+---+-----------+--------------------");
        sel = 1; a = 0; b = 0;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | sel and a were set",
                    $time, a, b, sel, y, sel ? b : a);
        if (y !== (sel ? b : a)) bad = bad + 1;
        b = 1;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | b changed, and b is read",
                    $time, a, b, sel, y, sel ? b : a);
        if (y !== (sel ? b : a)) bad = bad + 1;
        a = 1;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | a changed; y is unaffected",
                    $time, a, b, sel, y, sel ? b : a);
        if (y !== (sel ? b : a)) bad = bad + 1;
        b = 0;
        #1 $display("   %2t   %b  %b   %b  | %b |     %b     | b changed, and y follows",
                    $time, a, b, sel, y, sel ? b : a);
        if (y !== (sel ? b : a)) bad = bad + 1;
        $display("");
        $display("Columns four and five now agree on every line. The list");
        $display("cannot be incomplete because it is not written down, so");
        $display("editing the assignment cannot make it wrong again.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: y follows sel ? b : a at every step");
    end
endmodule
