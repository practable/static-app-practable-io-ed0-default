// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// adder4 — testbench
//
// A second testbench for adder4.v: the self-checking bench: every
// one of the 512 input combinations compared against a + b + cin,
// and one line of verdict.
//
// Run it:
//     iverilog -o tb_adder4_check.out adder4.v tb_adder4_check.v
//     vvp tb_adder4_check.out
`timescale 1ns/1ps
module tb_adder4_check;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_adder4_check);
    end
    reg  [3:0] a, b;  reg cin;
    wire [3:0] s;     wire cout;
    integer i, errors;

    adder4 dut (.a(a), .b(b), .cin(cin), .s(s), .cout(cout));

    initial begin
        errors = 0;
        for (i = 0; i < 512; i = i + 1) begin
            {cin, a, b} = i[8:0];
            #1;
            if ({cout, s} !== a + b + cin) begin
                errors = errors + 1;
                $display("FAIL: %0d + %0d + %b gave %0d",
                         a, b, cin, {cout, s});
            end
        end
        if (errors == 0) $display("PASS: all 512 vectors");
        else             $display("%0d failures", errors);
        $finish;
    end
endmodule
