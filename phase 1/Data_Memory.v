
module Data_Memory(read_enable,write_enable,read_data,write_data,clk,rst,read_addr,write_addr);

input read_enable;
input write_enable;
input wire [15:0]write_data;
input [15:0]read_addr;
input [15:0]write_addr;
input clk;
input rst;
output reg [15:0]read_data;
reg [15:0]Memo[0:2044];
integer j;

always @ (posedge clk or posedge rst)
begin
if(rst)
begin
for(j=0;j<2044;j=j+1)
Memo[j]='b0;
end

if(write_enable==1'b1)
 Memo[write_addr]=write_data;

end

always @ (*)
begin
read_data=(read_enable==1'b1) ? Memo[read_addr]:16'b0;
end

endmodule