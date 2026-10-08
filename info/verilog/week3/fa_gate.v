// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// fa_gate — design
//
// slide 3-9
//
// Gate primitives: the netlist written out directly.
//
// Run it:
//     iverilog -o fa_gate.out fa_gate.v tb_fa_gate.v
//     vvp fa_gate.out

module fa_gate (input a, b, cin, output s, cout);
    wire p, g1, g2;
    xor (p, a, b);
    xor (s, p, cin);
    and (g1, a, b);
    and (g2, p, cin);
    or  (cout, g1, g2);
endmodule
