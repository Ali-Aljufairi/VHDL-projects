library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
	port(
		a: in std_logic;	--declare inputs/outputs
		b: in std_logic;
		s: out std_logic;
		c: out std_logic
	);
end half_adder;

architecture data_flow of half_adder is --specify architecture model
begin
	
	s <= a XOR b;	--outputs
	c <= a AND b;

end data_flow;
		