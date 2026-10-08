// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// resets — verbose testbench
//
// slide 3-29
//
// The verbose bench for resets.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_resets.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 39 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     to the clock, or from logic driven by the same clock.
//
// Run it:
//     iverilog -o tbv_resets.out resets.v tbv_resets.v
//     vvp tbv_resets.out
`timescale 1ns/1ns
module tbv_resets;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_resets);
    end
    reg clk = 0, rst = 0, d = 1;
    wire qs, qa;
    integer t;
    dff_sync_rst  us (.clk(clk), .rst(rst), .d(d), .q(qs));
    dff_async_rst ua (.clk(clk), .rst(rst), .d(d), .q(qa));
    always #5 clk = ~clk;
    initial begin
        $display("resets -- the same reset pulse into two flip-flops. The");
        $display("pulse is raised at t=16 and dropped at t=19; the clock");
        $display("rises at 5, 15, 25 and 35.");
        $display("");
        $display("  time | clk rst | sync | async | event");
        $display("  -----+---------+------+-------+-----------------------------------");
        // Start watching at t=10, after the first clock edge has
        // put a known value in both flip-flops.
        #10;
        for (t = 10; t <= 30; t = t + 1) begin
            if (t == 16) rst = 1;
            if (t == 19) rst = 0;
            #0;                    // let the flops react to it
            $display("   %2t |  %b   %b  |  %b   |   %b   | %s",
                     $time, clk, rst, qs, qa,
                     (t == 15 || t == 25) ?
                         "clock edge                        " :
                     (t == 16) ?
                         "reset raised, between edges       " :
                     (t == 19) ?
                         "reset dropped, still between edges" :
                         "                                  ");
            #1;
        end
        $display("");
        $display("Each row is read at the start of that nanosecond, and a");
        $display("flip-flop takes its new value at the end of the instant");
        $display("in which its edge happened. So every change shows on the");
        $display("row after the event that caused it -- which is what a");
        $display("non-blocking assignment means, and is the subject of");
        $display("shift_nb.v and shift_b.v.");
        $display("");
        $display("The asynchronous flop cleared as soon as the pulse");
        $display("arrived, because posedge rst is in its sensitivity list.");
        $display("The synchronous flop never saw the pulse at all: by the");
        $display("time its clock edge came round the reset had already");
        $display("gone. Neither is wrong. Which you want depends on whether");
        $display("the reset comes from a button, which has no relationship");
        $display("to the clock, or from logic driven by the same clock.");
        $finish(0);
    end
endmodule
