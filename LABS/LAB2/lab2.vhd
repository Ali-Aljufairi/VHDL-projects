LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_labs.ALL;

ENTITY lab2 IS
    PORT (
        clk, wr_en : IN STD_LOGIC := '0';
        A_add, B_add, WB_add : IN INTEGER RANGE 0 TO address := 0;
        WB : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0');
        A, B : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0'));
END ENTITY;

ARCHITECTURE rtl OF lab2 IS
     
   

    SIGNAL myreg : reg_array := (OTHERS => (OTHERS => '-'));

    -- In VHDL we have  a lot of value  not only 1 and 0 
    --  ‘Z’	High impedance
    --  ‘W’	Weak signal, can’t tell if 0 or 1
    --  ‘L’	Weak 0, pulldown
    --  ‘H’	Weak 1, pullup
    --  ‘-‘	Don’t care
    --  ‘U’	Uninitialized
    --  ‘X’	Unknown, multiple drivers

BEGIN

    PROCESS (clk,wr_en,WB_add,WB) -- process to write to registers            
    BEGIN
        IF rising_edge(clk) THEN
            IF (wr_en = '1') THEN
                myreg(WB_add) <= WB;
            END IF;
        END IF;
    END PROCESS;


    PROCESS (clk, A_add, B_add) -- process to read from registers
    BEGIN
        IF rising_edge(clk) THEN
            A <= myreg(A_add);
            B <= myreg(B_add);
        END IF;
    END PROCESS;
  
END ARCHITECTURE;





  

    -- We use  - since we don't care the value of the register first time 




























