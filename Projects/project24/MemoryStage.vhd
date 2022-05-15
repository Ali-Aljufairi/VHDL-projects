LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MemoryStage IS
    PORT (
        clk,
        rst,
        CALL_i,
        RET_i,
        INT_i,
        RTI_i,
        POP_i,
        PUSH_i,
        SP_en,
        write32,
        read32,
        MW, -- we
        MR -- re
        : IN STD_LOGIC;
        Rsrc1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0); -- TODO add to buffers (for STD)
        PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_res : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        exception1 : OUT STD_LOGIC;
        exception2 : OUT STD_LOGIC;
        dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY MemoryStage;

ARCHITECTURE instance OF MemoryStage IS

    SIGNAL SP_used_Address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL memo_datain : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL memo_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL temp_exception2 : STD_LOGIC;
    SIGNAL STD_i : STD_LOGIC;
BEGIN
    -- PUSH_i <= SP_en AND (NOT write32) AND MW;
    -- POP_i <= SP_en AND (NOT read32) AND MR;
    STD_i <= MW AND (NOT write32) AND (NOT SP_en);
    SP_address_mux : ENTITY work.SP_Address_Unit PORT MAP(clk, rst, PUSH_i,
        POP_i, CALL_i, RET_i, INT_i, RTI_i, SP_used_Address,
        temp_exception2);
    Memo_data_mux : ENTITY work.Memo_data_mux PORT MAP(SP_en, PUSH_i,STD_i, Rsrc1, ALU_res, PC, memo_datain);
    Memo_address_mux : ENTITY work.memo_address_mux PORT MAP(clk, MW, MR, rst, SP_en, temp_exception2, SP_used_Address, ALU_res, memo_address, exception1);
    Ram : ENTITY work.ram PORT MAP(clk, MW, write32, MR, memo_address, memo_datain, dataout);
    exception2 <= temp_exception2;
END instance;