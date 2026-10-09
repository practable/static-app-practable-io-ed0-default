// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// act1 — design
//
// B is absent from the sensitivity list, so y does not follow it.
//
// This is the activity module, as set. The transcript shows the
// fault; act1_fixed.v is the correction.
//
// Run it:
//     iverilog -o act1.out act1.v tb_act1.v
//     vvp act1.out

module sel2 (input a, b, sel, output reg y);
    always @(a or sel)          // <-- read this line carefully
        if (sel) y = b;
        else     y = a;
endmodule
