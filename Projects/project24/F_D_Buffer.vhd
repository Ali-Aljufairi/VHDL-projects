
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ITCE364project.ALL;
ENTITY F_D_Buffer IS
  PORT (
    en, clk, rst : IN std_logic;
    INDATA_F : IN std_logic_vector(opcodesize DOWNTO 0);
    PC_F, Inst_F : IN std_logic_vector(width_size DOWNTO 0);
    PC_D, Inst_D : OUT std_logic_vector(width_size DOWNTO 0);
    INDATA_D : OUT std_logic_vector(opcodesize DOWNTO 0)
  );
END ENTITY;
ARCHITECTURE F_D_Buffer_Arch OF F_D_Buffer IS
BEGIN
  PROCESS (clk, rst) IS
  BEGIN
    IF (rst = '1') THEN
      Inst_D <= (OTHERS => '0');
      PC_D <= (OTHERS => '0');
      INDATA_D <= (OTHERS => '0');
    ELSIF (rising_edge(clk)) THEN
      IF en = '1' THEN
        Inst_D <= Inst_F;
        PC_D <= PC_F;
        INDATA_D <= INDATA_F;
      END IF;
    END IF;
  END PROCESS;
END ARCHITECTURE;