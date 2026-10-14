`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.1, testbench: solution
module tbv_ps3_1_mux2;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_1_mux2); end
    reg a, b, sel; wire y;
    integer i, errors = 0;
    reg expected;
    ps3_mux2 uut (.a(a), .b(b), .sel(sel), .y(y));
    initial begin
        $display(" sel b a | y");
        for (i = 0; i < 8; i = i + 1) begin
            {sel, b, a} = i[2:0];
            #10;
            expected = sel ? b : a;
            $display("  %b  %b %b | %b", sel, b, a, y); if (y !== expected) $display("   ^ wrong");
            if (y !== expected) errors = errors + 1;
        end
        if (errors == 0) $display("PASS: all 8 input combinations correct");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
