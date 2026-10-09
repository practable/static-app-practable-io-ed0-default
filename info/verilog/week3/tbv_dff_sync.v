// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// dff_sync — verbose testbench
//
// The verbose bench for dff_sync.v. It prints every step, the
// internal signals where an internal signal is the mechanism,
// and a sentence at the end saying what was shown.
//
// Running it prints 15 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     difference from the flop in resets.v.
//
// Run it:
//     iverilog -o tbv_dff_sync.out dff_sync.v tbv_dff_sync.v
//     vvp tbv_dff_sync.out
`timescale 1ns/1ns
module tbv_dff_sync;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_dff_sync);
    end
    reg clk = 0, rst = 1, d = 0; wire q; integer i;
    dff_sync u (.clk(clk), .rst(rst), .d(d), .q(q));
    always #5 clk = ~clk;
    initial begin
        $display("dff_sync -- a D flip-flop whose reset is tested inside");
        $display("the clocked block. Sampled here just before each rising");
        $display("edge and again just after it.");
        $display("");
        $display("  time  rst  d | q before | q after | why");
        $display("  ------+-----+--+----------+---------+---------------");
        for (i = 0; i < 6; i = i + 1) begin
            case (i)
                0: begin rst = 1; d = 1; end
                1: begin rst = 0; d = 1; end
                2: begin rst = 0; d = 0; end
                3: begin rst = 1; d = 1; end
                4: begin rst = 0; d = 1; end
                5: begin rst = 0; d = 1; end
            endcase
            @(negedge clk);
            $write("   %2t    %b   %b |    %b     ", $time, rst, d, q);
            @(posedge clk); #1;
            $display("|    %b    | %s", q,
                     rst ? "reset wins, sampled at the edge" :
                           "q takes d, sampled at the edge ");
        end
        $display("");
        $display("Nothing happens between edges. The reset is an input like");
        $display("any other: it is looked at when the clock rises and not");
        $display("before, which is what synchronous means and is the whole");
        $display("difference from the flop in resets.v.");
        $finish(0);
    end
endmodule
