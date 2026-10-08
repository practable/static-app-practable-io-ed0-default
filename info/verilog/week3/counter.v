// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// counter — design
//
// slide 3-28
//
// No else: q holds when en is low, which is what a register does.
//
// Run it:
//     iverilog -o counter.out counter.v tb_counter.v
//     vvp counter.out

module counter5 (input clk, rst, en, output reg [4:0] q);
    always @(posedge clk) begin
        if (rst)      q <= 5'd0;
        else if (en)  q <= q + 5'd1;
    end
endmodule
