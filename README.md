# RISC-V Processor Implementation

This repository contains a complete RISC-V processor designed and implemented in Verilog on FPGA. The project began with designing a single-cycle RISC-V processor from scratch, implementing the full RV32I instruction set and verifying its functionality in simulation. While the single-cycle design worked correctly in simulation, attempts to implement it on FPGA revealed limitations due to timing constraints, non-synchronous memory access, and high resource utilization, making it non-synthesizable in its initial form. To overcome these issues, the processor was redesigned with a pipelined architecture, improving performance and meeting FPGA timing requirements. Instruction memory was implemented using BRAM for efficient, synchronous reads and writes. To demonstrate the processor’s capability, an ML-based heart-rate anomaly detector application was developed using a linear regression model and successfully test-run on the RISC-V core. The design includes timing diagrams and BRAM implementation details for reference.

## Folder Structure

- **RTL / Top-level module**  
  `top.v` (includes: ALU.v, Branch_Comparator.v, clk_divider.v, Control_Unit.v, Data_Memory.v, Forwarding_Unit.v, Hazard_Detection_Unit.v, Immediate_Generator.v, Instruction_Memory.v, Mux_1R1.v, Mux_1R2.v, Mux_2_Imm_R2.v, Mux_2_PC_R1.v, Mux_PC_Selection.v, Mux3_Result.v, Program_Counter.v, Program_Counter_Plus_4.v, Register_File.v, Register1.v, Register2.v, Register3.v, Register4.v, Top_Module.v)
- **Assembly Program**  
  `Assembly Prog for HR Anomaly Detector.asm`
- **Memory Files**  
  `IM.mem`
- **Testbench**  
  `tb.v`
- **Vivado Project (Optional)**  
  `risc-v.xpr`

## Features

- Modular Pipelined RISC-V datapath  
- Supports R-type, I-type, load/store, branch, and jump RV32I instructions  
- Synthesizable RTL  
- Testbench for functional verification  
- Memory initialization using `.mem` files  
- FPGA-ready (Vivado project included)  
- Synchronous memory reads 
- BRAM inferrable for instruction memory  
- Tailorable for AI applications

## Author

- **Afroz Sahar** — Electrical (Electronics & Communications) Engineer
- **Focus:** RISC-V, Digital Design, FPGA, Embedded Systems, Computer Architecture, RTL Design, VLSI Circuit Design, Hardware/Software Co-Design, Application-specific processor, Machine learning
