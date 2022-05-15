LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memo_data_mux IS
    PORT (
        SP_en : IN STD_LOGIC;
        PUSH_i : IN STD_LOGIC;
        STD_i : IN STD_LOGIC;
        Rsrc1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_res : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        mem_datain : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY memo_data_mux;

ARCHITECTURE instance OF memo_data_mux IS

BEGIN
    mem_datain <= Rsrc1 & x"0000"
        WHEN STD_i = '1'
        ELSE
        ALU_res & x"0000"
        WHEN SP_en = '0' OR PUSH_i = '1'
        ELSE
        STD_LOGIC_VECTOR(unsigned(PC) + 2)
        ;

END instance;