// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// static_hazard_fixed — design (live example)
`timescale 1ns/1ps
module static_hazard_fixed (input a,b,c,d, output z);
  wire p1, p2, p3;
  assign #7  p1 = a & b;
  assign #19 p2 = !a & c & !d;
  assign #11 p3 = b & c & !d;     // consensus term: covers the change in a

  assign z = p1 | p2 | p3;

endmodule
