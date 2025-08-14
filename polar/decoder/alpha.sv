module polar_decoder_alpha #(
    parameter int WIDTH = 8
) (
    input  logic signed [WIDTH-1:0] llr_left,
    input  logic signed [WIDTH-1:0] llr_right,
    output logic signed [WIDTH-1:0] alpha
);
    logic signed [WIDTH-1:0] abs_left, abs_right, min_abs;
    assign abs_left = (llr_left < 0) ? -llr_left : llr_left;
    assign abs_right = (llr_right < 0) ? -llr_right : llr_right;
    assign min_abs = (abs_left < abs_right) ? abs_left : abs_right;
    assign alpha = (llr_left[WIDTH-1] ^ llr_right[WIDTH-1]) ? -min_abs : min_abs;
endmodule
