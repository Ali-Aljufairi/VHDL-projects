LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project IS

  ---------------------Constant Declarations---------------------
  CONSTANT opcodesize : integer := 15;
  CONSTANT width_size : integer := 31;
  CONSTANT ramSize : integer := 2500;

  ------------------ Ram Type ------------------  
  TYPE ram_type IS ARRAY(0 TO ramSize ) OF std_logic_vector(opcodesize DOWNTO 0); --$ Ram
  --------------------OP CODES--------------------
  CONSTANT opNOP : std_logic_vector(4 DOWNTO 0) := "00000"; --$ NOP
  CONSTANT opHLT : std_logic_vector(4 DOWNTO 0) := "00001"; --$ HLT
  CONSTANT opSETC : std_logic_vector(4 DOWNTO 0) := "00010";--$ SETC
  CONSTANT opNOT : std_logic_vector(4 DOWNTO 0) := "00011"; --$ NOT Rdst
  CONSTANT opINC : std_logic_vector(4 DOWNTO 0) := "00100"; --$ INC Rdst
  CONSTANT opOUT : std_logic_vector(4 DOWNTO 0) := "00101"; --$ OUT Rdst
  CONSTANT opIN : std_logic_vector(4 DOWNTO 0) := "00110"; --$ IN Rdst

  CONSTANT opMOV : std_logic_vector(4 DOWNTO 0) := "01000"; --$ MOV Rsrc, Rdst
  CONSTANT opADD : std_logic_vector(4 DOWNTO 0) := "01001"; --$ ADD Rdst, Rsrc1, Rsrc2
  CONSTANT opSUB : std_logic_vector(4 DOWNTO 0) := "01010"; --$ SUB Rdst, Rsrc1, Rsrc2
  CONSTANT opAND : std_logic_vector(4 DOWNTO 0) := "01011"; --$ AND Rdst, Rsrc1, Rsrc2
  CONSTANT opIADD : std_logic_vector(4 DOWNTO 0) := "01100";--$ IADD Rdst, Rsrc, Imm

  CONSTANT opPUSH : std_logic_vector(4 DOWNTO 0) := "10000";--$ PUSH Rdst
  CONSTANT opPOP : std_logic_vector(4 DOWNTO 0) := "10001"; --$ POP Rdst
  CONSTANT opLDM : std_logic_vector(4 DOWNTO 0) := "10010"; --$ LDM Rdst, Imm
  CONSTANT opLDD : std_logic_vector(4 DOWNTO 0) := "10011"; --$ LDD Rdst, offset(Rsrc)
  CONSTANT opSTD : std_logic_vector(4 DOWNTO 0) := "10100"; --$ STD Rsrc1, offset(Rsrc2)

  CONSTANT opJZ : std_logic_vector(4 DOWNTO 0) := "11000"; --$ JZ Rdst
  CONSTANT opJN : std_logic_vector(4 DOWNTO 0) := "11001"; --$ JN Rdst
  CONSTANT opJC : std_logic_vector(4 DOWNTO 0) := "11010"; --$ JC Rdst
  CONSTANT opJMP : std_logic_vector(4 DOWNTO 0) := "11011"; --$ JMP Rdst
  CONSTANT opCALL : std_logic_vector(4 DOWNTO 0) := "11100";--$ CALL Rdst
  CONSTANT opRET : std_logic_vector(4 DOWNTO 0) := "11101"; --$ RET
  CONSTANT opINT : std_logic_vector(4 DOWNTO 0) := "11110"; --$ INT index
  CONSTANT opRTI : std_logic_vector(4 DOWNTO 0) := "11111"; --$ RTI

  ---------- ALU operations----------------------------

  CONSTANT ALU_SETC : std_logic_vector(2 DOWNTO 0) := "111";
  CONSTANT ALU_NOT : std_logic_vector(2 DOWNTO 0) := "001";--$ ALU_NOT instruction
  CONSTANT ALU_INC : std_logic_vector(2 DOWNTO 0) := "010";--$ ALU_INC instruction    
  CONSTANT ALU_ADD : std_logic_vector(2 DOWNTO 0) := "110";--$ ALU_ADD instruction
  CONSTANT ALU_SUB : std_logic_vector(2 DOWNTO 0) := "100";--$ ALU_SUB  instruction
  CONSTANT ALU_AND : std_logic_vector(2 DOWNTO 0) := "101";--$ ALU_AND  instruction
  CONSTANT ALU_MOV : std_logic_vector(2 DOWNTO 0) := "011";--$ ALU_MOV    instruction
  CONSTANT ALU_NONE : std_logic_vector(2 DOWNTO 0) := "000";--$ ALU_NONE instruction

  ------------------ jMP types ----------------------------

  CONSTANT JZ : std_logic_vector(2 DOWNTO 0) := "000";--$ JZ
  CONSTANT JN : std_logic_vector(2 DOWNTO 0) := "001";--$ JN
  CONSTANT JC : std_logic_vector(2 DOWNTO 0) := "010";--$ JC
  CONSTANT JMP : std_logic_vector(2 DOWNTO 0) := "011";--$ JMP

END PACKAGE;