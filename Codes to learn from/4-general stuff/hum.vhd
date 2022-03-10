library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hum is
port(a: in std_logic_vector(1 downto 0);
	  b: in std_logic_vector(1 downto 0);
	  d: out std_logic_vector(1 downto 0)

);
end hum;

architecture rtl of hum is 

begin
process(a, b)
begin
	if (a(0) /= b(0)) and (a(1) /= b(1)) then 
		d <= "10";
	elsif (a(0) /= b(0)) or (a(1) /= b(1)) then
		d <= "01";
	else
		d <= "00";
	end if;

end process;
end rtl;