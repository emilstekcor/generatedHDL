module read_empty #(parameter address_size = 4) (
 input read_clk,
 input rreset_n,
 input read_incr,
 input [address_size:0] write_pointer_s,
 output reg [address_size:0] read_pointer,
 output [address_size-1:0] read_address,
 output reg read_empty
);
  assign read_address = read_pointer[address_size-1:0];
  wire [address_size:0] read_pointer_next = read_pointer +
      {{address_size{1'b0}}, (read_incr & ~read_empty)};

  always @(posedge read_clk or negedge rreset_n) begin
    if (!rreset_n) begin
      read_pointer <= '0;
    end else begin
      read_pointer <= read_pointer_next;
    end
  end

  always @(posedge read_clk or negedge rreset_n) begin
    if (!rreset_n) begin
      read_empty <= 1'b1;
    end else begin
      read_empty <= (read_pointer_next == write_pointer_s);
    end
  end
endmodule
