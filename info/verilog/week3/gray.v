// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// gray — design
//
// slide 3-34
//
// The machine from the week 2 activity, in the three-block form.
//
// Run it:
//     iverilog -o gray.out gray.v tb_gray.v
//     vvp gray.out

module gray2 (input clk, rst, en, output reg [1:0] q, output z);
    localparam S0 = 2'b00, S1 = 2'b01, S3 = 2'b11, S2 = 2'b10;
    reg [1:0] next;

    always @(posedge clk)
        if (rst) q <= S0;
        else     q <= next;

    always @* begin
        next = q;                  // default: hold
        if (en) case (q)
            S0: next = S1;
            S1: next = S3;
            S3: next = S2;
            S2: next = S0;
        endcase
    end

    assign z = (q == S2);          // Moore: depends on state alone
endmodule
