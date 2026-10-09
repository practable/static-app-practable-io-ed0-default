// Digital Systems Design 3 (ELEE09024)  ·  week 3, Verilog
// static_hazard — testbench (live example)

`timescale 1ns/1ps
module tbv_static_hazard;
    initial begin
        $dumpfile("dump.vcd");
      $dumpvars(0, tbv_static_hazard);
    end
    reg a, b, c, d; wire z; integer i;
  
  static_hazard u (.a(a), .b(b), .c(c), .d(d), .z(z));
    initial begin
        $display("   a   b   c   d   |  z   ");
        $display(" ------------------+-------");
      for (i = 0; i < 3; i = i + 1) begin
        {a, b, c, d} = 4'b0110;
            #50;
        $display("    %b    %b   %b   %b |   %b   ",
                     a, b, c, d,  z);
        {a, b, c, d} = 4'b1110;
            #50;
         $display("    %b    %b   %b   %b |   %b   ",
                     a, b, c, d,  z);
        end

    end
endmodule