Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity partA is 
	GENERIC (n : integer := 16);
	port(
		a : in std_logic_vector(n-1 downto 0);
		op_code : in std_logic_vector (2 downto 0);
		f : out std_logic_vector(n-1 downto 0);
		c_flag,z_flag,n_flag : inout std_logic;
		c_flag_en,z_flag_en,n_flag_en: in std_logic;
		alu_en: in std_logic
	);
end entity;

architecture partA_Arch of partA is
	signal temp: std_logic_vector(n downto 0);
	begin
		process(alu_en,op_code,a)
		begin
			if(alu_en='1') then
				case op_code is
					when "000" =>
					NULL;
	 				when "001" =>
 					temp <= '0' & not a;
 					when "010" =>
 					temp <= '0' & a + 1;
 					when "011" =>
 					temp <= '0' & a;
 					when others => NULL;
				end case;
			else null;
			end if;
		end process;

		process(alu_en,op_code,a,c_flag_en,temp)
		begin
			if(alu_en='1') and (c_flag_en='1') then
				if(op_code="010") then
					c_flag<=temp(n);
				else null;
				end if;
			else null;
			end if;
		end process;

		process(alu_en,op_code,a,z_flag_en,temp)
		begin
			if(alu_en='1') and (z_flag_en='1') then
				if (temp(n-1 downto 0) = (temp(n-1 downto 0)'range => '0')) then
					z_flag<='1';
				else z_flag<='0';
				end if;
			else null;
			end if;
		end process;

		process(alu_en,op_code,a,n_flag_en,temp)
		begin
			if(alu_en='1') and (n_flag_en='1') then
				if (temp(n-1)='1') then
					n_flag<='1';
				else n_flag<='0';
				end if;
			else null;
			end if;
		end process;
		process(alu_en,temp)
		begin
		if(alu_en='1') then
		f<=temp(n-1 downto 0);
		else null;
		end if;
		end process;

end architecture;