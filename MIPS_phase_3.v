module MIPS_phase_3 (
    input reg clk,
    input reset,
    input [15:0]in_port_data,
    output [15:0]out_port_data
);
//fetch
reg[31:0] pcin1=32;
wire  [31:0] pcout1;
wire  [31:0] pcout2;
 wire  [31:0] pcout_MUX;
wire[15:0] instruction1;
wire[15:0] instruction2;
reg[31:0] instruction;
//fetch 3
wire [31:0] branchPc;//check compilation=> if error >to reg
wire [31:0] poppedPc;//check compilation=> if error >to reg
// wire [31:0] pcNoinc;//check compilation=> if error >to reg
reg [31:0] pcNoinc;//check compilation=> if error >to reg
wire [31:0] PCin_fetch2;//

wire stall=0;
wire interrupt=0;
wire returnInstruction=0;
wire jumpInstruction=0;

//decode
wire [15:0] write_back;
wire  REG_Write;
wire  MEM_Write;
wire  MEM_Read;
wire  ALU_Source;
wire  MEM_to_REG;
wire  [4:0] ALU_Control;
wire  [15 : 0] read_data1;
wire  [15 : 0] read_data2;
wire  IF_Flush;
wire  READ_PORT;
wire  WRITE_PORT;
wire  STACK_SIGNAL;
wire  DEC_SP;
wire  INC_SP;
wire  BRANCH;
wire  RET;
wire  int_mem_selector1=0;
wire  int_mem_selector2=0;
//more signals
wire IF_Stall=0;
//execute
reg [15:0]alu_second_operand;
wire[15:0] result;
wire[3:0] flags;
//memory
wire [15:0]read_data_from_memory;

//In out ports



// assign pcNoinc=pcin1-2;
FetchMux PC_MUX(pcin1,pcNoinc,branchPc,poppedPc,pcout_MUX,reset,stall,interrupt,returnInstruction,jumpInstruction);
Fetch fetch_stage_1st_half (pcout_MUX,pcout1,instruction1,clk,reset);
Fetch fetch_stage_2nd_half (pcout_MUX+1/*compile check*/,pcout2,instruction2,clk,reset);
//IF_buffer
// wire    [31:0] buffer_if_instruction_in;
// wire    [31:0] buffer_if_pc_in;
wire    [31:0] buffer_if_instruction_out;
wire    [31:0] buffer_if_pc_out;
//instruction = {instruction1,instruction2};

//intermediate buffer for if/id
buffer_if if_id_buffer(clk,IF_Flush,IF_Stall,instruction,pcout1/*check later*/,
buffer_if_instruction_out,buffer_if_pc_out
);
Decode2 decode_stage(
    write_back,
    instruction,   //Incoming from fetch
    reset,
    clk,
    REG_Write,
    MEM_Write,
    MEM_Read,
    ALU_Source,
    MEM_to_REG,
    read_data1,
    read_data2,
    ALU_Control,
    IF_Flush,
    READ_PORT,
    WRITE_PORT,
    STACK_SIGNAL,
    DEC_SP,
    INC_SP,
    BRANCH,
    RET
);
ALU execute_stage(clk, ALU_Control, read_data1, alu_second_operand,result,flags,reset);
Memory_Stage memory_stage_instance(
    clk,reset,read_data1,
    //to be replaced with buffer output IE/IM
    pcin1[15:0],pcin1[31:16],flags,result,
    stack_signal,dec_sp,inc_sp,mem_write,
    mem_read,
    //selectors from interrupt controller
    //currently 0,0
    int_mem_selector1,int_mem_selector2,
    read_data_from_memory
);
WriteBack write_back_stage(
    read_data_from_memory,
    result,
    write_back,
    MEM_to_REG
);
always @(posedge clk) begin
    pcin1=pcout1;
    pcNoinc=pcin1-2;
    // pcin2=pcout2;//
end
always @(*) begin
instruction = {instruction1,instruction2};
alu_second_operand=(ALU_Source)?instruction[15:0]:read_data2;
end

//to stall is to
// 1- pc no change
// 2- IF/ID buffer WRITE_DATA=0
// 3- selector to make all control signals = 0



endmodule