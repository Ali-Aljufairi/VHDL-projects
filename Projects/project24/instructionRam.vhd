
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ITCE364project.ALL;

ENTITY instructionRam IS

  PORT (
    address : IN std_logic_vector(31 DOWNTO 0);
    dataout : OUT std_logic_vector(31 DOWNTO 0));
END ENTITY;
ARCHITECTURE instructionMem OF instructionRam IS

  SIGNAL ram : ram_type;
BEGIN
  dataout(31 DOWNTO 16) <= ram(to_integer(unsigned(address)));
  dataout(15 DOWNTO 0) <= ram(to_integer(unsigned(address) + 1));
END ARCHITECTURE;