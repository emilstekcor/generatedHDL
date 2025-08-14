package polar_decoder_calculations;

    parameter int WIDTH = 8;

    function automatic logic signed [WIDTH-1:0] alpha (
        input logic signed [WIDTH-1:0] llr_left,
        input logic signed [WIDTH-1:0] llr_right
    );
        logic signed [WIDTH-1:0] abs_left, abs_right, min_abs;
        abs_left = (llr_left < 0) ? -llr_left : llr_left;
        abs_right = (llr_right < 0) ? -llr_right : llr_right;
        min_abs = (abs_left < abs_right) ? abs_left : abs_right;
        alpha = (llr_left[WIDTH-1] ^ llr_right[WIDTH-1]) ? -min_abs : min_abs;
    endfunction

    function automatic logic signed [WIDTH-1:0] gamma (
        input logic signed [WIDTH-1:0] llr_left,
        input logic signed [WIDTH-1:0] llr_right,
        input logic bit_estimate
    );
        gamma = llr_right + (bit_estimate ? -llr_left : llr_left);
    endfunction

    function automatic logic [1:0] beta (
        input logic beta_left,
        input logic beta_right
    );
        beta[1] = beta_right;
        beta[0] = beta_left ^ beta_right;
    endfunction

endpackage
