LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fetch IS
  PORT (
    clk, reset, loadUse : IN std_logic;
    IRin : IN std_logic_vector(31 DOWNTO 0);
    pcIn : IN std_logic_vector(31 DOWNTO 0);
    pcOut : OUT std_logic_vector(31 DOWNTO 0);
    IR : OUT std_logic_vector(31 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE fetch_stage OF fetch IS
  SIGNAL stall_pc_mux_out : std_logic_vector(31 DOWNTO 0);
  SIGNAL pc_mux_out : std_logic_vector(31 DOWNTO 0);
  SIGNAL pcMuxOut : std_logic_vector(31 DOWNTO 0);

  SIGNAL m0 : std_logic_vector(31 DOWNTO 0);
  SIGNAL irTemp : std_logic_vector(31 DOWNTO 0);

  SIGNAL pcAdder : std_logic_vector(31 DOWNTO 0);
BEGIN

  pc_mux : ENTITY work.mux_2_1 PORT MAP (reset, pcIn, m0, pc_mux_out);

  stall_pc_mux : ENTITY work.mux_2_1 PORT MAP (loadUse, pcAdder, pc_mux_out, pcOut);

  mainMemory : ENTITY work.instructions_memory PORT MAP (reset, pc_mux_out, m0, irTemp);

  PROCESS (clk, reset, pcIn, irTemp, m0)
  BEGIN
    IF falling_edge(clk) AND irTemp(29) = '1' AND RESET = '0' THEN
      pcAdder <= std_logic_vector(to_unsigned(to_integer(unsigned(pcIn)) + 2, 32));

	END IF ; 
    IF falling_edge(clk) AND irTemp(29) = '0' AND RESET = '0' THEN
      pcAdder <= std_logic_vector(to_unsigned(to_integer(unsigned(pcIn)) + 1, 32));
	END IF ;
    IF RESET = '1' THEN
      pcAdder <= m0;

    END IF;

  END PROCESS;


--   pcAdder <= std_logic_vector(to_unsigned(to_integer(unsigned(pcIn)) + 2, 32)) WHEN (irTemp(29) = '1' AND RESET = '0' AND clk'event AND clk = '0')
--     ELSE
--     std_logic_vector(to_unsigned(to_integer(unsigned(pcIn)) + 1, 32)) WHEN(irTemp(29) = '0' AND RESET = '0' AND clk'event AND clk = '0')
--     ELSE
--     m0 WHEN RESET = '1';

  IR <= irTemp WHEN loadUse = '0' AND reset = '0'
    ELSE IRin;

END ARCHITECTURE;