LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY seq_detector IS
  PORT (
    clk : IN std_logic;
    X : IN std_logic;
    Y : OUT std_logic);
END ENTITY;

ARCHITECTURE rtl OF seq_detector IS

  TYPE state_type IS (s0, s1, s2);
  SIGNAL state, next_state : state_type := s0;
BEGIN

  PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      state <= next_state;
    END IF;
  END PROCESS;

  PROCESS (state, x)
  BEGIN
    next_state <= s0;
    y <= '0';
    IF state = s0 THEN
      IF x = '1' THEN
        next_state <= s1;
      END IF;
    ELSIF state = s1 THEN
      IF x = '1' THEN
        next_state <= s2;
      END IF;
    ELSE
      IF x = '1' THEN
        next_state <= s2;
      ELSE
        y <= '1';
      END IF;
    END IF;
  END PROCESS;
END rtl;