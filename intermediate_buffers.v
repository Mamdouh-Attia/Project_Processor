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
    rsrc,rdst
    pcout
*/
// complete buffers
// branch in ALU
// IN OUT
module buffer_id (
    //signals
    input clk,
    input ID_Flush,
    input ID_Stall,//  ~ !write_data
    input buffer_id_REG_Write_in,
    input buffer_id_MEM_Write_in,
    input buffer_id_MEM_Read_in,
    input buffer_id_ALU_Source_in,
    input buffer_id_MEM_to_REG_in,//
    input [15:0]buffer_id_read_data1_in,
    input [15:0]buffer_id_read_data2_in,
    input [15:0]buffer_id_immediate_in,
    input [4:0]buffer_id_ALU_Control_in,
    input buffer_id_READ_PORT_in,
    input buffer_id_WRITE_PORT_in,//
    input buffer_id_STACK_SIGNAL_in,
    input buffer_id_DEC_SP_in,
    input buffer_id_INC_SP_in,
    input buffer_id_BRANCH_in,
    input buffer_id_RET_in ,
    input [2:0]buffer_id_Rsrc_in ,
    input [2:0]buffer_id_Rdst_in ,
    input[31:0] buffer_id_pc_in,



    output buffer_id_REG_Write_out,
    output buffer_id_MEM_Write_out,
    output buffer_id_MEM_Read_out,
    output buffer_id_ALU_Source_out,
    output buffer_id_MEM_to_REG_out,
    output [15:0]buffer_id_read_data1_out,
    output [15:0]buffer_id_read_data2_out,
    output [15:0]buffer_id_immediate_out,
    output [4:0]buffer_id_ALU_Control_out,
    output buffer_id_READ_PORT_out,
    output buffer_id_WRITE_PORT_out,
    output buffer_id_STACK_SIGNAL_out,
    output buffer_id_DEC_SP_out,
    output buffer_id_INC_SP_out,
    output buffer_id_BRANCH_out,
    output buffer_id_RET_out ,
    output [2:0]buffer_id_Rsrc_out ,
    output [2:0]buffer_id_Rdst_out ,
    output[31:0] buffer_id_pc_out
);
reg buffer_id_REG_Write_reg;
reg buffer_id_MEM_Write_reg;
reg buffer_id_MEM_Read_reg;
reg buffer_id_ALU_Source_reg;
reg buffer_id_MEM_to_REG_reg;
reg [15:0]buffer_id_read_data1_reg;
reg [15:0]buffer_id_read_data2_reg;
reg [15:0]buffer_id_immediate_reg;
reg [4:0]buffer_id_ALU_Control_reg;
reg buffer_id_READ_PORT_reg;
reg buffer_id_WRITE_PORT_reg;
reg buffer_id_STACK_SIGNAL_reg;
reg buffer_id_DEC_SP_reg;
reg buffer_id_INC_SP_reg;
reg buffer_id_BRANCH_reg;
reg buffer_id_RET_reg;
reg [2:0]buffer_id_Rsrc_reg ;
reg [2:0]buffer_id_Rdst_reg ;
reg [31:0]buffer_id_pc_reg;
always @(posedge clk ) begin
    if (ID_Flush) begin
        buffer_id_REG_Write_reg=0;
        buffer_id_MEM_Write_reg=0;
        buffer_id_MEM_Read_reg=0;
        buffer_id_ALU_Source_reg=0;
        buffer_id_MEM_to_REG_reg=0;
        buffer_id_read_data1_reg=0;
        buffer_id_read_data2_reg=0;
        buffer_id_immediate_reg=0;
        buffer_id_ALU_Control_reg=0;
        buffer_id_READ_PORT_reg=0;
        buffer_id_WRITE_PORT_reg=0;
        buffer_id_STACK_SIGNAL_reg=0;
        buffer_id_DEC_SP_reg=0;
        buffer_id_INC_SP_reg=0;
        buffer_id_BRANCH_reg=0;
        buffer_id_RET_reg=0;
        buffer_id_Rsrc_reg=0;
        buffer_id_Rdst_reg=0;
        buffer_id_pc_reg=0;
    end else if (ID_Stall) begin
        //no change
    end
    else begin
    //write data to regs
        buffer_id_REG_Write_reg=buffer_id_REG_Write_in;
        buffer_id_MEM_Write_reg=buffer_id_MEM_Write_in;
        buffer_id_MEM_Read_reg=buffer_id_MEM_Read_in;
        buffer_id_ALU_Source_reg=buffer_id_ALU_Source_in;
        buffer_id_MEM_to_REG_reg=buffer_id_MEM_to_REG_in;
        buffer_id_read_data1_reg=buffer_id_read_data1_in;
        buffer_id_read_data2_reg=buffer_id_read_data2_in;
        buffer_id_immediate_reg=buffer_id_immediate_in;
        buffer_id_ALU_Control_reg=buffer_id_ALU_Control_in;
        buffer_id_READ_PORT_reg=buffer_id_READ_PORT_in;
        buffer_id_WRITE_PORT_reg=buffer_id_WRITE_PORT_in;
        buffer_id_STACK_SIGNAL_reg=buffer_id_STACK_SIGNAL_in;
        buffer_id_DEC_SP_reg=buffer_id_DEC_SP_in;
        buffer_id_INC_SP_reg=buffer_id_INC_SP_in;
        buffer_id_BRANCH_reg=buffer_id_BRANCH_in;
        buffer_id_RET_reg=buffer_id_RET_in;
        buffer_id_Rsrc_reg=buffer_id_Rsrc_in;
        buffer_id_Rdst_reg=buffer_id_Rdst_in;
        buffer_id_pc_reg=buffer_id_pc_in;
    end
