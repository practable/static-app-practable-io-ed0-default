// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// seqdet — verbose testbench
//
// slide 3-32
//
// The verbose bench for seqdet.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_seqdet.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 30 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: two sequences detected, one rejected
//
// Run it:
//     iverilog -o tbv_seqdet.out seqdet.v tbv_seqdet.v
//     vvp tbv_seqdet.out
`timescale 1ns/1ps
module tbv_seqdet;
    reg clk = 0, rst = 1, x = 0; wire z;
    integer i, bad;
    seqdet u (.clk(clk), .rst(rst), .x(x), .z(z));
    always #5 clk = ~clk;

    function [7:0] nm;
        input [2:0] s;
        case (s)
            3'd0: nm = "A"; 3'd1: nm = "B"; 3'd2: nm = "C";
            3'd3: nm = "D"; 3'd4: nm = "E"; 3'd5: nm = "H";
            default: nm = "J";
        endcase
    endfunction

    task feed(input [3:0] bits, input expect_z);
        integer k;
        begin
            @(negedge clk) rst = 1; x = 0;
            @(negedge clk) rst = 0;
            $display("  bit | state | next | z | note");
            $display("  ----+-------+------+---+--------------------------------");
            for (k = 3; k >= 0; k = k - 1) begin
                x = bits[k];
                #1;
                $display("   %b  |   %s   |  %s   | %b | %s",
                         x, nm(u.state), nm(u.next), z,
                         z ? "the sequence has just completed" : "");
                if (k == 0 && z !== expect_z) bad = bad + 1;
                @(posedge clk);
                @(negedge clk);
            end
            $display("");
        end
    endtask

    initial begin
        bad = 0;
        $display("seqdet -- the seven-state machine reduced in week 1,");
        $display("with the state it is in and the state it will move to.");
        $display("Output 1 on the last bit of 0101 or 1001.");
        $display("");
        $display("0101, which should be detected:");
        feed(4'b0101, 1'b1);
        $display("1001, which should be detected:");
        feed(4'b1001, 1'b1);
        $display("0110, which should not:");
        feed(4'b0110, 1'b0);
        $display("The state column is the machine walking the graph drawn");
        $display("in week 1. z is a Mealy output -- state and input -- so");
        $display("it rises during the last bit rather than after it, which");
        $display("is why the detection shows on the fourth line and not on");
        $display("a fifth.");
        $display("");
        $display("%s", bad ? "FAIL" :
                 "PASS: two sequences detected, one rejected");
        $finish(0);
    end
endmodule
