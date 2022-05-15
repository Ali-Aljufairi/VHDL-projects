Library ieee;
use ieee.std_logic_1164.all;

entity alu is
GENERIC (n : integer := 16);
port(
		a,b : in std_logic_vector(n-1 downto 0);
		op_code : in std_logic_vector (2 downto 0);
		f : out std_logic_vector(n-1 downto 0);
		c_flag,z_flag,n_flag : inout std_logic;
		c_flag_en,z_flag_en,n_flag_en: in std_logic;
		alu_en,rst,jz,jn,jc: in std_logic;
		int: in std_logic;
		rti: in std_logic
);

end entity;

Architecture alu_arch of alu is
Component partA is
port(
		a : in std_logic_vector(n-1 downto 0);
		op_code : in std_logic_vector (2 downto 0);
		f : out std_logic_vector(n-1 downto 0);
		c_flag,z_flag,n_flag : inout std_logic;
		c_flag_en,z_flag_en,n_flag_en: in std_logic;
		alu_en: in std_logic
	);

end Component;

Component partB is
port(
		a,b : in std_logic_vector(n-1 downto 0);
		op_code : in std_logic_vector (2 downto 0);
		f : out std_logic_vector(n-1 downto 0);
		c_flag,z_flag,n_flag : inout std_logic;
		c_flag_en,z_flag_en,n_flag_en: in std_logic;
		alu_en: in std_logic
	);
end Component;
 
Signal x1,x2:std_logic_vector(n-1 downto 0);
Signal c1,z1,n1,c2,z2,n2:std_logic;
SIGNAL Store_CF, Store_ZF, Store_NF: std_logic;
Signal en1,en2,cen1,zen1,nen1,cen2,zen2,nen2:std_logic;
begin
u0:partA port map (a,op_code,x1,c1,z1,n1,cen1,zen1,nen1,en1);
u1:partB port map (a,b,op_code,x2,c2,z2,n2,cen2,zen2,nen2,en2);

en1<='1' WHEN (alu_en='1') and (op_code(2)='0')
ELSE '0';

en2<='1' WHEN (alu_en='1') and (op_code(2)='1')
ELSE '0';

cen1<='1' WHEN (c_flag_en='1') and (op_code(2)='0')
ELSE '0';

zen1<='1' WHEN (z_flag_en='1') and (op_code(2)='0')
ELSE '0';

nen1<='1' WHEN (n_flag_en='1') and (op_code(2)='0')
ELSE '0';

cen2<='1' WHEN (c_flag_en='1') and (op_code(2)='1')
ELSE '0';

zen2<='1' WHEN (z_flag_en='1') and (op_code(2)='1')
ELSE '0';

nen2<='1' WHEN (n_flag_en='1') and (op_code(2)='1')
ELSE '0';

f <= (others => '0') WHEN (rst='1') 
ELSE x1 WHEN en1='1'
ELSE x2;

-- store flags on interrupts
Store_CF <= '0' WHEN rst = '1'
ELSE c_flag WHEN int = '1';

-- store flags on interrupts
Store_ZF <= '0' WHEN rst = '1'
ELSE z_flag WHEN int = '1';

-- store flags on interrupts
Store_NF <= '0' WHEN rst = '1'
ELSE n_flag WHEN int = '1';

c_flag<= '0' WHEN (rst='1') or (jc='1')
ELSE c1 WHEN (en1='1') and (cen1='1')
ELSE c2 WHEN (en2='1') and (cen2='1')
ELSE Store_CF WHEN rti = '1'
ELSE c_flag;

z_flag<= '0' WHEN (rst='1') or (jz='1')
ELSE z1 WHEN (en1='1') and (zen1='1')
ELSE z2 WHEN (en2='1') and (zen2='1')
ELSE Store_ZF WHEN rti = '1'
ELSE z_flag;

n_flag<='0' WHEN (rst='1') or (jn='1')
ELSE n1 WHEN (en1='1') and (nen1='1')
ELSE n2 WHEN (en2='1') and (nen2='1')
ELSE Store_NF WHEN rti = '1'
ELSE n_flag;
end Architecture;
