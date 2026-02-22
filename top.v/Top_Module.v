`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2026 07:29:45 PM
// Design Name: 
// Module Name: Top_Module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Top_Module(                                      //Connect All The Modules
input  clk_in,                                             //Clock Signal
input  reset,
output wire [3:0] leds                                         //reset Signal
);                                                  
     
    wire  clk; 
    wire PCSel_w;                                       //Jump selection Wire
    wire Stall_w;                                       //Hold wire
    wire IF_Flushh_w;                                   //Flush Register 1 From Hazard Control Unit
    wire IF_Flush_w;                                    //Flush Register 1 From Control Unit                                                      
    wire [31:0] pc_in_w;                                //Program Counter Input 
    wire [31:0] pc_out_w;                               //Program Counter Output
    wire [31:0] instruction;                            //Instruction Memory Output
    wire [31:0] pc_plus_4;                              //Next Instruction Address
    wire [31:0] pc_plus_4_EX;                           //Pass The value of Next Instruction Address
    wire [31:0] pc_out_EX;                              //Pass The value of Current Instruction Address
    wire [31:0] instruction_EX;                         //Pass The Instruction To Register 2
    wire [31:0] r1data;                                 //Pass The Data of Frist Register To Register 2
    wire [31:0] r2data;                                 //Pass The Data of Second Register To Register 2
    wire [31:0] instruction_C;                          //Pass Instruction To Control Unit
    wire [2:0]  immsel_w;                               //Immediate Selection wire
    wire [31:0] pc_out_M;                               //Pass Current Instruction Address To Mux
    wire [31:0] pc_plus_4_MEM;                          //Pass Next Instruction Address To Next Register 3
    wire [31:0] alu_in1;                                //Frist ALU Input
    wire [31:0] alu_in2;                                //Second ALU Input
    wire [31:0] alu_out_w;                              //ALU Output 
    wire Asel_w;                                        //Selection Wire Between Program Counter And Frist Register
    wire Bsel_w;                                        //Selection Wire Between  Immediate Value And second Register
    wire BrLT_W;                                        //Branch Less Than Wire
    wire BrEq_w;                                        //Branch Equall wire
    wire LoadH_w;                                       //Load Hazard Detection Wire
    wire Brun_w;                                        //Branch Unsigned Wire
    wire RegWEn_w;                                      //Register Write Enable Wire
    wire MemRW_w;                                       //Data Memory Enable Wire
    wire [3:0] ALUSel_w;                                //ALU Selection Wire
    wire [1:0] WBSel_w;                                 //Result Selection Wire
    wire [2:0] fund3_w;                                 //Detailed Data Write Operation
    wire [31:0] Imm_out;                                //Immediate Generator Output
    wire [31:0] R1data;                                 //Pass Frist Register Value To Mux For Update
    wire [31:0] R2data;                                 //Pass Second Register Value To Mux For Update
    wire [31:0] R1data_U;                               //Updated Value From Mux For First Register
    wire [31:0] R2data_U;                               //Updated Value From Mux For Second Register
    wire [4:0]  rsr1;                                   //Pass Frist Register Value To Forwarding Unit
    wire [4:0]  rsr2;                                   //Pass Second Register Value To Forwarding Unit
    wire [4:0]  rd_MEM;                                 //Pass Destination Register Value To Register 3
    wire [1:0]  m1sel;                                  //Wire For Frist Register Update
    wire [1:0]  m2sel;                                  //Wire For Second Register Update  
    wire [31:0] pc_plus_4_WB;                           //Pass Next Instruction Address
    wire RegWEn_WB;                                     //Pass Register Write Enable To Register 4
    wire MemRW_D;                                       //Hold Data Memory Write Enable
    wire [1:0] WBSel_WB;                                //Pass Result Selection Line To Register 4
    wire [2:0] Fund3_D;                                 //Hold Detailed Data Write Operation
    wire [31:0] alu_D;                                  //Value From ALU To Data Memory
    wire [31:0] data_M;                                 //Data From Data Memory
    wire [31:0] data_r;                                 //Data From Data Memory To Register WB
    wire [31:0] rsr2_D;                                 //Store second Register Value In Data Memory
    wire [4:0]  rd_WB;                                  //Destination Register Address
    wire [31:0] pc_plus4_M;                             //Pass Next Instruction Address To Result Mux
    wire RegWEn_R;                                      //Pass Register File Enable To Register File
    wire [1:0]  WBSel_M;                                //Selection Wire For Mux Result
    wire [31:0] alu_M;                                  //Pass ALU Value To Mux
    wire [31:0] data_D_M;                               //Pass Data From Data Memory To Mux
    wire [4:0]  rd_R;                                   //Pass Destination Register Address to Register File
    wire [31:0] result_w;                               //Pass Data To Register File To Write 
    
      
      
       clk_divider clkdiv(.clk_in(clk_in),.rst(reset),.clk_out(clk));


      Mux_PC_Selection  PCS(.PCSel(PCSel_w),.PCPlus4(pc_plus_4),.Alu_out(alu_out_w),.pc_in(pc_in_w));
       
      Program_Counter PC(.clk(clk),.reset(reset),.Stall(Stall_w),.pc_in(pc_in_w),.pc_out(pc_out_w));
      
      Program_Counter_Plus_4 PCP(.pc_out(pc_out_w),.PCPlus4(pc_plus_4));
      
      Instruction_Memory IMEM(.clk(clk),.zero(IF_Flush_w),.freeze(Stall_w),.pc_out(pc_out_w),.RI(instruction));
      
      Register1 Reg1(.clk(clk),.reset(reset),.StallH(Stall_w),.R1_Flush(IF_Flush_w),.PCPlus4(pc_plus_4),.pc_out(pc_out_w),.RI(instruction),
                     .pc_out_ID(pc_out_EX),.RI_ID(instruction_EX),.PCPlus4_ID(pc_plus_4_EX)); 
      
      Register_File RegF(.dataW(result_w),.clk(clk),.reset(reset),.RegWEn(RegWEn_R),.rsW(rd_R),.rsR1(instruction_EX[19:15]),
                         .rsR2(instruction_EX[24:20]),.dataR1(r1data),.dataR2(r2data));
                         
      Register2 Reg2(.clk(clk),.reset(reset),.IF_FlushH(IF_Flushh_w),.IF_Flush(IF_Flush_w),.pc_out_ID(pc_out_EX),
                     .PCPlus4_ID(pc_plus_4_EX),.dataR1(r1data),.dataR2(r2data),.rsW(instruction_EX[11:7]),
                     .rsR1(instruction_EX[19:15]),.rsR2(instruction_EX[24:20]),.RI_ID(instruction_EX),
                     .PCPlus4_EX(pc_plus_4_MEM),.Data1(R1data),.Data2(R2data),.rsW_EX(rd_MEM),.rsR1_EX(rsr1),.rsR2_EX(rsr2), 
                     .pc_out_EX(pc_out_M),.RI_EX(instruction_C));
      
      Hazard_Detection_Unit HDU(.Load_Hazard(LoadH_w),.rsW_EX(rd_MEM),.rsR1(instruction_EX[19:15]),.rsR2(instruction_EX[24:20]),
                                .Stall(Stall_w),.IF_FlushH(IF_Flushh_w));
      
      Immediate_Generator ImGe(.RI(instruction_C),.ImmSel(immsel_w),.ImmExt(Imm_out));
      
      Branch_Comparator BrC(.dataR1(R1data_U),.dataR2(R2data_U),.BrUn(Brun_w),.BrEq(BrEq_w),.BrLT(BrLT_W));
      
      Control_Unit CoUn(.opcode(instruction_C[6:0]),.fun3(instruction_C[14:12]),.fun7(instruction_C[31:25]),.BrEq(BrEq_w),
                        .BrLT(BrLT_W),.Load_Hazard(LoadH_w),.IF_Flush(IF_Flush_w),.PCSel(PCSel_w),.ImmSel(immsel_w),
                        .RegWEn(RegWEn_w),.BrUn(Brun_w),.Bsel(Bsel_w), .Asel(Asel_w),.ALUSel(ALUSel_w),.MemRW(MemRW_w),
                        .WBSel(WBSel_w),.fund3(fund3_w));
        
      Mux_1R1 MRU(.Data1(R1data),.dataW_WB(result_w),.ALU_MEM(alu_D),.M1Sel(m1sel),.Mux2R1_in1(R1data_U));
       
      Mux_1R2 MRUP(.Data2(R2data),.dataW_WB(result_w),.ALU_MEM(alu_D),.M2Sel(m2sel), .Mux2R2_in1(R2data_U));
      
      Mux_2_PC_R1 MPR(.Mux2R1_in1(R1data_U),.pc_out_EX(pc_out_M),.Asel(Asel_w),.Alu_in1(alu_in1)); 
      
      Mux_2_Imm_R2 MIR(.Mux2R2_in1(R2data_U),.ImmExt_EX(Imm_out),.Bsel(Bsel_w),.Alu_in2(alu_in2));
      
      ALU ARTM(.Alu_in1(alu_in1),.Alu_in2(alu_in2),.ALUSel(ALUSel_w),.Alu_out(alu_out_w));
      
      Forwarding_Unit FU(.rsW_MEM(rd_WB),.rsW_WB(rd_R),.rsR1_EX(rsr1),.rsR2_EX(rsr2),.RegWEn_MEM(RegWEn_WB),
                         .RegWEn_WB(RegWEn_R),.M1Sel(m1sel),.M2Sel(m2sel));    
      
      Register3 REG3(.clk(clk),.reset(reset),.RegWEn(RegWEn_w),.MemRW(MemRW_w),.WBSel(WBSel_w),.PCPlus4_EX(pc_plus_4_MEM),
                     .rsW_EX(rd_MEM),.fund3(fund3_w),.Mux2R2_in1(R2data_U),.Alu_out(alu_out_w),.Alu_out_MEM(alu_D),
                     .Mux2R2_in1_MEM(rsr2_D),.fund3_MEM(Fund3_D),.rsW_MEM(rd_WB),.PCPlus4_MEM(pc_plus_4_WB),
                     .WBSel_MEM(WBSel_WB),.RegWEn_MEM(RegWEn_WB),.MemRW_MEM(MemRW_D));
      
      Data_Memory DaM(.clk(clk),.Alu_out_MEM(alu_D),.Mux2R2_in1_MEM(rsr2_D),.fund3_MEM(Fund3_D),.MemRW_MEM(MemRW_D),
                      .Data_Load(data_r));
      
      Register4 Reg4(.clk(clk),.reset(reset),.RegWEn_MEM(RegWEn_WB),.WBSel_MEM(WBSel_WB),.PCPlus4_MEM(pc_plus_4_WB),  
                     .rsW_MEM(rd_WB),.Alu_out_MEM(alu_D),.Data_Load(data_r),.RegWEn_WB(RegWEn_R),.WBSel_WB(WBSel_M),      
                     .PCPlus4_WB(pc_plus4_M),.rsW_WB(rd_R),.Alu_out_WB(alu_M),.Data_Load_WB(data_D_M));
      
      Mux3_Result MuR( .WBSel_WB(WBSel_M),.PCPlus4_WB(pc_plus4_M),.Alu_out_WB(alu_M),.Data_Load_WB(data_D_M),
                       .dataW(result_w));
                       
assign leds = result_w[3:0];
               
endmodule