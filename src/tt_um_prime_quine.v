// Copyright (c) 2026 James Ross
// SPDX-License-Identifier: Apache-2.0i
module tt_um_prime_quine(
  input  [7:0] ui_in,
  output [7:0] uo_out,
  input  [7:0] uio_in,
  output [7:0] uio_out,
  output [7:0] uio_oe,
  input        ena,
  input        clk,
  input        rst_n
);
  wire u, v, p;
  q q(.k(clk), .u(u), .v(v), .p(p));
  assign uo_out = {u, p, p, p, v, p, p, p};
  wire _unused = &{ui_in, uio_in, ena, rst_n};
  assign {uio_out, uio_oe} = 0;
endmodule
