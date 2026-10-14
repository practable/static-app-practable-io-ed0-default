`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.8(a), testbench: solution
module tbv_ps3_8a_shift3;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_8a_shift3); end
    reg clk = 0, rst = 1, en = 0, d = 0; wire [2:0] q;
    reg [2:0] want [1:4];
    integer n, errors = 0;
    shift3 uut (.clk(clk), .rst(rst), .en(en), .d(d), .q(q));
    always #5 clk = ~clk;
    initial begin
        want[1] = 3'b001; want[2] = 3'b010; want[3] = 3'b100; want[4] = 3'b000;
        @(negedge clk); rst = 0; en = 1;
        d = 1;                                   // a single one at d for one clock
        for (n = 1; n <= 4; n = n + 1) begin
            @(negedge clk); d = 0;
            if (n == 1) $display("after 1 clock  q = %b", q); else $display("after %0d clocks q = %b", n, q);
            if (q !== want[n]) $display("   ^ wrong");
            if (q !== want[n]) errors = errors + 1;
        end
        if (errors == 0) $display("PASS: the one moves one place per clock");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
