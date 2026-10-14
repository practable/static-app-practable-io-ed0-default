`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.8(b), testbench: solution
module tbv_ps3_8b_add4;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_8b_add4); end
    reg [3:0] a, b; wire [3:0] sum; wire cout;
    reg [4:0] full;
    integer i, errors = 0;
    add4 uut (.a(a), .b(b), .sum(sum), .cout(cout));
    initial begin
        a = 9;  b = 9; #10 $display(" 9 + 9     sum = %0d     cout = %b", sum, cout);
        a = 15; b = 1; #10 $display("15 + 1     sum = %0d     cout = %b", sum, cout);
        a = 3;  b = 4; #10 $display(" 3 + 4     sum = %0d     cout = %b", sum, cout);
        for (i = 0; i < 256; i = i + 1) begin
            {a, b} = i[7:0]; #1;
            full = a + b;                        // five bits wide here, so no carry is lost
            if ({cout, sum} !== full) errors = errors + 1;
        end
        if (errors == 0) $display("PASS: all 256 additions correct, carry included");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
