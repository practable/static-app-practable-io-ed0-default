// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// casez — verbose testbench
//
// slide 3-17
//
// The verbose bench for casez.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_casez.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 27 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: any is set for every non-zero request
//
// Run it:
//     iverilog -o tbv_casez.out casez.v tbv_casez.v
//     vvp tbv_casez.out
`timescale 1ns/1ps
module tbv_casez;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_casez);
    end
    reg [3:0] r; wire [1:0] g; wire any; integer i, bad;
    enc u (.r(r), .g(g), .any(any));
    initial begin
        bad = 0;
        $display("enc -- casez, where ? in a pattern matches either value.");
        $display("Four patterns cover fifteen of the sixteen requests; the");
        $display("default covers the sixteenth and reports it.");
        $display("");
        $display("    r   | any  g | matched | why");
        $display("  ------+--------+---------+--------------------------");
        for (i = 0; i < 16; i = i + 1) begin
            r = i[3:0];
            #1;
            $display("   %b |  %b   %0d | %s | %s", r, any, g,
                     r[3] ? "4'b1???" : r[2] ? "4'b01??" :
                     r[1] ? "4'b001?" : r[0] ? "4'b0001" : "default",
                     r[3] ? "top bit set, rest irrelevant" :
                     r[2] ? "r[3] clear, r[2] set        " :
                     r[1] ? "top two clear, r[1] set     " :
                     r[0] ? "only r[0] set               " :
                            "no request at all           ");
            if (any !== (|r)) bad = bad + 1;
        end
        $display("");
        $display("The ? is a wildcard in the pattern only; it means nothing");
        $display("in the value being matched. The default is doing two jobs:");
        $display("it covers r = 0000, so no path leaves g unassigned and no");
        $display("latch is inferred, and it drives any low so that a reader");
        $display("of the outputs can tell no request from request zero.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: any is set for every non-zero request");
    end
endmodule
