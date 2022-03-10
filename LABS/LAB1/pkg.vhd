
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project_labs IS

    ----------------------Constant------------------------------------
    CONSTANT length : INTEGER := 8;
    CONSTANT opcode : INTEGER := 3;  
	
    ----------------------Type----------------------------------------
      TYPE rom_type IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR( 2 DOWNTO 0);

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


