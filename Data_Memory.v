
module Data_Memory(read_enable,write_enable,read_data,write_data,clk,rst,addr);

input read_enable;
input write_enable;
input wire [15:0]write_data;
input [15:0]addr;
//

input clk;
input rst;
output reg [15:0]read_data;
// my memory ask on its size????
reg [15:0]Memo[0:2047];
integer j;

always @ (posedge clk or posedge rst)
begin
if(rst)
begin
for(j=0;j<2048;j=j+1)
Memo[j]='b0;
end
// ask on else ????
if(write_enable==1'b1)
 Memo[addr]=write_data;
else 
 Memo[addr]=Memo[addr];
end

always @ (*)
begin
if(read_enable==1'b1)
  read_data=Memo[addr];
else
   read_data=16'b0;
end

endmodule

module Memory_Stage(
input clk,
input rst,
input [15:0]input_data,
input [15:0]pc_low,
input [15:0]pc_heigh,
input [15:0]flags,  // ask on flag size????
input [15:0]address,
input stack_signal,
input dec_sp,
input inc_sp,
input mem_write,
input mem_read,
input which_data1,
input which_data2,
output wire [15:0]output_data);
reg [15:0]addr;
reg [31:0]sp;
reg [15:0]data;
assign sp=32'b011111111111;

// ask about always parameter????
always @(*)
begin 
    // ask in case of 11 is there any priority????
    if (dec_sp && !inc_sp)
      sp=sp-1;
    else if (!dec_sp && inc_sp)
      sp=sp+1;
    else
      sp=sp;
    // pick wanted address
    // stack signal active heigh
    addr=(stack_signal) ? sp : address;
    // pick wanted data
    data=(!which_data1 && !which_data2) ? input_data : // 00
         (which_data1 && !which_data2) ? pc_low :  // 01
         (!which_data1 && which_data2) ? pc_heigh : flags;  // 10
end

Data_Memory Mem(mem_read,mem_write,output_data,data,clk,rst,addr);


endmodule