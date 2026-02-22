module Mux_2_Imm_R2(            //Selection Between Immediate Value OR Second Register
input  [31:0] Mux2R2_in1,       //Updated Second Register Value 
input  [31:0] ImmExt_EX,        //Immediate Value
input  Bsel,                    //Selection Line For Mux
output [31:0] Alu_in2           //ALU Frist Input 
); 
                                //0 For DataR2 and 1 For Immediate Value
        assign Alu_in2  = (Bsel)?ImmExt_EX:Mux2R2_in1;
endmodule