LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ITCE364project.ALL;
ENTITY tristate IS

  PORT (
    en : IN std_logic;
    intri : IN std_logic_vector(op_size - 1 DOWNTO 0);
    outtri : OUT std_logic_vector(op_size - 1 DOWNTO 0));
END tristate;

ARCHITECTURE triArch OF tristate IS
BEGIN
  outtri <= intri WHEN en = '1'
    ELSE (OTHERS => 'Z');
END triArch;