LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY memory IS
	PORT (
		clk, RESET, memRead, memWrite, memAddressSelector : IN STD_LOGIC;
		Rdest, ALUout, spIn, controlSignalsIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		rdstNum : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		memOut, aluOutMem, controlSignalsOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		rdestNumOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		spOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END memory;

ARCHITECTURE memory_stage OF memory IS
	SIGNAL addressMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sp : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

	addressMux : ENTITY work.mux_2_1 PORT MAP (memAddressSelector, ALUout, spIn, addressMuxOut);

	dataMemory : ENTITY work.data_memory  PORT MAP (clk, RESET, memRead, memWrite, addressMuxOut(15 DOWNTO 0), Rdest, controlSignalsIn(5 DOWNTO 4), memOut);
	-- sp control unit 
	sp_control_unit_lbl : ENTITY work.sp_control_unit PORT MAP(clk, RESET, controlSignalsIn(5 DOWNTO 4), spIn, sp);

	aluOutMem <= ALUout;
	rdestNumOut <= rdstNum;
	controlSignalsOut <= controlSignalsIn;
	spOut <= sp;
END ARCHITECTURE;