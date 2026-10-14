`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.8(c), testbench: solution
module tbv_ps3_8c_sel3;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_8c_sel3); end
    reg [2:0] d; reg [1:0] sel; wire y;
    reg expected;
    integer i, errors = 0;
    sel3 uut (.d(d), .sel(sel), .y(y));
    initial begin
        // The same sequence as the faulty transcript
        d = 3'b101; sel = 2'b00; #10 $display("  sel=%b y=%b", sel, y);
                    sel = 2'b10; #10 $display("  sel=%b y=%b", sel, y);
                    sel = 2'b11; #10 $display("  sel=%b y=%b", sel, y);
        d = 3'b000;              #10 $display("  sel=%b y=%b", sel, y);
        for (i = 0; i < 32; i = i + 1) begin
            {sel, d} = i[4:0]; #1;
            expected = (sel == 2'b11) ? 1'b0 : d[sel];
            if (y !== expected) errors = errors + 1;
        end
        if (errors == 0) $display("PASS: all 32 input combinations correct, no retained value");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
