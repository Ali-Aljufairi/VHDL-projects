
library ieee;
use ieee.std_logic_1164.all;

ENTITY DE_EX_Reg IS
	PORT(
		en: IN std_logic;
		clk: IN std_logic;
		rst: IN std_logic;
	-- input data
		INDATA_D: IN std_logic_vector(15 DOWNTO 0);
		PC_D: IN std_logic_vector(31 DOWNTO 0);
		src1_D, src2_D, offset_D: IN std_logic_vector(15 DOWNTO 0);
		dst_D, src1_D_addr, src2_D_addr: IN std_logic_vector(2 DOWNTO 0);
		-- control signals	
		ALU_op_D,JMP_op_D: IN std_logic_vector(2 DOWNTO 0);
		IN_en_D, OUT_en_D,
		ALU_en_D, ALU_src_D,
		MemRead_D, MemWrite_D,
		WriteBack_D, MemToReg_D,
		SP_en_D, SP_op_D,
		--PC_en_D,
		write32_D, read32_D,
		C_Flag_en_D,Z_Flag_en_D,N_Flag_en_D,
		STD_flag_D,
		Call_flag_D, INT_flag_D, Branch_flag_D,
		RTI_flag_D,
		RET_flag_D,
		LDM_flag_D,
		POP_flag_D,
		PUSH_flag_D: IN std_logic;
	-- output data
		INDATA_E:OUT std_logic_vector(15 DOWNTO 0);
		PC_E: OUT std_logic_vector(31 DOWNTO 0);
		src1_E, src2_E, offset_E: OUT std_logic_vector(15 DOWNTO 0);
		dst_E, src1_E_addr, src2_E_addr: OUT std_logic_vector(2 DOWNTO 0);
		-- control signals	
		ALU_op_E,JMP_op_E: OUT std_logic_vector(2 DOWNTO 0);
		IN_en_E, OUT_en_E,
		ALU_en_E, ALU_src_E,
		MemRead_E, MemWrite_E,
		WriteBack_E, MemToReg_E,
		SP_en_E, SP_op_E,
		--PC_en_E,
		write32_E, read32_E,
		C_Flag_en_E,Z_Flag_en_E,N_Flag_en_E,
		STD_flag_E,
		Call_flag_E, INT_flag_E, Branch_flag_E,
		RTI_flag_E,
		RET_flag_E,
		LDM_flag_E,
		POP_flag_E,
		PUSH_flag_E: OUT std_logic
	);
END DE_EX_Reg;


ARCHITECTURE DeExReg of DE_EX_Reg IS
BEGIN
	PROCESS (clk, rst) IS
	BEGIN
		IF (rst = '1')  THEN
			INDATA_E <= (others=>'0');
			PC_E <= (others=>'0');
			src1_E <= (others=>'0');
			src2_E <= (others=>'0');
			offset_E <= (others=>'0');
			dst_E <= (others=>'0');
			ALU_op_E <= (others=>'0');
			JMP_op_E <= (others=>'0');
			IN_en_E <= '0';
			OUT_en_E <= '0';
			ALU_en_E <= '0';
			ALU_src_E <= '0';
			MemRead_E <= '0';
			MemWrite_E <= '0';
			WriteBack_E <= '0';
			MemToReg_E <= '0';
			SP_en_E <= '0';
			SP_op_E <= '0';
			--PC_en_E <= '0';
			write32_E <= '0';
			read32_E <= '0';
			C_Flag_en_E <= '0';
			Z_Flag_en_E <= '0';
			N_Flag_en_E <= '0';
			STD_flag_E <= '0';
			Call_flag_E <= '0';
			INT_flag_E <= '0';
			Branch_flag_E <= '0';
			RTI_flag_E <= '0';
			RET_flag_E <= '0';
			src1_E_addr <= "000";
			src2_E_addr <= "000";
			LDM_flag_E<='0';
			POP_flag_E<='0';
			PUSH_flag_E<='0';
		ELSIF (rising_edge(clk) and en = '1') THEN
			INDATA_E <= INDATA_D;
			PC_E <= PC_D;
			src1_E <= src1_D;
			src2_E <= src2_D;
			offset_E <= offset_D;
			dst_E <= dst_D;
			ALU_op_E <= ALU_op_D;
			JMP_op_E <= JMP_op_D;
			IN_en_E <= IN_en_D;
			OUT_en_E <= OUT_en_D;
			ALU_en_E <= ALU_en_D;
			ALU_src_E <= ALU_src_D;
			MemRead_E <= MemRead_D;
			MemWrite_E <= MemWrite_D;
			WriteBack_E <= WriteBack_D;
			MemToReg_E <= MemToReg_D;
			SP_en_E <= SP_en_D;
			SP_op_E <= SP_op_D;
			--PC_en_E <= PC_en_D;
			write32_E <= write32_D;
			read32_E <= read32_D;
			C_Flag_en_E <= C_Flag_en_D;
			Z_Flag_en_E <= Z_Flag_en_D;
			N_Flag_en_E <= N_Flag_en_D;
			STD_flag_E <= STD_flag_D;
			Call_flag_E <= Call_flag_D;
			INT_flag_E <= INT_flag_D;
			Branch_flag_E <= Branch_flag_D;
			RTI_flag_E <= RTI_flag_D;
			RET_flag_E <= RET_flag_D;
			src1_E_addr <= src1_D_addr;
			src2_E_addr <= src2_D_addr;
			LDM_flag_E<=LDM_flag_D;
			POP_flag_E<=POP_flag_D;
			PUSH_flag_E<=PUSH_flag_D;
		END IF;

	END PROCESS;
END DeExReg;
