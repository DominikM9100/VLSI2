`timescale 1ns / 1ps

module tb_rejestr_przeuwajacy;

  reg        RST;
  reg        CLK;
  reg        S0;
  reg        S1;
  reg  [3:0] I;
  wire [3:0] Q;

  rejestr_przesuwajacy dut (
    .RST (RST),
    .CLK (CLK),
    .S0  (S0),
    .S1  (S1),
    .I   (I),
    .Q   (Q)
  );

  initial CLK = 1'b0;
  always  #5 CLK = ~CLK;

  task pokaz_stan;
    input [255:0] napis;
    begin
      $display("[%0t] %0s | RST=%b S1S0=%b%b I=%b Q=%b",
      $time, napis, RST, S1, S0, I, Q);
    end
  endtask

  initial begin

    RST = 1'b1;
    S0  = 1'b0;
    S1  = 1'b0;
    I   = 4'b0000;
    pokaz_stan("start (z wlaczonym resetem)");

    @(posedge CLK); #1;
    pokaz_stan("po 1. zboczu CLK (reset)");
    RST = 1'b0;

    S1 = 1'b1;
    S0 = 1'b1;
    I  = 4'b1010;
    @(posedge CLK); #1;
    pokaz_stan("ROWNOLEGLY WPIS I=1010 (S1S0=11)");

    S1 = 1'b0;
    S0 = 1'b0;
    I  = 4'b1111;
    repeat (2) begin
      @(posedge CLK); #1;
      pokaz_stan("WSTRZYMAJ (S1S0=00)");
    end

    S1 = 1'b0;
    S0 = 1'b1;
    repeat (3) begin
      @(posedge CLK); #1;
      pokaz_stan("PRZESUN W PRAWO (S1S0=01)");
    end

    S1 = 1'b1;
    S0 = 1'b0;
    repeat (3) begin
      @(posedge CLK); #1;
      pokaz_stan("PRZESUN W LEWO (S1S0=10)");
    end

    RST = 1'b1;
    @(posedge CLK); #1;
    pokaz_stan("synchroniczny RESET w trakcie pracy");

    RST = 1'b0;
    @(posedge CLK); #1;
    pokaz_stan("po zwolnieniu RESET");
    @(posedge CLK); #1;

    S1 = 1'b0;
    S0 = 1'b0;
    I  = 4'b0101;
    repeat (2) begin
      @(posedge CLK); #1;
      pokaz_stan("WSTRZYMAJ (S1S0=00)");
    end

    S1 = 1'b1;
    S0 = 1'b1;
    repeat (2) begin
      @(posedge CLK); #1;
      pokaz_stan("ROWNOLEGLY WPIS I=1111 (S1S0=11)");
    end

    $display("=== KONIEC SYMULACJI ===");
    $finish;
  end

endmodule
