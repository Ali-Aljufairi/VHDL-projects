LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memo_address_mux IS
  PORT (
    clk : IN std_logic;
    MW : IN std_logic;
    MR : IN std_logic;
    rst : IN std_logic;
    SP_en : IN std_logic;
    exception2 : IN std_logic;
    SP_used_Address : IN std_logic_vector(31 DOWNTO 0);
    ALU_res : IN std_logic_vector(15 DOWNTO 0);

    memo_address : OUT std_logic_vector(31 DOWNTO 0);
    exception1 : OUT std_logic
  );
END ENTITY memo_address_mux;

ARCHITECTURE rtl OF memo_address_mux IS

BEGIN
  PROCESS (clk, rst)IS
  BEGIN
    IF rst = '1' THEN
      exception1 <= '0';
    ELSIF falling_edge(clk) THEN
      IF (unsigned(ALU_res) > x"ff00") AND (SP_en = '0') AND ((MW = '1') OR (MR = '1'))
        THEN
        exception1 <= '1';
      ELSE
        exception1 <= '0';
      END IF;
    END IF;
  END PROCESS;

  memo_address <=
    SP_used_Address
    WHEN SP_en = '1'
    ELSE
    x"0000" & ALU_res
    ;
END ARCHITECTURE;