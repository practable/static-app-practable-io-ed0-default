`timescale 1ns/100ps
module mux_df(
	input a,b,s,
  output y
);
wire sbar;
  assign y = (a & sbar) || (s & b);
  assign sbar = ~s;
endmodule