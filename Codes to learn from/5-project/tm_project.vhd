LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ITCE211Project_library.ALL;

ENTITY tm_project IS

  PORT (
    reset, load, shift : IN std_logic := '0';
    eni : IN std_logic := '1';
    clk : IN std_logic;
    numberin : IN std_logic_vector(data_width - 1 DOWNTO 0);
    top_numbers : OUT std_logic_vector((data_width - 1) DOWNTO 0));
END ENTITY;

ARCHITECTURE rtl OF tm_project IS
  ---------------- Signal -------------------

  SIGNAL numberfrompetoreg : std_logic_vector(data_output - 1 DOWNTO 0);
  COMPONENT pe_array
    PORT (
      reset, clk : IN std_logic;
      eni : IN std_logic := '0';
      numberin : IN std_logic_vector (data_width - 1 DOWNTO 0) := (OTHERS => '0');
      numbercotnacted : OUT std_logic_vector (data_output - 1 DOWNTO 0) := (OTHERS => '0'));

  END COMPONENT;

  COMPONENT shift_reg
    PORT (
      clk, shift, reset, load : IN std_logic;
      numbers : IN std_logic_vector((data_output - 1) DOWNTO 0);
      top_numbers : OUT std_logic_vector((data_width - 1) DOWNTO 0)  );

  END COMPONENT;

BEGIN

  t1 : pe_array PORT MAP(eni => eni, reset => reset, clk => clk, numberin => numberin, numbercotnacted => numberfrompetoreg);
  t2 : shift_reg PORT MAP(
    clk => clk, shift => shift, reset => reset,
    load => load, top_numbers => top_numbers, numbers => numberfrompetoreg);

END rtl;