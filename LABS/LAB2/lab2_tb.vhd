LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_labs.ALL;

ENTITY lab2_tb IS

END ENTITY;

ARCHITECTURE rtl OF lab2_tb IS

    COMPONENT lab2
        PORT (
            clk, wr_en : IN STD_LOGIC := '0';
            A_add, B_add, WB_add : IN INTEGER RANGE 0 TO address := 0;
            WB : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0');
            A, B : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0'));
    END COMPONENT;

    ---------------- Signal -------------------

    SIGNAL clk, wr_en : STD_LOGIC := '0';
    SIGNAL A_add, B_add, WB_add : INTEGER RANGE 0 TO address := 0;
    SIGNAL WB : STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL A, B : STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := (OTHERS => '0');
    CONSTANT clk_period : TIME := 20 ns;
    CONSTANT clk_period_half : TIME := 10 ns;
    SIGNAL myreg : reg_array := (OTHERS => (OTHERS => '-'));

BEGIN

    ---------------- maping to test bench  -------------------

    uut : lab2 PORT MAP(clk, wr_en, A_add, B_add, WB_add, WB, A, B);

    PROCESS
    BEGIN

       
        clk <= '0';
        FOR i IN 1 TO 50
            LOOP
                clk <= NOT clk;
                WAIT FOR clk_period;
            END LOOP;
        END PROCESS;

      wr_en <= '1'; 








    END ARCHITECTURE;