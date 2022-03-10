LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fsm IS PORT (
    clk, x : IN STD_LOGIC;
    ce : OUT STD_LOGIC
);

END ENTITY;
ARCHITECTURE rtl OF fsm IS
    TYPE states IS (s0, s1);
    SIGNAL state, nextstate : states := s0;

BEGIN
    PROCESS (state, x)
    BEGIN

        nextstate <= s0;
        ce <= '0';
        CASE state IS

            WHEN s0 => IF x = '0' THEN
                nextstate <= s1;
        END IF;

        WHEN s1 => IF x = '0' THEN
        nextstate <= s1;
    ELSE
        ce <= '1';
    END IF;
    WHEN OTHERS => nextstate <= s0;
    ce <= '0';

END CASE;
END PROCESS;
PROCESS (clk) BEGIN
    IF rising_edge(clk) THEN
        state <= nextstate;
    END IF;
END PROCESS;

END rtl;