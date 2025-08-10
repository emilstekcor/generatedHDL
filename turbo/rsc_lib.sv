package rsc_lib;

  function automatic void rsc_encode(
      input  logic       bit_in,
      input  logic [1:0] state_in,
      output logic       parity_out,
      output logic [1:0] state_out
  );
      parity_out = bit_in ^ state_in[0] ^ state_in[1];
      state_out  = {bit_in, state_in[0]};
  endfunction

  function automatic int interleave_index(
      input int idx,
      input int size
  );
      interleave_index = (idx * 3) % size;
  endfunction

endpackage : rsc_lib
