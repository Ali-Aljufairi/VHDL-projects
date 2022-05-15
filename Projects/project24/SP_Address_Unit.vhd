LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SP_Address_Unit IS
    PORT (
        -- TODO check if exception 2 is true
        clk,
        rst,
        -- signals at memory stage
        PUSH_i,
        POP_i,
        CALL_i,
        RET_i,
        INT_i,
        RTI_i : IN STD_LOGIC;
        SP_used_Address : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --address used to access memory
        exception2 : OUT STD_LOGIC
    );
END ENTITY SP_Address_Unit;

ARCHITECTURE instance OF SP_Address_Unit IS
    SIGNAL newSP : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SP_output : STD_LOGIC_VECTOR(31 DOWNTO 0); -- value stored in SP
BEGIN
    SP : ENTITY work.SP_entity PORT MAP(rst, clk, newSP, SP_output);

    PROCESS (clk, rst)IS
    BEGIN
        IF rst = '1' THEN
            exception2 <= '0';
        ELSIF falling_edge(clk) THEN -- TODO make async? (pop not 1 yet)
            IF ((unsigned(SP_output) = x"000fffff" AND POP_i = '1')
		 OR (unsigned(SP_output) = x"000ffffe" AND (RET_i = '1' OR RTI_i = '1'))
		 OR (unsigned(SP_output) = x"000fffff" AND (RET_i = '1' OR RTI_i = '1'))
		) THEN
                exception2 <= '1';
                ELSE
                     exception2 <='0'; -- once it is one, should stay?
            END IF;
        END IF;
    END PROCESS;
    -- exception2 <= '1'
    --     WHEN (unsigned(SP_output) = x"000fffff" AND POP_i = '1')
    --     OR
    --     (((unsigned(SP_output) = x"000ffffe") OR (unsigned(SP_output) = x"000fffff" ))AND (RET_i = '1' OR RTI_i = '1'))
    -- --     ELSE
    -- --     '0'
    -- --intended latch
    -- ;
    newSP <= STD_LOGIC_VECTOR(unsigned(SP_output) + 1)
        WHEN POP_i = '1' AND (unsigned(SP_output) /= x"000fffff")
        ELSE
        STD_LOGIC_VECTOR(unsigned(SP_output) + 2)
        WHEN (RET_i = '1' OR RTI_i = '1') AND (unsigned(SP_output) /= x"000ffffe") AND (unsigned(SP_output) /= x"000fffff")
        ELSE
        STD_LOGIC_VECTOR(unsigned(SP_output) - 1)
        WHEN PUSH_i = '1'
        ELSE
        STD_LOGIC_VECTOR(unsigned(SP_output) - 2)
        WHEN CALL_i = '1' OR INT_i = '1'
        ELSE
        SP_output
        ;
    SP_used_Address <= SP_output WHEN -- I don't care about its value after falling edge
        PUSH_i = '1'
        ELSE
        STD_LOGIC_VECTOR(unsigned(SP_output) + 1)
        WHEN POP_i = '1' AND (unsigned(SP_output) /= x"000fffff")
        ELSE
        STD_LOGIC_VECTOR(unsigned(SP_output) - 1) WHEN -- @ram: write32:let d = passed address:data is written in d and d+1 
        INT_i = '1' OR CALL_i = '1'
        ELSE
        STD_LOGIC_VECTOR(unsigned(SP_output) + 1)
        WHEN (RET_i = '1' OR RTI_i = '1') AND (unsigned(SP_output) /= x"000ffffe") AND (unsigned(SP_output) /= x"000fffff")
        ELSE
        SP_output -- should not be chosen & should not reach this else
        ;
END instance;