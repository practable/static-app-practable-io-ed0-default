// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// gray — verbose testbench
//
// The verbose bench for gray.v. It prints every step, the
// internal signals where an internal signal is the mechanism,
// and a sentence at the end saying what was shown.
//
// Running it prints 23 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: one bit changes per enabled step
//
// Run it:
//     iverilog -o tbv_gray.out gray.v tbv_gray.v
//     vvp tbv_gray.out
`timescale 1ns/1ps
module tbv_gray;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_gray);
    end
    reg clk = 0, rst = 1, en = 0; wire [1:0] q; wire z;
    integer i, bad; reg [1:0] prev;
    gray2 u (.clk(clk), .rst(rst), .en(en), .q(q), .z(z));
    always #5 clk = ~clk;
    initial begin
        bad = 0;
        $display("gray2 -- the week 2 counter. Watch the two state bits:");
        $display("exactly one of them changes per step, which is what a");
        $display("Gray code is for.");
        $display("");
        $display("  clock | rst en | q  next | z | bits that changed");
        $display("  ------+--------+----+-----+---+-------------------");
        for (i = 0; i < 9; i = i + 1) begin
            @(negedge clk);
            rst = (i == 0);
            en  = (i > 0) && (i < 7);
            prev = q;
            @(posedge clk); #1;
            $display("    %0d   |  %b   %b | %b   %b  | %b | %0d %s",
                     i, rst, en, q, u.next, z,
                     {1'b0, q[1] ^ prev[1]} + {1'b0, q[0] ^ prev[0]},
                     (i == 0) ? "(reset)" :
                     (!en) ? "(held: en is low)" : "");
            if (i > 1 && en &&
                ({1'b0, q[1] ^ prev[1]} + {1'b0, q[0] ^ prev[0]}) != 1)
                bad = bad + 1;
        end
        $display("");
        $display("next is the combinational block's answer, and q is what");
        $display("the register took at the last edge. The default at the");
        $display("top of that block is next = q, so when the enable is low");
        $display("every path still assigns next and the machine holds");
        $display("without needing an else.");
        $display("");
        $display("z is a continuous assignment on q alone, which is what");
        $display("makes it a Moore output: it depends on where the machine");
        $display("is and not on how it got there.");
        $display("");
        $display("%s", bad ? "FAIL" :
                 "PASS: one bit changes per enabled step");
        $finish(0);
    end
endmodule
