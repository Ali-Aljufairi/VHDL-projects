LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY q3 IS
	GENERIC (
		N : INTEGER := 4
		data_width : INTEGER := 8
	);

	PORT (
		clk, reset, x : IN STD_LOGIC;
		seq : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
		y : OUT std_loigc
	);
END ENTITY;

ARCHITECTURE rtl OF q3 IS

	SIGNAL z : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);      

	COMPONENT q2
		GENERIC (N => 4, data_width => 8);
		PORT (
			clk, reset, data_in : IN STD_LOGIC;
			data_out : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
		);
	END COMPONENT;

BEGIN
	y <= '0';
	s1 : serial PORT MAP(
		clk => clk,
		reset => reset,
		data_in => x,
		data_out => z)
	PROCESS (clk)
	BEGIN
		IF z = seq THEN
			y <= '1';
			reset <= '1';
		ELSE
			y <= '0';
		END IF;
	END PROCESS;
END ARCHITECTURE;