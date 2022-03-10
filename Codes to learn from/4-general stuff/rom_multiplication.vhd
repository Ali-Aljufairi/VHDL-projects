LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY multiplier_rom IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        c : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END multiplier_rom;
ARCHITECTURE rtl OF multiplier_rom IS
    SIGNAL rom_addr, rom_data : STD_LOGIC_VECTOR(3 DOWNTO 0);

    TYPE rom IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT my_rom : rom := (
        0 => "0000",1 => "0000",2 => "0000",3 => "0000",4 => "0000",5 => "0001",6 => "0010",7 => "0011"8 => "0000", 9 => "0010",10 => "0100", 11 => "0110",12 => "0000",13 => "0011",  14 => "0110",15 => "1001"
    );

BEGIN
    rom_addr <= (a & b); -- if b is the least significant bit
    c <= rom_data;
    rom_data <= my_rom(to_integer(unsigned(rom_addr)));
END rtl;