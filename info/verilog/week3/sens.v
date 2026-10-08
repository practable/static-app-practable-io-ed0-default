// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// sens — design
//
// slide 3-14
//
// The simulation lags; a synthesiser builds the multiplexer anyway.
//
// This design is deliberately wrong. The transcript shows the
// simulation ignoring sel; a synthesiser would build the
// multiplexer anyway.
//
// Run it:
//     iverilog -o sens.out sens.v tb_sens.v
//     vvp sens.out

module sens (input a, b, sel, output reg y);
    always @(a or b)              // sel is missing
        y = sel ? b : a;
endmodule
