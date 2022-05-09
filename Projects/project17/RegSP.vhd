LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY RegSP IS

    PORT (
        clk, rst, enable : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END RegSP;

ARCHITECTURE a_Regsp OF RegSP IS
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF (enable = '0') THEN
            NULL;
        ELSIF (rst = '1') THEN
            q <= "00000000000000001111111111111110";
        ELSIF clk'event AND clk = '1' THEN
            q <= d;
        END IF;
    END PROCESS;
END a_Regsp;