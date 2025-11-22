`timescale 1ns / 1ps

module mux_4x1 (
  input  wire [3:0]   I,
  input  wire [1:0]   S,
  output  reg         Y
);

  wire [1:0] nS;
  wire [3:0] na_1;

  // negacje wejsc sterujacych
  not not0 (nS[0], S[0]);
  not not1 (nS[1], S[1]);

  // 1-wszy poziom
  nand nand_1_0 (na_1[0], I[3], S[1], S[0]);
  nand nand_1_1 (na_1[1], I[2], S[1], nS[0]);
  nand nand_1_2 (na_1[2], I[2], nS[1], S[0]);
  nand nand_1_3 (na_1[3], I[1], nS[1], nS[0]);
  
  // 2-gi poziom
  nand nand_2_1 (Y, na_1[0], na_1[1], na_1[2], na_1[3]);

endmodule
