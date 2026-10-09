// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// priority — verbose testbench
//
// The verbose bench for priority.v. It prints every step, the
// internal signals where an internal signal is the mechanism,
// and a sentence at the end saying what was shown.
//
// Running it prints 28 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: valid is set for every non-zero request
//
// Run it:
//     iverilog -o tbv_priority.out priority.v tbv_priority.v
//     vvp tbv_priority.out
`timescale 1ns/1ps
module tbv_priority;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_priority);
    end
    reg [3:0] r; wire [1:0] y; wire valid; integer i, bad;
    prio u (.r(r), .y(y), .valid(valid));
    initial begin
        bad = 0;
        $display("prio -- a nested if-else, tested in order r[3] first.");
        $display("Every one of the sixteen request patterns, so that the");
        $display("priority is visible rather than asserted.");
        $display("");
        $display("    r   | valid  y | winner | requests also set");
        $display("  ------+----------+--------+-------------------");
        for (i = 0; i < 16; i = i + 1) begin
            r = i[3:0];
            #1;
            $display("   %b |   %b    %0d | %s   | %0d", r, valid, y,
                     r[3] ? "r[3]" : r[2] ? "r[2]" :
                     r[1] ? "r[1]" : r[0] ? "r[0]" : "none",
                     ({3'b0, r[3]} + {3'b0, r[2]} +
                      {3'b0, r[1]} + {3'b0, r[0]}) - {3'b0, |r});
            if (valid !== (|r)) bad = bad + 1;
        end
        $display("");
        $display("The last column counts the requests that lost. Whenever");
        $display("it is not zero, a lower-numbered request was set and was");
        $display("ignored -- which is the definition of priority, and is");
        $display("what an if-else chain builds. A case statement with the");
        $display("same four labels would refuse the overlapping patterns");
        $display("instead of ranking them.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: valid is set for every non-zero request");
    end
endmodule
