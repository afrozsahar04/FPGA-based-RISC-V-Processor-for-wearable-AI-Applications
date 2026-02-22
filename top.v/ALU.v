module ALU(
input  [31:0] Alu_in1,            //Frist ALU Input
input  [31:0] Alu_in2,            //Second ALU Input
input  [3:0]  ALUSel,             //Selection Line For ALU Operation 
output reg [31:0] Alu_out         //Output of ALU
);
   always@(*)begin
     case(ALUSel)
       4'b0000: Alu_out  = Alu_in1 + Alu_in2;                                      //Perform ADD Operations
       4'b0001: Alu_out  = Alu_in1 - Alu_in2;                                      //Perform SUB Operations
       4'b0010: Alu_out  = Alu_in1 & Alu_in2;                                      //Perform AND Operations
       4'b0011: Alu_out  = Alu_in1 | Alu_in2;                                      //Perform OR  Operations
       4'b0100: Alu_out  = Alu_in1 ^ Alu_in2;                                      //Perform XOR Operations
       4'b0101: Alu_out  = ($signed(Alu_in1) < $signed(Alu_in2)) ? 32'd1 : 32'd0;  //Set Less Than For Signed Numbers
       4'b0110: Alu_out  = (Alu_in1 < Alu_in2) ? 32'd1 : 32'd0;                    //Set Less Than For Unsigned Numbers
       4'b0111: Alu_out  = Alu_in1 << Alu_in2[4:0];                                //Shift Left Logic Immediate
       4'b1000: Alu_out  = Alu_in1 >> Alu_in2[4:0];                                //Shift Right Logic Immediate
       4'b1001: Alu_out  = $signed(Alu_in1) >>> Alu_in2[4:0];                      //Shift Right Arithmetic Immediate
       4'b1010: Alu_out  = Alu_in2;                                                //Branch Instructions
       default: Alu_out  = 32'b0;                                                  //For Error Handling
     endcase
   end
endmodule