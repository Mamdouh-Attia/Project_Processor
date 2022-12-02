module Data_Memory_tb();
reg clk,reset,read_enable,write_enable;
wire [15:0]read_data;
reg [15:0]write_data;
reg [15:0]read_addr;
reg [15:0]write_addr;

Data_Memory memo (read_enable,write_enable,read_data,write_data,clk,reset,read_addr,write_addr);
initial
begin
clk=0;
reset=0;
forever #2 clk=~clk;
end

initial
begin

read_enable=1;
write_enable=0;
read_addr=16'b0000_0000_0000_0010;
#5
read_enable=0;
write_enable=1;
write_addr=16'b0000_0000_0000_0010;
write_data=16'b1;
#5
read_enable=1;
write_enable=0;
read_addr=16'b0000_0000_0000_0010;
end



endmodule
