library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seq_counter_moore_tb is 

end seq_counter_moore_tb;



architecture rtl of seq_counter_moore_tb is 

---------------componets-----------------

component seq_counter_moore is 
port(
		clk: in std_logic;
		ce: in std_logic;
		reset: in std_logic;
		count: out std_logic_vector(1 downto 0)

);
end component;
--------------signals and contstants------------------
--the vairaible of componeps not vsiable that way we make new constants
signal clk, ce, reset: std_logic:='0';
signal count: std_logic_vector(1 downto 0):= "00";

begin 

--------------genrate clock------------------
process
begin
clk <= '1';
for i in 0 to 7 loop 
			clk <= not clk;
			wait for 1ns;
	end loop;
wait;

end process;
 
---------------stimlus process------------------
process
begin 
reset <= '0'; 
	for i in 0 to 3 loop 
			ce <= '1';
			wait for 2ns;
	end loop;
wait;
end process;
--------------------connection--------------------------
uut: seq_counter_moore port map( clk, ce, reset, count);
															


end rtl; 