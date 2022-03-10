LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE work.ITCE211Project_library.ALL;

ENTITY tm_project_tb IS

END ENTITY;

ARCHITECTURE rtl OF tm_project_tb IS

    COMPONENT tm_project
        PORT (
            clk : IN STD_LOGIC;
            reset, load, shift : IN STD_LOGIC := '0';
            eni : IN STD_LOGIC := '1';
            top_numbers : OUT STD_LOGIC_VECTOR((data_width - 1) DOWNTO 0);
            numberin : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
        );
    END COMPONENT;

    ---------------- Signal -------------------

    SIGNAL clk, reset, load, shift : STD_LOGIC := '0'; 
    SIGNAL eni : STD_LOGIC := '1';
    SIGNAL top_numbers, numberin : STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0):= "10010100101110001101101011001110";
    FILE file_VECTORS : text;
    FILE file_RESULTS : text;
BEGIN

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

        ----------------- open files -------------------

        file_open(file_VECTORS, "D:\UNI\ITCE211\Codes\projectfinalstages\report\input.txt", read_mode);
        file_open(file_RESULTS, "D:\UNI\ITCE211\Codes\projectfinalstages\report\output.txt", write_mode);

        ----------------- intiliazeing  ports -------------------

        reset <= '0';
        load <= '1';
        shift <= '0';
        eni <= '1';
        WHILE NOT endfile(file_VECTORS) LOOP
            ----------------- read from file  -------------------

            FOR i IN 0 TO number_of_numberin -1 LOOP

                readline(file_VECTORS, read_line);
                read(read_line, numberinfromfile);
                numberin <= numberinfromfile;
                WAIT FOR 200 ns;
            END LOOP;

            ----------------stop numbers from enterining numbercotnacted--------

            eni <= '0';
         
			
			  FOR i IN 0 TO number_of_numberin -2 LOOP
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