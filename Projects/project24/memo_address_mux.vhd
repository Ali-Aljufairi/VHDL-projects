LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY memo_address_mux IS
    PORT (
        clk : IN STD_LOGIC;
        MW : IN STD_LOGIC;
        MR : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        SP_en : IN STD_LOGIC;
        exception2 : IN STD_LOGIC;
        SP_used_Address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALU_res : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        memo_address : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        exception1 : OUT STD_LOGIC
    );
END ENTITY memo_address_mux;

ARCHITECTURE instance OF memo_address_mux IS

BEGIN
    PROCESS (clk, rst)IS
    BEGIN
        IF rst = '1' THEN
            exception1 <= '0';
        ELSIF falling_edge(clk) THEN -- TODO make async? (pop not 1 yet)
            IF (unsigned(ALU_res) > x"ff00") AND (SP_en = '0') AND ((MW = '1') OR (MR = '1'))
                THEN
                exception1 <= '1';
            ELSE
                exception1 <= '0'; -- once it is one, should stay?
            END IF;
        END IF;
    END PROCESS;
    -- exception1 <= '0' WHEN rst = '1'
    --     ELSE
    --     '1' WHEN (unsigned(ALU_res) > x"ff00") AND (SP_en = '0') AND (MW = '1') AND (MR = '1')
    --     ELSE
    -- '0'; -- intended latch
    memo_address <=
        SP_used_Address
        WHEN SP_en = '1'
        ELSE
        x"0000" & ALU_res
        ;
END instance;