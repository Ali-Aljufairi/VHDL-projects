LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY seq_counter_moore_tb IS

END seq_counter_moore_tb;

ARCHITECTURE rtl OF seq_counter_moore_tb IS

  ---------------componets-----------------

  COMPONENT seq_counter_moore IS
    PORT (
      clk : IN std_logic;
      ce : IN std_logic;
      reset : IN std_logic;
      count : OUT std_logic_vector(1 DOWNTO 0)

    );
  END COMPONENT;
  --------------signals and contstants------------------
  --the vairaible of componeps not vsiable that way we make new constants
  SIGNAL clk, ce, reset : std_logic := '0';
  SIGNAL count : std_logic_vector(1 DOWNTO 0) := "00";

BEGIN

  --------------genrate clock------------------
  PROCESS
  BEGIN
    clk <= '1';
    FOR i IN 0 TO 7 LOOP
      clk <= NOT clk;
      WAIT FOR 1ns;
    END LOOP;
    WAIT;

  END PROCESS;

  ---------------stimlus process------------------
  PROCESS
  BEGIN
    reset <= '0';
    FOR i IN 0 TO 3 LOOP
      ce <= '1';
      WAIT FOR 2ns;
    END LOOP;
    WAIT;
  END PROCESS;
  --------------------connection--------------------------
  uut : seq_counter_moore PORT MAP(clk, ce, reset, count);

END rtl;