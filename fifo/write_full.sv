module write_full #(parameter address_size = 4) (
 input write_clk,
 input wreset_n,
 input write_incr,
 input [address_size:0] read_pointer_s,
 output reg [address_size:0] write_pointer,
 output [address_size-1:0] write_address,
 output reg write_full
);
  assign write_address = write_pointer[address_size-1:0];
  wire [address_size:0] write_pointer_next = write_pointer +
      {{address_size{1'b0}}, (write_incr & ~write_full)};

  always @(posedge write_clk or negedge wreset_n) begin
    if (!wreset_n) begin
      write_pointer <= '0;
    end else begin
      write_pointer <= write_pointer_next;
    end
  end

  always @(posedge write_clk or negedge wreset_n) begin
    if (!wreset_n) begin
      write_full <= 1'b0;
    end else begin
      write_full <= (write_pointer_next == {~read_pointer_s[address_size], read_pointer_s[address_size-1:0]});
    end
  end
endmodule
