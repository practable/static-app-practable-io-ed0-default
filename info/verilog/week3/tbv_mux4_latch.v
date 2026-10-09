// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// mux4_latch — verbose testbench
//
// The verbose bench for mux4_latch.v. It prints every step, the
// internal signals where an internal signal is the mechanism,
// and a sentence at the end saying what was shown.
//
// This design is deliberately wrong. The transcript shows the
// inferred latch holding its value.
//
// Running it prints 17 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     same circuit with every branch written.
//
// Run it:
//     iverilog -o tbv_mux4_latch.out mux4_latch.v tbv_mux4_latch.v
//     vvp tbv_mux4_latch.out
`timescale 1ns/1ns
module tbv_mux4_latch;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_mux4_latch);
    end
    reg [3:0] d; reg [1:0] sel; wire y; integer i;
    mux4_bad u (.d(d), .sel(sel), .y(y));
    initial begin
        d = 4'b1010;
        $display("mux4_bad -- the same case with the 11 branch missing.");
        $display("d is held at %b until the last two lines.", d);
        $display("");
        $display("  time  sel   d    | y | what happened");
        $display("  ------+-----+------+---+---------------------------");
        for (i = 0; i < 4; i = i + 1) begin
            sel = i[1:0];
            #1;
            $display("   %2t   %b   %b | %b | %s", $time, sel, d, y,
                     (sel === 2'b11) ? "no branch: y keeps its value"
                                     : "its branch assigns y        ");
        end
        d = 4'b0101;
        #1 $display("   %2t   %b   %b | %b | d changed, y did not move",
                    $time, sel, d, y);
        d = 4'b1111;
        #1 $display("   %2t   %b   %b | %b | nor now: y is stored, not driven",
                    $time, sel, d, y);
        $display("");
        $display("From sel = 11 onwards the output stopped being a");
        $display("function of the inputs. Something has to remember the");
        $display("old value, and that something is a latch -- transparent,");
        $display("with no clock and no defined timing. Nothing in the");
        $display("source asked for one.");
        $display("");
        $display("This example is wrong on purpose. See mux4.v for the");
        $display("same circuit with every branch written.");
    end
endmodule
