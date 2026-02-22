module Mux_1R2(               //Mux Used to Avoid Data Hazard And Update Second Register Value
input  [31:0] Data2,          //Hold The Value of First Register OR Program Counter
input  [31:0] dataW_WB,       //Data Came From WB Register to Avoid Hazard
input  [31:0] ALU_MEM,        //Data Came From MEM Register to Avoid Hazard
input  [1:0]  M2Sel,          //Selection Line Used by Fowarding Unit to Avoid Hazard 
output reg [31:0] Mux2R2_in1  //Second Input of Mux Having Updatd Second Register Value
); 
     always@(*)begin
     case(M2Sel)
       2'b10:Mux2R2_in1    =  ALU_MEM;
       2'b01:Mux2R2_in1    =  dataW_WB;
       2'b00:Mux2R2_in1    =  Data2;
       default:Mux2R2_in1  =  32'b0;
     endcase
     end
endmodule