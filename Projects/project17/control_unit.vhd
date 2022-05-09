
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
-- USE ieee.STD_LOGIC_ARITH.ALL;
-- USE ieee.STD_LOGIC_UNSIGNED.ALL;
USE work.ITCE364project.ALL;
ENTITY control_unit IS
  PORT (
    IR : IN std_logic_vector(31 DOWNTO 0);
    flags : IN std_logic_vector(2 DOWNTO 0);
    RESET : IN std_logic;
    loadFlagEXMEM : IN std_logic;
    loadFlagMEMWB : IN std_logic;
    RdestNumEXMEM : IN std_logic_vector(3 DOWNTO 0);
    RdestNumMEMWB : IN std_logic_vector(3 DOWNTO 0);
    memRead : OUT std_logic;
    memWrite : OUT std_logic;
    pcSelector : OUT std_logic;
    flagWrite : OUT std_logic;
    spOperationSelector : OUT std_logic_vector(1 DOWNTO 0);
    spWrite : OUT std_logic;
    rdstWBSeclector : OUT std_logic_vector(1 DOWNTO 0);
    memAddressSelector : OUT std_logic;
    outputPort : OUT std_logic;
    inputPort : OUT std_logic;
    aluSelect : OUT std_logic_vector(3 DOWNTO 0);
    clrCFlag : OUT std_logic;
    setCFlag : OUT std_logic;
    immFlag : OUT std_logic;
    loadFlag : OUT std_logic;
    rdstWB : OUT std_logic;
    loadUse : OUT std_logic
  );
END ENTITY;

ARCHITECTURE controle_unit_default OF control_unit IS
  SIGNAL operation : std_logic_vector(5 DOWNTO 0);
  -- define contants 

