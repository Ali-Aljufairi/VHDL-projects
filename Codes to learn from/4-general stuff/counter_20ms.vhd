library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity counter_20ms is
port(	 clk: 					in std_logic;
	  reset: 					in std_logic;
	  ce: 					in std_logic;
	  overflow: 				out std_logic
	  );
end counter_20ms;


architecture behavioural of counter_20ms is

signal count: integer range 0 to 100000 := 0;
signal overflow_i: std_logic :='0';

begin

overflow <= overflow_i;

process(reset, clk)
begin
if reset ='1' then
	count <= 0;
	overflow_i <= '0';
elsif rising_edge(clk) then
	if ce='1' then
		if count = 100000 then
			count <= 0;
			overflow_i <= '1';
		else
			count <= count +1;
			overflow_i <= '0';
		end if;
	else
		count <= count;
		overflow_i <= '0';
	end if;
end if;
end process;
end behavioural;
