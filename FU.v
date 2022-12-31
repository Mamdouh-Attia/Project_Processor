module FU(
    input [2:0]currentsrc,
    input [2:0]currentdest,
    input [2:0]exec_dest,
    input [2:0]mem_dest,
    input mem_wb_signal,
    input exec_wb_signal,
    output reg [1:0]src_selector,
    output reg [1:0]dest_selector
);
always @(*) begin
    src_selector=2'b00;
    dest_selector=2'b00;
    if(exec_wb_signal&&currentsrc==exec_dest)
    begin
        src_selector=01;
        
    end
    if(exec_wb_signal&&currentdest==exec_dest)
    begin
        dest_selector=01;
        
    end
    if(mem_wb_signal&&currentsrc==mem_dest)
    begin
        src_selector=10;
        
    end
    if(mem_wb_signal&&currentdest==mem_dest)
    begin
        dest_selector=10;
        
    end
    
end
endmodule