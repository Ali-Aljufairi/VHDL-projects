LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY adder IS
    PORT (
        count1, count2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        sum : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
    );
END adder;
ARCHITECTURE rtl OF adder IS

BEGIN

    sum <= STD_LOGIC_VECTOR(('0' & unsigned (count1)) + ('0' & unsigned (count2)));
END rtl;