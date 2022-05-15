library ieee;
use ieee.std_logic_1164.all;
ENTITY register32 IS 
	PORT (
		clk, en: IN std_logic;
		datain: IN std_logic_vector(31 DOWNTO 0);
		dataout: OUT std_logic_vector(31 DOWNTO 0)
	);
END ENTITY;
ARCHITECTURE reg OF register32 IS
BEGIN
	PROCESS (clk) IS
	BEGIN
		IF (rising_edge(clk) and en = '1') THEN
			dataout <= datain;
		END IF;
	END PROCESS;
END ARCHITECTURE;