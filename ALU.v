// flags -> 0: carry, 1: zero, 2: negative, 3: overflow
module ALU(input clk, input[4:0] alu_control, input[15:0] src, input[15:0] dst, output reg[15:0] result, output reg[3:0] flags,input reset);

	
 always @ (posedge clk)
  begin
	if (reset==1) begin
		flags=0;
	end
 	else if(alu_control === 0)	// NOP
	begin
		// nothing
	end

		else if(alu_control === 1)		// SETC
	begin
		flags[0] = 1;
	end

	else if(alu_control === 2)		// CLRC
	begin
		flags[0] = 0;
	end

	else if(alu_control === 3)	// NOT
	begin
		result = ~dst;
		flags[1] = result == 0 ? 1 : 0;
		flags[2] = result[15] == 1 ? 1 : 0;
	end

	else if(alu_control === 4)	// INC
	begin
		result = dst + 1;
		flags[1] =  result === 0 ? 1 : 0;
		flags[2] = result[15] === 1 ? 1 : 0;
	end

	else if(alu_control === 5)			// DEC
	begin
		result = dst - 1;
		flags[1] =  result === 0 ? 1 : 0;
		flags[2] = result[15] === 1 ? 1 : 0;
	end

	else if(alu_control === 6)			// OUT
	begin
		// nothing
	end

	else if(alu_control === 7)			// IN
	begin
		// nothing
	end

	else if(alu_control === 8)			// MOV
	begin
		result = src;
	end

	else if(alu_control === 9)			// ADD
	begin
		{flags[0], result} = src + dst;
		flags[1] =  result === 0 ? 1 : 0;
		flags[2] = result[15] === 1 ? 1 : 0;
		flags[3] = (src[15] === dst[15] && src[15] != result[15]) ? 1 : 0;
	end

	else if(alu_control === 10)		// SUB
	begin
		result = src - dst;
		flags[1] =  result === 0 ? 1 : 0;
		flags[2] = result[15] === 1 ? 1 : 0;
		//If 2 numbers are subtracted, and their signs are different, then overflow occurs if and only if the result has the same sign as the subtrahend.
		flags[3] = (src[15]^dst[15] === 1 && result[15] === dst[15]) ? 1 : 0;
	end

	else if(alu_control === 11)		// AND
	begin
		result = src & dst;
		flags[1] =  result === 0 ? 1 : 0;
		flags[2] = result[15] === 1 ? 1 : 0;
	end

	else if(alu_control === 12)		// OR
	begin
		result = src | dst;
		flags[1] =  result === 0 ? 1 : 0;
		flags[2] = result[15] === 1 ? 1 : 0;
	end

	else if(alu_control === 13)		// SHL
	begin
	// note : dst here = immediate value
		{flags[0], result} = src <<< dst;
	end

	else if(alu_control === 14)		// SHR
	begin
	// note : dst here = immediate value
		{result, flags[0]} = src <<< dst;
	end

	else if(alu_control === 15)		// PUSH
	begin
	// note : src here = SP
		result = src;
	end

	else if(alu_control === 16)		// POP
	begin
	// note : src here = SP
		result = src;
	end

	else if(alu_control === 17)		// LDM
	begin
	// note : src here = immediate value
		result = src;
	end

	else if(alu_control === 18)		// LDD
	begin
		// nothing
	end

	else if(alu_control === 19)		// STD
	begin
		// nothing
	end

	else if(alu_control === 20)		// JZ
	begin

	end

	else if(alu_control === 21)		// JN
	begin

	end

	else if(alu_control === 22)		// JC
	begin

	end

	else if(alu_control === 23)		// JMP
	begin

	end

	else if(alu_control === 24)		// CALL
	begin

	end

	else if(alu_control === 25)		// RET
	begin

	end

	else if(alu_control === 26)		// RETI
	begin

	end
 end
endmodule


