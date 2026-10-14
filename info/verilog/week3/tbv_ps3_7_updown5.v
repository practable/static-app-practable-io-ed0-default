`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.7, testbench: solution
module tbv_ps3_7_updown5;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_7_updown5); end
    reg clk = 0, rst = 1, up = 1; wire [4:0] q;
    reg [4:0] expected;
    integer n, errors = 0;
    ps3_updown5 uut (.clk(clk), .rst(rst), .up(up), .q(q));
    always #5 clk = ~clk;
    task step; begin
        @(negedge clk);
        expected = up ? expected + 1'b1 : expected - 1'b1;
        $display("up=%b  q = %2d", up, q); if (q !== expected) $display("   ^ wrong");
        if (q !== expected) errors = errors + 1;
    end endtask
    initial begin
        @(negedge clk); @(negedge clk);
        rst = 0; expected = 0;
        up = 1; repeat (4) step;      // 1 2 3 4
        up = 0; repeat (6) step;      // 3 2 1 0 31 30
        up = 1; repeat (3) step;      // 31 0 1
        rst = 1; @(negedge clk); $display("reset  q = %2d", q);
        if (q !== 0) errors = errors + 1;
        if (errors == 0) $display("PASS: counts up and down, wraps both ways, resets synchronously");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
