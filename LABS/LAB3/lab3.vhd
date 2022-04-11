LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE work.ITCE364Project_lab3.ALL;

ENTITY lab3 IS
  PORT (
    conin : IN std_logic;
    inbus : IN std_logic_vector(length - 1 DOWNTO 0) := (OTHERS => '0');
    ir : IN integer RANGE 0 TO length := 0;
    condition : OUT std_logic);
END ENTITY;

ARCHITECTURE rtl OF lab3 IS

  SIGNAL Decoder_out : std_logic_vector(length - 1 DOWNTO 0) := ((OTHERS => '0'));
  SIGNAL g : std_logic_vector(g_length - 1 DOWNTO 0) := ((OTHERS => '0'));
  SIGNAL brn : std_logic := '0';    

BEGIN

  Decoder : PROCESS (ir, Decoder_out)
  BEGIN
    Decoder_out <= rom(ir);
  END PROCESS;


  g(0) <= Decoder_out(1);
  g(1) <= Decoder_out(2) AND NOT (inbus(0) OR inbus(1) OR inbus(2) OR inbus(3) OR inbus(4) OR inbus(5) OR inbus(6) OR inbus(7));
  g(2) <= Decoder_out(3) AND (inbus(0) OR inbus(1) OR inbus(2) OR inbus(3) OR inbus(4) OR inbus(5) OR inbus(6) OR inbus(7));
  g(3) <= Decoder_out(4) AND NOT (inbus(7));
  g(4) <= Decoder_out(5) AND (inbus(7));
  brn <= g(0) OR g(1) OR g(2) OR g(3) OR g(4);  

  
  Con : PROCESS (conin)
  BEGIN
    IF rising_edge(conin) THEN
    condition <= brn;
    END IF;
  END PROCESS;
END ARCHITECTURE;