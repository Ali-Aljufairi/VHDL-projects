LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetch IS
	PORT (
		clk, reset, loadUse : IN STD_LOGIC;
		IRin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		pcIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		pcOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		IR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE fetch_stage OF fetch IS
	SIGNAL stall_pc_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pc_mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL pcMuxOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

	SIGNAL m0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL irTemp : STD_LOGIC_VECTOR(31 DOWNTO 0);

	SIGNAL pcAdder : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

	pc_mux : ENTITY work.mux_2_1 PORT MAP (reset, pcIn, m0, pc_mux_out);

	stall_pc_mux : ENTITY work.mux_2_1 PORT MAP (loadUse, pcAdder,pc_mux_out, pcOut);

	mainMemory : ENTITY work.instructions_memory  PORT MAP (reset, pc_mux_out, m0, irTemp);

	pcAdder <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(pcIn)) + 2, 32)) WHEN (irTemp(29) = '1' AND RESET = '0' AND clk'event AND clk = '0')
		ELSE
		STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(pcIn)) + 1, 32)) WHEN(irTemp(29) = '0' AND RESET = '0' AND clk'event AND clk = '0')
		ELSE
		m0 WHEN RESET = '1';

	IR <= irTemp when loadUse ='0' and reset = '0'
	else IRin;






	
END ARCHITECTURE;