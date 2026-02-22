# RISC-V Processor Implementation

This repository contains a complete single-cycle RISC-V processor designed and implemented in Verilog.

## Folder Structure

- **RTL / Top-level module**  
  `top.v` (includes: ALU.v, Branch_Comparator.v, clk_divider.v, Control_Unit.v, Data_Memory.v, Forwarding_Unit.v, Hazard_Detection_Unit.v, Immediate_Generator.v, Instruction_Memory.v, Mux_1R1.v, Mux_1R2.v, Mux_2_Imm_R2.v, Mux_2_PC_R1.v, Mux_PC_Selection.v, Mux3_Result.v, Program_Counter.v, Program_Counter_Plus_4.v, Register_File.v, Register1.v, Register2.v, Register3.v, Register4.v, Top_Module.v)
- **Assembly Program**  
  `Assembly Prog for HR Anomaly Detector.txt`
- **Memory Files**  
  `IM.mem`
- **Testbench**  
  `tb.v`
- **Vivado Project (Optional)**  
  `risc-v.xpr`
- **Documentation / Figures**  
  `pipelined processor diagram.pdf`, `README.md`

  ## Features

- Modular Pipelined RISC-V datapath  
- Supports R-type, I-type, load/store, branch, and jump RV32I instructions  
- Synthesizable RTL  
- Testbench for functional verification  
- Memory initialization using `.mem` files  
- FPGA-ready (Vivado project included)  
- Integrated ML pipeline for heart rate anomaly detection (Python)  
- Synchronous memory reads and writes  
- BRAM inferrable for instruction memory  
- Tailored for AI applications
## Figures
  ![Pipelined Schematic](figures/pipelined processer diagram.jpg)
