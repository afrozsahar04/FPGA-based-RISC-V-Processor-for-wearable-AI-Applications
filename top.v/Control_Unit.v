module Control_Unit(
input  [6:0] opcode,                    //Identifying Instruction Type
input  [2:0] fun3,                      //Identifying ALU Operation in General
input  [6:0] fun7,                      //Identifying ALU Operation in Detail
input  BrEq,                            //Branch Equall
input  BrLT,                            //Branch Less
output reg Load_Hazard,                 //To Hazard Due To Load Instruction
output reg IF_Flush,                    //To Avoid Wrong Instruction To Decode
output reg PCSel,                       //To Control Jump and Branch Instructions
output reg [2:0] ImmSel,                //Identifying Immediate Type
output reg RegWEn,                      //Register Write Enable
output reg BrUn,                        //For Branch Signed OR Unsigned 
output reg Bsel,                        //For The Selection of Second Register OR Immediate Value 
output reg Asel,                        //For The Selection of First Register  OR Program Counter Value
output reg [3:0] ALUSel,                //For The Selection of ALU Operation
output reg MemRW,                       //Data Memory Write Enable
output reg [1:0] WBSel,                 //For The Selection of Output
output reg [2:0] fund3                  //For Data Memory Operations in Detail
);
    
  always@(*)begin
         PCSel     =0;
         ImmSel    =3'b000;             
         RegWEn    =0;
         Bsel      =0;
         Asel      =0;
         ALUSel    =4'b0000;     
         MemRW     =0;
         WBSel     =2'b00;      
         BrUn      =0;
         fund3     =3'bx;
         BrUn      =0;
         Load_Hazard=0;
         IF_Flush  =0;              //To Avoid Wrong Instruction To Decode
    case(opcode)
      7'b0110111:begin              //OPcode for LUI Instruction
         PCSel     =0;
         ImmSel    =3'b011;         //For U-Type Instruction             
         RegWEn    =1;
         Bsel      =1;
         Asel      =0;
         ALUSel    =4'b1010;        //For aluin2      
         MemRW     =0;
         WBSel     =2'b01;
      end
      7'b0010111:begin              //OPcode For AUIPC Instruction
         PCSel     =0;
         ImmSel    =3'b011;         //For U-Type Instruction             
         RegWEn    =1;
         Bsel      =1;
         Asel      =1;
         ALUSel    =4'b0000;     
         MemRW     =0;
         WBSel     =2'b01;
      end
      7'b1101111:begin              //OPcode for Jal Instruction
        
         PCSel     =1;
         ImmSel    =3'b100;         //For J-Type Instruction          
         RegWEn    =1;
         Bsel      =1;
         Asel      =1;
         IF_Flush  =1;              //To Avoid Wrong Instruction To Decode      
         ALUSel    =4'b0000;     
         MemRW     =0;
         WBSel     =2'b10;
         
      end
      7'b1100111:begin              //OPcode for JALR Instruction
        case(fun3)
        3'b000:begin
         PCSel     =1;
         ImmSel    =3'b000;         //For I-Type Instruction          
         RegWEn    =1;
         Bsel      =1;
         Asel      =0;
         IF_Flush  =1;              //To Avoid Wrong Instruction To Decode
         ALUSel    =4'b0000;     
         MemRW     =0;
         WBSel     =2'b10;
        end  
        endcase
      end
      7'b1100011:begin              //OPcode for Branch Instructions
         ImmSel    =3'b010;         //For B-Type Instruction            
         RegWEn    =0;
         Bsel      =1;
         Asel      =1;
         ALUSel    =4'b1010;     
         MemRW     =0;
         WBSel     =2'b01;   
        case(fun3)
         3'b000:begin               //For Equal Branch
         if(BrEq)begin
           PCSel=1;
           IF_Flush  =1;            //To Avoid Wrong Instruction To Decode
         end
         end
         3'b001:begin               //For Unequal Branch 
         if(!BrEq)begin
           PCSel=1;
           IF_Flush  =1;            //To Avoid Wrong Instruction To Decode
         end
         end
         3'b100:begin               //For Less Than Branch Signed
         if(BrLT)begin
           PCSel=1;
           IF_Flush  =1;            //To Avoid Wrong Instruction To Decode
         end
         end
         3'b101:begin               //For Greater Branch Signed
         if(!BrEq && !BrLT)begin
           PCSel=1;
           IF_Flush  =1;            //To Avoid Wrong Instruction To Decode
         end
         end
         3'b110:begin               //For Less Than Branch Unsigned
         BrUn=1;
         if(BrLT)begin
           PCSel=1;
           IF_Flush  =1;            //To Avoid Wrong Instruction To Decode
         end
         end
         3'b111:begin               //For Greater Branch Unsigned
         BrUn=1;
         if(!BrEq && !BrLT)begin
           PCSel=1;
           IF_Flush  =1;            //To Avoid Wrong Instruction To Decode
         end
         end
        endcase
      end
      7'b0000011:begin              //OPcode for Load Instructions
         PCSel   =0;
         ImmSel  =3'b000;           //For I-Type Instruction             
         RegWEn  =1;
         Bsel    =1;
         Asel    =0;
         ALUSel  =4'b0000;
         Load_Hazard=1;            //To Avoid Hazard Due To Load Instruction     
         MemRW   =0;
         WBSel   =2'b00;
         fund3   =fun3;      
      end
      7'b0100011:begin              //OPcode for S-Type Instruction
         PCSel   =0;
         ImmSel  =3'b001;           //For S-Type Instruction             
         RegWEn  =0;
         Bsel    =1;
         Asel    =0;
         ALUSel  =4'b0000;     
         MemRW   =1;
         WBSel   =2'b00;      
         BrUn    =0;
         fund3   =fun3;            //for Implementation of SB,SH,SW
      end
      7'b0010011:begin              //OPcode for I-Type Instruction
        PCSel   =0;
        ImmSel  =3'b000;           // I-Type Instruction Selection
        RegWEn  =1;
        Bsel    =1;
        Asel    =0;
        MemRW   =0;
        WBSel   =2'b01;           //For Output Selection
        
        case(fun3)
        3'b000: ALUSel  =4'b0000;           //for ADD Instruction                       
        3'b010: ALUSel  =4'b0101;           //For For Set Less Than Signed Instruction
        3'b011: ALUSel  =4'b0110;           //For Set Less Then Unsigned Instruction
        3'b100: ALUSel  =4'b0100;           //For XOR Instruction
        3'b110: ALUSel  =4'b0011;           //For OR Instruction
        3'b111: ALUSel  =4'b0010;           //For ANDI Instruction
        endcase
        
        case({fun7,fun3})
         10'b0000000_001:ALUSel  =4'b0111;    //Shift Left Logic Instruction
         10'b0000000_101:ALUSel  =4'b1000;    //Shift Right Logic Instruction 
         10'b0100000_101:ALUSel  =4'b1001;    //Shift Right Arithmetic Instruction 
        endcase
      end
      7'b0110011:begin              //OPcode for R-Type Instruction
         PCSel   =0;
         RegWEn  =1;
         Bsel    =0;
         Asel    =0;
         MemRW   =0;
         WBSel   =2'b01;      //For Output Selection
       case({fun7,fun3})
       10'b0000000_000:ALUSel  =4'b0000;   //For ADD Instruction
       10'b0100000_000:ALUSel  =4'b0001;   //For SUB Instruction 
       10'b0000000_001:ALUSel  =4'b0111;   //For Shift Left Logical Instruction
       10'b0000000_010:ALUSel  =4'b0101;   //For Set Less Than Signed Instruction
       10'b0000000_011:ALUSel  =4'b0110;   //For Set Less Than Unsigned Instruction
       10'b0000000_100:ALUSel  =4'b0100;   //For XOR Instruction
       10'b0000000_101:ALUSel  =4'b1000;   //For Shift Right Logic Instruction
       10'b0100000_101:ALUSel  =4'b1001;   //For Shift Right Arithmetic Instruction
       10'b0000000_110:ALUSel  =4'b0011;   //For OR Instruction
       10'b0000000_111:ALUSel  =4'b0010;   //For AND Instruction
       endcase
      end
      default:begin
         PCSel     =0;
         ImmSel    =3'b000;             
         RegWEn    =0;
         Bsel      =0;
         Asel      =0;
         ALUSel    =4'b0000;     
         MemRW     =0;
         WBSel     =2'b00;      
         BrUn      =0;
         fund3     =3'bx;
         BrUn      =0;
         IF_Flush  =0;              //To Avoid Wrong Instruction To Decode
      end
    endcase
  end
endmodule