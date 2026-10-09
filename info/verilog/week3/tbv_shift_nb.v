// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// shift_nb — verbose testbench
//
// The verbose bench for shift_nb.v. It prints every step, the
// internal signals where an internal signal is the mechanism,
// and a sentence at the end saying what was shown.
//
// Running it prints 15 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     one clock per stage. This is a shift register.
//
// Run it:
//     iverilog -o tbv_shift_nb.out shift_nb.v tbv_shift_nb.v
//     vvp tbv_shift_nb.out
`timescale 1ns/1ps
module tbv_shift_nb;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_shift_nb);
    end
    reg clk = 0, d = 0; wire q1, q2, q3; integer i;
    shift_nb u (.clk(clk), .d(d), .q1(q1), .q2(q2), .q3(q3));
    always #5 clk = ~clk;
    initial begin
        $display("shift_nb -- three non-blocking assignments. A single");
        $display("one-clock pulse is put on d and then followed through.");
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
                     q3 ? "stage 3            " :
                     q2 ? "stage 2            " :
                     q1 ? "stage 1            " :
                          "not in the register");
            @(negedge clk);
        end
        $display("");
        $display("All three right-hand sides are read as they were before");
        $display("the edge, so q2 gets the old q1 and not the one assigned");
        $display("two lines above it. Each stage is independent of the");
        $display("order the three lines are written in, and the pulse takes");
        $display("one clock per stage. This is a shift register.");
        $finish(0);
    end
endmodule
