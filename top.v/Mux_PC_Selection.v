
module Mux_PC_Selection(            //Mux Used For Selection of New Program Counter Value
input  PCSel,                       //Selection Line From Control Unit to Select Nem Value of Program Counter
input  [31:0] PCPlus4,              //Address of Next Instruction
input  [31:0] Alu_out,              //Next Instruction Address After Jump
output [31:0] pc_in                 //Address of Instruction to Fetch
);
      assign pc_in =(PCSel)? Alu_out:PCPlus4;
endmodule