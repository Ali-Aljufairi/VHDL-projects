library ieee;
use ieee.std_logic_1164.all;


entity odd_checker_mealy is
port(clk: in std_logic;
	  X: in std_logic;
	  Y:	out std_logic);
end odd_checker_mealy;


architecture behavioural of odd_checker_mealy is

type state_type is (s0, s1);
signal state, next_state : state_type:= s0;



begin

--- synchronous process
process (clk) 
begin
if rising_edge(clk) then
	state <= next_state;
end if;
end process;


--- next state/output decode process
process(x, state)
begin
next_state <= s0;		--default next state
y <= '0'; 				--default output

if state = s0 then
	if x ='1' then
		next_state <= s1;
		y <= '1';
	end if;
else
	if x = '0' then
		next_state <= s1;
		y <= '1';
	end if;
end if;
end process;


end behavioural;