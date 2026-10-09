// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// shift_b — design
//
// One flip-flop: the pulse reaches q3 on the same clock.
//
// Run it:
//     iverilog -o shift_b.out shift_b.v tb_shift_b.v
//     vvp shift_b.out

module shift_b (input clk, input d, output reg q1, q2, q3);
    always @(posedge clk) begin
        q1 = d;
        q2 = q1;
        q3 = q2;
    end
endmodule
