module JDU(
    input [3:0]flags,
    input enable,//branch control signal
    output reg jumpInstruction,
    output reg if_flush,
    output reg id_flush
);
always @(*) begin
    if(enable)
    begin
        if(flags[0]||flags[1]||flags[2]||flags[3])
        begin
            jumpInstruction=1;
            if_flush=1;
            id_flush=1;
        end
        else
         begin
            jumpInstruction=0;
            if_flush=0;
            id_flush=0;
        end
    end
    else
    begin
    jumpInstruction=0;
    if_flush=0;
    id_flush=0;
    end
end
endmodule