module testFetch();



reg clk;
reg reset;
wire [15:0]instruction;
reg [31:0]pcin;
wire [31:0]pcout;

Fetch f( pcin, pcout, instruction, clk, reset);


initial
begin
clk=0;
reset=0;
pcin='d0;
forever #50 clk=~clk;
end

// initial
// begin
// #50
// clk=0;
// pcin='d0;
// // reset=0;
// end

// #50
always @(posedge clk)//?
begin
    pcin=pcout;
end

endmodule