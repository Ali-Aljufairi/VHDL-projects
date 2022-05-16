LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ITCE364project.ALL;

ENTITY r_Register IS
  PORT (
    Clk, Rst, enable : IN std_logic;
    d : IN std_logic_vector(opcodesize DOWNTO 0);
    q : OUT std_logic_vector(opcodesize DOWNTO 0));
END ENTITY;

ARCHITECTURE rtl OF r_Register
  IS
BEGIN
  PROCESS (Clk, Rst, enable)
  BEGIN

    IF Rst = '1' THEN
      q <= (OTHERS => '0');
    ELSIF falling_edge(Clk) THEN
      IF enable = '1' THEN
        q <= d;
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE;