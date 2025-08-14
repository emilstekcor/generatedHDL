module polar_encoder_beta (
    input  logic u_left,
    input  logic u_right,
    output logic [1:0] beta
);
    assign beta[1] = u_right;
    assign beta[0] = u_left ^ u_right;
endmodule
