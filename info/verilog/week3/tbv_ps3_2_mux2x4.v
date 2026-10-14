`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.2, testbench: solution
module tbv_ps3_2_mux2x4;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_2_mux2x4); end
    reg [3:0] a, b; reg sel; wire [3:0] y;
    integer i, errors = 0;
    ps3_mux2x4 uut (.a(a), .b(b), .sel(sel), .y(y));
    initial begin
        // Exhaustive: 16 x 16 x 2 = 512 cases, checked silently
        for (i = 0; i < 512; i = i + 1) begin
            {sel, b, a} = i[8:0];
            #1;
            if (y !== (sel ? b : a)) errors = errors + 1;
        end
        // A few cases printed so you can see it working
        a = 4'b0011; b = 4'b1010;
        sel = 0; #10 $display("sel=%b a=%b b=%b | y=%b", sel, a, b, y);
        sel = 1; #10 $display("sel=%b a=%b b=%b | y=%b", sel, a, b, y);
        if (errors == 0) $display("PASS: all 512 input combinations correct");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
