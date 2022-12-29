module WriteBack (
    input [15:0] read_data1,
    input [15:0] read_data2,
    output [15:0] write_data,
    input mem_to_reg 
);
    assign write_data= mem_to_reg? read_data1 : read_data2;
endmodule