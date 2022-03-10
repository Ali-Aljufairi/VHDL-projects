library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clk_divider is
port(clk_in: in std_logic;
	  clk_out: out std_logic
);
end clk_divider;

architecture rtl of clk_divider is

constant scale: integer := ((25/5)/2)-1;
signal count: integer range 0 to scale := 0;
signal clk_i: std_logic := '0';

begin
clk_out <= clk_i;
process(clk_in)
begin
	if rising_edge(clk_in) then
		if count=scale then
			count<= 0;
			clk_i<= not clk_i;
		else
			count<= count + 1;
			clk_i <= clk_i; --not nessecary
		end if;
	end if;

end process;
end rtl;