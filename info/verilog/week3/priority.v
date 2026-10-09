// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// priority — design
//
// A priority encoder: if-else nests, so r[3] wins over everything.
//
// Run it:
//     iverilog -o priority.out priority.v tb_priority.v
//     vvp priority.out

module prio (input [3:0] r, output reg [1:0] y, output reg valid);
    always @* begin
        valid = 1'b1;
        if      (r[3]) y = 2'd3;      // if-else is a priority chain
        else if (r[2]) y = 2'd2;
        else if (r[1]) y = 2'd1;
        else if (r[0]) y = 2'd0;
        else begin y = 2'd0; valid = 1'b0; end
    end
endmodule
