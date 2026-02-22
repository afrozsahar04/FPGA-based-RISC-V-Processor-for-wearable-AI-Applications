module Register3(                    //MEM/WB Register
input  clk,
input  reset,
input  RegWEn,                       //Selection Line For Register Write
input  MemRW,                        //Selection Line For Data Memory Write
input  [1:0] WBSel,                  //Selection Line For Result Mux
input  [31:0] PCPlus4_EX,            //Hold The Value of Next Instruction Address
input  [4:0]  rsW_EX,                //Destination Register
input  [2:0] fund3,                  //For Detail Data Write Operation 
input  [31:0] Mux2R2_in1,            //Data in Second Register
input  [31:0] Alu_out,               //Data After Processing
output reg [31:0] Alu_out_MEM,       //Pass Data After Processing
output reg [31:0] Mux2R2_in1_MEM,    //Pass Data in Second Register 
output reg [2:0] fund3_MEM,          //Pass Value For Detail Data Write Operation
output reg [4:0]  rsW_MEM,           //Pass Destination Register Address
output reg [31:0] PCPlus4_MEM,       //Pass The Value of Next Instruction Address
output reg [1:0] WBSel_MEM,          //Pass The Value of Selection Line For Result Mux
output reg RegWEn_MEM,               //Pass The Value of Selection Line For Register Write
output reg MemRW_MEM                 //Pass The Value of Selection Line For Data Memory Write
);
          always@(posedge clk)begin
          if(reset)begin
            Alu_out_MEM       <=   32'b0;
            Mux2R2_in1_MEM    <=   32'b0;
            fund3_MEM         <=   3'b0;
            rsW_MEM           <=   5'b0;
            PCPlus4_MEM       <=   32'b0;        //For Reset The Register
            WBSel_MEM         <=   2'b0;
            RegWEn_MEM        <=   1'b0;
            MemRW_MEM         <=   1'b0;
          end
          else begin
            Alu_out_MEM       <=   Alu_out;
            Mux2R2_in1_MEM    <=   Mux2R2_in1;
            fund3_MEM         <=   fund3;
            rsW_MEM           <=   rsW_EX;
            PCPlus4_MEM       <=   PCPlus4_EX;   //For Normal Conditions 
            WBSel_MEM         <=   WBSel;
            RegWEn_MEM        <=   RegWEn;
            MemRW_MEM         <=   MemRW;
          end
          end
endmodule