LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364project.ALL;


ENTITY mux_2_1 IS
	PORT (
		selector : IN STD_LOGIC;
		muxIn1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		muxIn2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		muxOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE mux_logic OF mux_2_1 IS
BEGIN
	muxOut <= muxIn2 WHEN selector = '1' ELSE
		muxIn1 WHEN selector = '0';
END ARCHITECTURE;