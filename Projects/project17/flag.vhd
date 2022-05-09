Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
USE work.ITCE364project.ALL;


ENTITY flag IS
  PORT (clk,reset, cin, changeEnable,setCarry,clrCarry: IN std_logic;
  inFlag: IN std_logic_vector (2 downto 0);
  F: IN std_logic_vector(31 downto 0) := (others => '0'); 
  aluSelect: IN std_logic_vector(3 downto 0);
	outFlag: OUT std_logic_vector (2 downto 0));
END ENTITY;

ARCHITECTURE flag_arch OF flag IS
  BEGIN
  outFlag(2) <= '0' when ((clrCarry = '1' and changeEnable = '1') or reset='1')
  else '1' when setCarry = '1' and changeEnable = '1'
  else cin when changeEnable = '1'
  else inFlag(2);

  outFlag(1) <= '0' when reset='1'
  else inFlag(1) when (aluSelect="0000" or aluSelect="1000" or changeEnable ='0')
  else F(31);

  outFlag(0) <= '0' when reset = '1'
  else inFlag(0) when (aluSelect="0000" or aluSelect="1000" or changeEnable ='0')
  else '1' when F="00000000000000000000000000000000" and changeEnable = '1'
  else '0';
END ARCHITECTURE;