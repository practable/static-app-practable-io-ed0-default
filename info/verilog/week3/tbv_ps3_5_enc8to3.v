`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.5, testbench: solution
module tbv_ps3_5_enc8to3;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_5_enc8to3); end
    reg [7:0] a; wire [2:0] y;
    integer i, errors = 0;
    ps3_enc8to3 uut (.a(a), .y(y));
    initial begin
        $display("    a     | y");
        for (i = 0; i < 8; i = i + 1) begin
            a = 8'b1 << i; #10;
            $display(" %b | %b", a, y); if (y !== i) $display("   ^ wrong");
            if (y !== i) errors = errors + 1;
        end
        $display("Inputs outside the table:");
        a = 8'b0000_0000; #10 $display(" %b | %b", a, y);
        a = 8'b0000_0011; #10 $display(" %b | %b", a, y);
        a = 8'b1000_0001; #10 $display(" %b | %b", a, y);
        if (errors == 0) $display("PASS: all 8 rows of the truth table correct");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
