package polar_encoder_calculations;

    parameter int WIDTH = 8;

    function automatic logic alpha (
        input logic u_left,
        input logic u_right
    );
        alpha = u_left ^ u_right;
    endfunction

    function automatic logic [1:0] beta (
        input logic u_left,
        input logic u_right
    );
        beta[1] = u_right;
        beta[0] = u_left ^ u_right;
    endfunction

    function automatic logic signed [WIDTH-1:0] gamma (
        input logic signed [WIDTH-1:0] llr_left,
        input logic signed [WIDTH-1:0] llr_right,
        input logic u_left
    );
        gamma = llr_right + (u_left ? -llr_left : llr_left);
    endfunction

endpackage
