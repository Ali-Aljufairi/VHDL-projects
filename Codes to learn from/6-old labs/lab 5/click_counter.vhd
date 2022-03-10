LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY click_counter IS PORT (

    clk, Push_Button1, counter_reset : IN STD_LOGIC;
    e : IN STD_LOGIC := '1';
    bcd_hundered, bcd_tens, bcd_ones : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);

END ENTITY;
ARCHITECTURE rtl OF click_counter IS

    SIGNAL click_dectectoutput : STD_LOGIC := '0';
    SIGNAL upcounteroutput : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL hunsig, tensig, onesig : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

    COMPONENT analyze_number IS

        PORT (

            number : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            n_hun : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            n_ten : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            n_one : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );

    END COMPONENT;
    COMPONENT sevensig IS

        PORT (
            number : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
            e : IN STD_LOGIC;
            seg7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)

        );
    END COMPONENT;
    COMPONENT click_detect IS PORT (

        clk, x : IN STD_LOGIC;
        y : OUT STD_LOGIC

        );

    END COMPONENT;
    COMPONENT up_counter IS PORT (
        clk, ce, reset : IN STD_LOGIC;
        count : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

        );
    END COMPONENT;
    COMPONENT Debounce IS PORT (

        clk, x : IN STD_LOGIC;

        y : OUT STD_LOGIC

        );
    END COMPONENT;
    COMPONENT fsm IS PORT (
        clk, x : IN STD_LOGIC;
        y : OUT STD_LOGIC
        );

    END COMPONENT;

BEGIN
    analyze_number1 : analyze_number PORT MAP(number => upcounteroutput, n_hun => hunsig, n_ten => tensig, n_one => onesig);
    up_counter1 : up_counter PORT MAP(clk => clk, reset => counter_reset, ce => click_dectectoutput, count => upcounteroutput);
    click_detect1 : click_detect PORT MAP(clk => clk, x => Push_Button1, y => click_dectectoutput);
    hun_seg : sevensig PORT MAP(e => e, number => hunsig, seg7 => bcd_hundered);
    ten_seg : sevensig PORT MAP(e => e, number => tensig, seg7 => bcd_tens);
    ones_seg : sevensig PORT MAP(e => e, number => onesig, seg7 => bcd_ones);

END rtl;