library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seq_detector is
port
	(	clk		  : in std_logic;
		X		   : in std_logic;
		Y		  : out std_logic);
end entity;

architecture rtl of seq_detector is

type state_type is (s0, s1, s2);
Signal state, next_state: state_type :=s0;


begin

process(clk)
begin
if rising_edge(clk) then
state <= next_state;
end if;
end process;

fff


process(state, x)
begin
next_state <= s0;
y <= '0';
if state = s0 then
	if x = '1' then 
		next_state <= s1;
	end if;
elsif state =s1 then
	if x = '1' then
		next_state <= s2;
	end if;
else
	if x = '1' then
		next_state <= s2;
	else
		y <= '1';
	end if;
end if;
end process;


end rtl;

