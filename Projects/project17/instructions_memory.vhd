
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364project.ALL;


ENTITY instructions_memory IS

	PORT (
		reset : IN STD_LOGIC;
		PC : IN STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0);
		m0 : OUT STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0);
		instruction : OUT STD_LOGIC_VECTOR(dataLineWidth - 1 DOWNTO 0)
	);
END instructions_memory;

ARCHITECTURE arch OF instructions_memory IS
	SIGNAL rom : ram_type;
	----------------------------
	FUNCTION to_string (a : STD_LOGIC_VECTOR) RETURN STRING IS
		VARIABLE b : STRING (1 TO a'length) := (OTHERS => NUL);
		VARIABLE stri : INTEGER := 1;
	BEGIN
		FOR i IN a'RANGE LOOP
			b(stri) := STD_LOGIC'image(a((i)))(2);
			stri := stri + 1;
		END LOOP;
		RETURN b;
	END FUNCTION;
	---------------
BEGIN
	m0(addressLineWidth - 1 DOWNTO 0) <= rom(0);
	m0(dataLineWidth - 1 DOWNTO addressLineWidth) <= (OTHERS => '0');
	--instruction <= (OTHERS => '0') WHEN reset = '1';

	instruction(addressLineWidth - 1 DOWNTO 0) <= rom(to_integer(unsigned(PC)) + 1);
	instruction(dataLineWidth - 1 DOWNTO addressLineWidth) <= rom(to_integer(unsigned(PC)));

END arch;