// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// mux2 — design
//
// slide 3-4
//
// Continuous assignment: one line, combinational by construction.
//
// Run it:
//     iverilog -o mux2.out mux2.v tb_mux2.v
//     vvp mux2.out

module mux2 (input a, b, sel, output y);
    assign y = sel ? b : a;
endmodule
