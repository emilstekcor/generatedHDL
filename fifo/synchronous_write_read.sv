module synchronous_write_read #(parameter address_size = 4) (
 input read_clk,
 input rreset_n,
 input [address_size:0] write_pointer,
 output reg [address_size:0] write_pointer_s
);
  reg [address_size:0] sync_ff;
  always @(posedge read_clk or negedge rreset_n) begin
    if (!rreset_n) begin
      sync_ff <= '0;
      write_pointer_s <= '0;
    end else begin
      sync_ff <= write_pointer;
      write_pointer_s <= sync_ff;
    end
  end
endmodule