BEGIN
  load_use_detection_lbl : ENTITY work.laod_use_detection PORT MAP (IR, loadFlagEXMEM, RdestNumEXMEM, loadUse);

  immFlag <= IR(29);
  opCode <= to_integer(unsigned(IR(31 DOWNTO 24)));
  memRead <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '1' WHEN(opCode = POP) ELSE
    '1' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  memWrite <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '1' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '1' WHEN(opCode = STDF);
  pcSelector <= '1' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  flagWrite <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '1' WHEN(opCode = SETC) ELSE
    '1' WHEN(opCode = CLRC) ELSE
    '1' WHEN(opCode = CLR) ELSE
    '1' WHEN(opCode = NOTControl) ELSE
    '1' WHEN(opCode = INC) ELSE
    '1' WHEN(opCode = NEG) ELSE
    '1' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '1' WHEN(opCode = RLC) ELSE
    '1' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '1' WHEN(opCode = ADD) ELSE
    '1' WHEN(opCode = SUBF) ELSE
    '1' WHEN(opCode = ANDControl) ELSE
    '1' WHEN(opCode = ORControl) ELSE
    '1' WHEN(opCode = IADD) ELSE
    '1' WHEN(opCode = SHL) ELSE
    '1' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  spOperationSelector <= "00" WHEN(RESET = '1') ELSE
    "00" WHEN(opCode = NOP) ELSE
    "00" WHEN(opCode = SETC) ELSE
    "00" WHEN(opCode = CLRC) ELSE
    "00" WHEN(opCode = CLR) ELSE
    "00" WHEN(opCode = NOTControl) ELSE
    "00" WHEN(opCode = INC) ELSE
    "00" WHEN(opCode = NEG) ELSE
    "00" WHEN(opCode = DEC) ELSE
    "00" WHEN(opCode = OUTControl) ELSE
    "00" WHEN(opCode = INControl) ELSE
    "00" WHEN(opCode = RLC) ELSE
    "00" WHEN(opCode = RRC) ELSE
    "00" WHEN(opCode = MOV) ELSE
    "00" WHEN(opCode = ADD) ELSE
    "00" WHEN(opCode = SUBF) ELSE
    "00" WHEN(opCode = ANDControl) ELSE
    "00" WHEN(opCode = ORControl) ELSE
    "00" WHEN(opCode = IADD) ELSE
    "00" WHEN(opCode = SHL) ELSE
    "00" WHEN(opCode = SHR) ELSE
    "00" WHEN(opCode = LDM) ELSE
    "10" WHEN(opCode = PUSH) ELSE
    "01" WHEN(opCode = POP) ELSE
    "00" WHEN(opCode = LDD) ELSE
    "00" WHEN(opCode = STDF);
  spWrite <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '1' WHEN(opCode = PUSH) ELSE
    '1' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  rdstWBSeclector <= "00" WHEN(RESET = '1') ELSE
    "00" WHEN(opCode = NOP) ELSE
    "00" WHEN(opCode = SETC) ELSE
    "00" WHEN(opCode = CLRC) ELSE
    "01" WHEN(opCode = CLR) ELSE
    "01" WHEN(opCode = NOTControl) ELSE
    "01" WHEN(opCode = INC) ELSE
    "01" WHEN(opCode = NEG) ELSE
    "01" WHEN(opCode = DEC) ELSE
    "00" WHEN(opCode = OUTControl) ELSE
    "01" WHEN(opCode = INControl) ELSE
    "01" WHEN(opCode = RLC) ELSE
    "01" WHEN(opCode = RRC) ELSE
    "01" WHEN(opCode = MOV) ELSE
    "01" WHEN(opCode = ADD) ELSE
    "01" WHEN(opCode = SUBF) ELSE
    "01" WHEN(opCode = ANDControl) ELSE
    "01" WHEN(opCode = ORControl) ELSE
    "01" WHEN(opCode = IADD) ELSE
    "01" WHEN(opCode = SHL) ELSE
    "01" WHEN(opCode = SHR) ELSE
    "01" WHEN(opCode = LDM) ELSE
    "00" WHEN(opCode = PUSH) ELSE
    "10" WHEN(opCode = POP) ELSE
    "10" WHEN(opCode = LDD) ELSE
    "00" WHEN(opCode = STDF);
  memAddressSelector <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '1' WHEN(opCode = PUSH) ELSE
    '1' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  outputPort <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '1' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  inputPort <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '1' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  aluSelect <= "0000" WHEN(RESET = '1') ELSE
    "0000" WHEN(opCode = NOP) ELSE
    "0000" WHEN(opCode = SETC) ELSE
    "0000" WHEN(opCode = CLRC) ELSE
    "0001" WHEN(opCode = CLR) ELSE
    "0010" WHEN(opCode = NOTControl) ELSE
    "0011" WHEN(opCode = INC) ELSE
    "0100" WHEN(opCode = NEG) ELSE
    "0101" WHEN(opCode = DEC) ELSE
    "0000" WHEN(opCode = OUTControl) ELSE
    "1000" WHEN(opCode = INControl) ELSE
    "0110" WHEN(opCode = RLC) ELSE
    "0111" WHEN(opCode = RRC) ELSE
    "1000" WHEN(opCode = MOV) ELSE
    "1001" WHEN(opCode = ADD) ELSE
    "1010" WHEN(opCode = SUBF) ELSE
    "1011" WHEN(opCode = ANDControl) ELSE
    "1100" WHEN(opCode = ORControl) ELSE
    "1001" WHEN(opCode = IADD) ELSE
    "1101" WHEN(opCode = SHL) ELSE
    "1110" WHEN(opCode = SHR) ELSE
    "1111" WHEN(opCode = LDM) ELSE
    "0000" WHEN(opCode = PUSH) ELSE
    "0000" WHEN(opCode = POP) ELSE
    "1001" WHEN(opCode = LDD) ELSE
    "1001" WHEN(opCode = STDF);
  clrCFlag <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '1' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  setCFlag <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '1' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '0' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  loadFlag <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '0' WHEN(opCode = CLR) ELSE
    '0' WHEN(opCode = NOTControl) ELSE
    '0' WHEN(opCode = INC) ELSE
    '0' WHEN(opCode = NEG) ELSE
    '0' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '0' WHEN(opCode = INControl) ELSE
    '0' WHEN(opCode = RLC) ELSE
    '0' WHEN(opCode = RRC) ELSE
    '0' WHEN(opCode = MOV) ELSE
    '0' WHEN(opCode = ADD) ELSE
    '0' WHEN(opCode = SUBF) ELSE
    '0' WHEN(opCode = ANDControl) ELSE
    '0' WHEN(opCode = ORControl) ELSE
    '0' WHEN(opCode = IADD) ELSE
    '0' WHEN(opCode = SHL) ELSE
    '0' WHEN(opCode = SHR) ELSE
    '0' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '0' WHEN(opCode = POP) ELSE
    '1' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
  rdstWB <= '0' WHEN(RESET = '1') ELSE
    '0' WHEN(opCode = NOP) ELSE
    '0' WHEN(opCode = SETC) ELSE
    '0' WHEN(opCode = CLRC) ELSE
    '1' WHEN(opCode = CLR) ELSE
    '1' WHEN(opCode = NOTControl) ELSE
    '1' WHEN(opCode = INC) ELSE
    '1' WHEN(opCode = NEG) ELSE
    '1' WHEN(opCode = DEC) ELSE
    '0' WHEN(opCode = OUTControl) ELSE
    '1' WHEN(opCode = INControl) ELSE
    '1' WHEN(opCode = RLC) ELSE
    '1' WHEN(opCode = RRC) ELSE
    '1' WHEN(opCode = MOV) ELSE
    '1' WHEN(opCode = ADD) ELSE
    '1' WHEN(opCode = SUBF) ELSE
    '1' WHEN(opCode = ANDControl) ELSE
    '1' WHEN(opCode = ORControl) ELSE
    '1' WHEN(opCode = IADD) ELSE
    '1' WHEN(opCode = SHL) ELSE
    '1' WHEN(opCode = SHR) ELSE
    '1' WHEN(opCode = LDM) ELSE
    '0' WHEN(opCode = PUSH) ELSE
    '1' WHEN(opCode = POP) ELSE
    '1' WHEN(opCode = LDD) ELSE
    '0' WHEN(opCode = STDF);
END controle_unit_default; -- controle_unit_default