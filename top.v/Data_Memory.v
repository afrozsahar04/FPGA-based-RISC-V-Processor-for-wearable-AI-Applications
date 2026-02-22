module Data_Memory(               //Data Storage Block
input  clk,                       
input  [31:0] Alu_out_MEM,        //Address Where Data Write
input  [31:0] Mux2R2_in1_MEM,     //Data For Write in Data Memory
input  [2:0] fund3_MEM,           //For Detail Data Write Operation
input  MemRW_MEM,                 //Data Write Enable
output reg [31:0] Data_Load       //Data For Load in Register
);
  reg [7:0] mem[0:1023];
  always@(posedge clk)begin
   if(MemRW_MEM)
     case(fund3_MEM)
     3'b000:mem[Alu_out_MEM]             <= Mux2R2_in1_MEM[7:0];   //for Store Byte
     3'b001:begin                                   
      mem[Alu_out_MEM]                   <= Mux2R2_in1_MEM[7:0];   //For Store Half Word
      mem[Alu_out_MEM+1]                 <= Mux2R2_in1_MEM[15:8];    
     end                                                             
     3'b010:begin                                                           
     mem[Alu_out_MEM]                    <= Mux2R2_in1_MEM[7:0];   //For Store Full Word
     mem[Alu_out_MEM+1]                  <= Mux2R2_in1_MEM[15:8];
     mem[Alu_out_MEM+2]                  <= Mux2R2_in1_MEM[23:16];
     mem[Alu_out_MEM+3]                  <= Mux2R2_in1_MEM[31:24];
     end
     endcase
   end
  always@(*)begin
     case(fund3_MEM)
       3'b000: Data_Load = {{24{mem[Alu_out_MEM][7]}},mem[Alu_out_MEM]};                                 //For Load Byte Signed
       3'b001: Data_Load = {{16{mem[Alu_out_MEM+1][7]}},mem[Alu_out_MEM+1],mem[Alu_out_MEM]};            //For Load Half Word Signed
       3'b010: Data_Load = {mem[Alu_out_MEM+3],mem[Alu_out_MEM+2],mem[Alu_out_MEM+1],mem[Alu_out_MEM]};  //For Load Word Signed
       3'b100: Data_Load = {24'b0,mem[Alu_out_MEM]};                                                     //For Load Byte Unsigned
       3'b101: Data_Load = {16'b0,mem[Alu_out_MEM+1],mem[Alu_out_MEM]};                                  //For Load Half Word Unsigned
     endcase
  end
endmodule