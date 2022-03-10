library ieee;
use ieee.std_logic_1164.all;

entity comparator is
port( A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		C: out std_logic_vector(7 downto 0));
end comparator;

architecture behavioural of comparator is
begin
process(A, B)
begin

	if A>B then
		c<=A;
	else
		c<=B;
	end if;
end process;
end architecture;