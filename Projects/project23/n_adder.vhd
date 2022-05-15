LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY n_adder IS
GENERIC (n : integer := 16);
PORT (
A,B : IN  std_logic_vector(n-1 downto 0);
CIN : IN std_logic;
F : OUT std_logic_vector(n-1 downto 0);
COUT: OUT std_logic 
);
END n_adder;

ARCHITECTURE nAdder OF n_adder IS

COMPONENT adder IS
PORT(
a,b,cin : IN std_logic;
f,cout : OUT std_logic
);
END COMPONENT;
SIGNAL temp : std_logic_vector(n downto 0);

BEGIN
temp(0)<=CIN;
loop1: FOR i IN 0 TO n-1 GENERATE
fx: adder PORT MAP(A(i),B(i),temp(i),F(i),temp(i+1));
END GENERATE;
COUT<=temp(n);
END nAdder;