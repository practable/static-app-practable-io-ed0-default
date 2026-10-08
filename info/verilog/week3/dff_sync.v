// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// dff_sync — design
//
// slide 3-24
//
// Reset is sampled on the clock edge like any other input.
//
// Run it:
//     iverilog -o dff_sync.out dff_sync.v tb_dff_sync.v
//     vvp dff_sync.out

module dff_sync (input clk, rst, d, output reg q);
    always @(posedge clk) begin
        if (rst) q <= 1'b0;
        else     q <= d;
    end
endmodule
