LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY multi_2_2 IS
    PORT (
        factor1, factor2 : IN STD_LOGIC_VECTOR(0 TO 3) := "0101";
        outcome : OUT STD_LOGIC := '0'

    );
END multi_2_2;

ARCHITECTURE rtl OF multi_2_2 IS

    COMPONENT xorgate
        PORT (
            xora, xorb : IN STD_LOGIC_VECTOR(0 TO 1);

            xorC : OUT STD_LOGIC_VECTOR(0 TO 1)
        );
    END COMPONENT;

    COMPONENT orgate IS
        PORT (
            ora, orb : IN STD_LOGIC_VECTOR(0 TO 1);

            orC : OUT STD_LOGIC_VECTOR(0 TO 1)
        );
    END COMPONENT;
    SIGNAL or1output, or2output, xoroutput : STD_LOGIC_VECTOR(0 TO 1) := (OTHERS => '0');
    SIGNAL allout : STD_LOGIC_VECTOR(0 TO 7) := (OTHERS => '0');
    ALIAS out1 : STD_LOGIC_VECTOR(0 TO 1) IS allout(0 TO 1);
    ALIAS out2 : STD_LOGIC_VECTOR(0 TO 1) IS allout(2 TO 3);
    ALIAS out3 : STD_LOGIC_VECTOR(0 TO 1) IS allout(4 TO 5);
    ALIAS out4 : STD_LOGIC_VECTOR(0 TO 1) IS allout(6 TO 7);

BEGIN
    allout <= STD_LOGIC_VECTOR(unsigned(factor1) * unsigned(factor2));

    firstor : orgate PORT MAP(ora => out1, orb => out2, orC => or1output);
    secondor : orgate PORT MAP(ora => out3, orb => out4, orC => or2output);
    firstxor : xorgate PORT MAP(xora => or1output, xorb => or2output, xorC => xoroutput);

    PROCESS (xoroutput)
    BEGIN

        CASE xoroutput IS

            WHEN "00" => outcome <= '0';

            WHEN "01" => outcome <= '1';

            WHEN "10" => outcome <= '1';
            WHEN "11" => outcome <= '0';

            WHEN OTHERS => outcome <= '0';

        END CASE;
    END PROCESS;
END ARCHITECTURE;