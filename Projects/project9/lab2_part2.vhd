LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
USE work.ITCE364Project_labs.ALL;
ENTITY lab2_part2 IS
	PORT (
		Clk, wr_en : IN STD_LOGIC := '1';
		A_ad, B_ad, WB_ad : IN INTEGER RANGE 0 TO address;
		op : IN INTEGER RANGE 0 TO opcode;
		Rout : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0));
END ENTITY;

ARCHITECTURE Behavioral OF lab2_part2 IS
	SIGNAL myreg : reg_array := ("11111111", "00000000", "11110000", "00001111");
	SIGNAL A_val, B_val, WB_val : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');

	COMPONENT AlU IS
		PORT (
			A : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(length - 1 DOWNTO 0);
			op : IN INTEGER RANGE 0 TO opcode := 0;
			R : OUT STD_LOGIC_VECTOR(length - 1 DOWNTO 0));
	END COMPONENT;
BEGIN
	read : PROCESS (A_ad, B_ad, Clk)
	BEGIN
		IF rising_edge(clk) THEN
			A_val <= myreg(A_ad);
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