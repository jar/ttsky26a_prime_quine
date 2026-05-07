// Copyright (c) 2026 James Ross
`default_nettype none
module tt_um_prime_quine(
  input  wire [7:0] ui_in,
  output wire [7:0] uo_out,
  input  wire [7:0] uio_in,
  output wire [7:0] uio_out,
  output wire [7:0] uio_oe,
  input  wire       ena,
  input  wire       clk,
  input  wire       rst_n
);
  q q(.k(clk), .u(uo_out[7]), .v(uo_out[3]), .p(uo_out[1])); // minimal
  assign {uio_out, uio_oe} = 0; // mandatory to pass linter
//  wire _unused = &{ui_in, uio_in, ena, rst_n};
//  wire u, v, p;
//  q q(.k(clk), .u(u), .v(v), .p(p));
//  assign uo_out = {u, {3{p}}, v, {3{p}}};
endmodule
