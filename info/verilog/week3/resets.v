// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// resets — design
//
// slide 3-29
//
// A reset pulse shorter than a clock period is invisible to one of
// these.
//
// Modules in this file: dff_sync_rst, dff_async_rst. dff_async_rst
// is the design; the other is what it instantiates.
//
// Run it:
//     iverilog -o resets.out resets.v tb_resets.v
//     vvp resets.out

module dff_sync_rst (input clk, rst, d, output reg q);
    always @(posedge clk)
        if (rst) q <= 1'b0;
        else     q <= d;
endmodule

module dff_async_rst (input clk, rst, d, output reg q);
    always @(posedge clk or posedge rst)
        if (rst) q <= 1'b0;
        else     q <= d;
endmodule
