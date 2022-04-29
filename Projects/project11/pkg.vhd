
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project_lab4_part2 IS

  ----------------------Constant------------------------------------

  CONSTANT datasize : integer := 7; --$ length of the data
  CONSTANT address : integer := 63; -- $ address  
  CONSTANT data_inseret : integer := 256; --$ data to be inserted
  CONSTANT clk_period : time := 200 ns; --$ Full clock period 
  CONSTANT clk_period_half : time := 100 ns; --$ half of clk_period 
  CONSTANT clk_period_2 : time := 400 ns;
  CONSTANT clk_period_2_half : time := 200 ns; --$ half of clk_period 
  ----------------------Type----------------------------------------
  TYPE mem_array IS ARRAY(address DOWNTO 0) OF std_logic_vector(datasize DOWNTO 0);

  ----------------------Data in rom ------------------------------------

  --$  this is the data repsent the decoder rom     
  ----------------------Data in register ------------------------------------ 
END PACKAGE;