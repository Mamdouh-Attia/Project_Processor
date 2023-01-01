vsim -gui work.MIPS_phase_3
# End time: 16:26:02 on Jan 01,2023, Elapsed time: 0:32:33
# Errors: 3, Warnings: 2
# vsim -gui work.MIPS_phase_3 
# Start time: 16:26:02 on Jan 01,2023
# Loading work.MIPS_phase_3
# Loading work.FetchMux
# Loading work.Fetch
# Loading work.Memory
# Loading work.buffer_if
# Loading work.Decode2
# Loading work.buffer_id
# Loading work.HDU
# Loading work.FU
# Loading work.JDU
# Loading work.ALU
# Loading work.buffer_ie
# Loading work.Memory_Stage
# Loading work.Data_Memory
# Loading work.buffer_im
# Loading work.WriteBack
mem load -i D:/projects/arch/decode/Project_Processor/instMem_2.mem -startaddress 0 -endaddress 999999 /MIPS_phase_3/fetch_stage_1st_half/instructionMemory/Memo
mem load -i D:/projects/arch/decode/Project_Processor/Data.mem /MIPS_phase_3/memory_stage_instance/Mem/Memo
mem load -i D:/projects/arch/decode/Project_Processor/instMem_2.mem /MIPS_phase_3/fetch_stage_2nd_half/instructionMemory/Memo
add wave -position insertpoint  \
sim:/MIPS_phase_3/decode_stage/Registers
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: lap2  Hostname: LAPTOP-53PG5H6G  ProcessID: 13568
#           Attempting to use alternate WLF file "./wlftw1ivnx".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftw1ivnx
add wave -position insertpoint  \
sim:/MIPS_phase_3/clk
add wave -position insertpoint  \
sim:/MIPS_phase_3/reset
add wave -position insertpoint  \
sim:/MIPS_phase_3/clk \
sim:/MIPS_phase_3/reset \
sim:/MIPS_phase_3/in_port_data \
sim:/MIPS_phase_3/out_port_data \
sim:/MIPS_phase_3/pcin1 \
sim:/MIPS_phase_3/pcout1 \
sim:/MIPS_phase_3/pcout2 \
sim:/MIPS_phase_3/pcout_MUX \
sim:/MIPS_phase_3/instruction1 \
sim:/MIPS_phase_3/instruction2 \
sim:/MIPS_phase_3/instruction \
sim:/MIPS_phase_3/branchPc \
sim:/MIPS_phase_3/poppedPc \
sim:/MIPS_phase_3/pcNoinc \
sim:/MIPS_phase_3/PCin_fetch2 \
sim:/MIPS_phase_3/stall \
sim:/MIPS_phase_3/interrupt \
sim:/MIPS_phase_3/returnInstruction \
sim:/MIPS_phase_3/jumpInstruction \
sim:/MIPS_phase_3/write_back \
sim:/MIPS_phase_3/REG_Write \
sim:/MIPS_phase_3/MEM_Write \
sim:/MIPS_phase_3/MEM_Read \
sim:/MIPS_phase_3/ALU_Source \
sim:/MIPS_phase_3/MEM_to_REG \
sim:/MIPS_phase_3/ALU_Control \
sim:/MIPS_phase_3/read_data1 \
sim:/MIPS_phase_3/read_data2 \
sim:/MIPS_phase_3/IF_Flush \
sim:/MIPS_phase_3/ID_Flush \
sim:/MIPS_phase_3/ID_Stall \
sim:/MIPS_phase_3/READ_PORT \
sim:/MIPS_phase_3/WRITE_PORT \
sim:/MIPS_phase_3/STACK_SIGNAL \
sim:/MIPS_phase_3/DEC_SP \
sim:/MIPS_phase_3/INC_SP \
sim:/MIPS_phase_3/BRANCH \
sim:/MIPS_phase_3/RET \
sim:/MIPS_phase_3/int_mem_selector1 \
sim:/MIPS_phase_3/int_mem_selector2 \
sim:/MIPS_phase_3/IF_Stall \
sim:/MIPS_phase_3/alu_second_operand \
sim:/MIPS_phase_3/result \
sim:/MIPS_phase_3/flags \
sim:/MIPS_phase_3/IE_Flush \
sim:/MIPS_phase_3/IE_Stall \
sim:/MIPS_phase_3/read_data_from_memory \
sim:/MIPS_phase_3/buffer_if_instruction_out \
sim:/MIPS_phase_3/buffer_if_pc_out \
sim:/MIPS_phase_3/buffer_im_Rdst_out \
sim:/MIPS_phase_3/buffer_im_REG_Write_out \
sim:/MIPS_phase_3/buffer_id_REG_Write_out \
sim:/MIPS_phase_3/buffer_id_MEM_Write_out \
sim:/MIPS_phase_3/buffer_id_MEM_Read_out \
sim:/MIPS_phase_3/buffer_id_ALU_Source_out \
sim:/MIPS_phase_3/buffer_id_MEM_to_REG_out \
sim:/MIPS_phase_3/buffer_id_read_data1_out \
sim:/MIPS_phase_3/buffer_id_read_data2_out \
sim:/MIPS_phase_3/buffer_id_immediate_out \
sim:/MIPS_phase_3/buffer_id_ALU_Control_out \
sim:/MIPS_phase_3/buffer_id_READ_PORT_out \
sim:/MIPS_phase_3/buffer_id_WRITE_PORT_out \
sim:/MIPS_phase_3/buffer_id_STACK_SIGNAL_out \
sim:/MIPS_phase_3/buffer_id_DEC_SP_out \
sim:/MIPS_phase_3/buffer_id_INC_SP_out \
sim:/MIPS_phase_3/buffer_id_BRANCH_out \
sim:/MIPS_phase_3/buffer_id_RET_out \
sim:/MIPS_phase_3/buffer_id_Rsrc_out \
sim:/MIPS_phase_3/buffer_id_Rdst_out \
sim:/MIPS_phase_3/buffer_id_pc_out \
sim:/MIPS_phase_3/stack_signal \
sim:/MIPS_phase_3/buffer_ie_Rdst_out \
sim:/MIPS_phase_3/buffer_ie_REG_Write_out \
sim:/MIPS_phase_3/buffer_ie_MEM_Read_out \
sim:/MIPS_phase_3/src_selector \
sim:/MIPS_phase_3/dest_selector \
sim:/MIPS_phase_3/buffer_ie_result_out \
sim:/MIPS_phase_3/buffer_ie_read_data1_out \
sim:/MIPS_phase_3/buffer_ie_MEM_Write_out \
sim:/MIPS_phase_3/buffer_ie_STACK_SIGNAL_out \
sim:/MIPS_phase_3/buffer_ie_DEC_SP_out \
sim:/MIPS_phase_3/buffer_ie_INC_SP_out \
sim:/MIPS_phase_3/buffer_ie_MEM_to_REG_out \
sim:/MIPS_phase_3/buffer_ie_WRITE_PORT_out \
sim:/MIPS_phase_3/buffer_ie_PC_out \
sim:/MIPS_phase_3/buffer_ie_FLAGS_out \
sim:/MIPS_phase_3/IM_Flush \
sim:/MIPS_phase_3/IM_Stall \
sim:/MIPS_phase_3/buffer_im_result_out \
sim:/MIPS_phase_3/buffer_im_read_data_from_memory_out \
sim:/MIPS_phase_3/buffer_im_MEM_to_REG_out \
sim:/MIPS_phase_3/buffer_im_WRITE_PORT_out
force -freeze sim:/MIPS_phase_3/reset 1 0
force -freeze sim:/MIPS_phase_3/clk 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/MIPS_phase_3/reset St0 0
run
run
run
run
run
run
run