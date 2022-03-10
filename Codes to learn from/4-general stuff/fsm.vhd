library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
port(x: in std_logic;
	  overflow: in std_logic;
	  clk: in std_logic;
	  ce: out std_logic;
	  reset: out std_logic;
	  y: out std_logic

);
end fsm;

architecture rtl of fsm is

type state_type is (wait_0, wait_0_stable, wait_1, wait_1_stable);
signal state, next_state: state_type := wait_0;

begin
process(clk) --synchronous process (register)
begin
if rising_edge(clk) then
	state <= next_state;
end if;
end process;

process(state) -- output decode process (output logic)
begin
y <= '1'; --always start by declaring default value of output
ce <= '0';
reset <= '0';
if state = wait_0 then
	reset <= '1';
elsif state = wait_0_stable then
	ce <= '1';
elsif state = wait_1 then
	reset <= '1';
	y <= '0';
else
	ce <= '1';
	y <= '0';
end if;
end process;

process(x, state) --next state decode process (next state logic)
begin
next_state <= wait_0; --always start by declaring default value of output
if state = wait_0 then
	if x = '0' then
		next_state <= wait_0_stable;
	end if;
elsif state = wait_0_stable then
	if overflow = '1' then
		next_state <= wait_1;
	else
		if x = '0' then
			next_state <= wait_1;
		end if;
	end if;
elsif state = wait_1 then
	if x = '0' then
		next_state <= wait_1;
	else
		next_state <= wait_1_stable;
	end if;
else
	if overflow = '0' then 
		next_state <= wait_1_stable;
	else
		if x = '0' then
			next_state <= wait_1;
		else
			next_state <= wait_1_stable;
		end if;
	end if;
end if;
		

end process;

end rtl;