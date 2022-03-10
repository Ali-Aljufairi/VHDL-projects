library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity seq_counter_moore is 
port(
		clk: in std_logic;
		ce: in std_logic;
		reset: in std_logic;
		count: out std_logic_vector(1 downto 0)

);
end seq_counter_moore;


architecture rtl of  seq_counter_moore is 

---------signals and state---------------------
type state_type is (s0, s1, s2,s3);
signal state, next_state: state_type := s0;

begin 

-----------register--------------
process(clk)
begin 
if rising_edge(clk) then 
	state <= next_state;
end if;
end process;

----------next_state-------------
process(state,ce, reset)
begin 
next_state <= s0;
	
	if reset = '1' then
		next_state <= s0;
		
	elsif state = s0 then
		 if ce= '0' then 
			next_state <= s0;
		 elsif ce = '1' then 
			next_state <= s1;
		end if;
		
	elsif state = s1 then 
		if ce = '0' then 
			next_state <= s1;
		elsif ce ='1'  then 
			next_state <= s2;
		end if;
		
	elsif state = s2 then 
		if ce = '0' then 
			next_state <= s2;
		elsif ce ='1'  then 
			next_state <= s3;
		end if;
		
		
	elsif state = s3 then 
		if ce = '0' then 
			next_state <= s3;
		elsif ce ='1'  then 
			next_state <= s0;
		end if;
	end if ;
end process;

-------------Output logic-----------------
process(state)
begin 
count <= "00";
		
	if state = s0 then 
		count <= "00";
		
	elsif state = s1 then 
		count <= "11";
		
	elsif state = s2 then 
		count <= "10";
		
	elsif state = s3 then 
		count <= "01";
		
	end if;
end process;

end rtl;




