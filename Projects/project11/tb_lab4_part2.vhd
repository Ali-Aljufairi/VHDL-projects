LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364Project_lab4_part2.ALL;

ENTITY tb_lab4_part2 IS
END ENTITY;

ARCHITECTURE rtl OF tb_lab4_part2 IS

  COMPONENT lab4_part2
    PORT (
    clock1, we : IN std_logic := '0';
    data : IN std_logic_vector(datasize DOWNTO 0) := (OTHERS => '0'); --$ data  
    write_address, read_address : IN integer RANGE 0 TO address := 0; --$ 5-bit write address input to RAM
    q : OUT std_logic_vector(datasize DOWNTO 0) := (OTHERS => '0')); --$ output from RAM--$ output from RAM
  END COMPONENT;

  ---------------- Signal -------------------
  SIGNAL clock1, we : std_logic := '0'; -- $ write clock and $Read clock  
  SIGNAL data : std_logic_vector(datasize DOWNTO 0) := (OTHERS => '0'); --$ data  
  SIGNAL write_address, read_address : integer RANGE 0 TO address := 0; --$ 5-bit write address input to RAM
  SIGNAL q : std_logic_vector(datasize DOWNTO 0) := (OTHERS => '0'); --$ output from RAM
  SIGNAL data_in_sig : integer := data_inseret; --$ data_in_sig to put in RAM
  SIGNAL stop_the_clock : boolean; --$ stop the clock

BEGIN

  ---------------- maping to test bench  -------------------

  uut : lab4_part2 PORT MAP(clock1, we, data, write_address, read_address, q);
  clock_1 : PROCESS
  BEGIN
    WHILE NOT stop_the_clock LOOP
      clock1 <= '0', '1' AFTER clk_period_half;
      WAIT FOR clk_period;
    END LOOP;
    WAIT;
  END PROCESS;

  main_process : PROCESS
  BEGIN
    we <= '1';
  
    WAIT FOR clk_period;
    Main_loop : FOR i IN 0 TO address - 1 LOOP
      data <= std_logic_vector(to_unsigned(data_in_sig, data'length));
      write_address <= i;
      read_address <= i;
      Wait_loop : FOR i IN 0 TO 3 LOOP
        WAIT FOR clk_period;
      END LOOP;
      data_in_sig <= data_in_sig - 1;
      write_address <= i + 1;
      read_address <= i + 1;
    END LOOP;
    we <= '0';
    WAIT FOR clk_period;
    stop_the_clock <= true;
    WAIT;
  END PROCESS;
END ARCHITECTURE;