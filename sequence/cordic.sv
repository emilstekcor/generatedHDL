// CORDIC-based sine and cosine generator with valid handshake
// Parameters:
//   WIDTH - bit width for fixed-point representation
//   ITER  - number of CORDIC iterations and pipeline depth
//   K_INIT - precomputed inverse CORDIC gain (1/K) in Q1.(WIDTH-1)

module cordic #(
    parameter int WIDTH  = 16,
    parameter int ITER   = 15,
    parameter logic signed [WIDTH-1:0] K_INIT = 16'sh26DD
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   valid_i,
    input  logic signed [WIDTH-1:0] angle,
    output logic signed [WIDTH-1:0] sin_o,
    output logic signed [WIDTH-1:0] cos_o,
    output logic                   valid_o
);

    // Precomputed arctangent table (Q1.(WIDTH-1))
    localparam logic signed [WIDTH-1:0] ATAN_TABLE [0:ITER-1] = '{
        16'sd8192, // atan(2^0)   * 2^15/π ≈ 8192
        16'sd4836, // atan(2^-1)  * 2^15/π ≈ 4836
        16'sd2555, // atan(2^-2)  * 2^15/π ≈ 2555
        16'sd1297, // atan(2^-3)  * 2^15/π ≈ 1297
        16'sd651,  // atan(2^-4)  * 2^15/π ≈ 651
        16'sd326,  // atan(2^-5)  * 2^15/π ≈ 326
        16'sd163,  // atan(2^-6)  * 2^15/π ≈ 163
        16'sd81,   // atan(2^-7)  * 2^15/π ≈ 81
        16'sd41,   // atan(2^-8)  * 2^15/π ≈ 41
        16'sd20,   // atan(2^-9)  * 2^15/π ≈ 20
        16'sd10,   // atan(2^-10) * 2^15/π ≈ 10
        16'sd5,    // atan(2^-11) * 2^15/π ≈ 5
        16'sd3,    // atan(2^-12) * 2^15/π ≈ 3
        16'sd1,    // atan(2^-13) * 2^15/π ≈ 1
        16'sd1     // atan(2^-14) * 2^15/π ≈ 1
    };

    // Pipeline registers
    logic signed [WIDTH-1:0] x [0:ITER];
    logic signed [WIDTH-1:0] y [0:ITER];
    logic signed [WIDTH-1:0] z [0:ITER];
    logic [ITER:0]           valid;

    integer i;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x[0]    <= K_INIT;
            y[0]    <= '0;
            z[0]    <= '0;
            valid[0]<= 1'b0;
            for (i = 0; i < ITER; i++) begin
                x[i+1]    <= '0;
                y[i+1]    <= '0;
                z[i+1]    <= '0;
                valid[i+1]<= 1'b0;
            end
        end else begin
            // load angle and propagate valid
            x[0]     <= K_INIT;
            y[0]     <= '0;
            z[0]     <= angle;
            valid[0] <= valid_i;
            for (i = 0; i < ITER; i++) begin
                if (z[i] >= 0) begin
                    x[i+1] <= x[i] - (y[i] >>> i);
                    y[i+1] <= y[i] + (x[i] >>> i);
                    z[i+1] <= z[i] - ATAN_TABLE[i];
                end else begin
                    x[i+1] <= x[i] + (y[i] >>> i);
                    y[i+1] <= y[i] - (x[i] >>> i);
                    z[i+1] <= z[i] + ATAN_TABLE[i];
                end
                valid[i+1] <= valid[i];
            end
        end
    end

    assign cos_o  = x[ITER];
    assign sin_o  = y[ITER];
    assign valid_o= valid[ITER];

endmodule

