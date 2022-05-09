LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY CPU IS
    PORT (
        clk, RESET : IN STD_LOGIC;
        inPort : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        outPort : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END CPU;

ARCHITECTURE CPU_arch OF CPU IS
    -- decode 
    SIGNAL PCFetch : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL PCDecode : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- IF/ID
    SIGNAL PcIFIDIn, PCIFIDOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL IRIFIDIn, IRIFIDOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- decode
    SIGNAL IR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL controlSignals : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL RdstNewValue : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RdstWriteBackNum : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL loadFlagEXMEM : STD_LOGIC;
    SIGNAL loadFlagMEMWB : STD_LOGIC;
    SIGNAL RdestNumEXMEM : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL RdestNumMEMWB : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rdstOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rsrcOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL offsetOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL inputportOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rdstNumOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rsrcNumOut : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL PCIDEXIn, PCIDEXOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rdstOutIDEXIn, rdstOutIDEXOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rsrcOutIDEXIn, rsrcOutIDEXOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL offsetOutIDEXIn, offsetOutIDEXOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL inputportOutIDEXIn, inputportOutIDEXOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rdstNumOutIDEXIn, rdstNumOutIDEXOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rsrcNumOutIDEXIn, rsrcNumOutIDEXOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL controlSignalsOutIDEXIn, controlSignalsOutIDEXOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

    ---- ex
    SIGNAL memOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL aluOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL RdestOutEX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL aluOutEX : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RdestNum : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL controlSignalsEx : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL EXIn : STD_LOGIC_VECTOR(134 DOWNTO 0);
    SIGNAL EXOut : STD_LOGIC_VECTOR(134 DOWNTO 0);

    SIGNAL RdestOutEXBuffIn, aluOutEXBuffIn : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RdestNumBuffIn : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL flagOutBuffIn : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL flagOutBuffOut : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL controlOutBuffIn : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL RdestOutEXBuffOut, aluOutEXBuffOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RdestNumBuffOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL controlOutBuffOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- memory 
    SIGNAL memOutMEMWBIn, memOutMEMWBOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL aluOutMEMWBIn, aluOutMEMWBOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rdstNumOutMEMWBIn, rdstNumOutMEMWBOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL controlSignalsOutMEMWBIn, controlSignalsOutMEMWBOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL spOutMEMWBIn, spOutMEMWBOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- wb 
    SIGNAL controlOutMEMWB : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    --- fetch 
    fetch_stage_lbl :
    ENTITY work.fetch PORT MAP(clk, RESET, controlSignalsOutIDEXIn(21), IRIFIDOut, PCIFIDOut, PCIFIDIn, IRIFIDIn);

    fetch_stage_registerr_lbl_1 :
    ENTITY work.Reg  PORT MAP (clk, '0', '1', PCIFIDIn, PCIFIDOut);

    fetch_stage_registerr_lbl_2 :
    ENTITY work.Reg  PORT MAP (clk, RESET, '1', IRIFIDIn, IRIFIDOut);
    -- decode
    decode_stage_lbl : ENTITY work.decoding_stage  PORT MAP(clk, PCIFIDOut, IRIFIDOut, RdstNewValue, rdstNumOutMEMWBOut, inPort, flags, RESET, controlSignalsOutMEMWBOut(20), controlOutBuffIn(19), controlSignalsOutMEMWBOut(19), RdestNumBuffIn, rdstNumOutMEMWBOut, controlSignalsOutMEMWBOut(5 DOWNTO 4), PCIDEXIn, rdstOutIDEXIn, rsrcOutIDEXIn, offsetOutIDEXIn, inputportOutIDEXIn, rdstNumOutIDEXIn, rsrcNumOutIDEXIn, controlSignalsOutIDEXIn);

    decode_stage_reg_lbl_1 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', PCIDEXIn, PCIDEXOut);
    decode_stage_reg_lbl_2 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', rdstOutIDEXIn, rdstOutIDEXOut);
    decode_stage_reg_lbl_3 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', rsrcOutIDEXIn, rsrcOutIDEXOut);
    decode_stage_reg_lbl_4 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', offsetOutIDEXIn, offsetOutIDEXOut);
    decode_stage_reg_lbl_5 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', inputportOutIDEXIn, inputportOutIDEXOut);
    decode_stage_reg_lbl_6 : ENTITY work.Reg2  PORT MAP (clk, RESET, '1', rdstNumOutIDEXIn, rdstNumOutIDEXOut);
    decode_stage_reg_lbl_7 : ENTITY work.Reg2  PORT MAP (clk, RESET, '1', rsrcNumOutIDEXIn, rsrcNumOutIDEXOut);
    decode_stage_reg_lbl_8 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', controlSignalsOutIDEXIn, controlSignalsOutIDEXOut);

    --- exec stage

    exec_stage_lbl : ENTITY work.execute_stage  PORT MAP(clk, RESET, rdstOutIDEXOut, rsrcOutIDEXOut, RdstNewValue, aluOutEXBuffOut, inputportOutIDEXOut, offsetOutIDEXOut, rdstNumOutIDEXOut, rsrcNumOutIDEXOut, rdstNumOutMEMWBOut, RdestNumBuffOut, controlOutBuffOut(20), controlSignalsOutMEMWBOut(20), controlSignalsOutIDEXOut, flagOutBuffOut, flagOutBuffIn, RdestOutEXBuffIn, aluOutEXBuffIn, outPort, RdestNumBuffIn, controlOutBuffIn);
    EX_MEM_BUU_SIGNAL_1_lbl :
    ENTITY work.Reg  PORT MAP (clk, RESET, '1', RdestOutEXBuffIn, RdestOutEXBuffOut);
    EX_MEM_BUU_SIGNAL_2_lbl :
    ENTITY work.Reg PORT MAP (clk, RESET, '1', aluOutEXBuffIn, aluOutEXBuffOut);
    EX_MEM_BUU_SIGNAL_3_lbl :
    ENTITY work.Reg2  PORT MAP (clk, RESET, '1', RdestNumBuffIn, RdestNumBuffOut);
    EX_MEM_BUU_SIGNAL_4_lbl :
    ENTITY work.Reg3  PORT MAP (clk, RESET, '1', flagOutBuffIn, flagOutBuffOut);
    EX_MEM_BUU_SIGNAL_5_lbl :
    ENTITY work.Reg  PORT MAP (clk, RESET, '1', controlOutBuffIn, controlOutBuffOut);
    FLAG_REG_lbl : ENTITY work.Reg3  PORT MAP (clk, RESET, '1', flagOutBuffIn, flagOutBuffOut);
    -- memory 
    memory_stage_lbl : ENTITY work.memory PORT MAP (clk, RESET, controlOutBuffOut(0), controlOutBuffOut(1), controlOutBuffOut(9), RdestOutEXBuffOut, aluOutEXBuffOut, spOutMEMWBOut, controlOutBuffOut, RdestNumBuffOut, memOutMEMWBIn, aluOutMEMWBIn, controlSignalsOutMEMWBIn, rdstNumOutMEMWBIn, spOutMEMWBIn);

    MEM_WB_reg_lbl_1 : ENTITY work.Reg PORT MAP (clk, RESET, '1', memOutMEMWBIn, memOutMEMWBOut);
    MEM_WB_reg_lbl_2 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', aluOutMEMWBIn, aluOutMEMWBOut);
    MEM_WB_reg_lbl_3 : ENTITY work.Reg2  PORT MAP (clk, RESET, '1', rdstNumOutMEMWBIn, rdstNumOutMEMWBOut);
    MEM_WB_reg_lbl_4 : ENTITY work.Reg  PORT MAP (clk, RESET, '1', controlSignalsOutMEMWBIn, controlSignalsOutMEMWBOut);
    MEM_WB_reg_lbl_5 : ENTITY work.RegSP PORT MAP (clk, RESET, '1', spOutMEMWBIn, spOutMEMWBOut);

    --write back
    write_back_lbl : ENTITY work.write_back PORT MAP(RESET, rdstNumOutMEMWBOut, aluOutMEMWBOut, memOutMEMWBOut, controlSignalsOutMEMWBOut, RdstNewValue);

END CPU_arch; -- CPU_arch