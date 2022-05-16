LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY r_Register IS
  PORT (
    Clk, Rst, enable : IN std_logic;
    d : IN std_logic_vector(15 DOWNTO 0);
    q : OUT std_logic_vector(15 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE Register_Structal OF r_Register
  IS
BEGIN
  PROCESS (Clk, Rst,enable)
  BEGIN

    IF Rst = '1' THEN
      q <= (OTHERS => '0');
    ELSIF falling_edge(Clk) AND enable = '1' THEN
      q <= d;
    END IF;

  END PROCESS;

END ARCHITECTURE;