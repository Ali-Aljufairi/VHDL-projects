LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY n_adder IS
  GENERIC (n : integer := 16); -- number of bits  

  PORT (
    A, B : IN std_logic_vector(n - 1 DOWNTO 0); --$ input  
    CIN : IN std_logic; --$ input
    F : OUT std_logic_vector(n - 1 DOWNTO 0); --$ output
    COUT : OUT std_logic); --$ output
END ENTITY;

ARCHITECTURE nAdder OF n_adder IS

  COMPONENT adder IS
    PORT (
      a, b, cin : IN std_logic;
      f, cout : OUT std_logic
    );
  END COMPONENT;
  SIGNAL temp : std_logic_vector(n DOWNTO 0);
BEGIN
  temp(0) <= CIN;
  loop1 : FOR i IN 0 TO n - 1 GENERATE
    fx : adder PORT MAP(A(i), B(i), temp(i), F(i), temp(i + 1));
  END GENERATE;
  COUT <= temp(n);
END ARCHITECTURE;