`timescale 1ns/1ps
// ELEE09024 Digital System Design 3
// Problem set 3, question 3.7: solution
//
// Five-bit up/down counter with synchronous reset.
// up = 1 counts up, up = 0 counts down. Both directions wrap: 31 + 1 = 0
// and 0 - 1 = 31, for the same reason as in 3.6.
module ps3_updown5 (
    input            clk,
    input            rst,   // synchronous reset to zero
    input            up,    // 1 = count up, 0 = count down
    output reg [4:0] q
);
    always @(posedge clk)
        if (rst)     q <= 5'd0;
        else if (up) q <= q + 1'b1;
        else         q <= q - 1'b1;
endmodule
