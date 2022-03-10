library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debounce is
port(x: in std_logic;
	  clk: in std_logic;
	  y: out std_logic

);
end debounce;

architecture rtl of debounce is

signal overflow_i, reset_i, ce_i: std_logic := '0';

component fsm
port(x: in std_logic;
	  overflow: in std_logic;
	  clk: in std_logic;
	  ce: out std_logic;
	  reset: out std_logic;
	  y: out std_logic);
end component;

component counter_20ms
port(	 clk: 					in std_logic;
	  reset: 					in std_logic;
	  ce: 					in std_logic;
	  overflow: 				out std_logic);
end component;

begin
fs : fsm port map(x => x,
						overflow => overflow_i,
						clk => clk,
						ce => ce_i,
						reset => reset_i,
						y => y);
c : counter_20ms port map(clk => clk,
								  reset => reset_i,
								  ce => ce_i,
								  overflow => overflow_i);

end rtl;