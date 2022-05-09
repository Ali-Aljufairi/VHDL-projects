library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY forwarding IS
  PORT (srcNumID, destNumEX,destNumMem : IN std_logic_vector (3 downto 0);
	wbEX,wbMem: IN std_logic;
	selector: OUT std_logic_vector (1 downto 0));
END forwarding;

ARCHITECTURE forwardingUnit OF forwarding is
	BEGIN
    selector <= "10" when (srcNumID = destNumEX) and wbEX = '1'
    else "01" when (srcNumID = destNumMem) and wbMem = '1'
    else "00";
END forwardingUnit;