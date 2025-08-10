module FIFO_Memory #(parameter data_size = 8, parameter address_size = 4) (
 input write_clk,
 input read_clk,
 input write_full,
 input write_en,
 input [data_size-1:0] write_data,
 output reg [data_size-1:0] read_data,
 input [address_size-1:0] write_address,
 input [address_size-1:0] read_address
);
  reg [data_size-1:0] mem [0:(1<<address_size)-1];

  always @(posedge write_clk) begin
    if (write_en && !write_full)
      mem[write_address] <= write_data;
  end

  always @(posedge read_clk) begin
    read_data <= mem[read_address];
  end
endmodule
