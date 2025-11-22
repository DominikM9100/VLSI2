`timescale 1ns / 1ps

module d_ff (
  input  wire   RST,
  input  wire   CLK,
  input  wire   D,
  output  reg   Q
);

  always @(posedge CLK or posedge RST)
    if (RST)   Q <= 1'b0;
    else       Q <= D;

endmodule
