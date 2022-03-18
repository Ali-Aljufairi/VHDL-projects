
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY up_counter IS PORT (
    clk, ce, reset : IN STD_LOGIC;
    count : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

);
END ENTITY;

ARCHITECTURE rtl OF up_counter IS
    SIGNAL count_i : INTEGER RANGE 0 TO 255 := 0;

BEGIN
    count <= STD_LOGIC_VECTOR(to_unsigned(count_i, 8));

    PROCESS (clk, reset)
    BEGIN
        IF reset = '0' THEN
            count_i <= 0;
        ELSIF rising_edge(clk) THEN
            IF ce = '1' THEN
                IF count_i = 255 THEN

                    count_i <= 0;
                ELSE
                    count_i <= count_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END rtl;