LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SP_entity IS
  PORT (
    rst, clk : IN std_logic;
    datain : IN std_logic_vector(31 DOWNTO 0);
    dataout : OUT std_logic_vector(31 DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE SP_instance OF SP_entity IS
BEGIN
  PROCESS (clk, rst) IS
  BEGIN
    IF rst = '1' THEN
      dataout <= x"000fffff"; -- last address in memory 2^20 - 1
    ELSIF (falling_edge(clk)) THEN
      dataout <= datain;
    END IF;
  END PROCESS;
END ARCHITECTURE;