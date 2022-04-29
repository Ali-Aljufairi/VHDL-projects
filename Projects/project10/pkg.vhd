
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project_lab3_part2 IS

  ----------------------Constant------------------------------------
  CONSTANT length : integer := 8; --length of the data  
  CONSTANT opcode : integer := 7;
  CONSTANT address : integer := 4;
  CONSTANT data : integer := 4;
  CONSTANT clk_period : time := 20 ns;
  CONSTANT clk_period_half : time := 10 ns;
  ----------------------Signals------------------------------------
  SIGNAL Loop_var : integer := 0;
  SIGNAL Count : std_logic_vector(length - 1 DOWNTO 0) := x"0C";
  ----------------------Type----------------------------------------
  TYPE rom_type IS ARRAY(0 TO opcode) OF std_logic_vector(2 DOWNTO 0);
  TYPE reg_array IS ARRAY(address DOWNTO 0) OF std_logic_vector(7 DOWNTO 0);
  ----------------------Data in rom ------------------------------------
  CONSTANT rom : rom_type := (
    0 => "000",
    1 => "001",
    2 => "010",
    3 => "011",
    4 => "100",
    5 => "101",
    6 => "110",
    7 => "111");

   --$ INBUS ROOM  DATA THAT TIS REPSENT IN THE Table
  --  CONSTANT inbusrom : rom_type := (
  --   0 => "00001000",
  --   1 => "00000010",
  --   2 => "11110000",
  --   3 => "11100000",
  --   4 => "11110000",
  --   5 => "00001000",
  --   6 => "10101010",
  --   7 => "10000000");
END PACKAGE;