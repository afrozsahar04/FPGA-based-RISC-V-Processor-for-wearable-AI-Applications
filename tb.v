module Top_Module_tb;
    reg clk;
    reg reset;
    wire [31:0] alu_out;
    wire [31:0] mux_result;
    wire [31:0] pc;
    wire [31:0] data1;
    wire [31:0] data2;
    //wire [31:0] pc_r2;
    wire [31:0] alu_input1;
    wire [31:0] alu_input2;
    wire [4:0] register_write;
    wire [4:0] register1;
    wire [4:0] register2; 
    wire [1:0] f1;
    wire [1:0] f2;
    wire [31:0] instruction;
    wire [31:0] instreg1;
    wire [31:0] instr;
    wire pcstall;
    wire regflush;
    wire [3:0] leds_tb;
    //wire [31:0] imm;
    //wire memrn;
    //wire [2:0] fun3;
    //wire [31:0] memoryw;
    Top_Module uut(.clk(clk),.reset(reset),
        .leds(leds_tb)
    );
    
     // Assign internal signals for observation (optional: aliases for clarity)
       assign alu_out    = uut.alu_out_w;        // Result of ALU From Register 3  
       assign mux_result = uut.result_w;         // Result from Mux_Result
       assign pc         = uut.pc_out_w;         // Program Counter
       //assign pc_r2      = uut.pc_out_M;         //Value of Program Counter From Register 2
       assign data1      = uut.R1data_U;         // Register 1(rs1)
       assign data2      = uut.R2data_U;         // Register 2(rs2)
       assign alu_input1 = uut.alu_in1;          //ALU First Input
       assign alu_input2 = uut.alu_in2;          //ALU Second Input
       assign f1         = uut.m1sel;            //Forwarding Mux 1 Selection Line
       assign f2         = uut.m2sel;            //Forwarding Mux 2 Selection Line
       assign register1  = uut.rsr1;             //First Register For Forwarding Unit
       assign register2  = uut.rsr2;             //Second Register For Forwarding Unit
       assign register_write=uut.rd_R;           //Address of Destination Register
       assign instruction= uut.instruction_C;    //Instruction For Control Unit
       assign instreg1   = uut.instruction_EX;   //Instruction From Register 1 
       assign instr      = uut.instruction;      //Instruction  
       assign pcstall    = uut.Stall_w;          //Hold Program Counter
       assign regflush   = uut.IF_Flushh_w;      //Flush From Hazard Control Unit
       //assign imm        = uut.imuxin1;        // Immediate Value
       //assign memrn      = uut.memrw;          // Data Memory Write
       //assign fun3       = uut.Fund3;          // Memory Write operation
       //assign memoryw    = uut.datab;          // Load Memory Operation
    always #5 clk=~clk;
    initial begin
    clk=1;reset=1;
    #10
    reset=0;
    #140
    $finish;
    end
endmodule