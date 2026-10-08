// Digital Systems Design 3 (ELEE09024)
// mux_df — testbench
//
// A bench is not synthesised, so it may use delays, initial blocks and
// the display tasks.
//
// Every one of the eight input combinations, each compared against
// what a 2-to-1 multiplexer should do. The reference is written as
// s ? b : a rather than as (a & ~s) | (s & b): checking a design
// against a restatement of its own expression only confirms that the
// expression was typed twice.
//
// Expected output, from the run this example was checked against:
//
//       s  a  b  |  y   want
//       0  0  0  |  0    0
//       0  1  0  |  1    1
//       0  0  1  |  0    0
//       0  1  1  |  1    1
//       1  0  0  |  0    0
//       1  1  0  |  0    0
//       1  0  1  |  1    1
//       1  1  1  |  1    1
//     PASS: all 8 input combinations
//
// Run it:
//     iverilog -Wall -o mux.out mux_df.v tb_mux_df.v
//     vvp mux.out
`timescale 1ns/100ps
module tb_mux_df;
    reg a, b, s;  wire y;
    integer i, errors;
    reg want;

    mux_df dut (.a(a), .b(b), .s(s), .y(y));

    initial begin
        $dumpfile("dump.vcd");
      $dumpvars(0, tb_mux_df);
        errors = 0;
        $display("  s  a  b  |  y   want");
        for (i = 0; i < 8; i = i + 1) begin
            // one integer counts through every combination, so no
            // input pattern can be left out by accident
            {s, b, a} = i[2:0];
            #1;
            want = s ? b : a;
            $display("  %b  %b  %b  |  %b    %b", s, a, b, y, want);
            // !== and not !=, so that an x on y is a failure rather
            // than a comparison that is itself x
            if (y !== want) begin
                errors = errors + 1;
                $display("           ^ FAIL: y is %b, should be %b",
                         y, want);
            end
        end
        if (errors == 0) $display("PASS: all 8 input combinations");
        else             $display("%0d of 8 combinations wrong", errors);
        $finish;
    end
endmodule