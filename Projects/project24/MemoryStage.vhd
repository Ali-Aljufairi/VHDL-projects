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
    : IN std_logic;
    Rsrc1 : IN std_logic_vector(15 DOWNTO 0);
    PC : IN std_logic_vector(31 DOWNTO 0);
    ALU_res : IN std_logic_vector(15 DOWNTO 0);
    exception1 : OUT std_logic;
    exception2 : OUT std_logic;
    dataout : OUT std_logic_vector(31 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE instance OF MemoryStage IS

  SIGNAL SP_used_Address : std_logic_vector(31 DOWNTO 0);
  SIGNAL memo_datain : std_logic_vector(31 DOWNTO 0);
  SIGNAL memo_address : std_logic_vector(31 DOWNTO 0);
  SIGNAL temp_exception2 : std_logic;
  SIGNAL STD_i : std_logic;
BEGIN

  STD_i <= MW AND (NOT write32) AND (NOT SP_en);
  SP_address_mux : ENTITY work.SP_Address_Unit PORT MAP(clk, rst, PUSH_i,
    POP_i, CALL_i, RET_i, INT_i, RTI_i, SP_used_Address,
    temp_exception2);
  Memo_data_mux : ENTITY work.Memo_data_mux PORT MAP(SP_en, PUSH_i, STD_i, Rsrc1, ALU_res, PC, memo_datain);
  Memo_address_mux : ENTITY work.memo_address_mux PORT MAP(clk, MW, MR, rst, SP_en, temp_exception2, SP_used_Address, ALU_res, memo_address, exception1);
  Ram : ENTITY work.ram PORT MAP(clk, MW, write32, MR, memo_address, memo_datain, dataout);
  exception2 <= temp_exception2;
END ARCHITECTURE;