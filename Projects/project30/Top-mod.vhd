
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Top IS
  PORT (
    rst : in STD_LOGIC;	
	clk : in STD_LOGIC;
	hex_1, hex_2, hex_3,hex_4 : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0)



  );

END ENTITY;

ARCHITECTURE Behavioral OF Top-mod IS
  --//components//---
  COMPONENT processor IS
  PORT (
    rst : IN std_logic;
    clk : IN std_logic;
    INPORT : IN std_logic_vector(15 DOWNTO 0);
    OUTPORT : OUT std_logic_vector(15 DOWNTO 0)
  );

END COMPONENT;

  SIGNAL clk50mhzSignal : std_logic := '0';
  SIGNAL clkSignal : std_logic;
  SIGNAL clrSignal : std_logic;
  SIGNAL dinSignal : std_logic_vector(63 DOWNTO 0);
  SIGNAL ukeySignal : std_logic_vector(127 DOWNTO 0);
  SIGNAL EorDSignal : std_logic := '0';
  SIGNAL out1signal : std_logic_vector(15 DOWNTO 0);--Gets displayed on 7seg
  SIGNAL Reg2Signal : std_logic_vector(31 DOWNTO 0);--Gets displayed on 7seg
  -------------------
  ----7seg display signals-----
  COMPONENT Hex2LED --Converts a 4 bit hex value into the pattern to be displayed on the 7seg
    PORT (
      CLK : IN std_logic;
      X : IN std_logic_vector (3 DOWNTO 0);
      Y : OUT std_logic_vector (7 DOWNTO 0));
  END COMPONENT;

  
  SIGNAL NAME : arr;
  SIGNAL Val : std_logic_vector(3 DOWNTO 0) := (OTHERS => '0');
  SIGNAL HexVal : std_logic_vector(31 DOWNTO 0);
  SIGNAL slowCLK : std_logic := '0';
  SIGNAL i_cnt : std_logic_vector(19 DOWNTO 0) := x"00000";
  ----end of 7seg display signals---

BEGIN

 
  PROCESS (clkSignal)
  BEGIN
    IF (rising_edge(clkSignal)) THEN
      clk50mhzSignal <= NOT clk50mhzSignal;
    END IF;
  END PROCESS;
  
  MIPS : processor PORT MAP(clk50mhzSignal, clrSignal, dinSignal, ukeySignal, EorDSignal, Reg1Signal, Reg2Signal);
  -------end code------------

  ------7 seg display code-----
  -----Creating a slowCLK of 500Hz using the board's 100MHz clock----
  PROCESS (CLK)
  BEGIN
    IF (rising_edge(CLK)) THEN
      IF (i_cnt = x"186A0") THEN --Hex(186A0)=Dec(100,000)
        slowCLK <= NOT slowCLK; --slowCLK toggles once after we see 100000 rising edges of CLK. 2 toggles is one period.
        i_cnt <= x"00000";
      ELSE
        i_cnt <= i_cnt + '1';
      END IF;
    END IF;
  END PROCESS;

  -----We use the 500Hz slowCLK to run our 7seg display at roughly 60Hz-----
  timer_inc_process : PROCESS (slowCLK)
  BEGIN
    IF (rising_edge(slowCLK)) THEN
      IF (Val = "1000") THEN
        Val <= "0001";
      ELSE
        Val <= Val + '1'; --Val runs from 1,2,3,...8 on every rising edge of slowCLK
      END IF;
    END IF;
    --end if;
  END PROCESS;



  CONV1 : Hex2LED PORT MAP(CLK => CLK, X => Reg1Signal(1 DOWNTO 28), Y => NAME(0));--Converting Reg1Signal's content into a 7seg display
  CONV2 : Hex2LED PORT MAP(CLK => CLK, X => Reg1Signal(27 DOWNTO 24), Y => NAME(1));--pattern so that we can visually display it on
  CONV3 : Hex2LED PORT MAP(CLK => CLK, X => Reg1Signal(23 DOWNTO 20), Y => NAME(2));--the 7segment display of the fpga board
  CONV4 : Hex2LED PORT MAP(CLK => CLK, X => Reg1Signal(19 DOWNTO 16), Y => NAME(3));

END Behavioral;

