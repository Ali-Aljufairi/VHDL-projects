library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- when up_down is 1 count up, when 0 count down
entity up_down_counter is
port(clk: in std_logic;
	  reset: in std_logic;
	  ce: in std_logic;
	  up_down: in std_logic;
	  z: out std_logic_vector(7 downto 0));
end up_down_counter;

architecture rtl of up_down_counter is

signal count: integer range 0 to 255 := 0;

begin

z <= std_logic_vector(to_unsigned(count, 8));

process(clk, reset)
begin
	if reset='1' then
		count<= 0;
	elsif rising_edge(clk) then
		if ce = '1' then
			if up_down = '1' then
				if count = 255 then
					count <= 0;
				else
					count <= count + 1;
				end if;
			else
				if count = 0 then
					count <= 255;
				else
					count <= count - 1;
				end if;
			end if;
		end if;
	end if;
	
end process;
end rtl;