module Mux_2_PC_R1(             //Selection Between Current Program Counter Value OR Frist Register
input  [31:0] Mux2R1_in1,       //Updated Frist Register Value 
input  [31:0] pc_out_EX,        //Current Program Value
input  Asel,                    //Selection Line For Mux
output [31:0] Alu_in1           //ALU Frist Input 
); 
                                //0 For DataR1 and 1 For Program Counter Output
        assign Alu_in1  = (Asel)?pc_out_EX:Mux2R1_in1;
endmodule