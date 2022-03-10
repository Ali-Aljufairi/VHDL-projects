library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_decoder is
port(addr: in std_logic_vector(1 downto 0);
	  data: out std_logic_vector(3 downto 0)
);
end rom_decoder;

architecture rtl of rom_decoder is

type rom is array(0 to 3) of std_logic_vector(3 downto 0);
constant MY_ROM: rom:=(
	0 => "0001",
	1 => "0010",
	2 => "0100",
	3 => "1000");
	
begin
process(addr)
begin
	case addr is
		when "00" =>
			data <= MY_ROM(0);
		when "01" =>
			data <= MY_ROM(1);			
		when "10" =>
			data <= MY_ROM(2);
		when others =>
			data <= MY_ROM(3);	
	end case;		
end process;
end rtl;