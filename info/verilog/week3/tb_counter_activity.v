// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// activity 2 — skeleton
//
// slide 3-39
//
// The second activity, as set: a bench for counter.v with three
// sections to write. It compiles and runs as it stands, and prints
// nothing, which is the thing to fix.
//
// Release the reset on a falling edge and enable the counter, let
// it run for four clocks, then check that q has reached four and
// say so in one line. Change the inputs away from the rising edge,
// and compare with !== rather than !=.
//
// Run it:
//     iverilog -o tb_counter_activity.out counter.v tb_counter_activity.v
//     vvp tb_counter_activity.out
`timescale 1ns/1ps

module tb_counter5;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_counter5);
    end
    reg clk = 0, rst = 1, en = 0;
    wire [4:0] q;

    counter5 dut (.clk(clk), .rst(rst), .en(en), .q(q));

    always #5 clk = ~clk;              // 100 MHz

    initial begin
        // 1. release reset on a falling edge, then enable

        // 2. let it count for four clocks

        // 3. check q has reached 4, and say so

        $finish;
    end
endmodule
