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
wire  IF_Flush=0;
wire  ID_Flush=0;
wire  ID_Stall=0;
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

wire IE_Flush=0;
wire IE_Stall=0;
//memory
wire [15:0]read_data_from_memory;

//In out ports

wire    [31:0] buffer_if_instruction_out;


// assign pcNoinc=pcin1-2;
FetchMux PC_MUX(pcin1,pcNoinc,{16'b0,read_data1}//branchPC = dst data  R[Rdst]
,poppedPc,
pcout_MUX,reset,stall,interrupt,returnInstruction,jumpInstruction);
Fetch fetch_stage_1st_half (pcout_MUX,pcout1,instruction1,clk,reset);
Fetch fetch_stage_2nd_half (pcout_MUX+1/*compile check*/,pcout2,instruction2,clk,reset);
//IF_buffer
// wire    [31:0] buffer_if_instruction_in;
// wire    [31:0] buffer_if_pc_in;
wire    [31:0] buffer_if_pc_out;
//instruction = {instruction1,instruction2};

wire[2:0] buffer_im_Rdst_out;
//intermediate buffer for if/id
buffer_if if_id_buffer(clk,IF_Flush,IF_Stall,instruction,pcout1/*check later*/,
buffer_if_instruction_out,buffer_if_pc_out
);
Decode2 decode_stage(
    write_back,
    buffer_im_REG_Write_out,
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
wire buffer_id_REG_Write_out;
wire buffer_id_MEM_Write_out;
wire buffer_id_MEM_Read_out;
wire buffer_id_ALU_Source_out;
wire buffer_id_MEM_to_REG_out;
wire [15:0]buffer_id_read_data1_out;
wire [15:0]buffer_id_read_data2_out;
wire [15:0]buffer_id_immediate_out;
wire [4:0]buffer_id_ALU_Control_out;
wire buffer_id_READ_PORT_out;
wire buffer_id_WRITE_PORT_out;
wire buffer_id_STACK_SIGNAL_out;
wire buffer_id_DEC_SP_out;
wire buffer_id_INC_SP_out;
wire buffer_id_BRANCH_out;
wire buffer_id_RET_out;
wire [2:0]buffer_id_Rsrc_out;
wire [2:0]buffer_id_Rdst_out;
wire [31:0]buffer_id_pc_out;


buffer_id id_ie_buffer (
    //signals
    clk,
    ID_Flush,
    ID_Stall,
    REG_Write,
    MEM_Write,
    MEM_Read,
    ALU_Source,
    MEM_to_REG,
    read_data1,
    read_data2,
    instruction[15:0],//immediate
    ALU_Control,
    READ_PORT,
    WRITE_PORT,
    stack_signal,
    DEC_SP,
    INC_SP,
    BRANCH,
    RET ,
    instruction[26:24] ,//Rdst
    instruction[23:21] ,//Rsrc
    buffer_if_pc_out,


    buffer_id_REG_Write_out,
    buffer_id_MEM_Write_out,
    buffer_id_MEM_Read_out,
    buffer_id_ALU_Source_out,
    buffer_id_MEM_to_REG_out,
    buffer_id_read_data1_out,
    buffer_id_read_data2_out,
    buffer_id_immediate_out,
    buffer_id_ALU_Control_out,
    buffer_id_READ_PORT_out,
    buffer_id_WRITE_PORT_out,
    buffer_id_STACK_SIGNAL_out,
    buffer_id_DEC_SP_out,
    buffer_id_INC_SP_out,
    buffer_id_BRANCH_out,
    buffer_id_RET_out ,
    buffer_id_Rsrc_out ,
    buffer_id_Rdst_out ,
    buffer_id_pc_out
);
wire [2:0]buffer_ie_Rdst_out ;

wire buffer_ie_REG_Write_out;
HDU hazard_detection_unit(
    instruction[23:21] ,//Rsrc
    instruction[26:24] ,//Rdst
    buffer_ie_Rdst_out,
    buffer_ie_MEM_Read_out,
    IF_Stall,
    ID_Stall
);
//to be sent to muxs
wire [1:0] src_selector;
wire [1:0] dest_selector;

FU forwarding_unit(
    buffer_id_Rsrc_out,
    buffer_id_Rdst_out,
    buffer_ie_Rdst_out,
    buffer_im_Rdst_out,
    buffer_im_REG_Write_out,
    buffer_ie_REG_Write_out,
    src_selector,
    dest_selector
);

JDU jump_detection_unit(
    flags,
    BRANCH,
    jumpInstruction,
    IF_Flush,
    ID_Flush
);



ALU execute_stage(clk, buffer_id_ALU_Control_out,
buffer_id_read_data1_out,
alu_second_operand,result,flags,reset);

//buffer wires
wire [15:0]buffer_ie_result_out;
wire [15:0]buffer_ie_read_data1_out;
wire buffer_ie_MEM_Write_out;
// wire buffer_ie_MEM_Read_out;
wire buffer_ie_STACK_SIGNAL_out;
wire buffer_ie_DEC_SP_out;
wire buffer_ie_INC_SP_out;
wire buffer_ie_MEM_to_REG_out;
wire buffer_ie_WRITE_PORT_out;
wire [31:0]buffer_ie_PC_out;
wire [3:0]buffer_ie_FLAGS_out;
buffer_ie ie_im_buffer (
    //signals
    clk,
    IE_Flush,
    IE_Stall,//  ~ !write_data
    buffer_id_Rdst_out,
    result,
    buffer_id_read_data1_out,
    buffer_id_MEM_Write_out,
    buffer_id_MEM_Read_out,
    buffer_id_STACK_SIGNAL_out,
    buffer_id_DEC_SP_out,
    buffer_id_INC_SP_out,
    buffer_id_MEM_to_REG_out,
    buffer_id_WRITE_PORT_out,
    buffer_id_pc_out,
    flags,
    buffer_id_REG_Write_out,

    buffer_ie_Rdst_out ,
    buffer_ie_result_out,
    buffer_ie_read_data1_out,
    buffer_ie_MEM_Write_out,
    buffer_ie_MEM_Read_out,
    buffer_ie_STACK_SIGNAL_out,
    buffer_ie_DEC_SP_out,
    buffer_ie_INC_SP_out,
    buffer_ie_MEM_to_REG_out,
    buffer_ie_WRITE_PORT_out,
    buffer_ie_PC_out,
    buffer_ie_FLAGS_out,
    buffer_ie_REG_Write_out
);
Memory_Stage memory_stage_instance(
    clk,reset,buffer_ie_read_data1_out,
    //to be replaced with buffer output IE/IM
    buffer_ie_PC_out[15:0],buffer_ie_PC_out[31:16],buffer_ie_FLAGS_out,
    buffer_ie_result_out,
    buffer_ie_STACK_SIGNAL_out,
    buffer_ie_DEC_SP_out,
    buffer_ie_INC_SP_out,
    buffer_ie_MEM_Write_out,
    buffer_ie_MEM_Read_out,
    //selectors from interrupt controller
    //currently 0,0
    int_mem_selector1,int_mem_selector2,
    read_data_from_memory
);
wire IM_Flush=0;
wire IM_Stall=0;
wire[15:0] buffer_im_result_out;
wire [15:0]buffer_im_read_data_from_memory_out;
wire buffer_im_MEM_to_REG_out;
wire buffer_im_WRITE_PORT_out;
// wire buffer_im_REG_Write_out;
buffer_im buffer_im_iw(
    //signals
    clk,
    IM_Flush,
    IM_Stall,//  ~ !write_data
    //inputs
    buffer_ie_Rdst_out,
    buffer_ie_result_out,
    read_data_from_memory,
    buffer_ie_MEM_to_REG_out,
    buffer_ie_WRITE_PORT_out,
    buffer_ie_REG_Write_out,
    //outputs
    buffer_im_Rdst_out,
    buffer_im_result_out,
    buffer_im_read_data_from_memory_out,
    buffer_im_MEM_to_REG_out,
    buffer_im_WRITE_PORT_out,
    buffer_im_REG_Write_out
);

WriteBack write_back_stage(
    buffer_im_read_data_from_memory_out,
    buffer_im_result_out,
    write_back,
    buffer_im_MEM_to_REG_out
);
always @(posedge clk) begin
    pcin1=pcout1;
    pcNoinc=pcin1-2;
    // pcin2=pcout2;//
end
always @(*) begin
instruction = {instruction1,instruction2};
alu_second_operand=(buffer_id_ALU_Source_out)?buffer_id_immediate_out:buffer_id_read_data2_out;
//TODO add 2 MUX before ALU 
end

//to stall is to
// 1- pc no change
// 2- IF/ID buffer WRITE_DATA=0
// 3- selector to make all control signals = 0



endmodule



/*TODO
1-jmp  (pc change in alu)
2-In port out port
3-simulation   to see initial results (+ assembler)
(setup a test case)
/////4-integrate JDU  ,  HDU   , FU
5-check for missing MUXs or connections in design [review the whole integration if possible]
=====
6-interrupt controller + CALL , RET , RTI

7-do files
*/