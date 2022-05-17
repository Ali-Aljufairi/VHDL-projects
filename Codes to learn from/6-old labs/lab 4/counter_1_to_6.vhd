LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY counter_1to6 IS
  PORT (
    clk : IN std_logic;
    reset : IN std_logic;
    ce : IN std_logic;
    overflow : OUT std_logic;
    counter : OUT std_logic_vector(3 DOWNTO 0)
  );
END counter_1to6;
ARCHITECTURE rtl OF counter_1to6 IS
  SIGNAL countsig : integer RANGE 1 TO 6 := 1;
  SIGNAL overflow_i : std_logic := '0';
BEGIN
  overflow <= overflow_i;
  counter <= std_logic_vector(to_unsigned(countsig, 4));
  PROCESS (reset, clk)
  BEGIN
    IF reset = '0' THEN
      countsig <= 1;
      overflow_i <= '0';
    ELSIF rising_edge(clk) THEN
      IF ce = '1' THEN
        IF countsig = 6 THEN
          countsig <= 1;
          overflow_i <= '1';
        ELSE
          countsig <= countsig + 1;
          overflow_i <= '0';
        END IF;
      ELSE
        countsig <= countsig;
        overflow_i <= '0';
      END IF;
    END IF;
  END PROCESS;

END rtl;