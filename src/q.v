module q(input k, output reg u, output reg v, output p);
  reg [9:0] x, y;
  wire [9:0] xx = x % 5, yy = y % 9; // position (from left) within a character glyph, y-cell (from top)
  wire [12:0] z = (y/9 << 7) + x/5; // cell index
  wire w = x == 799, h = y == 524, d = x < 640 & y < 480; // end of the row, end of the frame, draw
  always @(posedge k) begin
    u <= x >= 656 ~& x <= 751; v <= y >= 490 ~& y <= 491; // hsync, vsync
    x <= w ? 0 : x + 1; y <= w ? h ? 0 : y + 1 : y;       // increment pixel x-coordinate, y-coordinate
  end
  wire b = z >= i && z < i+768; // use glyph hex data in this range
  wire t = z == j+768 || z == j+n+769; // use quote ticks in this range
  wire s = z > j+768 && z < j+n+769; // use string
  wire [3:0] l = g[(3068-4*(z-i))+:4]; // 4 bits of glyph for use within the glyph hex mode
  wire [7:0] c = t ? 34 : b ? (l<10) ? {4'd0,l}+48 : {4'd0,l}+87 : a[8*(n-z-(s?768-j:1))+:8];
  //wire [8:0] gy = 4 * (c - 32) + {7'd0, xx[1:0]}; // offset 32 unprinted ASCII
  //assign p = (xx[2] || yy == 8) ? 0 : g[384*yy[2:0]+gy] & d;
  wire [8:0] gy = 4 * c - 128 + (xx & 3); // offset 32 unprinted ASCII
  assign p = (xx[2] || yy == 8) ? 0 : g[384*(yy&7)+gy] & d;

wire [3071:0] g = 3072'hf0000060000000810000020060000000f0080000000000c0000000000000000620001000000000001001001800020000f0224f8996e47181699495c982ee67e000686f4996626961699f967961f367910000226626646f4616020024069f5040904222e6f69281e799925449e219999000442149f69295b1999199299115999f230c229929949149260225420929500095422496999261999992344992f9199000442246f69283919d9158299119199b26f600894984824920f07242052cf0409a8218969992199999f254499799999000422266999267979d91582fd77917fb4c0300e6478f644b400025420243504090422f999997e7e767929667e26e67e405422496999219999bf138291119199f86f622998175484d400000420149f540f042200000020000000210010a08010207412899999299999bf1582991159999930c22998915896980000024299f5540f022400000020000000214410408010102616f999997676769919c796ff3676660000066f6f5f6468000001826045540;
parameter n = 222;
parameter i = n-34, j = n-13;
wire [8*n-1:0] a = "module q(input k, output reg u, output reg v, output p); reg [9:0] x, y; wire [9:0] xx = x % 5, yy = y % 9; wire w = x == 799, h = y == 524, d = x < 640 & y < 480; wire [3071:0] g = 3071'h; wire [8*n-1:0] a =   ; endmodule";

endmodule
