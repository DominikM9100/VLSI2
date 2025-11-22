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

  wire [3:0] o_q; // wyjscia przerzutnikow
  wire [3:0] i_d; // wejscia przerzutnikow

  assign Q = o_q;

  mux_4x1 mux_0 (
    .I( {I[0], 1'b0, o_q[1], o_q[0]}),
    .S( {S1, S0}),
    .Y( i_d[0])
  );

  mux_4x1 mux_1 (
    .I( {I[1], o_q[0], o_q[2], o_q[1]}),
    .S( {S1, S0}),
    .Y( i_d[1])
  );

  mux_4x1 mux_2 (
    .I( {I[2], o_q[1], o_q[3], o_q[2]}),
    .S( {S1, S0}),
    .Y( i_d[2])
  );

  mux_4x1 mux_3 (
    .I( {I[3], o_q[2], 1'b0, o_q[3]}),
    .S( {S1, S0}),
    .Y( i_d[3])
  );

  d_ff d_ff_0 (.RST(RST), .CLK(CLK), .D(i_d[0]), .Q(o_q[0]));
  d_ff d_ff_1 (.RST(RST), .CLK(CLK), .D(i_d[1]), .Q(o_q[1]));
  d_ff d_ff_2 (.RST(RST), .CLK(CLK), .D(i_d[2]), .Q(o_q[2]));
  d_ff d_ff_3 (.RST(RST), .CLK(CLK), .D(i_d[3]), .Q(o_q[3]));

endmodule
