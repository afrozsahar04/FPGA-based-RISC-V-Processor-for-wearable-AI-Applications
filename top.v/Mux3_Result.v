module Mux3_Result(               //Mux For Data Write in Register
input  [1:0] WBSel_WB,            //Hold The Vaule of Output Selection
input  [31:0] PCPlus4_WB,         //Hold The Value of Next Instruction Address
input  [31:0] Alu_out_WB,         //Hold Data After Processing 
input  [31:0] Data_Load_WB,       //Write Data From Data Memory to Register
output reg [31:0] dataW           //Data For Write in Register
);
       always@(*)begin
         case(WBSel_WB)
           2'b00: dataW  = Data_Load_WB;       //Data From Data Memory
           2'b01: dataW  = Alu_out_WB;         //Data From ALU
           2'b10: dataW  = PCPlus4_WB;         //Value of Next Instruction Address
           default:dataW = 32'b0;
         endcase
       end
endmodule