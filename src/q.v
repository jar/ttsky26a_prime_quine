//2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
`default_nettype none
module q(input wire k, output reg u, output reg v, output wire p);
  reg [9:0] x;
  reg [9:0] y;
  wire [9:0] xx = x % 5; // x-cell (from left)
  wire [9:0] yy = y % 9; // y-cell (from top)
  wire w = x == 799; // end of the row
  wire h = y == 524; // end of the frame
  wire d = x < 640 & y < 480; // draw
  reg [$clog2(3072)-1:0] i; // glyph index
  reg [$clog2(n)-1:0] s; // string index
  reg [$clog2(799/5)-1:0] o; // string offset within a row
  always @(posedge k) begin
    u <= x >= 656 ~& x <= 751;
    v <= y >= 490 ~& y <= 491;
    x <= w ? 0 : x + 1;
    y <= w ? h ? 0 : y + 1 : y;
    if (w) begin // at the end of a line
      o <= 0; // reset the in-line offset
      if (h) begin // reset everything else if at the end of the frame
        {s,i} <= 0;
      end else begin
        if (yy == 8) begin // at the end of the line and the end of bottom edge of the last cell
          s <= s + o + 1;
        end
      end
    end else if (xx[2]) begin // at the last pixel in the glyph
        if (~nl || gl) begin // increment offset if we haven't hit a new line or we're in the glyph phase
          o <= o + 1;
        end
        if (gl) begin
          i <= i + o + 1;//XXX
        end
    end
  end

  wire [3:0] l = g[3068-4*i+:4]; // 4 bits of glyph for use within the glyph hex mode
  wire [7:0] c = (~gl) ? str[8*(n-s-o-1)+:8] : (l<10) ? {4'd0,l}+48 : {4'd0,l}+87; // switch between string and glyph hex
  wire nl = c == 35; // using '#' in place of newline character
  wire gl = s == ny; // position of glyph hex data
  wire [8:0] gy = 4 * (c - 32) + {7'd0, xx[1:0]}; // offset 32 unprinted ASCII
  assign p = (xx[2] || yy == 8 || nl) ? 0 : g[384*yy[2:0]+gy] & d;

wire [3071:0] g = 3072'hf0000060000000810000020061000000f0080000000000c0000000000000000620001000000000001001001800020000f0224f8996e47181699495c982ee67e000686f4996626961699f967961f367910000226626646f4616020024069f5040904222e6f69281e799925449e219999000442149f69295b1999199299115999f230c229929949149260225420929500095422496999261999992344992f9199000442246f69283919d9158299119199b26f600894984824920f07242052cf0409a8218969992199999f254499799999000422266999267979d91582fd77917fb4c0300e6478f644b400025420243504090422f999997e7e767929667e26e67e405422496999219999bf138291119199f86f622998175484d400000420149f540f042200000020000000210010208010207412899999299999bf1582991159999930c22998915896980000024299f5540f022400000020000000214410408010102616f999997676769919c796ff3676660000066f6f5f6468000001826045540;
parameter n = 302;
parameter ny = n-26;
wire [8*n-1:0] str = "`default_nettype none#module q(input wire k, output reg u, output reg v, output wire p);#  wire w = x == 799;#  wire h = y == 524;#  reg [9:0] x;#  reg [9:0] y;#  wire [7:0] c = (~gl) ? str[8*(n-s-o-1)+:8] : (l<10) ? {4'd0,l}+48 : {4'd0,l}+87;#endmodule#wire [3071:0] g = 3071'h;#wire [8*n-1:0] str = ;";
//parameter n = 96;
//parameter [8*n-1:0] str = {" !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\177"};

endmodule
