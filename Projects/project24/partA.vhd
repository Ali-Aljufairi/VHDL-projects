LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY partA IS
  GENERIC (n : integer := 16);
  PORT (
    a : IN std_logic_vector(n - 1 DOWNTO 0);
    op_code : IN std_logic_vector (2 DOWNTO 0);
    f : OUT std_logic_vector(n - 1 DOWNTO 0);
    c_flag, z_flag, n_flag : INOUT std_logic;
    c_flag_en, z_flag_en, n_flag_en : IN std_logic;
    alu_en : IN std_logic
  );
END ENTITY;

ARCHITECTURE partA_Arch OF partA IS
  SIGNAL temp : std_logic_vector(n DOWNTO 0);
BEGIN
  PROCESS (alu_en, op_code, a)
  BEGIN
    IF (alu_en = '1') THEN
      CASE op_code IS
        WHEN "000" =>
          NULL;
        WHEN "001" =>
          temp <= '0' & NOT a;
        WHEN "010" =>
          temp <= '0' & a + 1;
        WHEN "011" =>
          temp <= '0' & a;
        WHEN OTHERS => NULL;
      END CASE;
    ELSE NULL;
    END IF;
  END PROCESS;

  PROCESS (alu_en, op_code, a, c_flag_en, temp)
  BEGIN
    IF (alu_en = '1') AND (c_flag_en = '1') THEN
      IF (op_code = "010") THEN
        c_flag <= temp(n);
      ELSE NULL;
      END IF;
    ELSE NULL;
    END IF;
  END PROCESS;

  PROCESS (alu_en, op_code, a, z_flag_en, temp)
  BEGIN
    IF (alu_en = '1') AND (z_flag_en = '1') THEN
      IF (temp(n - 1 DOWNTO 0) = (temp(n - 1 DOWNTO 0)'RANGE => '0')) THEN
        z_flag <= '1';
      ELSE z_flag <= '0';
      END IF;
    ELSE NULL;
    END IF;
  END PROCESS;

  PROCESS (alu_en, op_code, a, n_flag_en, temp)
  BEGIN
    IF (alu_en = '1') AND (n_flag_en = '1') THEN
      IF (temp(n - 1) = '1') THEN
        n_flag <= '1';
      ELSE n_flag <= '0';
      END IF;
    ELSE NULL;
    END IF;
  END PROCESS;
  PROCESS (alu_en, temp)
  BEGIN
    IF (alu_en = '1') THEN
      f <= temp(n - 1 DOWNTO 0);
    ELSE NULL;
    END IF;
  END PROCESS;

END ARCHITECTURE;