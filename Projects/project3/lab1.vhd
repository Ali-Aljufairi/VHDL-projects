LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364Project_labs.ALL ;

ENTITY lab1 IS
    PORT (
        A, B : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0);
        op : IN STD_LOGIC_VECTOR(opcode - 1 DOWNTO 0);
        R : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0)

    );
END ENTITY;

ARCHITECTURE rtl OF lab1 IS

    SIGNAL s_addr : INTEGER RANGE 0 TO 7 := 0;

BEGIN

    WITH rom(s_addr) SELECT

    R <=
        A AND B WHEN rom(3),
        A OR B WHEN rom(4),
        A XOR B WHEN rom(5),
        NOT A WHEN rom(6), -- not  
        B when others  ;





END ARCHITECTURE;