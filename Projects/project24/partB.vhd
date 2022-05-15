Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity partB is 
	GENERIC (n : integer := 16);
	port(
		a,b : in std_logic_vector(n-1 downto 0);
		op_code : in std_logic_vector (2 downto 0);
		f : out std_logic_vector(n-1 downto 0);
		c_flag,z_flag,n_flag : inout std_logic;
		c_flag_en,z_flag_en,n_flag_en: in std_logic;
		alu_en: in std_logic
	);
end entity;

architecture partB_Arch of partB is

Component n_adder  IS
PORT (
a,b : IN  std_logic_vector(n-1 downto 0);
cin : IN std_logic;
f : OUT std_logic_vector(n-1 downto 0);
cout: OUT std_logic 
);
end Component;
signal temp,res,b1: std_logic_vector(n-1 downto 0);
signal cout,cin: std_logic;
begin
b1<=not b WHEN (op_code="100") ELSE b;
cin<='1' WHEN (op_code="100") ELSE '0';
u0: n_adder GENERIC MAP(n) PORT MAP(a,b1,cin,res,cout);
		process(alu_en,op_code,a,b,res)
		begin
			if(alu_en='1') then
				case op_code is
	 				when "100" =>
					temp<=res;
 					when "101" =>
 					temp<= a and b;
 					when "110" =>
					temp<=res;
 					when others => NULL;
				end case;
			else null;
			end if;
		end process;

		process(alu_en,op_code,a,b,c_flag_en,temp)
		begin
			if(alu_en='1') and (c_flag_en='1') then
				if(op_code="111")  then
					c_flag<='1';
				elsif(op_code="100") or(op_code="110")  then
					c_flag<=cout;
				else null;
				end if;
			else null;
			end if;
		end process;

		process(alu_en,op_code,a,b,z_flag_en,temp)
		begin
			if(alu_en='1') and (z_flag_en='1') then
			if (temp(n-1 downto 0) = (temp(n-1 downto 0)'range => '0')) then
					z_flag<='1';
				else z_flag<='0';
				end if;
			else null;
			end if;
		end process;

		process(alu_en,op_code,a,b,n_flag_en,temp)
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