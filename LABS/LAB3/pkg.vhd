
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project_lab3 IS

  ----------------------Constant------------------------------------
  CONSTANT length : integer := 8;
  CONSTANT g_length : integer := 5;
  CONSTANT opcode : integer := 8;
  CONSTANT address : integer := 3;
  CONSTANT clk_period : time := 200 ns;
  CONSTANT clk_period_half : time := 100 ns;

  ----------------------Type----------------------------------------
  TYPE rom_type IS ARRAY(0 TO 7) OF std_logic_vector(length - 1 DOWNTO 0);
  TYPE reg_array IS ARRAY(address DOWNTO 0) OF std_logic_vector(length - 1 DOWNTO 0);
  ----------------------Data in rom ------------------------------------
  CONSTANT rom : rom_type := (
    0 => "00000001",
    1 => "00000010",
    2 => "00000100",
    3 => "00001000",
    4 => "00010000",
    5 => "00100000",
    6 => "01000000",
    7 => "10000000");

    CONSTANT inbusrom : rom_type := (
      0 => "00001000",
      1 => "00000010",
      2 => "11110000",
      3 => "11100000",
      4 => "11110000",
      5 => "00001000",
      6 => "10101010",
      7 => "10000000");
  ----------------------Data in register ------------------------------------ 


END PACKAGE;