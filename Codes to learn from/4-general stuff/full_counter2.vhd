library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- when up_down is 1 count up, when 0 count down, load asynchronous
entity full_counter is
port(clk: in std_logic;
	  reset: in std_logic;
	  ce: in std_logic;
	  up_down: in std_logic;
	  load: in std_logic;
	  data_in: in std_logic_vector(7 downto 0);
	  overflow: out std_logic := '0';
	  z: out std_logic_vector(7 downto 0));
end full_counter;

architecture rtl of full_counter is

signal count: integer range 0 to 255 := 0;

begin

z <= std_logic_vector(to_unsigned(count, 8));

process(clk, reset, load)
begin
	if reset='1' then
		count<= 0;
	elsif load = '1' then
		count <= to_integer(unsigned(data_in));
	elsif rising_edge(clk) then
		if ce = '1' then
			if up_down = '1' then
				if count = 255 then
					count <= 0;
					overflow <= '1';
				else
					count <= count + 1;
					overflow <= '0';
				end if;
			else
				if count = 0 then
					count <= 255;
					overflow <= '1';
				else
					count <= count - 1;
					overflow <= '0';
				end if;
			end if;
		end if;
	end if;
	
end process;
end rtl;