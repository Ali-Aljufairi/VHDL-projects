LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_labs.ALL;

ENTITY ALU IS
    PORT (
        A : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0) ;
        B : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0) ;
        op : IN INTEGER RANGE 0 TO opcode := 0;
        R : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0)   

    );
END ENTITY;

ARCHITECTURE rtl OF ALU IS

 
	 

BEGIN
  
  process (A,B,op)

    Begin 
    IF op = 0 THEN
    R <=  (OTHERS => '0');
    ELSIF op = 1 THEN
		R <= A - B;
    ELSIF op = 2 THEN
		R <= A + B;
    ELSIF op = 3 THEN
		R <= A AND B;
    ELSIF op = 4 THEN
		R <= A OR B;
    ELSIF op = 5 THEN
		R <= A XOR B;
    ELSIF op = 6 THEN
		R <= NOT A;
    ELSIF op = 7 THEN
    R <= (OTHERS => '1');
    ELSE
    R <= (OTHERS => 'Z');
    END IF;
    
       
End process ;
END ARCHITECTURE;




