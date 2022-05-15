library ieee;
use ieee.std_logic_1164.all;
ENTITY JMP_DETECT IS
PORT(
branch_en,call_en:in std_logic;
op_code: in std_logic_vector(2 downto 0);
c_flag,z_flag,n_flag: in std_logic;
jc,jz,jn: out std_logic;
address: in std_logic_vector(15 downto 0);
PC: out std_logic_vector (31 downto 0);
jmp: out std_logic
);
END ENTITY;

ARCHITECTURE JMP_DETECT_ARCH OF JMP_DETECT IS
BEGIN

process(branch_en, call_en,op_code,address)
begin
if(branch_en='1') then
if(op_code="000") and (z_flag='1') then
PC<="0000000000000000"&address;
jz<='1';
jmp<='1';
elsif(op_code="001") and (n_flag='1') then
PC<="0000000000000000"&address;
jn<='1';
jmp<='1';
elsif(op_code="010") and (c_flag='1') then
PC<="0000000000000000"&address;
jc<='1';
jmp<='1';
elsif(op_code="011") then
PC<="0000000000000000"&address;
jmp<='1';
else
jmp<='0';
jz<='0';
jn<='0';
jc<='0';
end if;
elsif (call_en='1') then
jmp<='1';
PC<="0000000000000000"&address;
else
jmp<='0';
jz<='0';
jn<='0';
jc<='0';
end if;
end process;


END JMP_DETECT_ARCH;