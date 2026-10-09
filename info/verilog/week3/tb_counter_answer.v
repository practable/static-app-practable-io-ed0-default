// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// activity 2 — answer
//
// The activity worked: the same bench with its three sections
// written. Run it against counter.v and it prints one line.
//
// Expected output, from the run this example was checked against:
//
//     PASS: q = 4 after four clocks
//
// Run it:
//     iverilog -o tb_counter_answer.out counter.v tb_counter_answer.v
//     vvp tb_counter_answer.out
`timescale 1ns/1ps

module tb_counter5_answer;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_counter5_answer);
    end
    reg clk = 0, rst = 1, en = 0;
    wire [4:0] q;

    counter5 dut (.clk(clk), .rst(rst), .en(en), .q(q));

    always #5 clk = ~clk;              // 100 MHz

    initial begin
        @(negedge clk) rst = 0; en = 1;    // away from the rising edge
        repeat (4) @(negedge clk);         // four counting clocks
        if (q !== 5'd4) $display("FAIL: q = %0d, expected 4", q);
        else            $display("PASS: q = 4 after four clocks");
        $finish;
    end
endmodule
