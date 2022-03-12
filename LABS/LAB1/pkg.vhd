
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project_labs IS

    ----------------------Constant------------------------------------
    CONSTANT length : INTEGER := 8;
    CONSTANT opcode : INTEGER := 7;  
	CONSTANT Ali_Redha_A : std_logic_vector(length - 1 downto 0) :="00000000";
    CONSTANT Ali_Redha_B : std_logic_vector(length - 1 downto 0) :="00000011";
	
   ----------------------Type----------------------------------------
      TYPE rom_type IS ARRAY(0 TO opcode ) OF STD_LOGIC_VECTOR( 2 DOWNTO 0);
    
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

END PACKAGE ;


