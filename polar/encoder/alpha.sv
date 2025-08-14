module polar_encoder_alpha (
    input  logic u_left,
    input  logic u_right,
    output logic alpha
);
    assign alpha = u_left ^ u_right;
endmodule
