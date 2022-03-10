LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY q2 IS
    GENERIC (
        N : INTEGER := 4;
        data_width : INTEGER := 8

    );
    PORT (
        clk, reset, data_in : IN STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE rtl OF q2 IS
    TYPE vector_array IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
    SIGNAL a, b : vector_array(N - 1 DOWNTO 0) := (OTHERS => (OTHERS => '0'));
    COMPONENT flip_flop
        PORT (
            A, clk, reset : IN STD_LOGIC;
            B : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN

    gen : FOR i IN 0 TO N GENERATE
        flip_flop : flip_flop PORT MAP(A => a(i), clk => clk, reset => reset, B => b(i));
    END GENERATE;

    PROCESS (clk)
    BEGIN
        a(0) <= data_in;
        L1 : FOR i IN 1 TO N LOOP
            a(i) <= b(i - 1);
        END LOOP L1;

    END PROCESS;
    concatenting : PROCESS (b) IS
    BEGIN

        L2 : FOR i IN 0 TO N - 1 LOOP
            data_out((data_width - 1) + i * data_width DOWNTO 0 + i * data_width) <= b(i);
        END LOOP L2;

    END PROCESS concatenting;

END ARCHITECTURE;