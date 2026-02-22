module Forwarding_Unit(                    //Data Hazard Handling Unit
input  [4:0] rsW_MEM,                      //Value of Destination Register From MEM Register
input  [4:0] rsW_WB,                       //Value of Destination Register From WB Register
input  [4:0] rsR1_EX,                      //Hold Value of First Register To Avoid Data Hazard
input  [4:0] rsR2_EX,                      //Hold Value of Second Register To Avoid Data Hazard 
input  RegWEn_MEM,                         //Hold Value of Register Write Enable
input  RegWEn_WB,                          //Hold Value of Register Write Enable
output reg [1:0] M1Sel,                    //Selection Line to Update Frist Register Value
output reg [1:0] M2Sel                     //Selection Line to Update Second Register Value
);
          always@(*)begin
          M1Sel = 2'b00;
           //For The Selection of Mux1(Frist Register)
           if((RegWEn_MEM == 1'b1) && (rsW_MEM != 5'b0) && (rsW_MEM == rsR1_EX))begin
           M1Sel = 2'b10;
           end
           else if((RegWEn_WB == 1'b1) && (rsW_WB != 5'b0) && (rsW_WB == rsR1_EX))begin
           M1Sel = 2'b01;
           end
          end
          always@(*)begin 
           M2Sel = 2'b00;
           //For The Selection of Mux2(Second Register)
           if((RegWEn_MEM == 1'b1) && (rsW_MEM != 5'b0) && (rsW_MEM == rsR2_EX))begin
           M2Sel = 2'b10;
           end
           else if((RegWEn_WB == 1'b1) && (rsW_WB != 5'b0) && (rsW_WB == rsR2_EX))begin
           M2Sel = 2'b01;
           end
          end
endmodule