-module Decode2 (
    input [15:0] write_back,  //Incoming from write back
    input [31:0] instr,      //Incoming from fetch
    input reset,clk,
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
);

//Reg File logic
reg[15 : 0] Registers[7 : 0];
integer i;
//control unit logic
always @(*) begin
    if (instr[31:27]==5'b00001) begin           //LDM instruction
        ALU_Control = 5'b10001;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 1;
        ALU_Source  = 1;
        MEM_to_REG  = 1;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end else if (instr[31:27]==5'b00010) begin  //STD instruction
        ALU_Control = 5'b10011;
        REG_Write   = 0;
        MEM_Write   = 1;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end else if (instr[31:27]==5'b00011) begin  //ADD instruction
        ALU_Control = 5'b01001;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end else if (instr[31:27]==5'b00100) begin  //NOT instruction
        ALU_Control = 5'b00001;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b00101) begin  //NOP instruction
        ALU_Control = 5'b00000;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b00000) begin  //SETC instruction
        ALU_Control = 5'b00001;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b00110) begin  //CLRC instruction
        ALU_Control = 5'b00010;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b00111) begin  //INC instruction
        ALU_Control = 5'b00011;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01000) begin  //DEC instruction
        ALU_Control = 5'b00100;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01001) begin  //OUT instruction
        ALU_Control = 5'b00101;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 1;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01010) begin  //IN instruction
        ALU_Control = 5'b00111;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 1;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 1;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01000) begin  //MOV instruction
        ALU_Control = 5'b01011;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01100) begin  //SUB instruction
        ALU_Control = 5'b01010;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01101) begin  //AND instruction
        ALU_Control = 5'b01011;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01110) begin  //OR instruction
        ALU_Control = 5'b01100;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b01111) begin  //SHL instruction
        ALU_Control = 5'b01101;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 1;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10000) begin  //SHR instruction
        ALU_Control = 5'b01110;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 1;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10001) begin  //PUSH instruction
        ALU_Control = 5'b01111;
        REG_Write   = 0;
        MEM_Write   = 1;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 1;
        DEC_SP      = 1;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10010) begin  //POP instruction
        ALU_Control = 5'b10000;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 1;
        ALU_Source  = 0;
        MEM_to_REG  = 1;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 1;
        DEC_SP      = 0;
        INC_SP      = 1;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10011) begin  //LDD instruction
        ALU_Control = 5'b10010;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 1;
        ALU_Source  = 0;
        MEM_to_REG  = 1;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b00010) begin  //STD instruction
        ALU_Control = 5'b10011;
        REG_Write   = 0;
        MEM_Write   = 1;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 0;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10100) begin  //JZ instruction
        ALU_Control = 5'b10100;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 1;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10101) begin  //JN instruction
        ALU_Control = 5'b10101;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 1;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10110) begin  //JC instruction
        ALU_Control = 5'b10110;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 0;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 1;
        RET         = 0;
    end
    else if (instr[31:27]==5'b10111) begin  //JMP instruction
        ALU_Control = 5'b10111;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 1;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 0;
        DEC_SP      = 0;
        INC_SP      = 0;
        BRANCH      = 1;
        RET         = 0;
    end
    else if (instr[31:27]==5'b11000) begin  //CALL instruction
        ALU_Control = 5'b11000;
        REG_Write   = 0;
        MEM_Write   = 1;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 1;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 1;
        DEC_SP      = 1;
        INC_SP      = 0;
        BRANCH      = 1;
        RET         = 0;
    end
    else if (instr[31:27]==5'b11001) begin  //RET instruction
        ALU_Control = 5'b11001;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 1;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
        IF_Flush    = 1;
        READ_PORT   = 0;
        WRITE_PORT  = 0;
        STACK_SIGNAL= 1;
        DEC_SP      = 0;
        INC_SP      = 1;
        BRANCH      = 0;
        RET         = 1;
    end
    //RTI to be added later insha'ALLAH
    // reset
    if (reset)
    begin
        for(i = 0; i < 8; i = i + 1)
            Registers[i] = 0;
    end
    // write to reg file
    if (REG_Write && write_back)begin
        Registers[instr[23:21]]  = write_back;
    end
    // read from reg file
    read_data1 = Registers[instr[26:24]];
    read_data2 = Registers[instr[23:21]];
end
endmodule
