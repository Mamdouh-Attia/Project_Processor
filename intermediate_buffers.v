//buffer IF/ID
module buffer_if (
    //signals
    input clk,
    input IF_Flush,
    input IF_Stall,//  ~ !write_data
    input[31:0] buffer_if_instruction_in,
    input[31:0] buffer_if_pc_in,
    output[31:0] buffer_if_instruction_out,
    output[31:0] buffer_if_pc_out
);
reg [31:0]buffer_if_instruction_reg;
reg [31:0]buffer_if_pc_reg;

always @(posedge clk ) begin
    if (IF_Flush) begin
        buffer_if_instruction_reg=0;
        buffer_if_pc_reg=0;
    end else if (IF_Stall) begin
        //no change
    end
    else begin
    //write data to regs
        buffer_if_instruction_reg=buffer_if_instruction_in;
        buffer_if_pc_reg=buffer_if_pc_in;
    end
end
    //asynch read
assign buffer_if_instruction_out=buffer_if_instruction_reg;
assign buffer_if_pc_out=buffer_if_pc_reg;

endmodule
/*
    output reg  REG_Write,
    output reg  MEM_Write,
    output reg  MEM_Read,
    output reg  ALU_Source,
    output reg  MEM_to_REG,
    output reg  [15 : 0] read_data1,
    output reg  [15 : 0] read_data2,
    //new phase 3
    output reg  [4:0] ALU_Control,
    output reg  IF_Flush,
    output reg  READ_PORT,
    output reg  WRITE_PORT,
    output reg  STACK_SIGNAL,
    output reg  DEC_SP,
    output reg  INC_SP,
    output reg  BRANCH,
    output reg  RET

    immediate
    rsrc & rdst

*/
// complete buffers
// branch in ALU 
// IN OUT
module buffer_id (
    //signals
    input clk,
    input IF_Flush,
    input IF_Stall,//  ~ !write_data
    input [31:0] buffer_if_instruction_in,
    input [31:0] buffer_if_pc_in,
    output[31:0] buffer_if_instruction_out,
    output[31:0] buffer_if_pc_out
);
reg [31:0]buffer_if_instruction_reg;
reg [31:0]buffer_if_pc_reg;

always @(posedge clk ) begin
    if (IF_Flush) begin
        buffer_if_instruction_reg=0;
        buffer_if_pc_reg=0;
    end else if (IF_Stall) begin
        //no change
    end
    else begin
    //write data to regs
        buffer_if_instruction_reg=buffer_if_instruction_in;
        buffer_if_pc_reg=buffer_if_pc_in;
    end
end
    //asynch read
assign buffer_if_instruction_out=buffer_if_instruction_reg;
assign buffer_if_pc_out=buffer_if_pc_reg;

endmodule




/*
IE

rdst
result
m wb signals
*/
/*
IM

rdst
result
wb signals
read data from memory
result from alu
rdst


*/


