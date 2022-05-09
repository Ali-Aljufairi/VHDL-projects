LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY write_back IS
    PORT (
        RESET : IN STD_LOGIC;
        rdstNum : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        aluOut, memOut, controlSignals : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        rdstNewValue : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END write_back;

ARCHITECTURE write_back_arch OF write_back IS

BEGIN

    rdst_mux : ENTITY work.mux_2_1_mod PORT MAP(RESET, controlSignals(8 DOWNTO 7), aluOut, memOut, rdstNewValue);

END write_back_arch; -- write_back_arch