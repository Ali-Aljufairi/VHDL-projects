LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY alu IS
  GENERIC (n : integer := 16);
  PORT (
    a, b : IN std_logic_vector(n - 1 DOWNTO 0);
    op_code : IN std_logic_vector (2 DOWNTO 0);
    f : OUT std_logic_vector(n - 1 DOWNTO 0);
    c_flag, z_flag, n_flag : INOUT std_logic;
    c_flag_en, z_flag_en, n_flag_en : IN std_logic;
    alu_en, rst, jz, jn, jc : IN std_logic;
    int : IN std_logic;
    rti : IN std_logic
  );

END ENTITY;

ARCHITECTURE rtl OF alu IS
  COMPONENT partA IS
    GENERIC (n : integer := 16);
    PORT (
      a : IN std_logic_vector(n - 1 DOWNTO 0);
      op_code : IN std_logic_vector (2 DOWNTO 0);
      f : OUT std_logic_vector(n - 1 DOWNTO 0);
      c_flag, z_flag, n_flag : INOUT std_logic;
      c_flag_en, z_flag_en, n_flag_en : IN std_logic;
      alu_en : IN std_logic
    );

  END COMPONENT;

  COMPONENT partB IS
    GENERIC (n : integer := 16);
    PORT (
      a, b : IN std_logic_vector(n - 1 DOWNTO 0);
      op_code : IN std_logic_vector (2 DOWNTO 0);
      f : OUT std_logic_vector(n - 1 DOWNTO 0);
      c_flag, z_flag, n_flag : INOUT std_logic;
      c_flag_en, z_flag_en, n_flag_en : IN std_logic;
      alu_en : IN std_logic
    );
  END COMPONENT;

  SIGNAL x1, x2 : std_logic_vector(n - 1 DOWNTO 0);
  SIGNAL c1, z1, n1, c2, z2, n2 : std_logic;
  SIGNAL Store_CF, Store_ZF, Store_NF : std_logic;
  SIGNAL en1, en2, cen1, zen1, nen1, cen2, zen2, nen2 : std_logic;
BEGIN
  u0 : partA PORT MAP(a, op_code, x1, c1, z1, n1, cen1, zen1, nen1, en1);
  u1 : partB PORT MAP(a, b, op_code, x2, c2, z2, n2, cen2, zen2, nen2, en2);

  en1 <= '1' WHEN (alu_en = '1') AND (op_code(2) = '0')
    ELSE '0';

  en2 <= '1' WHEN (alu_en = '1') AND (op_code(2) = '1')
    ELSE '0';

  cen1 <= '1' WHEN (c_flag_en = '1') AND (op_code(2) = '0')
    ELSE '0';

  zen1 <= '1' WHEN (z_flag_en = '1') AND (op_code(2) = '0')
    ELSE '0';

  nen1 <= '1' WHEN (n_flag_en = '1') AND (op_code(2) = '0')
    ELSE '0';

  cen2 <= '1' WHEN (c_flag_en = '1') AND (op_code(2) = '1')
    ELSE '0';

  zen2 <= '1' WHEN (z_flag_en = '1') AND (op_code(2) = '1')
    ELSE '0';

  nen2 <= '1' WHEN (n_flag_en = '1') AND (op_code(2) = '1')
    ELSE '0';

  f <= (OTHERS => '0') WHEN (rst = '1')
    ELSE x1 WHEN en1 = '1'
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

  c_flag <= '0' WHEN (rst = '1') OR (jc = '1')
    ELSE c1 WHEN (en1 = '1') AND (cen1 = '1')
    ELSE c2 WHEN (en2 = '1') AND (cen2 = '1')
    ELSE Store_CF WHEN rti = '1'
    ELSE c_flag;

  z_flag <= '0' WHEN (rst = '1') OR (jz = '1')
    ELSE z1 WHEN (en1 = '1') AND (zen1 = '1')
    ELSE z2 WHEN (en2 = '1') AND (zen2 = '1')
    ELSE Store_ZF WHEN rti = '1'
    ELSE z_flag;

  n_flag <= '0' WHEN (rst = '1') OR (jn = '1')
    ELSE n1 WHEN (en1 = '1') AND (nen1 = '1')
    ELSE n2 WHEN (en2 = '1') AND (nen2 = '1')
    ELSE Store_NF WHEN rti = '1'
    ELSE n_flag;
END ARCHITECTURE;