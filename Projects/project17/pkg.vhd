
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
PACKAGE ITCE364Project IS

Constant Op_size : integer := 32;
Constant Op_sizet4 : integer := 4;
Constant Op_sizet3 : integer := 3;


Constant memorySize : INTEGER := 65536;
Constant dataLineWidth : INTEGER := 32;
Constant addressLineWidth : INTEGER := 16;
Constant controlSignalsSize : INTEGER := 32;
Constant controlSignalSize : INTEGER := 32;







-----------------------------------------------------------------
CONSTANT NOP : INTEGER := 16#0#;
CONSTANT SETC : INTEGER := 16#1#;
CONSTANT CLRC : INTEGER := 16#2#;
CONSTANT CLR : INTEGER := 16#10#;
CONSTANT NOTControl : INTEGER := 16#11#;
CONSTANT INC : INTEGER := 16#12#;
CONSTANT NEG : INTEGER := 16#13#;
CONSTANT DEC : INTEGER := 16#14#;
CONSTANT OUTControl : INTEGER := 16#15#;
CONSTANT INControl : INTEGER := 16#16#;
CONSTANT RLC : INTEGER := 16#17#;
CONSTANT RRC : INTEGER := 16#18#;
CONSTANT MOV : INTEGER := 16#40#;
CONSTANT ADD : INTEGER := 16#41#;
CONSTANT SUBF : INTEGER := 16#42#;
CONSTANT ANDControl : INTEGER := 16#43#;
CONSTANT ORControl : INTEGER := 16#44#;
CONSTANT IADD : INTEGER := 16#65#;
CONSTANT SHL : INTEGER := 16#66#;
CONSTANT SHR : INTEGER := 16#67#;
CONSTANT LDM : INTEGER := 16#68#;
CONSTANT PUSH : INTEGER := 16#80#;
CONSTANT POP : INTEGER := 16#81#;
CONSTANT LDD : INTEGER := 16#b0#;
CONSTANT STDF : INTEGER := 16#b1#;
CONSTANT RET : INTEGER := 16#c0#;
CONSTANT RTI : INTEGER := 16#c1#;
CONSTANT JZ : INTEGER := 16#d0#;
CONSTANT JN : INTEGER := 16#d1#;
CONSTANT JC : INTEGER := 16#d2#;
CONSTANT JMP : INTEGER := 16#d3#;
CONSTANT CALL : INTEGER := 16#d4#;
SIGNAL opCode : INTEGER;










-----------------------------TYPES------------------------------------- 
TYPE ram_type IS ARRAY(0 TO memorySize - 1) OF STD_LOGIC_VECTOR(addressLineWidth - 1 DOWNTO 0);



           



END PACKAGE ;
