// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// shift_nb — design
//
// Three flip-flops: the pulse takes three clocks to reach q3.
//
// Run it:
//     iverilog -o shift_nb.out shift_nb.v tb_shift_nb.v
//     vvp shift_nb.out

module shift_nb (input clk, input d, output reg q1, q2, q3);
    always @(posedge clk) begin
        q1 <= d;
        q2 <= q1;
        q3 <= q2;
    end
endmodule
