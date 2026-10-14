`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.3: solution
//
// One-bit 4-to-1 multiplexer using a case statement.
// y is assigned inside an always block, so it must be declared reg. It is
// still combinational logic: always @* plus a value for y on every path
// means no storage is inferred.
//
// What if sel is "anything else"? In hardware a 2-bit sel has only four
// values. But Verilog signals are four-valued (0, 1, x, z), so in
// simulation sel can be, for example, 2'bx1 before it has been driven, and
// then none of the four branches matches. The default branch decides what
// happens: here y becomes x, so an undriven selector shows up as an unknown
// output instead of silently passing one of the inputs. Without a default,
// y would keep its old value, which is a latch.
module ps3_mux4 (
    input  [3:0] d,     // d[0] .. d[3]
    input  [1:0] sel,
    output reg   y
);
    always @* begin
        case (sel)
            2'b00:   y = d[0];
            2'b01:   y = d[1];
            2'b10:   y = d[2];
            2'b11:   y = d[3];
            default: y = 1'bx;   // sel contains x or z (simulation only)
        endcase
    end
endmodule
