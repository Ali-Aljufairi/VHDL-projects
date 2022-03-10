library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_mult is
port(addr: in std_logic_vector(3 downto 0);
	  data: out std_logic_vector(3 downto 0)
);
end rom_mult;

architecture rtl of rom_mult is

type rom is array(0 to 15) of std_logic_vector(3 downto 0);
constant MY_ROM: rom:=(
	0 => x"0",
	1 => x"0",
	2 => x"0",
	3 => x"0",
	4 => x"0",
	5 => x"1",
	6 => x"2",
	7 => x"3",
	8 => x"0",
	9 => x"2",
	10 => x"4",
	11 => x"6",
	12 => x"0",
	13 => x"3",
	14 => x"6",
	15 => x"9"
	);
	
begin
process(addr)
begin
	--data <= mul(to_integer(unsigned(addr))); can use this instead of case

	case addr is
		when x"0" =>
			data <= MY_ROM(0);
		when x"1" =>
			data <= MY_ROM(1);			
		when x"2" =>
			data <= MY_ROM(2);
		when x"3" =>
			data <= MY_ROM(3);
		when x"4" =>
			data <= MY_ROM(4);
		when x"5" =>
			data <= MY_ROM(5);			
		when x"6" =>
			data <= MY_ROM(6);
		when x"7" =>
			data <= MY_ROM(7);
		when x"8" =>
			data <= MY_ROM(8);
		when x"9" =>
			data <= MY_ROM(9);			
		when x"a" =>
			data <= MY_ROM(10);
		when x"b" =>
			data <= MY_ROM(11);
		when x"c" =>
			data <= MY_ROM(12);
		when x"d" =>
			data <= MY_ROM(13);			
		when x"e" =>
			data <= MY_ROM(14);
		when others =>
			data <= MY_ROM(15);
		end case;
end process;
end rtl;