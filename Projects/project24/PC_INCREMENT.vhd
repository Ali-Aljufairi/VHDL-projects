LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ITCE364project.ALL;

ENTITY PC_INCREMENT IS
  PORT (
    old_PC : IN std_logic_vector(width_size DOWNTO 0);
    selector : IN std_logic;
    new_PC : OUT std_logic_vector(width_size DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE rtl OF PC_INCREMENT IS
BEGIN
  new_PC <= std_logic_vector(unsigned(old_PC) + 1) WHEN selector = '0'
    ELSE std_logic_vector(unsigned(old_PC) + 2);
END ARCHITECTURE;