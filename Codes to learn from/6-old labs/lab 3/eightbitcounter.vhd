LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY eightbitcounter IS
    PORT (

        up_down, clk, reset : IN STD_LOGIC; -- up_down control for counter
        count : OUT STD_LOGIC_VECTOR (7 DOWNTO 0):="00000000"
    );
END ENTITY;

ARCHITECTURE rtl OF eightbitcounter IS
    SIGNAL internalcount : INTEGER RANGE 0 TO 255 := 0;

BEGIN

    count <= STD_LOGIC_VECTOR(to_unsigned(internalcount, 8));
    PROCESS (clk, reset) BEGIN
        IF (reset = '1') THEN
            internalcount <= 0;
        ELSIF (rising_edge(clk)) THEN
            IF (up_down = '1') THEN
                internalCount <= internalCount + 1;
            ELSE
                internalCount <= internalCount - 1;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;