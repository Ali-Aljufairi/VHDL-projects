LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;
USE work.ITCE364project.ALL;

ENTITY mux_4x16 IS
    PORT (
        clk : IN STD_LOGIC;
        selector : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        in0, in1, in2, in3, in4, in5, in6, in7, in8, in9 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        outData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END mux_4x16;

ARCHITECTURE mux_4x16_arch OF mux_4x16 IS

BEGIN

    outData <= in0 WHEN (selector = "0000") ELSE
        in1 WHEN (selector = "0001") ELSE
        in2 WHEN (selector = "0010") ELSE
        in3 WHEN (selector = "0011") ELSE
        in4 WHEN (selector = "0100") ELSE
        in5 WHEN (selector = "0101") ELSE
        in6 WHEN (selector = "0110") ELSE
        in7 WHEN (selector = "0111") ELSE
        in8 WHEN (selector = "1000") ELSE
        in9 WHEN (selector = "1001") ELSE
        in0;

END mux_4x16_arch; -- mux_4x16_arch