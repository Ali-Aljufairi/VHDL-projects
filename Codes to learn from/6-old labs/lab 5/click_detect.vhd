
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY click_detect IS PORT (

    clk, x : IN STD_LOGIC;
    y : OUT STD_LOGIC

);

END ENTITY;

ARCHITECTURE rtl OF click_detect IS

    SIGNAL pushbottomsig : STD_LOGIC := '0';

    COMPONENT Debounce PORT (

        clk, x : IN STD_LOGIC;
        y : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT fsm PORT (

        clk, x : IN STD_LOGIC;
        y : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
     fsmcomponent: fsm PORT MAP(x => pushbottomsig, clk => clk, y => y);
     Debouncecomponent: Debounce PORT MAP(x => x, clk=>clk, y => pushbottomsig);
    
END rtl;