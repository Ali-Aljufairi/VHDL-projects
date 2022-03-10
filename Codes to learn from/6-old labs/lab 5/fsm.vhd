LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY fsm IS PORT (
    clk, x : IN STD_LOGIC;
    y : OUT STD_LOGIC
);

END fsm;
ARCHITECTURE rtl OF fsm IS 
TYPE states IS (s0, s1);
SIGNAL state, nextstate : states := s0;

BEGIN

PROCESS (clk) BEGIN 
    IF rising_edge(clk) THEN
        state <= nextstate;
    END IF;
END PROCESS;

PROCESS (state, x) BEGIN

    CASE state IS
        WHEN s0 => 
            IF x = '1' THEN
                nextstate <= s0;
                y <= '0';
            ELSE
                nextstate <= s1;
                y <= '0';
            END IF;
        WHEN s1 =>

            IF x = '1' THEN
                nextstate <= s0;
                y <= '1';
            ELSE

                nextstate <= s1 ;
                    y <= '0';

            END IF;
    END CASE;
END PROCESS;
END rtl;