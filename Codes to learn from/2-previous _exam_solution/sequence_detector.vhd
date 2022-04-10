LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sequence_detector IS --sequence to  be detected is 101
  PORT (
    x : IN std_logic;
    clk : IN std_logic;
    y : OUT std_logic

  );
END sequence_detector;

ARCHITECTURE rtl OF sequence_detector IS

  TYPE state_type IS (s0, s1, s2, s3);
  SIGNAL state, next_state : state_type := s0;

BEGIN
  PROCESS (clk) --synchronous process (register)
  BEGIN
    IF rising_edge(clk) THEN
      state <= next_state;
    END IF;
  END PROCESS;

  PROCESS (state) -- output decode process (output logic)
  BEGIN
    y <= '0'; --always start by declaring default value of output
    IF state = s3 THEN
      y <= '1';
    END IF;
  END PROCESS;

  PROCESS (x, state) --next state decode process (next state logic)
  BEGIN
    next_state <= s0; --always start by declaring default value of output
    IF state = s0 THEN
      IF x = '1' THEN
        next_state <= s1;
      END IF;
    ELSIF state = s1 THEN
      IF x = '0' THEN
        next_state <= s2;
      ELSE
        next_state <= s1;
      END IF;
    ELSIF state = s2 THEN
      IF x = '1' THEN
        next_state <= s3;
      END IF;
    ELSE
      IF x = '0' THEN
        next_state <= s2;
      ELSE
        next_state <= s1;
      END IF;
    END IF;
  END PROCESS;

END rtl;