LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FA IS
  PORT (
    a, b, IN std_logic;
    c, d : OUT std_logic);
END ENTITY;

ARCHITECTURE Behavioral OF FA IS
BEGIN

  c <= a XOR b;
  d <= a AND b;

END ARCHITECTURE;