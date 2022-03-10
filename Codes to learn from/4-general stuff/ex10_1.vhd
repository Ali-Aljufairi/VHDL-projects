library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ex10_1 is
port(clk: in std_logic;
	  X: 	in std_logic;
	  z: 	out std_logic_vector(4 downto 0)
	  );
end ex10_1;


architecture behavioural of ex10_1 is

signal state, next_state: std_logic_vector(1 downto 0) := "00";
signal addr: std_logic_vector(2 downto 0);
signal rom_out: std_logic_vector(6 downto 0) := (others => '0');

type rom is array(0 to 7) of std_logic_vector(6 downto 0);
constant fsm: rom:=(
	0 => "1000000",	--memory locations of ROM
	1 => "1000000",
	2 => "0100000",
	3 => "0100010",
	4 => "0011000",
	5 => "0010110",
	6 => "0000000",
	7 => "0000000"
	);
	

begin

next_state <= rom_out(1 downto 0);
z <= rom_out(6 downto 2);

addr <= state & x;

--fsm synchronous process
process(clk)
begin
if rising_edge(clk) then
	state <= next_state;
end if;
end process;

process(addr)
begin
	rom_out <= fsm(to_integer(unsigned(addr)));
end process;
end behavioural;