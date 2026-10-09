// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// static_hazard — design (live example)
`timescale 1ns/1ps
module static_hazard (input a,b,c,d, output z);
  wire p1, p2;
  assign #7 p1 = a & b;
  assign #19 p2 = !a & c & !d;
                 
  assign z = p1 | p2;
  
endmodule 