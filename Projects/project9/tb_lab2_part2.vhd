LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_labs.ALL;

ENTITY tb_lab2_part2 IS
END ENTITY;

ARCHITECTURE rtl OF tb_lab2_part2 IS

    COMPONENT lab2_part2
        PORT (
            Clk, wr_en : IN STD_LOGIC := '1';
            A_ad, B_ad, WB_ad : IN INTEGER RANGE 0 TO address;
            op : IN INTEGER RANGE 0 TO opcode;
            Rout : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0));
    END COMPONENT;

    ---------------- Signal -------------------

    SIGNAL clk, wr_en, finished : STD_LOGIC := '0';
    SIGNAL A_ad, B_ad, WB_ad : INTEGER RANGE 0 TO address := 0;
    SIGNAL op : INTEGER RANGE 0 TO opcode := 0;
    SIGNAL Rout : STD_LOGIC_VECTOR(length - 1 DOWNTO 0);
    SIGNAL stop_the_clock : BOOLEAN;

BEGIN

    ---------------- maping to test bench  -------------------

    uut : lab2_part2 PORT MAP(clk, wr_en, A_ad, B_ad, WB_ad, op, Rout);
    clocking : PROCESS
    BEGIN
        WHILE NOT stop_the_clock LOOP
            clk <= '0', '1' AFTER clk_period_half;
            WAIT FOR clk_period;
        END LOOP;
        WAIT;
    END PROCESS;

   Checkking_vairables :PROCESS
    BEGIN
        wr_en <= '1';
        Change : FOR i IN 0 TO 3 LOOP
            Op <= i;
            IF op = 0 THEN
                A_ad <= 0;
                B_ad <= 1;
                WB_ad <= 2;
            ELSIF op = 1 THEN
                A_ad <= 2;
                B_ad <= 3;
                WB_ad <= 3;

            ELSIF op = 2 THEN
                A_ad <= 0;
                B_ad <= 1;
                WB_ad <= 1;
            ELSIF op = 3 THEN
                A_ad <= 2;
                B_ad <= 3;
                WB_ad <= 0;
                stop_the_clock <= true;
                WAIT;
            END IF;
            WAIT FOR clk_period;

        END LOOP;
    END PROCESS;
END ARCHITECTURE;