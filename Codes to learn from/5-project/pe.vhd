LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ITCE211Project_library.ALL;

ENTITY pe IS

	PORT (
		clk : IN STD_LOGIC;
		eni, reset : IN STD_LOGIC;
		numberin : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
		numberout : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
		eno : OUT STD_LOGIC := '0';
		number : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0')
	);

END ENTITY;

ARCHITECTURE rtl OF pe IS

	SIGNAL stored : STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN

	number <= stored;

	PROCESS (clk, reset, eni)
	BEGIN
		IF reset = '1' THEN
			eno <= '0';
			stored <= (OTHERS => '0');
			numberout <= (OTHERS => '0');

		ELSIF rising_edge (clk) THEN

			IF eni = '0' THEN
				eno <= '0';
				numberout <= (OTHERS => '0');

			ELSIF numberin > stored AND eni = '1' THEN
				eno <= '1';
				numberout <= stored;
				stored <= numberin;

			ELSE
				eno <= '1';
				numberout <= numberin;

			END IF;

		END IF;
	END PROCESS;

END ARCHITECTURE;