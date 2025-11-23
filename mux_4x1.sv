`timescale 1ns / 1ps

module mux_4x1 (
  input  wire   [3:0] I,
  input  wire   [1:0] S,
  output  reg         Y
);

  wire   [3:0] nS;
  wire   [3:0] na_1;

  // negacje wejsc sterujacych
  assign nS[0] = ~S[0];
  assign nS[1] = ~S[1];

  // 1-wszy poziom
  assign na_1[3] = ~(I[3] &  S[1] &  S[0]);
  assign na_1[2] = ~(I[2] &  S[1] & nS[0]);
  assign na_1[1] = ~(I[1] & nS[1] &  S[0]);
  assign na_1[0] = ~(I[0] & nS[1] & nS[0]);
  
  // 2-gi poziom
  assign Y = ~(na_1[0] & na_1[1] & na_1[2] & na_1[3]);

endmodule
