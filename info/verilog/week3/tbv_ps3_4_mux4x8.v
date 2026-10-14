`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.4, testbench: solution
module tbv_ps3_4_mux4x8;
    initial begin $dumpfile("dump.vcd"); $dumpvars(0, tbv_ps3_4_mux4x8); end
    reg [7:0] d0, d1, d2, d3; reg [1:0] sel; wire [7:0] y;
    reg [7:0] expected;
    integer i, errors = 0;
    ps3_mux4x8 uut (.d0(d0), .d1(d1), .d2(d2), .d3(d3), .sel(sel), .y(y));
    initial begin
        d0 = 8'h11; d1 = 8'h22; d2 = 8'h44; d3 = 8'h88;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i; #10;
            case (sel) 0: expected = d0; 1: expected = d1; 2: expected = d2; default: expected = d3; endcase
            $display("sel=%b | y=%h", sel, y); if (y !== expected) $display("   ^ wrong");
            if (y !== expected) errors = errors + 1;
        end
        // Random data, all four selects
        for (i = 0; i < 200; i = i + 1) begin
            {d0, d1, d2, d3} = {$random, $random}; sel = $random; #1;
            case (sel) 0: expected = d0; 1: expected = d1; 2: expected = d2; default: expected = d3; endcase
            if (y !== expected) errors = errors + 1;
        end
        if (errors == 0) $display("PASS: 4 named and 200 random cases correct");
        else             $display("FAIL: %0d wrong", errors);
        $finish;
    end
endmodule
