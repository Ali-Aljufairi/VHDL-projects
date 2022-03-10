LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Mux_Case_IS IS
    GENERIC (
        N : INTEGER := 3;
        Y : INTEGER := 2
    );

    PORT (
        Sel : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(Y - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF Mux_Case_IS IS
BEGIN

    X <= A WHEN (SEL = '1') ELSE B;

END ARCHITECTURE;