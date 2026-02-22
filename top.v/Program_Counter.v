module Program_Counter(
input  clk,
input  reset,               
input  Stall,                //To Avoid Hazard By Holding Previous Instruction Address 
input  [31:0] pc_in,         //Program Counter Input
output reg [31:0] pc_out     //Program Counter Output
);                             
  always@(posedge clk)                
  if(reset)                       
    pc_out<=32'b0;           //Reset PC to 0 on reset
  else if(Stall)
    pc_out<=pc_out;         //To Avoid Hazard By Holding Previous Instruction Address
  else                       
    pc_out<=pc_in;           // Otherwise, update PC
endmodule