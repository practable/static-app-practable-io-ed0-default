// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// mux4_latch — design
//
// slide 3-12
//
// Y keeps its previous value when sel=11, which is a latch.
//
// This design is deliberately wrong. The transcript shows the
// inferred latch holding its value.
//
// Run it:
//     iverilog -o mux4_latch.out mux4_latch.v tb_mux4_latch.v
//     vvp mux4_latch.out

module mux4_bad (input [3:0] d, input [1:0] sel, output reg y);
    always @* begin
        case (sel)
            2'b00: y = d[0];
            2'b01: y = d[1];
            2'b10: y = d[2];
        endcase                 // 2'b11 is missing
    end
endmodule
