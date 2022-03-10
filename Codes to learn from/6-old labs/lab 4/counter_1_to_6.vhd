LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY counter_1to6 IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        ce : IN STD_LOGIC;
        overflow : OUT STD_LOGIC;
        counter : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END counter_1to6;
ARCHITECTURE rtl OF counter_1to6 IS
    SIGNAL countsig : INTEGER RANGE 1 TO 6 := 1;
    SIGNAL overflow_i : STD_LOGIC := '0';
BEGIN
    overflow <= overflow_i;
    counter <= STD_LOGIC_VECTOR(to_unsigned(countsig, 4));
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