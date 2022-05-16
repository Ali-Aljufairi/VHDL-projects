LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY REG IS
  PORT (
    clk, en : IN std_logic;
    datain : IN std_logic_vector(31 DOWNTO 0);
    dataout : OUT std_logic_vector(31 DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE reg OF REG IS
BEGIN
  PROCESS (clk) IS
  BEGIN
    IF rising_edge(clk) THEN
      IF en = '1' THEN
        dataout <= datain;
      END IF;
    END IF;
  END PROCESS;
END ARCHITECTURE;