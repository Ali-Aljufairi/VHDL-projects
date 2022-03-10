-- Shift Register with asynchronous reset
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.ITCE211Project_library.ALL;
-----------------------------------------------------------------------------------------
ENTITY shift_reg IS
    PORT (
	      clk: in std_logic ; 
         shift, reset, load : IN STD_LOGIC :='0';
        numbers : IN STD_LOGIC_VECTOR((data_output - 1) DOWNTO 0):=(OTHERS => '0'); -- input
        top_numbers : OUT STD_LOGIC_VECTOR((data_width - 1) DOWNTO 0) -- output
    );
END ENTITY;

-----------------------------------------------------------------------------------------
ARCHITECTURE rtl OF shift_reg IS
    SIGNAL sr : STD_LOGIC_VECTOR((data_output - 1) DOWNTO 0) := (OTHERS => '0'); 
    SIGNAL result : STD_LOGIC_VECTOR((data_width - 1) DOWNTO 0) := (OTHERS => '0');
    CONSTANT zero_in : STD_LOGIC_VECTOR((data_width - 1) DOWNTO 0) := (OTHERS => '0');

BEGIN
    -- the output of shift register
    top_numbers <= result;
    PROCESS (clk, reset, load, numbers)
    BEGIN

        -- asynchronous reset
        IF reset = '1' THEN
            sr <= (OTHERS => '0');
            result <= (OTHERS => '0');

            -- asynchronous load
        ELSIF load = '1' THEN
            sr <= numbers;

        ELSIF rising_edge(clk) THEN

            -- shift register process
            IF shift = '1' THEN
                sr <= zero_in & sr((data_output - 1) DOWNTO (data_width));
                result <= sr((data_width - 1) DOWNTO 0);

            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;