module Register2(                   //ID/EX Register
input  clk,
input  reset,
input  IF_Flush,                    //Remove The Current Instruction From Control Unit
input  IF_FlushH,                   //Remove The Current Instruction From Hazard Detection Unit
input  [31:0] pc_out_ID,            //Hold The Value of Current Instruction Address
input  [31:0] PCPlus4_ID,           //Hold The Next Instruction Address
input  [31:0] dataR1,               //Data in First Register
input  [31:0] dataR2,               //Data in Second Register
input  [4:0] rsW,                   //Destination Register Used To Avoid Hazard
input  [4:0] rsR1,                  //First Register Used To Avoid Hazard
input  [4:0] rsR2,                  //Second Register Used To Avoid Hazard
input  [31:0] RI_ID,                //Pass The Current Instruction
output reg [31:0] PCPlus4_EX,       //Hold Value of Next Instruction Address
output reg [31:0] Data1,            //Value of First Register As Input for Mux Later Used by ALU
output reg [31:0] Data2,            //Value of Second Register OR Immediate As Input for Mux Later Used by ALU
output reg [4:0]  rsW_EX,           //Hold Value of Destination Register
output reg [4:0]  rsR1_EX,          //Hold Value of First Register Used by Fowarding Unit To Avoid Data Hazard
output reg [4:0]  rsR2_EX,          //Hold Value of Second Register Used by Fowarding Unit To Avoid Data Hazard
output reg [31:0] pc_out_EX,        //Pass The Value of Current Instruction Address to Mux
output reg [31:0] RI_EX             //Hold The Current Instruction
);
        always @(posedge clk) begin
         if(reset)begin
           PCPlus4_EX   <=   32'b0;                      //Reset The Register To 0 Value
           Data1        <=   32'b0;
           Data2        <=   32'b0; 
           rsW_EX       <=   5'b0; 
           rsR1_EX      <=   5'b0; 
           rsR2_EX      <=   5'b0;
           RI_EX        <=   32'b0;
           pc_out_EX    <=   32'b0;
         end 
         else if(IF_Flush || IF_FlushH) begin
           PCPlus4_EX   <=   32'b0;                      //Reset The Register To 0 Value To Avoid Hazard 
           Data1        <=   32'b0;
           Data2        <=   32'b0; 
           rsW_EX       <=   5'b0; 
           rsR1_EX      <=   5'b0; 
           rsR2_EX      <=   5'b0;
           RI_EX        <=   32'b0;
           pc_out_EX    <=   32'b0;
         end           
         else begin    
           Data1        <=  dataR1;      
           Data2        <=  dataR2;         
           PCPlus4_EX   <=  PCPlus4_ID;
           rsW_EX       <=  rsW;
           rsR1_EX      <=  rsR1;
           rsR2_EX      <=  rsR2;
           pc_out_EX    <=  pc_out_ID;
           RI_EX        <=  RI_ID;
         end
        end
endmodule