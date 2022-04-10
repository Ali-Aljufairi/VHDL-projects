LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY seq_counter_moore IS
  PORT (
    clk : IN std_logic;
    ce : IN std_logic;
    reset : IN std_logic;
    count : OUT std_logic_vector(1 DOWNTO 0)

  );
END seq_counter_moore;
ARCHITECTURE rtl OF seq_counter_moore IS

  ---------signals and state---------------------
  TYPE state_type IS (s0, s1, s2, s3);
  SIGNAL state, next_state : state_type := s0;

BEGIN

  -----------register--------------
  PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      state <= next_state;
    END IF;
  END PROCESS;

  ----------next_state-------------
  PROCESS (state, ce, reset)
  BEGIN
    next_state <= s0;

    IF reset = '1' THEN
      next_state <= s0;

    ELSIF state = s0 THEN
      IF ce = '0' THEN
        next_state <= s0;
      ELSIF ce = '1' THEN
        next_state <= s1;
      END IF;

    ELSIF state = s1 THEN
      IF ce = '0' THEN
        next_state <= s1;
      ELSIF ce = '1' THEN
        next_state <= s2;
      END IF;

    ELSIF state = s2 THEN
      IF ce = '0' THEN
        next_state <= s2;
      ELSIF ce = '1' THEN
        next_state <= s3;
      END IF;
    ELSIF state = s3 THEN
      IF ce = '0' THEN
        next_state <= s3;
      ELSIF ce = '1' THEN
        next_state <= s0;
      END IF;
    END IF;
  END PROCESS;

  -------------Output logic-----------------
  PROCESS (state)
  BEGIN
    count <= "00";

    IF state = s0 THEN
      count <= "00";

    ELSIF state = s1 THEN
      count <= "11";

    ELSIF state = s2 THEN
      count <= "10";

    ELSIF state = s3 THEN
      count <= "01";

    END IF;
  END PROCESS;

END rtl;