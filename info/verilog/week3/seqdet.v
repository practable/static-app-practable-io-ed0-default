// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// seqdet — design
//
// The machine derived in week 1, coded in the three-block style.
//
// Run it:
//     iverilog -o seqdet.out seqdet.v tb_seqdet.v
//     vvp seqdet.out

module seqdet (input clk, rst, x, output reg z);
    localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3,
               E = 3'd4, H = 3'd5, J = 3'd6;
    reg [2:0] state, next;

    always @(posedge clk)                 // state register
        if (rst) state <= A;
        else     state <= next;

    always @* begin                       // next state
        case (state)
            A: next = x ? C : B;
            B: next = x ? E : D;
            C: next = x ? D : E;
            D: next = H;
            E: next = x ? H : J;
            H: next = A;
            J: next = A;
            default: next = A;
        endcase
    end

    always @* z = (state == J) & x;       // Mealy output
endmodule
