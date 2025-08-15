`timescale 1ns/1ns

module Atan2_tb;
  // clock and reset
  logic clk = 0;
  logic reset = 0;
  logic clk_enable = 1;
  // inputs
  logic signed [17:0] y_dataIn;
  logic signed [17:0] x_dataIn;
  logic validIn;
  // outputs
  logic ce_out;
  logic signed [17:0] thetaOut;
  logic validOut;

  // instantiate DUT
  Atan2 dut(
    .clk(clk),
    .reset(reset),
    .clk_enable(clk_enable),
    .y_dataIn(y_dataIn),
    .x_dataIn(x_dataIn),
    .validIn(validIn),
    .ce_out(ce_out),
    .thetaOut(thetaOut),
    .validOut(validOut)
  );

  // provide clock
  always #5 clk = ~clk;

  // stimulus
  initial begin
    reset = 1; validIn = 0; x_dataIn = 0; y_dataIn = 0;
    #12; // reset for a few cycles
    reset = 0;

    // send a few sample vectors
    repeat (3) begin
      @(negedge clk);
      validIn <= 1;
      x_dataIn <= $random;
      y_dataIn <= $random;
    end
    @(negedge clk);
    validIn <= 0;

    #100;
    $finish;
  end
endmodule

// simple stub for Atan2_block used by Atan2
module Atan2_block(
  input  logic clk,
  input  logic reset,
  input  logic enb,
  input  logic signed [17:0] y_in,
  input  logic signed [17:0] x_in,
  output logic signed [17:0] angle
);
  // placeholder: drive angle with 0
  always_comb begin
    angle = 18'sd0;
  end
endmodule
