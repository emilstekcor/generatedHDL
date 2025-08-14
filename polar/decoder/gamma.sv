module polar_decoder_gamma #(
    parameter int WIDTH = 8
) (
    input  logic signed [WIDTH-1:0] llr_left,
    input  logic signed [WIDTH-1:0] llr_right,
    input  logic bit_estimate,
    output logic signed [WIDTH-1:0] gamma
);
    assign gamma = llr_right + (bit_estimate ? -llr_left : llr_left);
endmodule
