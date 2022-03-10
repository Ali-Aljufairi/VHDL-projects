LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Fulladder_generic is
GENERIC (
	data_width : INTEGER := 16);
PORT (
	a : IN STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0);
	b : IN STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0);
	cin : IN STD_LOGIC;
	s : OUT STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0);
	cout : OUT STD_LOGIC);
END Fulladder_generic ;

ARCHITECTURE Behavioral OF Fulladder_generic IS

	COMPONENT FA IS
		PORT (
			a, b, c_in : IN STD_LOGIC;
			s, c_out : OUT STD_LOGIC);
	END COMPONENT;
	SIGNAL c : STD_LOGIC_VECTOR(data_width  DOWNTO 0);
BEGIN

	c(0) <= cin;
	cout <= c(data_width - 1);

END Behavioral;