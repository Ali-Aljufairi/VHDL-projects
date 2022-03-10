library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_counter is
port(clk: in std_logic;
	  reset: in std_logic;
	  ce: in std_logic;
	  z: out std_logic_vector(7 downto 0));
end up_counter;

architecture rtl of up_counter is

signal count: integer range 0 to 255 := 0;

begin

z <= std_logic_vector(to_unsigned(count, 8));

process(clk, reset)
begin
	if reset='1' then
		count<= 0;
	elsif rising_edge(clk) then
		if ce = '1' then
			if count = 255 then
				count <= 0;
			else
				count <= count + 1;
			end if;
		end if;
	end if;
	
end process;
end rtl;