library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequence_detector_mealy is	--sequence to  be detected is 101
port(x: in std_logic;
	  clk: in std_logic;
	  y: out std_logic

);
end sequence_detector_mealy;

architecture rtl of sequence_detector_mealy is

type state_type is (s0, s1, s2);
signal state, next_state: state_type := s0;

begin
process(clk) --synchronous process (register)
begin
if rising_edge(clk) then
	state <= next_state;
end if;
end process;


process(x, state) --next state/output decode process
begin
next_state <= s0; --always start by declaring default value of output
y <= '0';			--default output

if state = s0 then
	if x = '1' then 
		next_state <= s1; --y already 0
	end if;
elsif state = s1 then
	if x = '1' then 
		next_state <= s1;
	else
		next_state <= s2;
	end if;
else
	if x ='1' then
		next_state <= s1;
		y <= '1';
	end if;
end if;
end process;

end rtl;