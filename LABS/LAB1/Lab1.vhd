LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_labs.ALL;

ENTITY lab1 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0):=Ali_Redha_A;
        B : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0):=Ali_Redha_B;
        op : IN INTEGER RANGE 0 TO opcode := 0;
        R : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0) 

    );
END ENTITY;

ARCHITECTURE rtl OF lab1 IS


BEGIN

    WITH rom(op) SELECT

    R <=
        (OTHERS => '0') WHEN rom(0), -- set to zero if op = 0    
        A + B WHEN rom(1), -- ADD                 
        A - B WHEN rom(2), -- A - B
        A AND B WHEN rom(3), -- AND 
        A OR B WHEN rom(4), -- OR
        A XOR B WHEN rom(5), -- xor
        NOT A WHEN rom(6), -- not  
        (OTHERS => '1') WHEN rom(7), -- set to one if op = 7     
        (OTHERS => 'Z')WHEN OTHERS;

END ARCHITECTURE;



