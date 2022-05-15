
library ieee;
use ieee.std_logic_1164.all;

ENTITY ForwardingUnit Is
	PORT(
		EXMem_WriteBack, MemWB_WtiteBack: IN std_logic;
		EXMem_destAddress, MemWB_destAddress: IN std_logic_vector (2 DOWNTO 0);
		DeEX_srcAddress1, DeEX_srcAddress2: IN std_logic_vector(2 DOWNTO 0);
		src1Selectors, src2Selectors: OUT std_logic_vector(1 DOWNTO 0)
	);
END ForwardingUnit;


ARCHITECTURE FUnit of ForwardingUnit IS

BEGIN
	src1Selectors <= "10" WHEN (DeEX_srcAddress1 = EXMem_destAddress)
				and(EXMem_WriteBack = '1')  		ELSE
			 "11" WHEN (DeEX_srcAddress1 = MemWB_destAddress)
				and(MemWB_WtiteBack = '1')		ELSE
			 "00";

	src2Selectors <= "10" WHEN (DeEX_srcAddress2 = EXMem_destAddress)
				and(EXMem_WriteBack = '1')  		ELSE
			 "11" WHEN (DeEX_srcAddress2 = MemWB_destAddress)
				and(MemWB_WtiteBack = '1') 		ELSE
			 "00";

END FUnit;
