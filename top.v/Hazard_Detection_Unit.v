module Hazard_Detection_Unit(         //Error Detection Unit
input  Load_Hazard,                   //Avoid Loard Hazard
input  [4:0] rsW_EX,                  //Destination Register Value
input  [4:0] rsR1,                    //Frist Register Value
input  [4:0] rsR2,                    //Second Register Value
output reg Stall,                     //Stop The Program counter
output reg IF_FlushH                  //Reset The Pipelined Register
);
          always@(*)begin
            Stall     = 1'b0;
            IF_FlushH = 1'b0;
           if((Load_Hazard ==1'b1) && (rsW_EX != 5'b0))begin
             if((rsW_EX == rsR1) || (rsW_EX == rsR2)) begin
               Stall     = 1'b1;
               IF_FlushH = 1'b1;
           end
           end     
          end
endmodule