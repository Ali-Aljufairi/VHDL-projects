LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY odd_checker_mealy IS
  PORT (
    clk : IN std_logic;
    X : IN std_logic;
    Y : OUT std_logic);
END odd_checker_mealy;
ARCHITECTURE behavioural OF odd_checker_mealy IS

  TYPE state_type IS (s0, s1);
  SIGNAL state, next_state : state_type := s0;

BEGIN

  --- synchronous process
  PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      state <= next_state;
    END IF;
  END PROCESS;
  --- next state/output decode process
  PROCESS (x, state)
  BEGIN
    next_state <= s0; --default next state
    y <= '0'; --default output

    IF state = s0 THEN
      IF x = '1' THEN
        next_state <= s1;
        y <= '1';
      END IF;
    ELSE
      IF x = '0' THEN
        next_state <= s1;
        y <= '1';
      END IF;
    END IF;
  END PROCESS;
END behavioural;