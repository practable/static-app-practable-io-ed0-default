// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// gotcha — design
//
// Width and signedness are decided by the operands, not the target.
//
// Run it:
//     iverilog -o gotcha.out gotcha.v tb_gotcha.v
//     vvp gotcha.out

module gotcha;
    reg  [3:0] a, b, u;
    reg  [4:0] wide;
    reg signed [3:0] p;
    initial begin
        a = 4'd3;  b = 4'd5;
        $display("3 - 5, four bits unsigned  = %0d", a - b);
        a = 4'd9;  b = 4'd9;
        $display("(9 + 9) >> 1, four bits    = %0d", (a + b) >> 1);
        wide = a + b;
        $display("the same with a 5-bit sum  = %0d", wide >> 1);
        u = 4'b1110;  p = 4'sb1110;
        $display("1110 >>> 1, unsigned reg   = %b", u >>> 1);
        $display("1110 >>> 1, signed reg     = %b", p >>> 1);
        $display("4'b0x01 ==  4'b0001        = %b", 4'b0x01 == 4'b0001);
        $display("4'b0x01 === 4'b0x01        = %b", 4'b0x01 === 4'b0x01);
    end
endmodule
