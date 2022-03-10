LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_4_1 IS
	PORT (
		a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		b : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE behavioural OF mux_4_1 IS
BEGIN
	PROCESS (a, s)
	BEGIN

		IF s = "00" THEN
			b <= a(0);
		ELSIF s = "01" THEN
			b <= a(1);
		ELSIF s = "10" THEN
			b <= a(2);
		ELSE
			b <= a(3);
		END IF;
	END PROCESS;
END ARCHITECTURE;