LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.ITCE211Project_library.ALL;

ENTITY pe_array IS

    PORT (
        reset, clk : IN STD_LOGIC;
        eni : IN STD_LOGIC := '0';
        numberin : IN STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0) := (OTHERS => '0');
        numbercotnacted : OUT STD_LOGIC_VECTOR (data_output - 1 DOWNTO 0) := (OTHERS => '0')

    );
END ENTITY;

ARCHITECTURE rtl OF pe_array IS
    COMPONENT pe IS
        PORT (
            numberin : IN STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0);
            numberout : OUT STD_LOGIC_VECTOR (data_width - 1 DOWNTO 0);
            clk, eni, reset : IN STD_LOGIC;
            eno : OUT STD_LOGIC;
				number: OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
        );

    END COMPONENT;
	 
	 
	 
	 
    ----------------------Signals-------------------------------------
    SIGNAL number_sig, numberout_sig : vector_array(number_of_pe - 1 DOWNTO 0) := (OTHERS => (OTHERS => '0'));
    SIGNAL enablesig : STD_LOGIC_VECTOR(number_of_pe - 1 DOWNTO 0) := (OTHERS => '0');
	 
	 
BEGIN

    ----------------------Generate component-------------------------------------
	
	 
    Gen_PE : FOR i IN 0 TO number_of_PE - 1 GENERATE
        Gen_PE0 : IF i = 0 GENERATE
            Processing_Element : pe PORT MAP(
                numberin => numberin,
                numberout => numberout_sig(0),
					 number => number_sig(0),
                eno => enablesig(0),
                clk => clk,
                reset => reset,
                eni => eni);
        END GENERATE Gen_PE0;
		  
		  
        Gen_PE1 : IF i > 0 AND i < number_of_PE - 1 GENERATE
            Processing_Element : pe PORT MAP(
                numberin => numberout_sig(i - 1),
                eni => enablesig(i - 1),
					 number => number_sig(i),
                numberout => numberout_sig(i),
                eno => enablesig(i),
                clk => clk,
                reset => reset);
        END GENERATE Gen_PE1;
		  
		  
        Gen_PE2 : IF i = number_of_PE - 1 GENERATE
            Processing_Element : pe PORT MAP(
                numberin => numberout_sig(i - 1),
                eni => enablesig(i - 1),
					 number => number_sig(i),
                numberout => OPEN,
                eno => OPEN,
                clk => clk,
                reset => reset 
            );
        END GENERATE Gen_PE2;
		  
    END GENERATE Gen_PE;
	 
	
	 
	 concatenting : PROCESS (number_sig) IS
    BEGIN
            L1 : FOR i IN 0 TO number_of_pe - 1 LOOP
                numbercotnacted((data_width - 1) + i * data_width  DOWNTO 0 + i *data_width ) <= number_sig(i);
            END LOOP L1;
    END PROCESS concatenting;
	 

END ARCHITECTURE;