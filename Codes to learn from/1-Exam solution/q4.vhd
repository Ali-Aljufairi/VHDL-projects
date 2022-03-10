LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY q4 IS
    PORT (
        clk : IN STD_LOGIC;

        o_count : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    );
END ENTITY;

ARCHITECTURE rtl OF q4 IS

    SIGNAL s_addr : INTEGER RANGE 0 TO 3 := 0;

    TYPE rom_type IS ARRAY(0 TO 2**2-1) OF STD_LOGIC_VECTOR(1 DOWNTO 0);

    CONSTANT rom : rom_type := (
        0 => "00",
        1 => "11",
        2 => "10",  
        3 => "01"
    );

BEGIN

    ----------------------------------------
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN

            IF s_addr = 3 THEN
                s_addr <= 0;
            ELSE
                s_addr <= s_addr + 1;
            END IF;

        END IF;
    END PROCESS;
    ----------------------------------------

    o_count <= rom(s_addr);

END ARCHITECTURE;