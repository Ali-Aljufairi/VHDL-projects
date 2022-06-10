
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Top IS
  PORT (
    rst : IN std_logic;
    clk : IN std_logic;
    hex_1, hex_2, hex_3, hex_4 : OUT std_logic_vector(7 DOWNTO 0);
    in1 : IN std_logic;
    in2 : IN std_logic
  );
END ENTITY;

ARCHITECTURE Behavioral OF Top IS
  --//components//---
  COMPONENT processor IS
    PORT (
      rst : IN std_logic;
      clk : IN std_logic;
      INPORT : IN std_logic_vector(15 DOWNTO 0);
      OUTPORT : OUT std_logic_vector(15 DOWNTO 0)
    );

  END COMPONENT;
  COMPONENT Hex2LED --Converts a 4 bit hex value into the pattern to be displayed on the 7seg
    PORT (
      CLK : IN std_logic;
      X : IN std_logic_vector (3 DOWNTO 0);
      Y : OUT std_logic_vector (7 DOWNTO 0));
  END COMPONENT;
  SIGNAL inputsignal, outputsignal, bruh, inputsignal2 : std_logic_vector(15 DOWNTO 0);
  SIGNAL hex_1_sig, hex_2_sig, hex_3_sig, hex_4_sig : std_logic_vector(3 DOWNTO 0);
  -------end code------------

  
BEGIN

  PROCESS (rst, inputsignal) IS
  BEGIN
    IF rst = '1' THEN
      inputsignal <= (OTHERS => '0');
      inputsignal2 <= (OTHERS => '0');
    ELSIF in1 = '0' THEN
      inputsignal <= "0000000000000101";

    ELSIF in2 = '0' THEN
      inputsignal <= "0000000000010000";
    END IF;
  END PROCESS;
  MIPS : processor PORT MAP(rst, clk, inputsignal, outputsignal);
  --bruh <= x"FAB1" ;
  hex_1_sig <= outputsignal(3 DOWNTO 0);
  hex_2_sig <= outputsignal(7 DOWNTO 4);
  hex_3_sig <= outputsignal(11 DOWNTO 8);
  hex_4_sig <= outputsignal(15 DOWNTO 12);
  CONV1 : Hex2LED PORT MAP(CLK => CLK, X => hex_1_sig, Y => hex_1);
  CONV2 : Hex2LED PORT MAP(CLK => CLK, X => hex_2_sig, Y => hex_2);
  CONV3 : Hex2LED PORT MAP(CLK => CLK, X => hex_3_sig, Y => hex_3);
  CONV4 : Hex2LED PORT MAP(CLK => CLK, X => hex_4_sig, Y => hex_4);
END ARCHITECTURE;