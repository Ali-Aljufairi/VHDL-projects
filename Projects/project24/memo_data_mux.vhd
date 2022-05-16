LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ITCE364project.ALL;

ENTITY memo_data_mux IS
  PORT (
    SP_en : IN std_logic;
    PUSH_i : IN std_logic;
    STD_i : IN std_logic;
    Rsrc1 : IN std_logic_vector( opcodesize DOWNTO 0);
    ALU_res : IN std_logic_vector(opcodesize DOWNTO 0);
    PC : IN std_logic_vector(31 DOWNTO 0);
    mem_datain : OUT std_logic_vector(31 DOWNTO 0)
  );
END ENTITY ;

ARCHITECTURE instance OF memo_data_mux IS

BEGIN
  mem_datain <= Rsrc1 & x"0000"
    WHEN STD_i = '1'
    ELSE
    ALU_res & x"0000"
    WHEN SP_en = '0' OR PUSH_i = '1'
    ELSE
    std_logic_vector(unsigned(PC) + 2)
    ;

END ARCHITECTURE;