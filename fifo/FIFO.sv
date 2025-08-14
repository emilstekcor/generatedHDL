module FIFO #(parameter address_size = 4, parameter data_size = 8) (
 input write_clk, read_clk,
 input write_incr, read_incr,
 input wreset_n, rreset_n,
 input [data_size-1:0] write_data,
 output [data_size-1:0] read_data,
 output read_empty, write_full
);
 wire [address_size:0] write_pointer, read_pointer;
 wire [address_size:0] write_pointer_s, read_pointer_s;
 wire [address_size-1:0] write_address, read_address;

 FIFO_Memory #(data_size, address_size) FIFO_inst (
  .write_clk(write_clk),
  .read_clk(read_clk),
  .write_full(write_full),
  .write_en(write_incr),
  .write_data(write_data),
  .read_data(read_data),
  .write_address(write_address),
  .read_address(read_address)
 );

 synchronous_write_read #(address_size) sync1 (
  .read_clk(read_clk),
  .rreset_n(rreset_n),
  .write_pointer(write_pointer),
  .write_pointer_s(write_pointer_s)
 );

 synchronous_read_write #(address_size) sync2 (
  .write_clk(write_clk),
  .wreset_n(wreset_n),
  .read_pointer(read_pointer),
  .read_pointer_s(read_pointer_s)
 );

 write_full #(address_size) full (
  .write_clk(write_clk),
  .wreset_n(wreset_n),
  .write_incr(write_incr),
  .read_pointer_s(read_pointer_s),
  .write_pointer(write_pointer),
  .write_address(write_address),
  .write_full(write_full)
 );

 read_empty #(address_size) empty (
  .read_clk(read_clk),
  .rreset_n(rreset_n),
  .read_incr(read_incr),
  .write_pointer_s(write_pointer_s),
  .read_pointer(read_pointer),
  .read_address(read_address),
  .read_empty(read_empty)
 );
endmodule
