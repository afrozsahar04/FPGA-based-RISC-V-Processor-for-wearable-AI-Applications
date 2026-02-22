# RISC-V Processor Implementation

This repository contains a complete single-cycle RISC-V processor designed and implemented in Verilog.

## Features
- Modular Pipelined RISC-V datapath
- Supports R-type, I-type, load/store, branch, and jump instructions
- Synthesizable RTL
- Testbench for functional verification
- Memory initialization using .mem files
- FPGA-ready (Vivado project included)
- Integrated ML pipeline for heart rate anomaly detection (Python)

## Folder Structure
- rtl/    → Verilog RTL modules
- tb/     → Testbench
- mem/    → Instruction & data memory files
- asm/    → Assembly and hex programs
- ml/     → Python ML code
- vivado/ → Vivado project (optional)

## Author
Affay — Electrical (Telecommunication) Engineering  
Focus: RISC-V, Digital Design, FPGA, Embedded Systems
