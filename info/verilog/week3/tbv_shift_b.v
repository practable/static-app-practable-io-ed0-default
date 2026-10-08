// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// shift_b — verbose testbench
//
// slide 3-27
//
// The verbose bench for shift_b.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_shift_b.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 18 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     says what it appears to say.
//
// Run it:
//     iverilog -o tbv_shift_b.out shift_b.v tbv_shift_b.v
//     vvp tbv_shift_b.out
`timescale 1ns/1ps
module tbv_shift_b;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_shift_b);
    end
    reg clk = 0, d = 0; wire q1, q2, q3; integer i;
    shift_b u (.clk(clk), .d(d), .q1(q1), .q2(q2), .q3(q3));
    always #5 clk = ~clk;
    initial begin
        $display("shift_b -- the same three lines with = instead of <=,");
        $display("and the same single pulse on d.");
        $display("");
        $display("  clock | d | q1 q2 q3 | where the pulse is");
        $display("  ------+---+----------+--------------------");
        d = 0;                       // flush: three clocks of zero,
        repeat (3) @(posedge clk);   // so no stage starts unknown
        @(negedge clk);
        for (i = 0; i < 6; i = i + 1) begin
            d = (i == 1);
            @(posedge clk); #1;
            $display("    %0d   | %b |  %b  %b  %b | %s",
                     i, d, q1, q2, q3,
                     (q1 & q2 & q3) ? "all three at once  " :
                     (q1 | q2 | q3) ? "partly through     " :
                                      "not in the register");
            @(negedge clk);
        end
        $display("");
        $display("q1 takes d, then q2 reads the q1 just assigned, then q3");
        $display("reads that. The pulse reaches all three outputs on one");
        $display("edge: one flip-flop's delay, not three. Compare the");
        $display("middle column with tbv_shift_nb.v, which differs by one");
        $display("character on each of three lines.");
        $display("");
        $display("The order of the lines now matters. Reversing them gives");
        $display("the shift register back, which means the text no longer");
        $display("says what it appears to say.");
        $finish(0);
    end
endmodule
