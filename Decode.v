module ControlUnit (
    input clk,
    input[4:0] opCode,
    output reg REG_Write,
    output reg MEM_Write,
    output reg MEM_Read,
    output reg ALU_Source,
    output reg MEM_to_REG,
    output reg [2:0] ALU_Control
);

always @(posedge clk) begin
    if (opCode==5'b00001) begin           //LDM instruction
        ALU_Control = 3'b010;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 1;
        ALU_Source  = 1;
        MEM_to_REG  = 1;
    end else if (opCode==5'b00010) begin  //STD instruction
        ALU_Control = 3'b011;
        REG_Write   = 0;
        MEM_Write   = 1;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end else if (opCode==5'b00011) begin  //ADD instruction
        ALU_Control = 3'b000;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end else if (opCode==5'b00100) begin  //NOT instruction
        ALU_Control = 3'b001;
        REG_Write   = 1;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end else if (opCode==5'b00101) begin  //NOP instruction
        ALU_Control = 3'b100;
        REG_Write   = 0;
        MEM_Write   = 0;
        MEM_Read    = 0;
        ALU_Source  = 0;
        MEM_to_REG  = 0;
    end
end

endmodule //ControlUnit

module RegFile_registers #(
    parameter N = 16,   // register size
    parameter accessBits = 3,
    parameter registersCount = 8
)
(read_enable, write_enable, read_data1,read_data2, write_data, clk, reset, read_addr1,read_addr2, write_addr);

// declaration
input read_enable, write_enable, reset, clk;
input[N-1 : 0] write_data;
input[accessBits-1 : 0] read_addr1,read_addr2, write_addr;
output reg[N-1 : 0] read_data1;
output reg[N-1 : 0] read_data2;
reg[N-1 : 0] Registers[registersCount-1 : 0];
integer i;

// logic
always @ (posedge clk)
// reset
    if (reset)
    begin
    	for(i = 0; i < 8; i = i + 1)
             Registers[i] = 0;
    end
// read
    else if (read_enable && write_enable !== 1)begin
         read_data1 = Registers[read_addr1];
         read_data2 = Registers[read_addr2];
// write
    end else if (write_enable && read_enable !== 1)
        Registers[write_addr]  = write_data;
endmodule

module Decode (
    input [15:0] write_back,
    input [15:0] instr,   //Incoming from fetch
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
    ControlUnit cu(clk,instr[15:13],REG_Write,MEM_Write,MEM_Read,ALU_Source,MEM_to_REG,ALU_Control);
    RegFile_registers regFile (read_enable, write_enable, read_data1,read_data2, write_back, clk, reset, read_addr1,read_addr2, write_addr);
endmodule

