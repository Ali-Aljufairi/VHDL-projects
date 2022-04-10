LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Fulladder_generic IS
  GENERIC (
    data_width : integer := 16);
  PORT (
    a : IN std_logic_vector (data_width - 1 DOWNTO 0);
    b : IN std_logic_vector (data_width - 1 DOWNTO 0);
    cin : IN std_logic;
    s : OUT std_logic_vector (data_width - 1 DOWNTO 0);
    cout : OUT std_logic);
END Fulladder_generic;

ARCHITECTURE Behavioral OF Fulladder_generic IS

  COMPONENT FA IS
    PORT (
      a, b, c_in : IN std_logic;
      s, c_out : OUT std_logic);
  END COMPONENT;
  SIGNAL c : std_logic_vector(data_width DOWNTO 0);
BEGIN

  c(0) <= cin;
  cout <= c(data_width - 1);

END Behavioral;