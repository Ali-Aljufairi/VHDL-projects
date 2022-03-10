LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Byte_Swap IS
    PORT (
        i_A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        o_B : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    );
END ENTITY;

ARCHITECTURE rtl OF Byte_Swap IS

    COMPONENT Max_Min
        PORT (
            i_A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            i_B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

            o_Max : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            o_Min : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL s_smallest_byte_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL s_smallest_byte_2 : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL s_largest_byte_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL s_largest_byte_2 : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    ----------------------------------------

    xn_1 : Max_Min
    PORT MAP(
        i_A => i_A(7 DOWNTO 0), -- A0
        i_B => i_A(15 DOWNTO 8), -- A1

        o_Max => s_largest_byte_1,
        o_Min => s_smallest_byte_1
    );

    xn_2 : Max_Min
    PORT MAP(
        i_A => i_A(25 DOWNTO 16), -- A2
        i_B => i_A(31 DOWNTO 24), -- A3

        o_Max => s_largest_byte_2,
        o_Min => s_smallest_byte_2
    );

    ----------------------------------------

    xn_3 : Max_Min
    PORT MAP(
        i_A => s_largest_byte_1,
        i_B => s_largest_byte_2,

        o_Max => o_B(31 DOWNTO 24), -- B3
        o_Min => o_B(25 DOWNTO 16) -- B2
    );

    xn_4 : Max_Min
    PORT MAP(
        i_A => s_smallest_byte_1,
        i_B => s_smallest_byte_2,

        o_Max => o_B(15 DOWNTO 8), -- B1
        o_Min => o_B(7 DOWNTO 0) -- B0
    );

    ----------------------------------------

END ARCHITECTURE;