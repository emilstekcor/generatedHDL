#!/bin/bash
set -e
verilator --lint-only -Wall -Wno-MULTITOP \
  turbo/rsc_lib.sv turbo/TurboEncoder.sv turbo/TurboDecoder.sv \
  fifo/FIFO.sv fifo/FIFO_Memory.sv fifo/synchronous_write_read.sv fifo/synchronous_read_write.sv fifo/write_full.sv fifo/read_empty.sv \
  polar/PolarEncoder.sv polar/PolarDecoder.sv
