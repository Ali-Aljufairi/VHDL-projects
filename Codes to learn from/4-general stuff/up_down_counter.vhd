LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
-- when up_down is 1 count up, when 0 count down
ENTITY up_down_counter IS
  PORT (
    clk : IN std_logic;
    reset : IN std_logic;
    ce : IN std_logic;
    up_down : IN std_logic;
    z : OUT std_logic_vector(7 DOWNTO 0));
END up_down_counter;

ARCHITECTURE rtl OF up_down_counter IS

  SIGNAL count : integer RANGE 0 TO 255 := 0;

BEGIN

  z <= std_logic_vector(to_unsigned(count, 8));

  PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count <= 0;
    ELSIF rising_edge(clk) THEN
      IF ce = '1' THEN
        IF up_down = '1' THEN
          IF count = 255 THEN
            count <= 0;
          ELSE
            count <= count + 1;
          END IF;
        ELSE
          IF count = 0 THEN
            count <= 255;
          ELSE
            count <= count - 1;
          END IF;
        END IF;
      END IF;
    END IF;

  END PROCESS;
END rtl;