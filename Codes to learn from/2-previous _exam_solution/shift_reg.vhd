
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL; -- Needed for shifts
ENTITY shift_reg IS

  PORT (
    a : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE rtl OF shift_reg IS
  SIGNAL x : unsigned(1 DOWNTO 0) := "10";
  SIGNAL allout, t : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
  SIGNAL y : INTEGER := 0;
 SIGNAL wow : unsigned(3 DOWNTO 0) := "0000";

BEGIN
  t <= a;
  y <= to_integer(x);
  wow <= shift_right(unsigned(t),y);
  B <= std_logic_vector(wow);
  
  
  END ARCHITECTURE ;
  
  