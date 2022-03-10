library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity debounce is
port(clk: 						in std_logic;
	  btn_in: 					in std_logic;
	  btn_out: 					out std_logic
	  );
end debounce;


architecture behavioural of debounce is

signal count: integer range 0 to 1000000 := 0;
signal btn_out_i: std_logic :='1';
signal reset, overflow, ce: std_logic :='0';

type state_type is (wait_0, wait_0_stable, wait_1, wait_1_stable);
signal state, next_state: state_type := wait_0; 



begin

btn_out <= btn_out_i;

---btn press counter
process(reset, clk)
begin
if reset ='1' then
	count <= 0;
	overflow <= '0';
elsif rising_edge(clk) then
	if ce='1' then
		if count = 1000000 then
			count <= 0;
			overflow <= '1';
		else
			count <= count +1;
			overflow <= '0';
		end if;
	end if;
end if;
end process;


--fsm synchronous process
process(clk)
begin
if rising_edge(clk) then
	state <= next_state;
end if;
end process;


--fsm output decode process
process(state)
begin

btn_out_i <= '1';
reset <='0';
ce <= '0';

if state = wait_0 then
	reset <= '1';
elsif state = wait_0_stable then
	ce <= '1';
elsif state = wait_1 then
	reset <= '1';
	btn_out_i <= '0';
else
	ce <= '1';
	btn_out_i <= '0';
end if;
end process;


--fsm next state decode process
process(state, overflow, btn_in)
begin

next_state <= wait_0; 

if state = wait_0 then
	if btn_in ='0' then
		next_state <= wait_0_stable;
	end if;
elsif state = wait_0_stable then
	if btn_in = '0' then
		if overflow = '1' then
			next_state <= wait_1;
		else
			next_state <= wait_0_stable;
		end if;
	end if;
elsif state = wait_1 then
	if btn_in ='1' then
		next_state <= wait_1_stable;
	else
		next_state <= wait_1;
	end if;
else
	if btn_in = '1' then
		if overflow = '1' then
			next_state <= wait_0;
		else
			next_state <= wait_1_stable;
		end if;
	else
		next_state <= wait_1;
	end if;
end if;
end process;








end behavioural;