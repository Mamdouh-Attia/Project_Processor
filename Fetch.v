
module Fetch(input [31:0] pcin
,output reg  [31:0] pcout
,output  [15:0] instruction
,input reg clk
,input reset);


wire read_enable,write_enable;
reg [15:0]write_data;
reg [31:0]write_addr;

assign read_enable=1;
assign write_enable=0;


Memory instructionMemory (read_enable,write_enable,instruction,write_data,clk,reset,pcin,write_addr);


always @(negedge clk)
begin
    pcout=pcin+2;
end
 

endmodule

module FetchMux(input [31:0] pcin,
input [31:0] pcNoinc,
input [31:0] branchPc,
input [31:0] poppedPc,
output reg [31:0] pcout,
input reset,
input stall,
input interrupt,
input returnInstruction,
input jumpInstruction
);

always @ (*)
begin
    if(interrupt)
    pcout=0;
    else if(reset)
    pcout=32;
    else if(stall)
    pcout=pcNoinc;
    else if(returnInstruction)
    pcout=poppedPc;
    else if(jumpInstruction)
    pcout=branchPc;
    else
    pcout=pcin;
end



endmodule