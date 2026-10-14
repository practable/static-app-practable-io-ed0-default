`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.4: solution
//
// Eight-bit 4-to-1 multiplexer. Same as 3.3 with the data widened: four
// separate 8-bit inputs and an 8-bit output. The case statement is
// unchanged apart from the width of the default value.
module ps3_mux4x8 (
    input      [7:0] d0, d1, d2, d3,
    input      [1:0] sel,
    output reg [7:0] y
);
    always @* begin
        case (sel)
            2'b00:   y = d0;
            2'b01:   y = d1;
            2'b10:   y = d2;
            2'b11:   y = d3;
            default: y = 8'bx;
        endcase
    end
endmodule
