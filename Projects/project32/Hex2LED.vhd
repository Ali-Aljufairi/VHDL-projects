LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Hex2LED IS
  PORT (
    CLK : IN std_logic;
    X : IN std_logic_vector (3 DOWNTO 0);
    Y : OUT std_logic_vector (7 DOWNTO 0));
END ENTITY;

ARCHITECTURE Behavioral OF Hex2LED IS
BEGIN
  --'1' to switch off segment, '0' to turn on segment--
  PROCESS (CLK,x)
  BEGIN
    CASE X IS
      WHEN "0000" => Y <= "11000000";--Led segment Pattern for 7 seg display to visually show 0
      WHEN "0001" => Y <= "11111001";--Led segment Pattern for 7 seg display to visually show 1 
      WHEN "0010" => Y <= "10100100";--Led segment Pattern for 7 seg display to visually show 2 
      WHEN "0011" => Y <= "10110000";--Led segment Pattern for 7 seg display to visually show 3 
      WHEN "0100" => Y <= "10011001";--Led segment Pattern for 7 seg display to visually show 4
      WHEN "0101" => Y <= "10010010";--Led segment Pattern for 7 seg display to visually show 5
      WHEN "0110" => Y <= "10000010";--Led segment Pattern for 7 seg display to visually show 6
      WHEN "0111" => Y <= "11111000";--Led segment Pattern for 7 seg display to visually show 7
      WHEN "1000" => Y <= "10000000";--Led segment Pattern for 7 seg display to visually show 8
      WHEN "1001" => Y <= "10010000";--Led segment Pattern for 7 seg display to visually show 9
      WHEN "1010" => Y <= "10001000";--Led segment Pattern for 7 seg display to visually show A
      WHEN "1011" => Y <= "10000011";--Led segment Pattern for 7 seg display to visually show B 
      WHEN "1100" => Y <= "11000110";--Led segment Pattern for 7 seg display to visually show C 
      WHEN "1101" => Y <= "10100001";--Led segment Pattern for 7 seg display to visually show D
      WHEN "1110" => Y <= "10000110";--Led segment Pattern for 7 seg display to visually show E 
      WHEN OTHERS => Y <= "10001110";--Led segment Pattern for 7 seg display to visually show F
    END CASE;
  END PROCESS;
END Behavioral;