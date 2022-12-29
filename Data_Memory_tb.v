
module Data_Memory_tb();
reg clk,reset,read_enable,write_enable;
wire [15:0]read_data;
reg [15:0]write_data;
reg [15:0]addr;

Data_Memory memo (read_enable,write_enable,read_data,write_data,clk,reset,addr);
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
addr=16'b0000_0000_0000_0010;
#5
read_enable=0;
write_enable=1;
addr=16'b0000_0000_0000_0010;
write_data=16'b1;
#5
read_enable=1;
write_enable=0;
addr=16'b0000_0000_0000_0010;
end



endmodule

module Memory_Stage_tb();
reg clk,rst,mem_read,mem_write,dec_sp,inc_sp,which_data1,which_data2,stack_signal;
wire [15:0]output_data;
reg [15:0]input_data;
reg [15:0]address;
reg [15:0]pc_low;
reg [15:0]pc_heigh;
reg [15:0]flags; 

Memory_Stage memo (
clk,
rst,
input_data,
pc_low,
pc_heigh,
flags,  // ask on flag size????
address,
stack_signal,
dec_sp,
inc_sp,
mem_write,
mem_read,
which_data1,
which_data2,
output_data);
initial
begin
clk=0;
rst=0;
forever #100 clk=~clk;
end

initial
begin

// normal read
mem_read=1;
mem_write=0;
dec_sp=0;
inc_sp=0;
address=16'b0000_0000_0000_0010;
stack_signal=0;
#350
// push
mem_read=0;
mem_write=1;
address=16'b0000_0000_0000_0010;
stack_signal=1;
dec_sp=1;
inc_sp=0;
which_data1=0;
which_data2=0;
input_data=16'b1;
#250
// pop
mem_read=1;
mem_write=0;
stack_signal=1;
dec_sp=0;
inc_sp=1;
#250
// normal write
stack_signal=0;
mem_read=0;
mem_write=1;
address=16'b0000_0000_0000_0010;
which_data1=0;
which_data2=0;
input_data=16'b1;
#250
// read after normal write
mem_read=1;
mem_write=0;
stack_signal=0;
address=16'b0000_0000_0000_0010;
end



endmodule
