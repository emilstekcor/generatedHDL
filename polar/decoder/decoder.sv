module polar_decoder #(
    parameter int N = 2,
    parameter int WIDTH = 8
) (
    input  logic signed [WIDTH-1:0] llr [N],
    output logic u [N]
);
    if (N == 1) begin : base
        assign u[0] = llr[0][WIDTH-1];
    end else begin : rec
        localparam int HALF = N/2;
        logic signed [WIDTH-1:0] alpha_in [HALF];
        for (genvar i = 0; i < HALF; i++) begin : alpha_loop
            polar_decoder_alpha #(.WIDTH(WIDTH)) alpha_inst(
                .llr_left(llr[2*i]),
                .llr_right(llr[2*i+1]),
                .alpha(alpha_in[i])
            );
        end
        logic u_upper [HALF];
        polar_decoder #(.N(HALF), .WIDTH(WIDTH)) upper_dec(
            .llr(alpha_in),
            .u(u_upper)
        );
        logic signed [WIDTH-1:0] gamma_in [HALF];
        for (genvar j = 0; j < HALF; j++) begin : gamma_loop
            polar_decoder_gamma #(.WIDTH(WIDTH)) gamma_inst(
                .llr_left(llr[2*j]),
                .llr_right(llr[2*j+1]),
                .bit_estimate(u_upper[j]),
                .gamma(gamma_in[j])
            );
        end
        logic u_lower [HALF];
        polar_decoder #(.N(HALF), .WIDTH(WIDTH)) lower_dec(
            .llr(gamma_in),
            .u(u_lower)
        );
        for (genvar k = 0; k < HALF; k++) begin : beta_loop
            logic [1:0] beta_pair;
            polar_decoder_beta beta_inst(
                .beta_left(u_upper[k]),
                .beta_right(u_lower[k]),
                .beta(beta_pair)
            );
            assign u[2*k] = beta_pair[0];
            assign u[2*k+1] = beta_pair[1];
        end
    end
endmodule

