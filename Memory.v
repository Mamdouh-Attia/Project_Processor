module Memory(read_enable,write_enable,read_data,write_data,clk,rst,read_addr,write_addr);

input read_enable;
input write_enable;
input [15:0]write_data;
input [31:0]read_addr;
input [31:0]write_addr;
input clk;
input rst;
output reg [15:0]read_data;
reg [15:0]Memo[0:999999];
integer j;

always @ (negedge clk )//write
begin

if((write_enable==1'b1))
 Memo[write_addr]=write_data;
end

always @ (posedge clk )// or posedge rst //read
begin

if(rst)
begin
for(j=0;j<999999;j=j+1)
Memo[j]='b0;
end

if((read_enable==1'b1))
 read_data=Memo[read_addr];

end
endmodule