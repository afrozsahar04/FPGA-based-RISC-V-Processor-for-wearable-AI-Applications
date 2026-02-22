module Register1(             //IF/ID Register For Pipelining
input  clk,
input  reset,
input  StallH,                //Hold The Current State (Selection Signal From Hazard Control Unit)
input  R1_Flush,              //Remove The Current Instruction From Control Unit
input  [31:0] PCPlus4,        //Hold The value of Next Instruction            
input  [31:0] pc_out,         //Hold The Instruction Address
input  [31:0] RI,             //Hold The Instruction
output reg [31:0] pc_out_ID,  //Pass The Program Counter Value For Jump
output reg [31:0] RI_ID,      //Pass The Instruction Stage
output reg [31:0] PCPlus4_ID  //Pass The Next Instruction Address
);
       always @(posedge clk) begin
         if (reset || R1_Flush) begin
          pc_out_ID  <= 32'b0;
          RI_ID      <= 32'b0;
          PCPlus4_ID <= 32'b0;
         end
         else if (StallH) begin
          pc_out_ID  <= pc_out_ID;
          RI_ID      <= RI_ID;
          PCPlus4_ID <= PCPlus4_ID;
         end  
         else begin
          pc_out_ID  <= pc_out-4;
          RI_ID      <= RI;
          PCPlus4_ID <= PCPlus4-4;
         end
       end
endmodule