LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mooreexam IS
    PORT (
        Ce : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        X : OUT STD_LOGIC;
        Y : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE rtl OF seq_detector IS

    TYPE state_type IS (s0, s1, s2, s3);
    SIGNAL state, next_state : state_type := s0;
BEGIN

    PROCESS (state)

    BEGIN
        Y <= '1';
        x <= '1';

        CASE state IS

            WHEN s0 => state
                Y <= '0';
                x <= '0';

            WHEN s1 => state
                Y <= '1';
                x <= '1';
            WHEN s2 => state
                Y <= '0';

            WHEN s3 => state
                x <= '0';

        END CASE;
    END PROCESS;
    PROCESS (state, ce, reset)
    BEGIN
        next_state <= s0;
        CASE state IS

            WHEN s0 =>
                IF reset = '1' THEN
                    next_state <= s0;
                ELSIF
                    ce = '1' THEN
                    next_state <= s1;
                END IF;

            WHEN s1 =>
                IF reset = '1' THEN
                    next_state <= s0;
                ELSIF
                    ce = '1' THEN
                    next_state <= s2;
                ELSE
                    next_state <= s1;
                END IF;

            WHEN s2 =>
                IF reset = '1' THEN
                    next_state <= s0;
                ELSIF
                    ce = '1' THEN
                    next_state <= s3;
                ELSE
                    next_state <= s2;

                END IF;

            WHEN s3 =>
                IF reset = '1' THEN
                    next_state <= s0;
                ELSIF
                    ce = '1' THEN
                    next_state <= s0;
                ELSE
                    next_state <= s3;

                END IF;
                end case ;
        END PROCESS;
    END rtl;