end
    //asynch read
assign buffer_id_REG_Write_out=buffer_id_REG_Write_reg;
assign buffer_id_MEM_Write_out=buffer_id_MEM_Write_reg;
assign buffer_id_MEM_Read_out=buffer_id_MEM_Read_reg;
assign buffer_id_ALU_Source_out=buffer_id_ALU_Source_reg;
assign buffer_id_MEM_to_REG_out=buffer_id_MEM_to_REG_reg;
assign buffer_id_read_data1_out=buffer_id_read_data1_reg;
assign buffer_id_read_data2_out=buffer_id_read_data2_reg;
assign buffer_id_immediate_out=buffer_id_immediate_reg;
assign buffer_id_ALU_Control_out=buffer_id_ALU_Control_reg;
assign buffer_id_READ_PORT_out=buffer_id_READ_PORT_reg;
assign buffer_id_WRITE_PORT_out=buffer_id_WRITE_PORT_reg;
assign buffer_id_STACK_SIGNAL_out=buffer_id_STACK_SIGNAL_reg;
assign buffer_id_DEC_SP_out=buffer_id_DEC_SP_reg;
assign buffer_id_INC_SP_out=buffer_id_INC_SP_reg;
assign buffer_id_BRANCH_out=buffer_id_BRANCH_reg;
assign buffer_id_RET_out=buffer_id_RET_reg;
assign buffer_id_Rsrc_out =buffer_id_Rsrc_reg;
assign buffer_id_Rdst_out =buffer_id_Rdst_reg;
assign buffer_id_pc_out =buffer_id_pc_reg;
endmodule


