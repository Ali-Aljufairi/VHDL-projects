LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY click_detect IS
    PORT (

        y : IN STD_LOGIC;
        clk : IN STD_LOGIC ;
        z : OUT STD_LOGIC

    );
END ENTITY;
ARCHITECTURE rtl OF click_detect IS

    TYPE states IS (s0, s1);
    SIGNAL state, nextstate : states;

BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            state <= nextstate;
        END IF;

    END PROCESS;
    PROCESS (state, y)
    BEGIN

        z <= '0';
        nextstate <= s0;
        IF state = s0 THEN
            IF y = '1'THEN
                nextstate <= s1;
                z <= '1';
            END IF;

        ELSE
            IF y = '1'THEN
                nextstate <= s1;
                z <= '1';
            END IF;
        END IF;
    END PROCESS;
END rtl;