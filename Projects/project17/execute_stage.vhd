LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364project.ALL;


ENTITY execute_stage IS
  PORT (
    clk, RESET : IN STD_LOGIC;
    Rdest, Rsrc : IN STD_LOGIC_VECTOR (op_size-1 DOWNTO 0);
    memOut, aluOut : IN STD_LOGIC_VECTOR (op_size-1 DOWNTO 0);
    inPort, offset : IN STD_LOGIC_VECTOR (op_size-1 DOWNTO 0);
    RdestNumID, RsrcNumID, RdestNumMem, RdestNumEX : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    wbEX, wbMem : IN STD_LOGIC;
    control : IN STD_LOGIC_VECTOR (controlSignalSize - 1 DOWNTO 0);
    flagIn: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    flagOut: Out STD_LOGIC_VECTOR (2 DOWNTO 0);
    RdestOutEX, aluOutEX, outPort : OUT STD_LOGIC_VECTOR (op_size-1 DOWNTO 0);
    RdestNum : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    controlOut : OUT STD_LOGIC_VECTOR (controlSignalSize - 1 DOWNTO 0)
  );
END execute_stage;

ARCHITECTURE executeArch OF execute_stage IS
  ---------------------
  -- Components
  ---------------------
  COMPONENT alu IS
    PORT (
      A, B : IN STD_LOGIC_VECTOR (op_size-1 DOWNTO 0);
      selector : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      cin : IN STD_LOGIC;
      F : OUT STD_LOGIC_VECTOR (op_size-1 DOWNTO 0);
      cout : OUT STD_LOGIC);
  END COMPONENT;

  COMPONENT forwarding IS
    PORT (
      srcNumID, destNumEX, destNumMem : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      wbEX, wbMem : IN STD_LOGIC;
      selector : OUT STD_LOGIC_VECTOR (1 DOWNTO 0));
  END COMPONENT;

  COMPONENT flag IS
    PORT (
      clk,reset, cin, changeEnable, setCarry, clrCarry : IN STD_LOGIC;
      inFlag : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      F : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      aluSelect: IN std_logic_vector(3 downto 0);
      outFlag : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
  END COMPONENT;
  ---------------------
  -- Signals
  ---------------------
  SIGNAL writeFlags, writeOut, immediate, readInputPort, aluCout : STD_LOGIC;
  SIGNAL setCarry, clrCarry : STD_LOGIC;
  SIGNAL aluSelect : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL srcIn, forwardedDest, aluIn1, aluIn2, aluTemp : STD_LOGIC_VECTOR(op_size-1 DOWNTO 0);
  SIGNAL inSel1, inSel2 : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
  writeFlags <= control(3);
  writeOut <= control(10);
  readInputPort <= control(11);
  aluSelect <= control(15 DOWNTO 12);
  clrCarry <= control(16);
  setCarry <= control(17);
  immediate <= control(18);
  srcIn <= inPort WHEN readInputPort = '1'
    ELSE
    Rsrc;

  SelIn1 : forwarding PORT MAP(RsrcNumID, RdestNumEX, RdestNumMem, wbEX, wbMem, inSel1);
  SelIn2 : forwarding PORT MAP(RdestNumID, RdestNumEX, RdestNumMem, wbEX, wbMem, inSel2);

  aluIn1 <= memOut WHEN inSel1 = "01"
    ELSE
    aluOut WHEN inSel1 = "10"
    ELSE
    srcIn;

  forwardedDest <= memOut WHEN inSel2 = "01"
    ELSE
    aluOut WHEN inSel2 = "10"
    ELSE
    Rdest;

  aluIn2 <= offset WHEN immediate = '1'
    ELSE
    forwardedDest;

  aluComp : alu  PORT MAP(aluIn1, aluIn2, aluSelect, flagIn(2), aluTemp, aluCout);

  flagComp : flag PORT MAP(clk,RESET, aluCout, writeFlags, setCarry, clrCarry, flagIn, aluTemp,aluSelect, flagOut);

  aluOutEx <= aluTemp;
  outPort <= forwardedDest WHEN writeOut = '1';
  RdestOutEX <= forwardedDest;
  controlOut <= control;
  RdestNum <= RdestNumID;

END executeArch;