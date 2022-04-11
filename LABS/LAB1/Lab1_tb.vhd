-- vsg_off
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.textio.ALL;
USE ieee.std_logic_textio.ALL;
USE work.ITCE364Project_lab1.ALL;

ENTITY Lab1_tb IS

END ENTITY;

ARCHITECTURE rtl OF Lab1_tb IS

  COMPONENT lab1 IS
    PORT (
      A, B : IN std_logic_vector(length - 1 DOWNTO 0) := Ali_Redha_A;
      op : IN integer RANGE 0 TO 7 := 0;
      R : OUT std_logic_vector(length - 1 DOWNTO 0)

    );
  END COMPONENT;
  ---------------- Signal -------------------
  SIGNAL A_sig : std_logic_vector(length - 1 DOWNTO 0) := Ali_Redha_A;
  SIGNAL B_sig : std_logic_vector(length - 1 DOWNTO 0) := Ali_Redha_B;
  SIGNAL Op_sig : integer RANGE 0 TO Opcode := 0;
  SIGNAL R_sig : std_logic_vector(length - 1 DOWNTO 0);
  SIGNAL Y_sig : std_logic_vector(length - 1 DOWNTO 0);
  --  Signal A_sig : STD_LOGIC_VECTOR(length - 1 DOWNTO 0) := Ali_Redha_A;
  ---------------- Component ----------------

BEGIN
  uut : lab1 PORT MAP(A_sig, B_sig, Op_sig, R_sig);
  PROCESS
  BEGIN
    FOR i IN 0 TO opcode LOOP
      Op_sig <= i;
      WAIT FOR 50 ns;
    END LOOP;
  END PROCESS;
END rtl;