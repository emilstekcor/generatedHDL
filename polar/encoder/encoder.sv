module polar_encoder #(
    parameter int N = 2
) (
    input  logic [N-1:0] u,
    output logic [N-1:0] x
);
    if (N == 1) begin : base
        assign x[0] = u[0];
    end else begin : rec
        localparam int HALF = N/2;
        logic [HALF-1:0] upper, lower;
        for (genvar i = 0; i < HALF; i++) begin : stage0
            polar_encoder_alpha alpha_inst(
                .u_left(u[2*i]),
                .u_right(u[2*i+1]),
                .alpha(upper[i])
            );
            assign lower[i] = u[2*i+1];
        end
        logic [HALF-1:0] enc_upper, enc_lower;
        polar_encoder #(.N(HALF)) upper_enc(
            .u(upper),
            .x(enc_upper)
        );
        polar_encoder #(.N(HALF)) lower_enc(
            .u(lower),
            .x(enc_lower)
        );
        for (genvar j = 0; j < HALF; j++) begin : stage1
            assign x[j] = enc_upper[j];
            assign x[j+HALF] = enc_lower[j];
        end
    end
endmodule

