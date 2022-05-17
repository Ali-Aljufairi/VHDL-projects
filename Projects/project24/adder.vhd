
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY adder IS
  PORT (
    a, b, cin : IN std_logic; --$ input of adder
    f, cout : OUT std_logic   --$ output of adder 

  );
END ENTITY;

ARCHITECTURE rtl OF adder IS
  SIGNAL x1 : std_logic; --$ singal to stor adder
BEGIN
  x1 <= a XOR b;
  f <= x1 XOR cin;
  cout <= (a AND b) OR (cin AND x1);
END ARCHITECTURE;