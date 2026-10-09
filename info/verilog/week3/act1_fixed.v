// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// act1_fixed — design
//
// Always @* builds the sensitivity list from the block itself.
//
// Run it:
//     iverilog -o act1_fixed.out act1_fixed.v tb_act1_fixed.v
//     vvp act1_fixed.out

module sel2 (input a, b, sel, output reg y);
    always @*                   // every input, automatically
        if (sel) y = b;
        else     y = a;
endmodule
