// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// casez — design
//
// slide 3-17
//
// The default is what stops a latch and what reports 'no request'.
//
// Run it:
//     iverilog -o casez.out casez.v tb_casez.v
//     vvp casez.out

module enc (input [3:0] r, output reg [1:0] g, output reg any);
    always @* begin
        any = 1'b1;
        casez (r)
            4'b1???: g = 2'd3;
            4'b01??: g = 2'd2;
            4'b001?: g = 2'd1;
            4'b0001: g = 2'd0;
            default: begin g = 2'd0; any = 1'b0; end
        endcase
    end
endmodule
