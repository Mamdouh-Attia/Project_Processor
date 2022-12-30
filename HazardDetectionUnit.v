module HDU(
    input [2:0]currentsrc,
    input [2:0]currentdest,
    input [2:0]exec_dest,
    input mem_read,
    output reg stall_fetch,
    output reg stall_decode
);
always @(*) begin
    if(mem_read&&(currentsrc==exec_dest||currentdest==exec_dest))// note: we need not stall if mov , what to do ?
    begin
        stall_fetch=1;
        stall_decode=1;
    end
    else
    begin
        stall_fetch=0;
        stall_decode=0;
    end
end
endmodule