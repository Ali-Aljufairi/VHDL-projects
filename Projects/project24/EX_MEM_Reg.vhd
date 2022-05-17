
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY EX_MEM_Reg IS
  PORT (
    en : IN std_logic;
    clk : IN std_logic;
    rst : IN std_logic;
    -- input data
    INDATA_E : IN std_logic_vector(15 DOWNTO 0);
    PC_E : IN std_logic_vector(31 DOWNTO 0);
    src1_E : IN std_logic_vector(15 DOWNTO 0);
    offset_E : IN std_logic_vector(15 DOWNTO 0);
    ALU_res_E : IN std_logic_vector(15 DOWNTO 0);
    dst_E : IN std_logic_vector(2 DOWNTO 0);
    -- control signals	
    IN_en_E, OUT_en_E,
    MemRead_E, MemWrite_E,
    WriteBack_E, MemToReg_E,
    SP_en_E, SP_op_E,
    write32_E, read32_E,
    STD_flag_E,
    Call_flag_E, INT_flag_E,
    RTI_flag_E,
    RET_flag_E,
    POP_flag_E,
    PUSH_flag_E : IN std_logic;
    -- output data
    INDATA_M : OUT std_logic_vector(15 DOWNTO 0);
    PC_M : OUT std_logic_vector(31 DOWNTO 0);
    src1_M : OUT std_logic_vector(15 DOWNTO 0);
    offset_M : OUT std_logic_vector(15 DOWNTO 0);
    ALU_res_M : OUT std_logic_vector(15 DOWNTO 0);
    dst_M : OUT std_logic_vector(2 DOWNTO 0);
    -- control signals	
    IN_en_M, OUT_en_M,
    MemRead_M, MemWrite_M,
    WriteBack_M, MemToReg_M,
    SP_en_M, SP_op_M,
    write32_M, read32_M,
    STD_flag_M,
    Call_flag_M, INT_flag_M,
    RTI_flag_M,
    RET_flag_M,
    POP_flag_M,
    PUSH_flag_M : OUT std_logic
  );
END ENTITY;
ARCHITECTURE rtl OF EX_MEM_Reg IS
BEGIN
  PROCESS (clk, rst, en) IS
  BEGIN
    IF (rst = '1') THEN
      INDATA_M <= (OTHERS => '0');
      PC_M <= (OTHERS => '0');
      src1_M <= (OTHERS => '0');
  
      offset_M <= (OTHERS => '0');
      ALU_res_M <= (OTHERS => '0');
      dst_M <= (OTHERS => '0');
    
      IN_en_M <= '0';
      OUT_en_M <= '0';
    
      MemRead_M <= '0';
      MemWrite_M <= '0';
      WriteBack_M <= '0';
      MemToReg_M <= '0';
      write32_M <= '0';
    
      read32_M <= '0';
      SP_en_M <= '0';
      SP_op_M <= '0';
  
      STD_flag_M <= '0';
      Call_flag_M <= '0';
      INT_flag_M <= '0';
   
      RTI_flag_M <= '0';
      RET_flag_M <= '0';
      POP_flag_M <= '0';
      PUSH_flag_M <= '0';
    ELSIF (rising_edge(clk)) THEN
      IF en = '1' THEN
        INDATA_M <= INDATA_E;
        PC_M <= PC_E;
        src1_M <= src1_E;

        offset_M <= offset_E;
        ALU_res_M <= ALU_res_E;
        dst_M <= dst_E;

        IN_en_M <= IN_en_E;
        OUT_en_M <= OUT_en_E;

        MemRead_M <= MemRead_E;

        MemWrite_M <= MemWrite_E;
        WriteBack_M <= WriteBack_E;
        MemToReg_M <= MemToReg_E;
        write32_M <= write32_E;
        read32_M <= read32_E;
        SP_en_M <= SP_en_E;
        SP_op_M <= SP_op_E;

        STD_flag_M <= STD_flag_E;
        Call_flag_M <= Call_flag_E;
        INT_flag_M <= INT_flag_E;

        RTI_flag_M <= RTI_flag_E;
        RET_flag_M <= RET_flag_E;
        POP_flag_M <= POP_flag_E;
        PUSH_flag_M <= PUSH_flag_E;
      END IF;
    END IF;
  END PROCESS;
END ARCHITECTURE;