
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


always @(negedge clk)//?
begin
    pcout=pcin+2;
end
 

endmodule
