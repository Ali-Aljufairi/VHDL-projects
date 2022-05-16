LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364project.ALL;

ENTITY Register_File IS
  PORT (
    Read_Address_1,
    Read_Address_2,
    Write_Address : IN std_logic_vector(2 DOWNTO 0);
    Clk, Rst, WB_enable : IN std_logic;
    write_data : IN std_logic_vector(opcodesize DOWNTO 0);
    Src1_data, Src2_data : OUT std_logic_vector(opcodesize DOWNTO 0));
END ENTITY;

ARCHITECTURE Register_File_Structal OF Register_File IS
  SIGNAL enable : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
  SIGNAL q0, q1, q2, q3, q4, q5, q6, q7 : std_logic_vector(15 DOWNTO 0) := (OTHERS => '0');

  COMPONENT r_Register IS
    PORT (
      Clk, Rst, enable : IN std_logic;
      d : IN std_logic_vector(opcodesize DOWNTO 0);
      q : OUT std_logic_vector(opcodesize DOWNTO 0)
    );
  END COMPONENT;
BEGIN

  PROCESS (enable, Write_Address, WB_enable)
  BEGIN
    IF WB_enable = '1' THEN
      IF Write_Address = "000" THEN
        enable <= "00000001";
      ELSIF Write_Address = "001" THEN
        enable <= "00000010";
      ELSIF Write_Address = "010" THEN
        enable <= "00000100";
      ELSIF Write_Address = "011" THEN
        enable <= "00001000";
      ELSIF Write_Address = "100" THEN
        enable <= "00010000";
      ELSIF Write_Address = "101" THEN
        enable <= "00100000";
      ELSIF Write_Address = "110" THEN
        enable <= "01000000";
      ELSIF Write_Address = "111" THEN -- write back
        enable <= "10000000";
      ELSE
        enable <= "00000000";
      END IF;
    END IF;
  END PROCESS;

  r0 : r_Register PORT MAP(Clk, Rst, enable(0), write_data, q0);
  r1 : r_Register PORT MAP(Clk, Rst, enable(1), write_data, q1);
  r2 : r_Register PORT MAP(Clk, Rst, enable(2), write_data, q2);
  r3 : r_Register PORT MAP(Clk, Rst, enable(3), write_data, q3);
  r4 : r_Register PORT MAP(Clk, Rst, enable(4), write_data, q4);
  r5 : r_Register PORT MAP(Clk, Rst, enable(5), write_data, q5);
  r6 : r_Register PORT MAP(Clk, Rst, enable(6), write_data, q6);
  r7 : r_Register PORT MAP(Clk, Rst, enable(7), write_data, q7);

  PROCESS (Read_Address_1, q0, q1, q2, q3, q4, q5, q6, q7)
  BEGIN
    IF Read_Address_1 = "000" THEN
      Src1_data <= q0;
    ELSIF Read_Address_1 = "001" THEN
      Src1_data <= q1;
    ELSIF Read_Address_1 = "010" THEN
      Src1_data <= q2;
    ELSIF Read_Address_1 = "011" THEN
      Src1_data <= q3;
    ELSIF Read_Address_1 = "100" THEN
      Src1_data <= q4;
    ELSIF Read_Address_1 = "101" THEN
      Src1_data <= q5;
    ELSIF Read_Address_1 = "110" THEN
      Src1_data <= q6;
    ELSIF Read_Address_1 = "111" THEN -- write back
      Src1_data <= q7;
    END IF;
  END PROCESS;

  PROCESS (Read_Address_2, q0, q1, q2, q3, q4, q5, q6, q7)
  BEGIN
    IF Read_Address_2 = "000" THEN
      Src2_data <= q0;
    ELSIF Read_Address_2 = "001" THEN
      Src2_data <= q1;
    ELSIF Read_Address_2 = "010" THEN
      Src2_data <= q2;
    ELSIF Read_Address_2 = "011" THEN
      Src2_data <= q3;
    ELSIF Read_Address_2 = "100" THEN
      Src2_data <= q4;
    ELSIF Read_Address_2 = "101" THEN
      Src2_data <= q5;
    ELSIF Read_Address_2 = "110" THEN
      Src2_data <= q6;
    ELSIF Read_Address_2 = "111" THEN -- write back
      Src2_data <= q7;
    END IF;
  END PROCESS;
END ARCHITECTURE;

-- enable <= "00000001" WHEN Write_Address = "000" AND WB_enable = '1' ELSE
--   "00000010" WHEN Write_Address = "001" AND WB_enable = '1' ELSE
--   "00000100" WHEN Write_Address = "010" AND WB_enable = '1' ELSE
--   "00001000" WHEN Write_Address = "011" AND WB_enable = '1' ELSE
--   "00010000" WHEN Write_Address = "100" AND WB_enable = '1' ELSE
--   "00100000" WHEN Write_Address = "101" AND WB_enable = '1' ELSE
--   "01000000" WHEN Write_Address = "110" AND WB_enable = '1' ELSE
--   "10000000" WHEN Write_Address = "111" AND WB_enable = '1' ELSE
--   "00000000";

-- Src2_data <= q0 WHEN Read_Address_2 = "000"
--   ELSE q1 WHEN Read_Address_2 = "001"
--   ELSE q2 WHEN Read_Address_2 = "010"
--   ELSE q3 WHEN Read_Address_2 = "011"
--   ELSE q4 WHEN Read_Address_2 = "100"
--   ELSE q5 WHEN Read_Address_2 = "101"
--   ELSE q6 WHEN Read_Address_2 = "110"
--   ELSE q7 WHEN Read_Address_2 = "111";
-- Src1_data <= q0 WHEN Read_Address_1 = "000"
--   ELSE q1 WHEN Read_Address_1 = "001"
--   ELSE q2 WHEN Read_Address_1 = "010"
--   ELSE q3 WHEN Read_Address_1 = "011"
--   ELSE q4 WHEN Read_Address_1 = "100"
--   ELSE q5 WHEN Read_Address_1 = "101"
--   ELSE q6 WHEN Read_Address_1 = "110"
--   ELSE q7 WHEN Read_Address_1 = "111";