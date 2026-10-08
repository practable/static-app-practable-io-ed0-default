// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// mux4 — design
//
// slide 3-11
//
// Every branch covered, so no latch is inferred.
//
// Run it:
//     iverilog -o mux4.out mux4.v tb_mux4.v
//     vvp mux4.out

module mux4 (input [3:0] d, input [1:0] sel, output reg y);
    always @* begin
        case (sel)
            2'b00: y = d[0];
            2'b01: y = d[1];
            2'b10: y = d[2];
            2'b11: y = d[3];
        endcase
    end
endmodule
