module Register4(                     //WB Register
input  clk,                            
input  reset,                           
input  RegWEn_MEM,                    //Selection Line For Register Write
input  [1:0] WBSel_MEM,               //Hold The Value of Selection Line For Result Mux
input  [31:0] PCPlus4_MEM,            //Hold The Value of Next Instruction Address
input  [4:0]  rsW_MEM,                //Hold Destination Register Address
input  [31:0] Alu_out_MEM,            //Pass Data After Processing
input  [31:0] Data_Load,              //Data For Load in Register
output reg RegWEn_WB,                 //Pass Register Write Enable
output reg [1:0] WBSel_WB,            //Pass The Vaule of Output Selection
output reg [31:0] PCPlus4_WB,         //Pass The Value of Next Instruction Address
output reg [4:0]  rsW_WB,             //Pass The Destination Register Address
output reg [31:0] Alu_out_WB,         //Pass Data After Processing 
output reg [31:0] Data_Load_WB        //Write Data From Data Memory to Register
);
    always@(posedge clk)begin
    if(reset)begin
       RegWEn_WB       <=  1'b0;
       WBSel_WB        <=  2'b0;
       PCPlus4_WB      <=  32'b0;                //For Reset Register
       rsW_WB          <=  5'b0;
       Alu_out_WB      <=  32'b0;
       Data_Load_WB    <=  32'b0;
    end
    else begin
       RegWEn_WB       <=  RegWEn_MEM;
       WBSel_WB        <=  WBSel_MEM;
       PCPlus4_WB      <=  PCPlus4_MEM;          //For Normal Condition
       rsW_WB          <=  rsW_MEM;
       Alu_out_WB      <=  Alu_out_MEM;
       Data_Load_WB    <=  Data_Load;
    end
    end
endmodule