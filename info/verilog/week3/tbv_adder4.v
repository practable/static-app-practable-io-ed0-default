// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// adder4 — verbose testbench
//
// slide 3-20
//
// The verbose bench for adder4.v. It prints every step rather than
// the three the slide has room for, the internal signals where an
// internal signal is the mechanism, and a sentence at the end
// saying what was shown.
//
// tb_adder4.v is the short version, and is the one the lecture
// shows.
//
// Running it prints 19 lines. The last is:
//
// Expected output, from the run this example was checked against:
//
//     PASS: all 512 input combinations equal a + b + cin
//
// Run it:
//     iverilog -o tbv_adder4.out adder4.v tbv_adder4.v
//     vvp tbv_adder4.out
`timescale 1ns/1ps
module tbv_adder4;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tbv_adder4);
    end
    reg [3:0] a, b; reg cin; wire [3:0] s; wire cout;
    integer i, bad;
    adder4 u (.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
    initial begin
        bad = 0;
        $display("adder4 -- four full adders in a row. The carry chain");
        $display("between them is u.c, which a bench may look at and a");
        $display("synthesisable design may not.");
        $display("");
        $display("    a    b  cin | c2 c1 c0 | cout  s   | decimal");
        $display("  ------+------+-----+----------+-----------+---------");
        for (i = 0; i < 8; i = i + 1) begin
            case (i)
                0: {a, b, cin} = {4'd0,  4'd0,  1'b0};
                1: {a, b, cin} = {4'd1,  4'd1,  1'b0};
                2: {a, b, cin} = {4'd7,  4'd1,  1'b0};
                3: {a, b, cin} = {4'd8,  4'd8,  1'b0};
                4: {a, b, cin} = {4'd15, 4'd1,  1'b0};
                5: {a, b, cin} = {4'd15, 4'd15, 1'b0};
                6: {a, b, cin} = {4'd15, 4'd0,  1'b1};
                7: {a, b, cin} = {4'd9,  4'd6,  1'b1};
            endcase
            #1;
            $display("   %2d   %2d   %b  |  %b  %b  %b |  %b   %b  | %2d + %2d + %b = %2d",
                     a, b, cin, u.c[2], u.c[1], u.c[0], cout, s,
                     a, b, cin, {cout, s});
            if ({cout, s} !== a + b + cin) bad = bad + 1;
        end
        $display("");
        $display("Watch the chain on the row where a and b are both 15: the");
        $display("carry has to travel from c0 to cout before the top bit of");
        $display("the sum is right. That is the delay a ripple-carry adder");
        $display("costs, and it is the reason week 4 looks for a faster");
        $display("structure.");
        $display("");
        for (i = 0; i < 512; i = i + 1) begin
            {cin, a, b} = i[8:0];
            #1 if ({cout, s} !== a + b + cin) bad = bad + 1;
        end
        $display("%s", bad ? "FAIL" :
                 "PASS: all 512 input combinations equal a + b + cin");
    end
endmodule