/*
IE

rdst
result
m wb signals:stack_signal,dec_sp,inc_sp,mem_write,mem_read,
*/
//buffer IF/ID
module buffer_ie (
    //signals
    input clk,
    input IE_Flush,
    input IE_Stall,//  ~ !write_data
    input [2:0]buffer_ie_Rdst_in,
    input [15:0]buffer_ie_result_in,
    input [15:0]buffer_ie_read_data1_in,
    input buffer_ie_MEM_Write_in,
    input buffer_ie_MEM_Read_in,
    input buffer_ie_STACK_SIGNAL_in,
    input buffer_ie_DEC_SP_in,
    input buffer_ie_INC_SP_in,
    input buffer_ie_MEM_to_REG_in,//
    input buffer_ie_WRITE_PORT_in,//
    input [31:0]buffer_ie_PC_in,
    input [3:0]buffer_ie_FLAGS_in,
    input buffer_ie_REG_Write_in,

    output [2:0]buffer_ie_Rdst_out ,
    output [15:0]buffer_ie_result_out,
    output [15:0]buffer_ie_read_data1_out,
    output buffer_ie_MEM_Write_out,
    output buffer_ie_MEM_Read_out,
    output buffer_ie_STACK_SIGNAL_out,
    output buffer_ie_DEC_SP_out,
    output buffer_ie_INC_SP_out,
    output buffer_ie_MEM_to_REG_out,
    output buffer_ie_WRITE_PORT_out,
    output [31:0]buffer_ie_PC_out,
    output [3:0]buffer_ie_FLAGS_out,
    output buffer_ie_REG_Write_out
);
reg [2 :0]buffer_ie_Rdst_reg ;
reg [15:0]buffer_ie_result_reg;
reg [15:0]buffer_ie_read_data1_reg;
reg buffer_ie_MEM_Write_reg;
reg buffer_ie_MEM_Read_reg;
reg buffer_ie_STACK_SIGNAL_reg;
reg buffer_ie_DEC_SP_reg;
reg buffer_ie_INC_SP_reg;
reg buffer_ie_MEM_to_REG_reg;
reg buffer_ie_WRITE_PORT_reg;
reg [31:0]buffer_ie_PC_reg;
reg [3:0]buffer_ie_FLAGS_reg;
reg buffer_ie_REG_Write_reg;
always @(posedge clk ) begin
    if (IE_Flush) begin
        buffer_ie_Rdst_reg=0;
        buffer_ie_result_reg=0;
        buffer_ie_read_data1_reg=0;
        buffer_ie_MEM_Write_reg=0;
        buffer_ie_MEM_Read_reg=0;
        buffer_ie_STACK_SIGNAL_reg=0;
        buffer_ie_DEC_SP_reg=0;
        buffer_ie_INC_SP_reg=0;
        buffer_ie_MEM_to_REG_reg=0;
        buffer_ie_WRITE_PORT_reg=0;
        buffer_ie_PC_reg=0;
        buffer_ie_FLAGS_reg=0;
        buffer_ie_REG_Write_reg=0;
        
    end else if (IE_Stall) begin
        //no change
    end
    else begin
    //write data to regs
        buffer_ie_Rdst_reg=buffer_ie_Rdst_in;
        buffer_ie_result_reg=buffer_ie_result_in;
        buffer_ie_read_data1_reg=buffer_ie_read_data1_in;
        buffer_ie_MEM_Write_reg=buffer_ie_MEM_Write_in;
        buffer_ie_MEM_Read_reg=buffer_ie_MEM_Read_in;
        buffer_ie_STACK_SIGNAL_reg=buffer_ie_STACK_SIGNAL_in;
        buffer_ie_DEC_SP_reg=buffer_ie_DEC_SP_in;
        buffer_ie_INC_SP_reg=buffer_ie_INC_SP_in;
        buffer_ie_MEM_to_REG_reg=buffer_ie_MEM_to_REG_in;
        buffer_ie_WRITE_PORT_reg=buffer_ie_WRITE_PORT_in;
        buffer_ie_PC_reg=buffer_ie_PC_in;
        buffer_ie_FLAGS_reg=buffer_ie_FLAGS_in;
        buffer_ie_REG_Write_reg=buffer_ie_REG_Write_in;
    end
end
    //asynch read
