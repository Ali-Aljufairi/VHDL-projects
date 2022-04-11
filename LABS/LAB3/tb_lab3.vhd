LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_lab3.ALL;

ENTITY tb_lab3 IS
END ENTITY;

ARCHITECTURE rtl OF tb_lab3 IS

  COMPONENT lab2_part2
    PORT (
      conin : IN std_logic;
      inbus : IN std_logic_vector(length - 1 DOWNTO 0) := (OTHERS => '0');
      ir : IN integer RANGE 0 TO length := 0;
      condition : OUT std_logic);
  END COMPONENT;

  ---------------- Signal -------------------

  SIGNAL conin, condition : std_logic := '0';
  SIGNAL ir : integer RANGE 0 TO opcode := 0;
  SIGNAL inbus : std_logic_vector(length - 1 DOWNTO 0) := (OTHERS => '0');
  SIGNAL stop_the_clock : boolean;
  SIGNAL Decoder_out : std_logic_vector(length - 1 DOWNTO 0) := ((OTHERS => '0'));
  SIGNAL g : std_logic_vector(g_length - 1 DOWNTO 0) := ((OTHERS => '0'));
  SIGNAL brn : std_logic := '0';

  --   SIGNAL A_ad, B_ad, WB_ad : integer RANGE 0 TO address := 0;
BEGIN

  g(0) <= Decoder_out(1);

  ---------------- maping to test bench  -------------------

  uut : lab2_part2 PORT MAP(conin, inbus, ir, condition);
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