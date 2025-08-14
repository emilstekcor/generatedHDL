module polar_decoder_beta (
    input  logic beta_left,
    input  logic beta_right,
    output logic [1:0] beta
);
    assign beta[1] = beta_right;
    assign beta[0] = beta_left ^ beta_right;
endmodule
