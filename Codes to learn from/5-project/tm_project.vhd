LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ITCE211Project_library.ALL;

ENTITY tm_project IS

    PORT (
        reset, load, shift : IN STD_LOGIC := '0';
        eni : IN STD_LOGIC := '1';
        clk : IN STD_LOGIC;
        numberin : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
        top_numbers : OUT STD_LOGIC_VECTOR((data_width - 1) DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF tm_project IS
 ---------------- Signal -------------------

    SIGNAL numberfrompetoreg : STD_LOGIC_VECTOR(data_output - 1 DOWNTO 0);
    COMPONENT pe_array
        PORT (
            reset, clk : IN STD_LOGIC;
            eni : IN STD_LOGIC := '0';
            numberin : IN STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0) := (OTHERS => '0');
            numbercotnacted : OUT STD_LOGIC_VECTOR (data_output - 1 DOWNTO 0) := (OTHERS => '0')

        );

    END COMPONENT;

    COMPONENT shift_reg
        PORT (
            clk, shift, reset, load : IN STD_LOGIC;
            numbers : IN STD_LOGIC_VECTOR((data_output - 1) DOWNTO 0);
            top_numbers : OUT STD_LOGIC_VECTOR((data_width - 1) DOWNTO 0)
        );

    END COMPONENT;

BEGIN

    t1 : pe_array PORT MAP(eni => eni, reset => reset, clk => clk, numberin => numberin, numbercotnacted => numberfrompetoreg);
    t2 : shift_reg PORT MAP(
        clk => clk, shift => shift, reset => reset,
        load => load, top_numbers => top_numbers, numbers => numberfrompetoreg);

END rtl;