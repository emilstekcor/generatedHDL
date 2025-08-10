module TurboEncoder (
    input  logic clk,
    input  logic rst_n,
    input  logic bit_in,
    input  int   index_in,
    input  int   size,
    output logic parity_out,
    output int   index_out
);
    import rsc_lib::*;

    logic [1:0] state;
    logic [1:0] next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= '0;
        end else begin
            rsc_encode(bit_in, state, parity_out, next_state);
            state <= next_state;
        end
    end

    assign index_out = interleave_index(index_in, size);
endmodule
