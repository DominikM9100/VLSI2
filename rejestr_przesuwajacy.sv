`timescale 1ns / 1ps

//======================================================
// Dwukierunkowy rejestr przesuwajacy 4-bitowy
// S1 S0 = 00 -> WSTRZYMAJ
// S1 S0 = 01 -> PRZESUN W PRAWO
// S1 S0 = 10 -> PRZESUN W LEWO
// S1 S0 = 11 -> ROWNOLEGLY WPIS (I)
//======================================================
module rejestr_przesuwajacy (
  input  wire         RST,
  input  wire         CLK,
  input  wire         S0,
  input  wire         S1,
  input   reg   [3:0] I,
  output  reg   [3:0] Q
);

  wire   [3:0] i_mux_4x1_3; // wejscia mux_4x1
  wire   [3:0] i_mux_4x1_2; // wejscia mux_4x1
  wire   [3:0] i_mux_4x1_1; // wejscia mux_4x1
  wire   [3:0] i_mux_4x1_0; // wejscia mux_4x1
  wire         o_mux_4x1_3, o_mux_4x1_2, o_mux_4x1_1, o_mux_4x1_0; // wyjscia mux_4x1

  wire   [1:0] i_mux_2x1_3; // wejscia mux_2x1
  wire   [1:0] i_mux_2x1_2; // wejscia mux_2x1
  wire   [1:0] i_mux_2x1_1; // wejscia mux_2x1
  wire   [1:0] i_mux_2x1_0; // wejscia mux_2x1
  wire         o_mux_2x1_3, o_mux_2x1_2, o_mux_2x1_1, o_mux_2x1_0; // wyjscia mux_2x1

  wire         i_d_ff_3, i_d_ff_2, i_d_ff_1, i_d_ff_0; // wejscia przerzutnikow
  wire         o_d_ff_3, o_d_ff_2, o_d_ff_1, o_d_ff_0; // wyjscia przerzutnikow



  assign i_mux_4x1_3 = { I[3],   o_d_ff_2,       1'b0,   o_d_ff_3 };
  assign i_mux_4x1_2 = { I[2],   o_d_ff_1,   o_d_ff_3,   o_d_ff_2 };
  assign i_mux_4x1_1 = { I[1],   o_d_ff_0,   o_d_ff_2,   o_d_ff_1 };
  assign i_mux_4x1_0 = { I[0],       1'b0,   o_d_ff_1,   o_d_ff_0 };

  mux_4x1 mux_4x1_3 (.I(i_mux_4x1_3), .S({S1, S0}), .Y(o_mux_4x1_3));
  mux_4x1 mux_4x1_2 (.I(i_mux_4x1_2), .S({S1, S0}), .Y(o_mux_4x1_2));
  mux_4x1 mux_4x1_1 (.I(i_mux_4x1_1), .S({S1, S0}), .Y(o_mux_4x1_1));
  mux_4x1 mux_4x1_0 (.I(i_mux_4x1_0), .S({S1, S0}), .Y(o_mux_4x1_0));
  
  assign i_mux_2x1_3 = { 1'b0,   o_mux_4x1_3 };
  assign i_mux_2x1_2 = { 1'b0,   o_mux_4x1_2 };
  assign i_mux_2x1_1 = { 1'b0,   o_mux_4x1_1 };
  assign i_mux_2x1_0 = { 1'b0,   o_mux_4x1_0 };

  mux_2x1 mux_2x1_3 (.I(i_mux_2x1_3), .S(RST), .Y(o_mux_2x1_3));
  mux_2x1 mux_2x1_2 (.I(i_mux_2x1_2), .S(RST), .Y(o_mux_2x1_2));
  mux_2x1 mux_2x1_1 (.I(i_mux_2x1_1), .S(RST), .Y(o_mux_2x1_1));
  mux_2x1 mux_2x1_0 (.I(i_mux_2x1_0), .S(RST), .Y(o_mux_2x1_0));

  assign i_d_ff_3 = o_mux_2x1_3;
  assign i_d_ff_2 = o_mux_2x1_2;
  assign i_d_ff_1 = o_mux_2x1_1;
  assign i_d_ff_0 = o_mux_2x1_0;

  d_ff d_ff_3 (.RST(1'b0), .CLK(CLK), .D(i_d_ff_3), .Q(o_d_ff_3));
  d_ff d_ff_2 (.RST(1'b0), .CLK(CLK), .D(i_d_ff_2), .Q(o_d_ff_2));
  d_ff d_ff_1 (.RST(1'b0), .CLK(CLK), .D(i_d_ff_1), .Q(o_d_ff_1));
  d_ff d_ff_0 (.RST(1'b0), .CLK(CLK), .D(i_d_ff_0), .Q(o_d_ff_0));

  assign Q = {o_d_ff_3, o_d_ff_2, o_d_ff_1, o_d_ff_0};

endmodule
