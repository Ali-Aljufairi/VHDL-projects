library ieee;
use ieee.std_logic_1164.all;
ENTITY MUX_1_2 IS
GENERIC (n : integer:=32);
	PORT(
		In1, In2: IN std_logic_vector(n-1 DOWNTO 0);
		sel: IN std_logic;
		out_data: OUT std_logic_vector(n-1 DOWNTO 0)
	);
END MUX_1_2;
ARCHITECTURE mux_1_2 OF MUX_1_2 IS
BEGIN
	out_data <= In1 WHEN sel = '0' ELSE
		    In2;
END mux_1_2;
