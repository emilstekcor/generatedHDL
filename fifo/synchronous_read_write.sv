module synchronous_read_write #(parameter address_size = 4) (
 input write_clk,
 input wreset_n,
 input [address_size:0] read_pointer,
 output reg [address_size:0] read_pointer_s
);
  reg [address_size:0] sync_ff;
  always @(posedge write_clk or negedge wreset_n) begin
    if (!wreset_n) begin
      sync_ff <= '0;
      read_pointer_s <= '0;
    end else begin
      sync_ff <= read_pointer;
      read_pointer_s <= sync_ff;
    end
  end
endmodule
