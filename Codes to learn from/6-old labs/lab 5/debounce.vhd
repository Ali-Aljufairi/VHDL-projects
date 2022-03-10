LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Debounce IS PORT (

    clk, x : IN STD_LOGIC;

    y : OUT STD_LOGIC

);
END ENTITY;

ARCHITECTURE rtl OF Debounce IS
    ---------- Counter 20ms part     --------------
    TYPE my_state IS(lvl1, lvl0, wait0, wait1);
    SIGNAL state, nextsate : my_state := lvl1;

    CONSTANT delay : INTEGER := 3;
    SIGNAL reset, overflow : STD_LOGIC := '0';
    SIGNAL Ce : STD_LOGIC := '0';
    SIGNAL count : INTEGER RANGE 0 TO delay := 0;

BEGIN
  ---------- Counter 20ms part     --------------
    PROCESS (clk, reset)
    BEGIN

        IF reset = '1' THEN

            count <= 0;
            overflow <= '0';

        ELSIF rising_edge(clk) THEN

            IF ce = '1' THEN

                IF count = delay THEN

                    count <= 0;

                    overflow <= '1';

                ELSE
                    count <= count + 1;

                    overflow <= '0';

                END IF;
            END IF;
        END IF;

    END PROCESS;

    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            state <= nextsate;
        END IF;
    END PROCESS;
    PROCESS (state, x)
    BEGIN

        CASE state IS

            WHEN wait0 =>
                IF overflow <= '1' THEN
                    nextsate <= lvl0;
                    y <= '0';
                    ce <= '1';
                    reset <= '1';

                ELSIF x = '1' THEN

                    nextsate <= lvl1;
                    y <= '1';
                    ce <= '1';
                    reset <= '1';

                ELSIF overflow <= '0' THEN
                    nextsate <= wait0;
                    y <= '1';
                    ce <= '0';
                    reset <= '1';
                END IF;

            WHEN lvl1 =>

                IF x = '1' THEN

                    nextsate <= lvl1;

                    y <= '1';
                    reset <= '1';
                    ce <= '1';
                ELSE
                    nextsate <= wait0;
                    y <= '1';
                    reset <= '0';
                    ce <= '1';
                END IF;

            WHEN lvl0 =>
                IF x = '1' THEN

                    nextsate <= wait1;
                    y <= '0';
                    ce <= '1';
                    reset <= '0';
                ELSE
                    nextsate <= lvl1;

                    y <= '1';
                    ce <= '1';
                    reset <= '1';
                END IF;

            WHEN wait1 =>
                IF overflow <= '1' THEN

                    nextsate <= lvl1;
                    y <= '1';
                    ce <= '1';
                    reset <= '1';
                ELSIF x = '0' THEN

                    nextsate <= lvl0;

                    y <= '0';
                    ce <= '1';
                    reset <= '1';

                ELSIF overflow <= '0' THEN
                    nextsate <= wait1;

                    y <= '0';
                    ce <= '0';
                    reset <= '1';
                END IF;
        END CASE;
    END PROCESS;
END rtl;