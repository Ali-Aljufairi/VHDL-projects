LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.textio.ALL;
USE ieee.std_logic_textio.ALL;
use ieee.math_real.all;
USE work.ITCE211Project_library.ALL;

ENTITY tm_project_ulimate_tb IS

END ENTITY;

ARCHITECTURE rtl OF tm_project_ulimate_tb IS

    COMPONENT tm_project
        PORT (
            clk : IN STD_LOGIC;
            reset, load, shift : IN STD_LOGIC := '0';
            eni : IN STD_LOGIC := '1';
            top_numbers : OUT STD_LOGIC_VECTOR((data_width - 1) DOWNTO 0):= (OTHERS => '0');
            numberin : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
        );
    END COMPONENT;

    ---------------- Signal -------------------

    SIGNAL rand_num : INTEGER := 0;----random number value 
	SIGNal randomwait : std_logic := '0'; ------ signal to be used to stop other procces from running 
	SIGnal randomwait2 : std_logic := '1';------ signal to be used to stop other procces from running 
    SIGNAL randomsig : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
    FILE writonfile : text;
    SIGNAL clk, reset, load, shift : STD_LOGIC := '0';
    SIGNAL eni : STD_LOGIC := '1';
    SIGNAL top_numbers, numberin : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
    FILE file_VECTORS : text;
    FILE file_RESULTS : text;
BEGIN

   PROCESS
        VARIABLE seed1, seed2 : POSITIVE; -- seed values  that are to be used to generate randome random numbers 
        VARIABLE rand : real; -- random real-numbwer  
        VARIABLE range_of_rand : real := Maxiumnumber; -- the Maxiumnumber that could be generate it 
        VARIABLE randomsigtofile : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE Write_line : line;----- line to be ussed to store generate random numbers 
    BEGIN
        file_open(writonfile, "D:\UNI\ITCE211\Codes\projectfinalstages\report\input.txt", write_mode);------- open file in write mode 

        FOR i IN 0 TO number_of_numberin - 1 LOOP

            uniform(seed1, seed2, rand); -- unifrom is a function frojm  math library to generate random values from 0 to 1
            rand_num <= INTEGER(rand * range_of_rand); -- convert to int
            randomsigtofile := STD_LOGIC_VECTOR(to_unsigned(rand_num, data_width));-- convert and store in the randomfile
            randomsig <= randomsigtofile;-------- store in a singal so we can monitor the output
            write(Write_line, randomsig); ------ write the value on the file  and use it 
            writeline(writonfile, Write_line);----- write what you have saved 
            WAIT FOR 10 ns;
        END LOOP;
        file_close(writonfile);
		   randomwait <= '1'; ---- this act lke enable to the second proccess 
        WAIT;
		  
		  
    END PROCESS;

    ---------------- maping to test bench  -------------------

    uut : tm_project PORT MAP(clk, reset, load, shift, eni, top_numbers, numberin);

    ---------------- GENERATE CLOCK -------------------
    
    PROCESS

    BEGIN
        clk <= '1';
        WAIT FOR 100 ns;
        clk <= '0';
        WAIT FOR 100 ns;
    END PROCESS;

    ----------------- STIMULUS PROCESS -------------------

    PROCESS
        VARIABLE read_line : line;
        VARIABLE write_line : line;
        VARIABLE numberinfromfile : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
        VARIABLE top_numbersfromfile : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  
    BEGIN

      wait until randomwait = randomwait2 ;
        ----------------- open files -------------------

        file_open(file_VECTORS, "D:\UNI\ITCE211\Codes\projectfinalstages\report\input.txt", read_mode);
        file_open(file_RESULTS, "D:\UNI\ITCE211\Codes\projectfinalstages\report\output.txt", write_mode);

        ----------------- intiliazeing  ports -------------------

        
        --------------------ports config -----------------------
        
        reset <= '0';
        load <= '1';
        shift <= '0';
        eni <= '1';




       ------------------To read until the end file----------------
        WHILE NOT endfile(file_VECTORS) LOOP
            ----------------- read from file  -------------------

            FOR i IN 0 TO number_of_numberin - 1 LOOP

                readline(file_VECTORS, read_line);
                read(read_line, numberinfromfile);
                numberin <= numberinfromfile;
                WAIT FOR 200 ns;
            END LOOP;

            ----------------stop numbers from enterining--------

            eni <= '0';


            ------------wait until numbers are in numbercotnacted -----------
            FOR i IN 0 TO number_of_numberin - 2 LOOP
                WAIT FOR 200 ns;
            END LOOP;
            --------------------------- re-config ports-------------------------------------

    
            eni <= '0';
            load <= '0';
            shift <= '1';
            

            WAIT FOR 200 ns;

            ---------------- write to  file  -------------------

            FOR i IN 0 TO number_of_PE - 1 LOOP

                write(write_line, top_numbers);
                writeline(file_RESULTS, write_line);
                WAIT FOR 200 ns;

            END LOOP;

        END LOOP;
        ---------------- close file   -------------------

        file_close(file_VECTORS);
        file_close(file_RESULTS);
        WAIT;

    END PROCESS;
END rtl;