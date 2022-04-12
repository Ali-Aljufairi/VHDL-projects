LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364Project_lab3.ALL;

ENTITY tb_lab3 IS
END ENTITY;

ARCHITECTURE rtl OF tb_lab3 IS

  COMPONENT lab3
    PORT (
      conin : IN std_logic;
      inbus : IN std_logic_vector(length - 1 DOWNTO 0) := (OTHERS => '0');
      ir : IN integer RANGE 0 TO length := 0;
      condition : OUT std_logic);
  END COMPONENT;

  ---------------- Signal -------------------
  --$ INPUT SIGNAL 
  SIGNAL conin, condition : std_logic := '0';
  --$ IR Range 
  SIGNAL ir : integer RANGE 0 TO opcode := 0;
  --$  inbus 
  SIGNAL inbus : std_logic_vector(length - 1 DOWNTO 0) := (OTHERS => '0');

  --$ stop clock siganl 
  SIGNAL stop_the_clock : boolean;
  
BEGIN

  ---------------- maping to test bench  -------------------

  uut : lab3 PORT MAP(conin, inbus, ir, condition);
  clocking : PROCESS
  BEGIN
    WHILE NOT stop_the_clock LOOP
      conin <= '0', '1' AFTER clk_period_half;
      WAIT FOR clk_period;
    END LOOP;
    WAIT;
  END PROCESS;

  Checkking_vairables : PROCESS
  BEGIN
    Change : FOR i IN 0 TO opcode LOOP
      IR <= i;
      WAIT FOR clk_period;
      FOR j IN 0 TO length - 1 LOOP
        inbus <= inbusrom(j);
        WAIT FOR clk_period;
      END LOOP;
      WAIT FOR clk_period;
    END LOOP;
    stop_the_clock <= true;
    WAIT;
  END PROCESS;
END ARCHITECTURE;