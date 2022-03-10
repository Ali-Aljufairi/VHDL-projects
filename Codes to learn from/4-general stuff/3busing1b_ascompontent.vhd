LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder_3bit IS
    PORT (
        A, B : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Cin : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        out: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE rtl OF adder_3bit IS

    SIGNAL sigc : STD_LOGIC_VECTOR(3 DOWNTO 0);

    COMPONENT full_adder
        PORT (
            A, B, Cin : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            Cout : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    sigc(0) <= Cin;
    Cout <= sigc(3);

    full_adder_1 : full_adder PORT MAP(A => A(0), B => B(0), Cin => sigc(0), S => S(0), Cout => sigc(1));
    full_adder_2 : full_adder PORT MAP(A => A(1), B => B(1), Cin => sigc(1), S => S(1), Cout => sigc(2));
    full_adder_3 : full_adder PORT MAP(A => A(2), B => B(2), Cin => sigc(2), S => S(2), Cout => sigc(3));

END rtl;