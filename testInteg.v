module testInteg();
reg clk;
reg reset;
MIPS_phase_1 mips(
    clk,
    reset
);
initial
begin
clk=0;
reset=0;
forever #50 clk=~clk;
end

endmodule