LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE211Project_library IS

    ----------------------Constant------------------------------------
    CONSTANT number_of_PE : INTEGER := 10;
    CONSTANT number_of_numberin : INTEGER :=  128;
	 CONSTANT Maxiumnumber : real :=  256.0;
    CONSTANT data_width : INTEGER := 7;
    CONSTANT data_output : INTEGER := number_of_PE * data_width;
    ----------------------Type----------------------------------------
    TYPE vector_array IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);

END PACKAGE ITCE211Project_library;


