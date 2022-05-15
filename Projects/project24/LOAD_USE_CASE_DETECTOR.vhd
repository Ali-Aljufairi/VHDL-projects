library ieee;
use ieee.std_logic_1164.all;
ENTITY LOAD_USE_CASE_DETECTOR IS
PORT(
EX_MEMR:IN STD_LOGIC;
D_SRC1,D_SRC2,EX_dest:IN STD_LOGIC_VECTOR(2 DOWNTO 0); 

LOAD_USE_CASE_OUT:OUT STD_LOGIC

);
END ENTITY;

ARCHITECTURE LOAD_USE_CASE_DETECTOR_STRUCTURE OF LOAD_USE_CASE_DETECTOR IS
BEGIN

LOAD_USE_CASE_OUT<='1' WHEN (EX_MEMR ='1' AND ((EX_dest=D_SRC1) OR (EX_dest=D_SRC2)))

ELSE
'0'; 


END LOAD_USE_CASE_DETECTOR_STRUCTURE;
  
