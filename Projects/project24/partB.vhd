LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY partB IS
  GENERIC (n : integer := 16);
  PORT (
    a, b : IN std_logic_vector(n - 1 DOWNTO 0);
    op_code : IN std_logic_vector (2 DOWNTO 0);
    f : OUT std_logic_vector(n - 1 DOWNTO 0);
    c_flag, z_flag, n_flag : INOUT std_logic;
    c_flag_en, z_flag_en, n_flag_en : IN std_logic;
    alu_en : IN std_logic
  );
END ENTITY;

ARCHITECTURE partB_Arch OF partB IS

  COMPONENT n_adder IS
    GENERIC (n : integer := 16);
    PORT (
      a, b : IN std_logic_vector(n - 1 DOWNTO 0);
      cin : IN std_logic;
      f : OUT std_logic_vector(n - 1 DOWNTO 0);
      cout : OUT std_logic
    );
  END COMPONENT;
  SIGNAL temp, res, b1 : std_logic_vector(n - 1 DOWNTO 0);
  SIGNAL cout, cin : std_logic;
BEGIN
  b1 <= NOT b WHEN (op_code = "100") ELSE b;
  cin <= '1' WHEN (op_code = "100") ELSE '0';
  u0 : n_adder GENERIC MAP(n) PORT MAP(a, b1, cin, res, cout);
  PROCESS (alu_en, op_code, a, b, res, cout)
  BEGIN
    IF (alu_en = '1') THEN
      CASE op_code IS
        WHEN "100" =>
          temp <= res;
        WHEN "101" =>
          temp <= a AND b;
        WHEN "110" =>
          temp <= res;
        WHEN OTHERS => NULL;
      END CASE;
    ELSE NULL;
    END IF;
  END PROCESS;

  PROCESS (alu_en, op_code, a, b, c_flag_en, temp,cout)
  BEGIN
    IF (alu_en = '1') AND (c_flag_en = '1') THEN
      IF (op_code = "111") THEN
        c_flag <= '1';
      ELSIF (op_code = "100") OR(op_code = "110") THEN
        c_flag <= cout;
      ELSE NULL;
      END IF;
    ELSE NULL;
    END IF;
  END PROCESS;

  PROCESS (alu_en, op_code, a, b, z_flag_en, temp)
  BEGIN
    IF (alu_en = '1') AND (z_flag_en = '1') THEN
      IF (temp(n - 1 DOWNTO 0) = (temp(n - 1 DOWNTO 0)'RANGE => '0')) THEN
        z_flag <= '1';
      ELSE z_flag <= '0';
      END IF;
    ELSE NULL;
    END IF;
  END PROCESS;

  PROCESS (alu_en, op_code, a, b, n_flag_en, temp)
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