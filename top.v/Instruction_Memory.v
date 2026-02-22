module Instruction_Memory(
input   clk,                    //Clock
input   zero,                   //Reset
input   freeze,                 // Active High: Holds the current instruction
input   [31:0] pc_out,          //Input Address of Instruction
output  reg [31:0] RI           //Read Instruction/Instruction Output
);                              
       reg [31:0] mem[0:11];  //Memoey Array (ROM)
       
    //initial $readmemh("IM.mem", mem);        // You must provide 32-bit hex entries here
    // Synchronous Read: This matches the BRAM hardware architecture
    
     initial begin         //tialize the memory
          mem[0]  = 32'h00438393; // addi sp, sp, -8
          mem[1]  = 32'hffe38393; // sw a0, 4(sp)
          mem[2]  = 32'h00c40433; // sw ra, 0(sp)
          mem[3]  = 32'h00000000;
mem[4]  = 32'h00000000;
mem[5]  = 32'h00000000;
mem[6]  = 32'h00000000;
mem[7]  = 32'h00000000;
mem[8]  = 32'h00438393; // addi sp, sp, -8
          mem[9]  = 32'hffe38393; // sw a0, 4(sp)
         
      end
      
    always@(posedge clk)begin 
      if (zero) begin
            RI <= 32'h00000000;     // RISC-V NOP: ADDI x0, x0, 0
        end
        else if (!freeze) begin
            RI <= mem[pc_out[31:2]];
        end
      end 
endmodule