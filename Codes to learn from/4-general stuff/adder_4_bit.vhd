LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder_4_bit IS
	PORT (
		a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		c : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)

	);
END adder_4_bit;

ARCHITECTURE rtl OF adder_4_bit IS

	SIGNAL a_sig, b_sig : unsigned(3 DOWNTO 0) := (OTHERS => '0');
	SIGNAL c_sig : unsigned(4 DOWNTO 0) := (OTHERS => '0');
BEGIN

	a_sig <= unsigned(a);
	b_sig <= unsigned(b);

	c_sig <= ('0' & a_sig) + ('0' & b_sig);

	c <= STD_LOGIC_VECTOR(c_sig);

END rtl;