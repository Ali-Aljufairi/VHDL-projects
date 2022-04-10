

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project_labs IS

  ----------------------Constant------------------------------------
  CONSTANT length : integer := 8;
  CONSTANT opcode : integer := 8;
  CONSTANT address : integer := 3;

  ----------------------Type----------------------------------------
  TYPE rom_type IS ARRAY(0 TO 7) OF std_logic_vector(2 DOWNTO 0);
  TYPE reg_array IS ARRAY(address DOWNTO 0) OF std_logic_vector(length - 1 DOWNTO 0);
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