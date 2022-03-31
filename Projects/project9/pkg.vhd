
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project_labs IS

  ----------------------Constant------------------------------------
  CONSTANT length : integer := 8; --length of the data  
  CONSTANT opcode : integer := 7;
  CONSTANT address : integer := 3;
  CONSTANT clk_period : time := 200 ns;
  CONSTANT clk_period_half : time := 100 ns;
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
    7 => "111"

  );

END PACKAGE;