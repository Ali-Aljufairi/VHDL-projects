
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY instructionRam IS
	PORT(
		address : IN  std_logic_vector(31 DOWNTO 0);
		dataout : OUT std_logic_vector(31 DOWNTO 0));
END ENTITY instructionRam;
ARCHITECTURE instructionMem OF instructionRam IS
	-- 2^20 = 1048576
TYPE ram_type IS ARRAY(0 TO 1048575) OF std_logic_vector(15 DOWNTO 0);
SIGNAL ram : ram_type ;
BEGIN
	dataout(31 DOWNTO 16) <= ram(to_integer(unsigned(address)));
	dataout(15 DOWNTO 0) <= ram(to_integer(unsigned(address)+1));
END instructionMem;