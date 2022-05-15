LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY MUX_2_4 IS
  GENERIC (n : integer := 32);
  PORT (
    In1, In2, In3, In4 : IN std_logic_vector(n - 1 DOWNTO 0);
    sel1, sel2 : IN std_logic;
    out_data : OUT std_logic_vector(n - 1 DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE mux_2_4 OF MUX_2_4 IS
BEGIN
  out_data <= In1 WHEN sel1 = '0' AND sel2 = '0' ELSE
    In2 WHEN sel1 = '0' AND sel2 = '1' ELSE
    In3 WHEN sel1 = '1' AND sel2 = '0' ELSE
    In4;
END ARCHITECTURE;