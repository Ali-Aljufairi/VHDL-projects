LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY h_t_0 IS

    PORT (

        number : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        n_hun : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        n_ten : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        n_one : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );

END ENTITY;

ARCHITECTURE rtl OF h_t_0 IS

    SIGNAL signumber : INTEGER RANGE 0 TO 255 := 0;
    SIGNAL hunderds : INTEGER RANGE 0 TO 9 := 0;
    SIGNAL tens : INTEGER RANGE 0 TO 30 := 0;
    SIGNAL ones : INTEGER RANGE 0 TO 255 := 0;

BEGIN
    signumber <= to_integer(unsigned(number));
    hunderds <= signumber/100;
    tens <= (signumber - ((signumber/100) * 100))/10;
    ones <= (signumber - ((signumber/100) * 100) - (((signumber - ((signumber/100) * 100))/10) * 10));
    n_hun <= STD_LOGIC_VECTOR(to_unsigned(hunderds, 4));
    n_ten <= STD_LOGIC_VECTOR(to_unsigned(tens, 4));
    n_one <= STD_LOGIC_VECTOR(to_unsigned(ones, 4));

END rtl;