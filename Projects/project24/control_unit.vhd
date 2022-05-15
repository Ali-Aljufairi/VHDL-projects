LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control_unit IS
    PORT (
        -- INPUT
        opCode : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

        -- OUTPUT
        IN_en, -- input port enable
        OUT_en, -- output port enable
        ALU_en, -- ALU enable
        MR, -- Memory read - to read from memory
        MW, -- Memory Write - to write to memory
        WB, -- Write Back
        SP_en, -- Stack Pointer Enable - to change SP
        SP_op, -- Stack Pointer operation - +1 or -1?
        PC_en, -- Program Counter enable
        ALU_src, -- ALU source - 
        CF_en, ZF_en, NF_en, -- Flags enable - to change flags
        STD_FLAG, -- store flag - @opSTD - it is muxes' input to choose ALU src1, src2, offset
        CALL_i, -- CALL instruction - @opCALL
        INT_i, -- INT instruction - @opINT
        BRANCH_i, -- Branching instruction @opJMP, opJN, opJZ, opJC
        MEM_REG, -- Memory to Register @opLDD, opLDM, OPO?????????????
        RTI_i, -- RTI instruction @opRTI
        write32, -- flag to write 32 bit into memory or 16
        read32, -- flag to read 32 bit into memory or 16
        RET_i, -- RET instruction @opRET
        LDM_i,
        POP_i,
        PUSH_i : OUT STD_LOGIC;

        ALU_op : OUT STD_LOGIC_VECTOR(2 DOWNTO 0); -- ALU operation bits 
        -- SETC: 111
        -- NOT: 001
        -- INC: 010
        -- ADD: 110
        -- SUB: 100
        -- AND: 101
        -- MOV: 011

        JMP_op : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY control_unit;

ARCHITECTURE instance OF control_unit IS

    --opCodes
    CONSTANT opNOP : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000"; -- NOP
    CONSTANT opHLT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001"; -- HLT
    CONSTANT opSETC : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00010";-- SETC
    CONSTANT opNOT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00011";-- NOT Rdst
    CONSTANT opINC : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00100"; -- INC Rdst
    CONSTANT opOUT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00101"; -- OUT Rdst
    CONSTANT opIN : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00110"; -- IN Rdst

    CONSTANT opMOV : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01000"; -- MOV Rsrc, Rdst
    CONSTANT opADD : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01001"; -- ADD Rdst, Rsrc1, Rsrc2
    CONSTANT opSUB : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01010"; -- SUB Rdst, Rsrc1, Rsrc2
    CONSTANT opAND : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01011"; -- AND Rdst, Rsrc1, Rsrc2
    CONSTANT opIADD : STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";-- IADD Rdst, Rsrc, Imm

    CONSTANT opPUSH : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000"; -- PUSH Rdst
    CONSTANT opPOP : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10001"; -- POP Rdst
    CONSTANT opLDM : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10010"; -- LDM Rdst, Imm
    CONSTANT opLDD : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10011"; -- LDD Rdst, offset(Rsrc)
    CONSTANT opSTD : STD_LOGIC_VECTOR(4 DOWNTO 0) := "10100"; -- STD Rsrc1, offset(Rsrc2)

    CONSTANT opJZ : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11000"; -- JZ Rdst
    CONSTANT opJN : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11001"; -- JN Rdst
    CONSTANT opJC : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11010"; -- JC Rdst
    CONSTANT opJMP : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11011";-- JMP Rdst
    CONSTANT opCALL : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11100";-- CALL Rdst
    CONSTANT opRET : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11101";-- RET
    CONSTANT opINT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11110";-- INT index
    CONSTANT opRTI : STD_LOGIC_VECTOR(4 DOWNTO 0) := "11111";-- RTI

    -- ALU operations

    CONSTANT ALU_SETC : STD_LOGIC_VECTOR(2 DOWNTO 0) := "111";
    CONSTANT ALU_NOT : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT ALU_INC : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
    CONSTANT ALU_ADD : STD_LOGIC_VECTOR(2 DOWNTO 0) := "110";
    CONSTANT ALU_SUB : STD_LOGIC_VECTOR(2 DOWNTO 0) := "100";
    CONSTANT ALU_AND : STD_LOGIC_VECTOR(2 DOWNTO 0) := "101";
    CONSTANT ALU_MOV : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";
    CONSTANT ALU_NONE : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

    -- JMP operations

    CONSTANT JZ : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    CONSTANT JN : STD_LOGIC_VECTOR(2 DOWNTO 0) := "001";
    CONSTANT JC : STD_LOGIC_VECTOR(2 DOWNTO 0) := "010";
    CONSTANT JMP : STD_LOGIC_VECTOR(2 DOWNTO 0) := "011";

BEGIN
    IN_en <= '1' WHEN opCode = opIN ELSE
        '0';

    OUT_en <= '1' WHEN opCode = opOUT ELSE
        '0';
    write32 <= '1' WHEN
        opCode = opCALL OR
        opCode = opINT
        ELSE
        '0';
    read32 <= '1' WHEN
        opCode = opRET OR
        opCode = opRTI
        ELSE
        '0';
    LDM_i <= '1' WHEN
        opCode = opLDM
        ELSE
        '0';
    POP_i <= '1' WHEN
        opCode = opPOP
        ELSE
        '0';
    PUSH_i <= '1' WHEN
        opCode = opPUSH
        ELSE
        '0';
    ALU_en <= '1' WHEN
        opCode = opSETC OR
        opCode = opNOT OR
        opCode = opINC OR
        opCode = opOUT OR -- out?
        opCode = opMOV OR
        opCode = opAND OR
        opCode = opSUB OR
        opCode = opADD OR
        opCode = opIADD OR
        opCode = opPUSH OR --?
        opCode = opLDM OR
        opCode = opLDD OR
        opCode = opSTD OR
	opCode = opINT
        ELSE
        '0';

    MR <= '1' WHEN
        opCode = opLDD OR
        opCode = opPOP OR
        opCode = opRET OR
        opCode = opRTI
        ELSE
        '0';

    MW <= '1' WHEN
        opCode = opSTD OR
        opCode = opPUSH OR
        opCode = opCALL OR
        opCode = opINT
        ELSE
        '0';

    WB <= '1' WHEN
        opCode = opNOT OR
        opCode = opINC OR
        opCode = opIN OR
        opCode = opMOV OR
        opCode = opAND OR
        opCode = opSUB OR
        opCode = opADD OR
        opCode = opIADD OR
        opCode = opLDM OR
        opCode = opLDD OR
        opCode = opPOP -- ???
        ELSE
        '0';

    SP_en <= '1' WHEN
        opCode = opPUSH OR
        opCode = opPOP OR
        opCode = opCALL OR
        opCode = opINT OR --????
        opCode = opRET OR --???
        opCode = opRTI --???
        ELSE
        '0';

    SP_op <= '0'; --????????

    PC_en <= '0' WHEN
        opCode = opHLT -- Other cases??? mux outside the control unit for pc enable?
        ELSE
        '1';

    ALU_src <= '1' WHEN
        opCode = opLDD OR
        opCode = opSTD OR
        opCode = opIADD OR
	opCode = opINT
        ELSE
        '0';

    ALU_op <=
        ALU_SETC -- 111
        WHEN opCode = opSETC

        ELSE
        ALU_NOT -- 001
        WHEN opCode = opNOT

        ELSE
        ALU_INC -- 010
        WHEN opCode = opINC

        ELSE
        ALU_ADD -- 110
        WHEN
        opCode = opADD OR
        opCode = opIADD OR
        opCode = opLDD OR
        opCode = opSTD OR
	opCode = opINT

        ELSE
        ALU_SUB -- 100
        WHEN opCode = opSUB

        ELSE
        ALU_AND -- 101
        WHEN opCode = opAND

        ELSE
        ALU_MOV -- 011
        WHEN
        opCode = opMOV OR
        opCode = opOUT OR
        opCode = opPUSH OR
        opCode = opLDM -- ??????????? offset is ALU's src1???
        ELSE
        ALU_NONE; -- 000

    CF_en <= '1' WHEN
        opCode = opSETC OR
        opCode = opINC OR
        opCode = opSUB OR
        opCode = opADD OR
        opCode = opIADD
        ELSE
        '0';

    ZF_en <= '1' WHEN
        opCode = opNOT OR
        opCode = opINC OR
        opCode = opAND OR
        opCode = opSUB OR
        opCode = opADD OR
        opCode = opIADD
        ELSE
        '0';

    NF_en <= '1' WHEN
        opCode = opNOT OR
        opCode = opINC OR
        opCode = opAND OR
        opCode = opSUB OR
        opCode = opADD OR
        opCode = opIADD
        ELSE
        '0';

    STD_FLAG <= '1' WHEN
        opCode = opSTD
        ELSE
        '0';

    -- ADD TO TABLE
    CALL_i <= '1' WHEN opCode = opCALL
        ELSE
        '0';

    INT_i <= '1' WHEN opCode = opINT
        ELSE
        '0';

    BRANCH_i <= '1' WHEN
        opCode = opJMP OR
        opCode = opJN OR
        opCode = opJZ OR
        opCode = opJC
        ELSE
        '0';

    JMP_op <=
        JZ
        WHEN opCode = opJZ
        ELSE
        JN
        WHEN opCode = opJN
        ELSE
        JC
        WHEN opCode = opJC
        ELSE
        JMP
        WHEN
        opCode = opJMP
        ELSE
        (OTHERS => '0');

    MEM_REG <= '1' WHEN --???
        -- opCode = opLDM OR
        opCode = opLDD OR
        opCode = opPOP
        ELSE
        '0';

    RTI_i <= '1' WHEN
        opCode = opRTI
        ELSE
        '0';

    RET_i <= '1' WHEN
        opCode = opRET
        ELSE
        '0';
END instance;