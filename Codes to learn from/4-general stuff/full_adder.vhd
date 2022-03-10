library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port(
		a: in std_logic;	--declare inputs/outputs
		b: in std_logic;
		c_in: in std_logic;
		s: out std_logic;
		c: out std_logic
	);
end full_adder;

architecture rtl of full_adder is
	signal x,y,z: std_logic := '0';
	
	component half_adder
		port(
		a: in std_logic;	--declare inputs/outputs
		b: in std_logic;
		s: out std_logic;
		c: out std_logic);
	end component;
	
begin
	
	ha1: half_adder port map(a => a,
									 b => b,
									 s => x,
									 c => y);
									 
	ha2: half_adder port map(a => x,
									 b => c_in,
									 s => s,
									 c=> z);
									 
	c <= Y OR Z;
	
end architecture;
		