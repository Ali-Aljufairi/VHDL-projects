LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY check IS
  PORT (
    load_use_case, signal1, signal2 : IN std_logic;
    signal_out : OUT std_logic

  );
END ENTITY;

ARCHITECTURE check_structure OF check IS
BEGIN
  signal_out <= '0'WHEN load_use_case = '1' ELSE
    signal1;

END ARCHITECTURE;