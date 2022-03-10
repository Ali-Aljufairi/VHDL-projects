library ieee;
use ieee.std_logic_1164.all;

entity decoder_2_4 is
port(a: in std_logic_vector(1 downto 0);
		b: out std_logic_vector(3 downto 0));
end entity decoder_2_4;

architecture behavioural of decoder_2_4 is
begin
process(a)
	begin
		
		case a is 
			when "00" =>
				b <= "0001";
			when "01" =>
				b <= "0010";
			when "10" =>
				b <= "0100";
			when others =>
				b <= "1000";
		end case;
			
end process;
end architecture;
	