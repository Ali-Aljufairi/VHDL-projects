LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE work.ITCE364project.ALL;


ENTITY addernbit IS
Generic ( n : Integer:=32);
	PORT (x,y : IN   std_logic_vector (n-1 downto 0);
	cin: IN std_logic;
	s: OUT std_logic_vector (n-1 downto 0);
	cout : OUT std_logic);
END ENTITY;

ARCHITECTURE a_addernbit OF addernbit IS
	component adder1bit is
		PORT (a,b,cin : IN  std_logic;
		s, cout : OUT std_logic );
	END component;

	signal carry : std_logic_vector (n-1 downto 0);

	BEGIN
		sum0: adder1bit PORT MAP(x(0), y(0), cin, s(0), carry(0));
		loop2: FOR i IN 1 TO n-1 GENERATE
						sumx: adder1bit PORT MAP(x(i),y(i),carry(i-1),s(i),carry(i));
		END GENERATE;
	cout <= carry(n-1);
END ARCHITECTURE;