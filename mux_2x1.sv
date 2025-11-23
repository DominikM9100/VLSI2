`timescale 1ns / 1ps

module mux_2x1 (
  input  wire   [1:0] I,
  input  wire         S,
  output  reg         Y
);

  wire         nS;
  wire   [1:0] na_1;

  // negacje wejsc sterujacych
  assign nS = ~S;

  // 1-wszy poziom
  assign na_1[1] = ~(I[1] &  S);
  assign na_1[0] = ~(I[0] & nS);
  
  // 2-gi poziom
  assign Y = ~(na_1[0] & na_1[1]);

endmodule
