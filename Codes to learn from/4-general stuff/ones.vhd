library ieee;
use ieee.std_logic_1164.all;

entity ones is
port( A: in std_logic_vector(3 downto 0);
		B: out std_logic_vector(2 downto 0));
end ones;

architecture behavioural of ones is
begin
process(A)
begin
	
	if A="0000" then		--all zeroes
		B<="000";
	elsif A="1111" then	--all ones
		B<="111";
	elsif (A="0001") or (A="0010") or (A="0100") or (A="1000") then			--one one
		B<="001";
	elsif (A="0011") or (A="1100") or (A="0101") or (A="1010") or (A="1001") or (A="0110") then	--two ones
		B<="010";
	else				--three ones
		B<="011";
	

end process;
end architecture;