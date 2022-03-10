library ieee;
use ieee.std_logic_1164.all;


entity click_detector_rom is
port(clk: 						in std_logic;
	  y: 					in std_logic;
	  z: 			out std_logic
	  );
end click_detector_rom;


architecture behavioural of click_detector_rom is

signal state, next_state: std_logic := '0';
signal addr, rom_out: std_logic_vector(1 downto 0);

type rom is array(0 to 3) of std_logic_vector(1 downto 0);
constant fsm: rom:=(
	0 => "10",	--memory locations of ROM
	1 => "10",
	2 => "00",
	3 => "01"
	);
	

begin

next_state <= rom_out(1);
z <= rom_out(0);

addr <= y & state;

--fsm synchronous process
process(clk)
begin
if rising_edge(clk) then
	state <= next_state;
end if;
end process;

process(addr)
begin
	case addr is
		when "00" =>
			rom_out <= fsm(0);
		when "01" =>
			rom_out <= fsm(1);			
		when "10" =>
			rom_out <= fsm(2);
		when others =>
			rom_out <= fsm(3);
		end case;
end process;
end behavioural;