assign buffer_ie_Rdst_out=buffer_ie_Rdst_reg;
assign buffer_ie_result_out=buffer_ie_result_reg;
assign buffer_ie_read_data1_out=buffer_ie_read_data1_reg;
assign buffer_ie_MEM_Write_out=buffer_ie_MEM_Write_reg;
assign buffer_ie_MEM_Read_out=buffer_ie_MEM_Read_reg;
assign buffer_ie_STACK_SIGNAL_out=buffer_ie_STACK_SIGNAL_reg;
assign buffer_ie_DEC_SP_out=buffer_ie_DEC_SP_reg;
assign buffer_ie_INC_SP_out=buffer_ie_INC_SP_reg;
assign buffer_ie_MEM_to_REG_out=buffer_ie_MEM_to_REG_reg;
assign buffer_ie_WRITE_PORT_out=buffer_ie_WRITE_PORT_reg;
assign buffer_ie_PC_out=buffer_ie_PC_reg;
assign buffer_ie_FLAGS_out=buffer_ie_FLAGS_reg;
assign buffer_ie_REG_Write_out=buffer_ie_REG_Write_reg;

endmodule


/*
IM

rdst
result
read data from memory
wb signals


==>>>> reg write needs to travel from 1st buffer to last buffer to reg file again directly from it
*/
//buffer IE/IM
module buffer_im (
    //signals
    input clk,
    input IM_Flush,
    input IM_Stall,//  ~ !write_data
    
    input [2:0] buffer_im_Rdst_in,
    input [15:0]buffer_im_result_in,
    input [15:0]buffer_im_read_data_from_memory_in,
    input buffer_im_MEM_to_REG_in,
    input buffer_im_WRITE_PORT_in,
    input buffer_im_REG_Write_in,

    output[2:0] buffer_im_Rdst_out,
    output[15:0] buffer_im_result_out,
    output [15:0]buffer_im_read_data_from_memory_out,
    output buffer_im_MEM_to_REG_out,
    output buffer_im_WRITE_PORT_out,
    output buffer_im_REG_Write_out
);
    reg[2:0] buffer_im_Rdst_reg;
    reg[15:0] buffer_im_result_reg;
    reg buffer_im_MEM_to_REG_reg;
    reg buffer_im_WRITE_PORT_reg;
    reg [15:0]buffer_im_read_data_from_memory_reg;
    reg buffer_im_REG_Write_reg;

always @(posedge clk ) begin
    if (IM_Flush) begin
        buffer_im_Rdst_reg=0;
        buffer_im_result_reg=0;
        buffer_im_read_data_from_memory_reg=0;
        buffer_im_MEM_to_REG_reg=0;
        buffer_im_WRITE_PORT_reg=0;
        buffer_im_REG_Write_reg=0;
    end else if (IM_Stall) begin
        //no change
    end
    else begin
    //write data to regs
        buffer_im_Rdst_reg=buffer_im_Rdst_in;
        buffer_im_result_reg=buffer_im_result_in;
        buffer_im_read_data_from_memory_reg=buffer_im_read_data_from_memory_in;
        buffer_im_MEM_to_REG_reg=buffer_im_MEM_to_REG_in;
        buffer_im_WRITE_PORT_reg=buffer_im_WRITE_PORT_in;
        buffer_im_REG_Write_reg=buffer_im_REG_Write_in;
    end
end
assign buffer_im_Rdst_out=buffer_im_Rdst_reg;
assign buffer_im_result_out=buffer_im_result_reg;
assign buffer_im_read_data_from_memory_out=buffer_im_read_data_from_memory_reg;
assign buffer_im_MEM_to_REG_out=buffer_im_MEM_to_REG_reg;
assign buffer_im_WRITE_PORT_out=buffer_im_WRITE_PORT_reg;
assign buffer_im_REG_Write_out=buffer_im_REG_Write_reg;
endmodule

