module Decode2 (
    input [15:0] write_back,
    input [31:0] instr,   //Incoming from fetch
    input read_enable, write_enable, reset, clk,
    input[2 : 0] read_addr1,read_addr2, write_addr,
    output reg  REG_Write,
    output reg  MEM_Write,
    output reg  MEM_Read,
    output reg  ALU_Source,
    output reg  MEM_to_REG,
    output reg  [2:0] ALU_Control,
    output reg[15 : 0] read_data1,
    output reg[15 : 0] read_data2
);
    //ControlUnit cu(clk,instr[31:27],REG_Write,MEM_Write,MEM_Read,ALU_Source,MEM_to_REG,ALU_Control);
    //RegFile_registers regFile (read_enable, write_enable, read_data1,read_data2, write_back, clk, reset, read_addr1,read_addr2, write_addr);
//Reg File logic
reg[15 : 0] Registers[7 : 0];
integer i;
//control unit logic
initial begin
        	for(i = 0; i < 8; i = i + 1)
             Registers[i] = 0;
end


always @(*) begin
    if (instr[31:27]==5'b00001) begin           //LDM instruction
        ALU_Control = 3'b010;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 1;
        ALU_Source  = 1;
        MEM_to_REG  = 1;
    end else if (instr[31:27]==5'b00010) begin  //STD instruction
        ALU_Control = 3'b011;
        REG_Write   = 0;
        MEM_Write   = 1;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end else if (instr[31:27]==5'b00011) begin  //ADD instruction
        ALU_Control = 3'b000;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end else if (instr[31:27]==5'b00100) begin  //NOT instruction
        ALU_Control = 3'b001;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end else if (instr[31:27]==5'b00101) begin  //NOP instruction
        ALU_Control = 3'b100;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end

    // reset
    if (reset)
    begin
    	for(i = 0; i < 8; i = i + 1)
             Registers[i] = 0;
    end
// read
    read_data1 = Registers[instr[26:24]];
    read_data2 = Registers[instr[23:21]];
// write
    if (REG_Write )
        Registers[instr[23:21]]  = write_back;



end








endmodule
