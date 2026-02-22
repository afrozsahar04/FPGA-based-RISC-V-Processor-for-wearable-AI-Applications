
module Program_Counter_Plus_4(
input  [31:0] pc_out,
output [31:0] PCPlus4
);
 assign PCPlus4 = pc_out + 4;   //For Next Instruction Location
endmodule