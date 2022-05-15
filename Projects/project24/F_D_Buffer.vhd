
library ieee;
use ieee.std_logic_1164.all;

ENTITY F_D_Buffer IS
	PORT(
		en,clk,rst: IN std_logic;
		INDATA_F: IN std_logic_vector(15 downto 0);
		PC_F,Inst_F: IN std_logic_vector(31 DOWNTO 0);
		PC_D,Inst_D: OUT std_logic_vector(31 DOWNTO 0);
		INDATA_D: OUT std_logic_vector(15 downto 0)
);
END ENTITY;


ARCHITECTURE F_D_Buffer_Arch of F_D_Buffer IS
BEGIN
	PROCESS (clk, rst) IS
	BEGIN
		IF (rst = '1') THEN
			Inst_D <= (others=>'0');
			PC_D <= (others=>'0');
			INDATA_D <= (others =>'0');
		ELSIF (rising_edge(clk) and en = '1') THEN
			Inst_D <= Inst_F;
			PC_D <= PC_F;
			INDATA_D <= INDATA_F;
		END IF;

	END PROCESS;
END Architecture;