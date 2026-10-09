// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// mux2 — design
//
// Continuous assignment: one line, combinational by construction.
//
// Run it:
//     iverilog -o mux2.out mux2.v tb_mux2.v
//     vvp mux2.out

module mux2 (input a, b, sel, output x, y);
   reg last_sel, last_last_sel,last_a;

   assign y = sel ? b : a;
   assign x = last_sel != last_last_sel;
  
  initial
    begin
      last_sel = 0;
      last_last_sel = 0;
    end
  always @(*) //does not run when a or b change unless a or b are used in the block 
    begin
      last_last_sel = last_sel;        
      last_sel = sel;
      //last_a = a; //uncomment this line to change behaviour


    end

endmodule
