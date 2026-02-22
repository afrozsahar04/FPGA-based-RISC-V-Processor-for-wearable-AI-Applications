module Register_File(
input  [31:0] dataW,       //Data For Write on Destination Register  
input  clk,
input  reset,          
input  RegWEn,             //Register Write Enable
input  [4:0] rsW,          //Destination Register
input  [4:0] rsR1,         //First Register
input  [4:0] rsR2,         //Second Register
output [31:0] dataR1,      //Data in First Register
output [31:0] dataR2       //Data in Second Register
);
    integer i;
    reg [31:0] register_file[31:0];
    always @(posedge clk) begin
       if (reset) begin
         for (i = 1; i < 32; i = i + 1) begin
            register_file[i] <= 32'b0;
             end
         end
       else if(RegWEn && rsW !=0)
        register_file[rsW] <= dataW;
    end       
  
          assign dataR1 = (rsR1 == 0) ? 32'b0 : register_file[rsR1];
          assign dataR2 = (rsR2 == 0) ? 32'b0 : register_file[rsR2];

endmodule