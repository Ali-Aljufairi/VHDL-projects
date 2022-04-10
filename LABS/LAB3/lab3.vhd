LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_labs.ALL;

ENTITY lab3 IS
    PORT (
        clk, wr_en : IN STD_LOGIC := '0';
        A_add, B_add, WB_add : IN INTEGER RANGE 0 TO address := 0;
        WB : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0');
        A, B : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0'));
END ENTITY;

ARCHITECTURE rtl OF lab3 IS

    SIGNAL myreg : reg_array := (OTHERS => (OTHERS => '-'));
BEGIN

    PROCESS (clk, wr_en, WB_add, WB) -- process to write to registers            
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