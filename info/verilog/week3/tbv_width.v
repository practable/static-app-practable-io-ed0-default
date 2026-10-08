// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// width — verbose testbench
//
// slide 3-19
//
// The verbose bench for width.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_width.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 18 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: wide agrees with a five-bit sum throughout
//
// Run it:
//     iverilog -o tbv_width.out width.v tbv_width.v
//     vvp tbv_width.out
`timescale 1ns/1ps
module tbv_width;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_width);
    end
    reg [3:0] a, b;
    wire [3:0] narrow; wire [4:0] wide, boxed, extended;
    integer i, bad;
    widths u (.a(a), .b(b), .narrow(narrow), .wide(wide),
              .boxed(boxed), .extended(extended));
    initial begin
        bad = 0;
        $display("widths -- one addition assigned four ways.");
        $display("");
        $display("   a   b  | a+b | narrow wide boxed extended | carry?");
        $display("  -----+---+-----+--------------------------+-------");
        for (i = 0; i < 6; i = i + 1) begin
            case (i)
                0: begin a = 4'd3;  b = 4'd4;  end
                1: begin a = 4'd7;  b = 4'd8;  end
                2: begin a = 4'd9;  b = 4'd9;  end
                3: begin a = 4'd12; b = 4'd9;  end
                4: begin a = 4'd15; b = 4'd1;  end
                5: begin a = 4'd15; b = 4'd15; end
            endcase
            #1;
            $display("  %2d  %2d |  %2d | %5d %6d %5d %8d | %s",
                     a, b, {1'b0, a} + b, narrow, wide, boxed,
                     extended, ({1'b0, a} + b > 15) ? "yes" : "no ");
            if (wide !== {1'b0, a} + b) bad = bad + 1;
        end
        $display("");
        $display("narrow loses the carry, because the target is four bits.");
        $display("wide keeps it: the width of an addition is set by the");
        $display("widest operand and by the target it is assigned to.");
        $display("boxed loses it again, and that is the exception worth");
        $display("remembering -- operands inside { } are self-determined,");
        $display("so the sum is computed at four bits before the");
        $display("concatenation is assigned anywhere.");
        $display("extended widens an operand explicitly and always works.");
        $display("");
        $display("%s", bad ? "FAIL" : "PASS: wide agrees with a five-bit sum throughout");
    end
endmodule
