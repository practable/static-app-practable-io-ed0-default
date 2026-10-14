`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.6, testbench: solution
module tbv_ps3_6_count5;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_6_count5); end
    reg clk = 0, rst = 1; wire [4:0] q;
    reg [4:0] expected;
    integer n, errors = 0;
    ps3_count5 uut (.clk(clk), .rst(rst), .q(q));
    always #5 clk = ~clk;
    initial begin
        @(negedge clk); @(negedge clk);           // two clocks in reset
        if (q !== 5'd0) begin $display("FAIL: reset did not clear q (q=%b)", q); errors = errors + 1; end
        rst = 0; expected = 0;
        for (n = 1; n <= 36; n = n + 1) begin
            @(negedge clk); expected = expected + 1;
            if (n >= 29 || n <= 2) $display("after %2d clocks q = %2d", n, q);
            if (q !== expected) errors = errors + 1;
        end
        rst = 1; @(negedge clk);                    // synchronous reset mid-count
        $display("after reset     q = %2d", q);
        if (q !== 5'd0) errors = errors + 1;
        if (errors == 0) $display("PASS: counts 0..31, wraps to 0, resets synchronously");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
