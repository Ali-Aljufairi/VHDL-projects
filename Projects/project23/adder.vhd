
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY adder IS
PORT (
a,b,cin : IN  std_logic;
f, cout : OUT std_logic 
);
END adder;

ARCHITECTURE modelAdder OF adder IS
SIGNAl x1: std_logic;
BEGIN
x1<=a XOR b;
f <= x1 XOR cin;
cout <= (a AND b) OR (cin AND x1);		
END ARCHITECTURE;