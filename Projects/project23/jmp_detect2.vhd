library ieee;
use ieee.std_logic_1164.all;
ENTITY JMP_DETECT2 IS
PORT(
branch_en:in std_logic;
op_code: in std_logic_vector(2 downto 0);
c_flag,z_flag,n_flag: in std_logic;
jc,jz,jn: out std_logic;
address: in std_logic_vector(15 downto 0);
PC: out std_logic_vector (31 downto 0);
jmp: out std_logic
);
END ENTITY;

ARCHITECTURE JMP_DETECT_ARCH OF JMP_DETECT2 IS
BEGIN

PC<="0000000000000000"&address WHEN branch_en='1' and op_code="000" and z_flag='1' 
ELSE "0000000000000000"&address WHEN branch_en='1' and op_code="001" and n_flag='1' 
ELSE "0000000000000000"&address WHEN branch_en='1' and op_code="010" and c_flag='1' 
ELSE "0000000000000000"&address WHEN branch_en='1' and op_code="011";

jmp <= '1' WHEN branch_en='1' and op_code="000" and z_flag='1' 
ELSE '1' WHEN branch_en='1' and op_code="001" and n_flag='1' 
ELSE '1' WHEN branch_en='1' and op_code="010" and c_flag='1' 
ELSE '1' WHEN branch_en='1' and op_code="011"
ELSE '0';

jz <='1' WHEN branch_en='1' and op_code="000" and z_flag='1' 
ELSE '0';

jn<='1' WHEN branch_en='1' and op_code="001" and n_flag='1' 
ELSE '0';

jc<='1' WHEN branch_en='1' and op_code="010" and c_flag='1' 
ELSE '0';


END JMP_DETECT_ARCH;
