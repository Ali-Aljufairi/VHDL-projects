LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364Project_lab4_part2.ALL;

ENTITY lab4_part2 IS
  PORT (
    clock1, we, re : IN std_logic := '0'; 
    data : IN std_logic_vector(datasize DOWNTO 0) := (OTHERS => '0'); --$ data  
    write_address, read_address : IN integer RANGE 0 TO address := 0; --$ 5-bit write address input to RAM
    q : OUT std_logic_vector(datasize DOWNTO 0) := (OTHERS => '0')); --$ output from RAM
END ENTITY;

ARCHITECTURE rtl OF lab4_part2 IS

  SIGNAL mymem : mem_array := (OTHERS => (OTHERS => '-'));
  SIGNAL re_sig, reg_sig2 : std_logic := '0';
BEGIN

 

  Read_process : PROCESS (clock1, read_address, re) --read
  BEGIN
    IF (rising_edge(clock1)) THEN
    
        q <= mymem(read_address);
		

    END IF;
  END PROCESS;

  write_process : PROCESS (clock1, write_address, we, re) --write
  BEGIN
    IF (rising_edge(clock1)) THEN
      IF (we = '1') THEN
        mymem(write_address) <= data;
  
      END IF;
    END IF;
  END PROCESS;
END rtl;