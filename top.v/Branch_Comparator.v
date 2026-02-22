module Branch_Comparator(
input  [31:0] dataR1,             //Data From First Register
input  [31:0] dataR2,             //Data From Second Register
input  BrUn,                      //For Branch Signed OR Unsigned
output BrEq,                      //Branch Equall
output BrLT                       //Branch Less
);                           
                                  //Equality Check For Both Signed AND Ansigned Numbers
   assign BrEq =(dataR1==dataR2); 
                                  //0 For Signed Numbers & 1 For Unsigned Numbers
   assign BrLT=(BrUn)?(dataR1<dataR2):($signed(dataR1)<$signed(dataR2));
endmodule