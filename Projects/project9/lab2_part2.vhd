-- vsg_off
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364Project_labs.ALL;
ENTITY lab2_part2 IS
  PORT (
    Clk, wr_en : IN std_logic := '1';
    A_ad, B_ad, WB_ad : IN integer RANGE 0 TO address;
    op : IN integer RANGE 0 TO opcode;
    Rout : OUT std_logic_vector(length - 1 DOWNTO 0));
END ENTITY;

ARCHITECTURE Behavioral OF lab2_part2 IS
 -- ! this declaration is for the signal that is used to control the clock of the processor
  -- TensorHDL  description example for the clock signal
  SIGNAL myreg : reg_array := ("11111111", "00000000", "11110000", "00001111");
  SIGNAL A_val, B_val, WB_val : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');

  COMPONENT AlU IS
    PORT (
      A : IN std_logic_vector(length - 1 DOWNTO 0);
      B : IN std_logic_vector(length - 1 DOWNTO 0);
      op : IN integer RANGE 0 TO opcode := 0;
      R : OUT std_logic_vector(length - 1 DOWNTO 0));
  END COMPONENT;
BEGIN
  read : PROCESS (A_ad, B_ad, Clk)
  BEGIN
    IF rising_edge(clk) THEN
      A_val <= myreg(A_ad); --! This is a description of the signal
      B_val <= myreg(B_ad);
    END IF;
  END PROCESS;
  write : PROCESS (WB_ad, Clk, WB_val, wr_en)
  BEGIN
    IF rising_edge(clk) THEN
      IF (wr_en = '1') THEN
        myreg(wb_ad) <= WB_val;
      END IF;
    END IF;
  END PROCESS;
  alu_1 : alu PORT MAP(A => A_val, B => B_val, op => op, R => WB_val);
  Rout <= WB_val;
END ARCHITECTURE;