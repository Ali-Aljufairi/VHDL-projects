LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY lab2_attempt1 IS

    PORT (
        number : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
        e : IN STD_LOGIC;
        seg7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)

    );
END lab2_attempt1;
ARCHITECTURE rtl OF lab2_attempt1 IS

    SIGNAL intconv : INTEGER RANGE 0 TO 9 := 0;

    SIGNAL S1, S2 : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL numbersix : STD_LOGIC_VECTOR(4 DOWNTO 0) := "0110";

    TYPE rom IS ARRAY (0 TO 2 ** 3 + 1) OF STD_LOGIC_VECTOR(6 DOWNTO 0);

    CONSTANT MY_rom : rom := (
        --abcdefg
        0 => "0000001",
        1 => "1000111",
        2 => "0010010",
        3 => "0000110",
        4 => "1001100",
        5 => "0100100",
        6 => "0100000",
        7 => "0001111",
        8 => "0000000",
        9 => "0000100");
BEGIN

    intconv <= to_integer(unsigned(number));

    PROCESS (e, intconv)

    BEGIN

        IF E = '1' AND intconv < 10 THEN

            seg7 <= MY_rom(intconv);
        ELSE

            seg7 <= "1111111";

        END IF;

    END PROCESS;

END rtl;