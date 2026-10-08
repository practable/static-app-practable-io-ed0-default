// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// fa_data — design
//
// slide 3-9
//
// The same function, described by what it does rather than how.
//
// Run it:
//     iverilog -o fa_data.out fa_data.v tb_fa_data.v
//     vvp fa_data.out

module fa_data (input a, b, cin, output s, cout);
    assign {cout, s} = a + b + cin;
endmodule
