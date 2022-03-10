LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Lab1 IS

	PORT (
		i : IN STD_LOGIC_VECTOR(0 TO 3);
		s : IN STD_LOGIC_VECTOR(0 TO 1);
		e : IN STD_LOGIC;
		A : IN STD_LOGIC_VECTOR(2 DOWNTO 1);
		d : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		y : OUT STD_LOGIC
	);
END Lab1;
ARCHITECTURE rtl OF Lab1 IS
BEGIN
	PROCESS (i, s)
	BEGIN
		IF s = "00" THEN

			y <= i(0);

		ELSIF s = "01" THEN
			y <= i(1);

		ELSIF s = "10" THEN
			y <= i(2);

		ELSE
			y <= i(3);

		END IF;

	END PROCESS;

	PROCESS (e, a)

	BEGIN

		d <= "0000";

		IF E = '1' THEN

			CASE a IS

				WHEN "00" => d <= "0001";

				WHEN "01" => d <= "0010";

				WHEN "10" => d <= "0100";

				WHEN "11" => d <= "1000";
				
				WHEN OTHERS => d <= "0000";

			END CASE;
		END IF;

	END PROCESS;

END rtl;