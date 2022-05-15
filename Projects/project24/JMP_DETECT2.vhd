LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY JMP_DETECT2 IS
  PORT (
    branch_en : IN std_logic;
    op_code : IN std_logic_vector(2 DOWNTO 0);
    c_flag, z_flag, n_flag : IN std_logic;
    jc, jz, jn : OUT std_logic;
    address : IN std_logic_vector(15 DOWNTO 0);
    PC : OUT std_logic_vector (31 DOWNTO 0);
    jmp : OUT std_logic
  );
END ENTITY;

ARCHITECTURE JMP_DETECT_ARCH OF JMP_DETECT2 IS
BEGIN

  PC <= "0000000000000000" & address WHEN branch_en = '1' AND op_code = "000" AND z_flag = '1'
    ELSE "0000000000000000" & address WHEN branch_en = '1' AND op_code = "001" AND n_flag = '1'
    ELSE "0000000000000000" & address WHEN branch_en = '1' AND op_code = "010" AND c_flag = '1'
    ELSE "0000000000000000" & address WHEN branch_en = '1' AND op_code = "011";

  jmp <= '1' WHEN branch_en = '1' AND op_code = "000" AND z_flag = '1'
    ELSE '1' WHEN branch_en = '1' AND op_code = "001" AND n_flag = '1'
    ELSE '1' WHEN branch_en = '1' AND op_code = "010" AND c_flag = '1'
    ELSE '1' WHEN branch_en = '1' AND op_code = "011"
    ELSE '0';

  jz <= '1' WHEN branch_en = '1' AND op_code = "000" AND z_flag = '1'
    ELSE '0';

  jn <= '1' WHEN branch_en = '1' AND op_code = "001" AND n_flag = '1'
    ELSE '0';

  jc <= '1' WHEN branch_en = '1' AND op_code = "010" AND c_flag = '1'
    ELSE '0';
END JMP_DETECT_ARCH;