LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
ENTITY PC_INCREMENT IS
PORT(
	old_PC: IN std_logic_vector(31 DOWNTO 0);
	selector: IN std_logic;
	new_PC: OUT std_logic_vector(31 DOWNTO 0)
);
END PC_INCREMENT;

ARCHITECTURE PC_increment OF PC_INCREMENT IS
BEGIN
new_PC <= std_logic_vector(unsigned(old_PC) + 1) WHEN selector = '0'
ELSE	std_logic_vector(unsigned(old_PC) + 2);
END PC_increment;