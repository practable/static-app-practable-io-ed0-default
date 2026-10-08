// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// counter — verbose testbench
//
// slide 3-28
//
// The verbose bench for counter.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_counter.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 22 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: reset clears, enable counts, and q holds when it should
//
// Run it:
//     iverilog -o tbv_counter.out counter.v tbv_counter.v
//     vvp tbv_counter.out
`timescale 1ns/1ps
module tbv_counter;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_counter);
    end
    reg clk = 0, rst = 1, en = 0; wire [4:0] q; integer i, bad;
    counter5 u (.clk(clk), .rst(rst), .en(en), .q(q));
    always #5 clk = ~clk;
    initial begin
        bad = 0;
        $display("counter5 -- an enable written as a missing else. Ten");
        $display("clocks, with the enable dropped for three of them.");
        $display("");
        $display("  clock | rst en | q | what the flip-flops did");
        $display("  ------+--------+---+------------------------");
        for (i = 0; i < 10; i = i + 1) begin
            @(negedge clk);
            rst = (i == 0);
            en  = (i > 0) && !(i >= 4 && i <= 6);
            @(posedge clk); #1;
            $display("    %0d   |  %b   %b | %0d | %s", i, rst, en, q,
                     rst ? "cleared                 " :
                     en  ? "counted                 " :
                           "held: no path assigned q");
            if (rst && q !== 0) bad = bad + 1;
        end
        $display("");
        $display("The three held clocks are the point. In a clocked block");
        $display("a path that assigns nothing means the flip-flop keeps");
        $display("its value, which is free and is exactly what an enable");
        $display("needs. The same omission in a combinational block infers");
        $display("a latch and is the commonest fault in the language --");
        $display("see mux4_latch.v. What decides is the sensitivity of the");
        $display("block, not the shape of the if.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: reset clears, enable counts, and q holds when it should");
        $finish(0);
    end
endmodule
