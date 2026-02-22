module Immediate_Generator(
input  [31:0] RI,            //Instruction
input  [2:0]  ImmSel,        //For The Selection of Instruction Type 
output reg [31:0] ImmExt     //Convert 12 bit Information to 32 bit
);
  always@(*)begin
  case(ImmSel)
     3'b000: ImmExt={{20{RI[31]}},RI[31:20]};                                 //I-Type
     3'b001: ImmExt={{20{RI[31]}},RI[31:25],RI[11:7]};                        //S-Type
     3'b010: ImmExt={{19{RI[31]}},RI[31],RI[7],RI[30:25],RI[11:8],1'b0};      //B-Type
     3'b011: ImmExt={RI[31:12],12'b0};                                        //U-Type
     3'b100: ImmExt={{11{RI[31]}},RI[31],RI[19:12],RI[20],RI[30:21],1'b0};    //J-Type
     default:ImmExt=32'b0;
  endcase
  end
endmodule