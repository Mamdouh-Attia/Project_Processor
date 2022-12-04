module MIPS_phase_1 (
    input reg clk,
    input reset
);
//fetch
reg[31:0] pcin1=32;
reg[31:0] pcin2=33;
wire  [31:0] pcout1;
wire  [31:0] pcout2;
wire[15:0] instruction1;
wire[15:0] instruction2;
reg[31:0] instruction;
//decode
wire [15:0] write_back;
wire  REG_Write;
wire  MEM_Write;
wire  MEM_Read;
wire  ALU_Source;
wire  MEM_to_REG;
wire  [2:0] ALU_Control;
wire[15 : 0] read_data1;
wire[15 : 0] read_data2;
//execute
reg [15:0]alu_second_operand;
wire[15:0] result;
wire[3:0] flags;
//memory
wire [15:0]read_data_from_memory;
Fetch fetch_stage_1st_half (pcin1,pcout1,instruction1,clk,reset);
Fetch fetch_stage_2nd_half (pcin2,pcout2,instruction2,clk,reset);
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
    ALU_Control,
    read_data1,
    read_data2
);
ALU_Execute execute_stage(clk, ALU_Control, read_data1, alu_second_operand,result,flags);
Data_Memory memory_stage(MEM_Read,MEM_Write,read_data_from_memory,read_data1,clk,reset,result,result);
WriteBack write_back_stage(
    read_data_from_memory,
    result,
    write_back,
    MEM_to_REG 
);
always @(posedge clk) begin
    pcin1=pcout1;
    pcin2=pcout2;
end
always @(*) begin
instruction = {instruction1,instruction2};
alu_second_operand=(ALU_Source)?instruction[15:0]:read_data2;
end

endmodule