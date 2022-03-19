LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_labs.ALL;

ENTITY lab1 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := Ali_Redha_A;
        B : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := Ali_Redha_B;
        op : IN INTEGER RANGE 0 TO opcode := 0;
        -- op : in std_logic_vector(2 downto 0);
        R : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0)

    );
END ENTITY;

ARCHITECTURE rtl OF lab1 IS
BEGIN
    WITH op SELECT
        R <= "00000000" WHEN "000", -- set to zero if op = 0    
        A - B WHEN "001", -- ADD                 
        A + B WHEN "010", -- A - B
        A AND B WHEN "011", -- AND 
        A OR B WHEN "100", -- OR
        A XOR B WHEN "101", -- xor
        NOT A WHEN "110", -- not  
        "11111111" WHEN "111", -- set to one if op = 7     
        "ZZZZZZZZ" WHEN OTHERS;
		

END ARCHITECTURE;

-- -- 
-- R <=
-- (OTHERS => '0') WHEN rom(0), -- set to zero if op = 0    
-- A - B WHEN rom(1), -- ADD                 
-- A + B WHEN rom(2), -- A - B
-- A AND B WHEN rom(3), -- AND 
-- A OR B WHEN rom(4), -- OR
-- A XOR B WHEN rom(5), -- xor
-- NOT A WHEN rom(6), -- not  
-- (OTHERS => '1') WHEN rom(7), -- set to one if op = 7     
-- "ZZZZZZZZ" WHEN OTHERS;
  
-- WITH rom(op) SELECT


