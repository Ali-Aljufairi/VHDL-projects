LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_lab3_part2.ALL;

ENTITY lab3_part2 IS
  PORT (
    clk, ld, decr : IN std_logic := '0';
    inbus : IN std_logic_vector(length - 1 DOWNTO 0) := (OTHERS => '0');
    dec_out : OUT std_logic_vector(address DOWNTO 0) := (OTHERS => '-');--$ InBuS       
    n : OUT std_logic := '0');--$ condition  
END ENTITY;
ARCHITECTURE rtl OF lab3_part2 IS
  SIGNAL in_bus_sig : std_logic_vector( address DOWNTO 0) := ((OTHERS => '-')); --$ inbus signal   
BEGIN
  -- $  Decrment  process 
  Decrment : PROCESS (decr, ld, clk, inbus)
  BEGIN
    IF rising_edge(clk) THEN
      IF ld = '1' THEN
        in_bus_sig <= inbus(address DOWNTO 0);
      END IF;
      IF decr = '1' THEN
        in_bus_sig <= in_bus_sig - '1';
        dec_out <= in_bus_sig;
        IF (in_bus_sig = "00000") THEN
          n <= '1';
        END IF;
      END IF;
    END IF;
  END PROCESS;
END ARCHITECTURE;