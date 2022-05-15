LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
ENTITY ram IS
	PORT(
		clk : IN std_logic;
		we, write32  : IN std_logic;	
		re: IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(31 DOWNTO 0);
		dataout : OUT std_logic_vector(31 DOWNTO 0));
END ENTITY ram;
ARCHITECTURE syncrama OF ram IS
	-- 2^20 = 1048576
TYPE ram_type IS ARRAY(0 TO 1048576) OF std_logic_vector(15 DOWNTO 0);
SIGNAL ram : ram_type ;
BEGIN
		PROCESS(clk) IS
		BEGIN
				IF falling_edge(clk) THEN
					IF (we = '1') THEN
						ram(to_integer(unsigned(address))) <= datain(31 DOWNTO 16);
					END IF;
					IF (we = '1' and write32 = '1') THEN
						ram(to_integer(unsigned(address)+1)) <= datain(15 DOWNTO 0);
					END IF;
					IF (re = '1') THEN
						dataout(31 DOWNTO 16) <= ram(to_integer(unsigned(address)));
						dataout(15 DOWNTO 0) <= ram(to_integer(unsigned(address)+1));
					END IF;
				END IF;
		END PROCESS;
END syncrama;
