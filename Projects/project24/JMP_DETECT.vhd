LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY JMP_DETECT IS
  PORT (
    branch_en, call_en : IN std_logic;
    op_code : IN std_logic_vector(2 DOWNTO 0);
    c_flag, z_flag, n_flag : IN std_logic;
    jc, jz, jn : OUT std_logic;
    address : IN std_logic_vector(15 DOWNTO 0);
    PC : OUT std_logic_vector (31 DOWNTO 0);
    jmp : OUT std_logic
  );
END ENTITY;

ARCHITECTURE JMP_DETECT_ARCH OF JMP_DETECT IS
BEGIN

  PROCESS (branch_en, call_en, op_code, address)
  BEGIN
    IF (branch_en = '1') THEN
      IF (op_code = "000") AND (z_flag = '1') THEN
        PC <= "0000000000000000" & address;
        jz <= '1';
        jmp <= '1';
      ELSIF (op_code = "001") AND (n_flag = '1') THEN
        PC <= "0000000000000000" & address;
        jn <= '1';
        jmp <= '1';
      ELSIF (op_code = "010") AND (c_flag = '1') THEN
        PC <= "0000000000000000" & address;
        jc <= '1';
        jmp <= '1';
      ELSIF (op_code = "011") THEN
        PC <= "0000000000000000" & address;
        jmp <= '1';
      ELSE
        jmp <= '0';
        jz <= '0';
        jn <= '0';
        jc <= '0';
      END IF;
    ELSIF (call_en = '1') THEN
      jmp <= '1';
      PC <= "0000000000000000" & address;
    ELSE
      jmp <= '0';
      jz <= '0';
      jn <= '0';
      jc <= '0';
    END IF;
  END PROCESS;
END JMP_DETECT_ARCH;