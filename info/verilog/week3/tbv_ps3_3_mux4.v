`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.3, testbench: solution
module tbv_ps3_3_mux4;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_3_mux4); end
    reg [3:0] d; reg [1:0] sel; wire y;
    integer i, errors = 0;
    ps3_mux4 uut (.d(d), .sel(sel), .y(y));
    initial begin
        for (i = 0; i < 64; i = i + 1) begin
            {sel, d} = i[5:0];
            #1;
            if (y !== d[sel]) errors = errors + 1;
        end
        d = 4'b1010;
        $display("d = %b", d);
        for (i = 0; i < 4; i = i + 1) begin
            sel = i; #10 $display("  sel=%b | y=%b", sel, y);
        end
        sel = 2'bx1; #10 $display("  sel=%b | y=%b   (default branch: unknown select gives unknown output)", sel, y);
        if (errors == 0) $display("PASS: all 64 input combinations correct");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
