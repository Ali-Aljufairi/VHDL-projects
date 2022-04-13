LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ITCE364Project_lab3_part2.ALL;

ENTITY tb_lab3_part2 IS
END ENTITY;

ARCHITECTURE rtl OF tb_lab3_part2 IS

  COMPONENT lab3_part2
    PORT (
      clk, ld, decr : IN std_logic; --$ ClK 
      inbus : IN std_logic_vector(length - 1 DOWNTO 0) := (OTHERS => '0'); --$ InBus    
      dec_out : OUT std_logic_vector(address DOWNTO 0) := ((OTHERS => '0'));--$ InBus
      n : OUT std_logic := '0');
  END COMPONENT;

  ---------------- Signal -------------------

  SIGNAL clk, ld, decr, n : std_logic := '0';
  SIGNAL inbus : std_logic_vector(length - 1 DOWNTO 0);
  SIGNAL dec_out : std_logic_vector(address DOWNTO 0) := ((OTHERS => '0'));--$ InBus
  SIGNAL stop_the_clock : boolean;

BEGIN

  ---------------- maping to test bench  -------------------

  uut : lab3_part2 PORT MAP(clk, ld, decr, inbus, dec_out, n);

  clocking : PROCESS
  BEGIN
    WHILE NOT stop_the_clock LOOP
      clk <= '0', '1' AFTER clk_period_half;
      WAIT FOR clk_period;
    END LOOP;
    WAIT;
  END PROCESS;

  Input_process : PROCESS
  BEGIN

    Loop_var <= to_integer(unsigned(Count));

    ld <= '1';
    decr <= '0';
    inbus <= Count;
    WAIT FOR clk_period;
    ld <= '0';
    decr <= '1';

    Wait_loop : FOR i IN 0 TO Loop_var LOOP
      WAIT FOR clk_period;
    END LOOP;

    stop_the_clock <= true;
    WAIT;

  END PROCESS;
END ARCHITECTURE;