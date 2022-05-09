LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE work.ITCE364project.ALL;


ENTITY adder1bit IS
	PORT (a,b,cin : IN  std_logic;
	s, cout : OUT std_logic );
END ENTITY;

ARCHITECTURE a_adder1bit OF adder1bit IS
	BEGIN
		s <= a XOR b XOR cin;
		cout <= (a AND b) OR (cin AND (a XOR b));
END ARCHITECTURE;