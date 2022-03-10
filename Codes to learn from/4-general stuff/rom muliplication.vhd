LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY homework IS

    PORT (
        input : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
        reslutofmultplication : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)

    );
END homework;
ARCHITECTURE rtl OF homework IS
    SIGNAL multisignal : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    ALIAS num1 : STD_LOGIC_VECTOR(0 TO 1) IS multisignal(3 DOWNTO 2);
    ALIAS num2 : STD_LOGIC_VECTOR(0 TO 1) IS multisignal(1 DOWNTO 0);
    TYPE rom IS ARRAY (0 TO 2 ** 4 - 1) OF STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT MY_rom : rom := (

        0 => "0000",
        1 => "0000",
        2 => "0000",
        3 => "0000",
        4 => "0000",
        5 => "0001",
        6 => "0010",
        7 => "0011",
        8 => "0000",
        9 => "0010",
        10 => "0100",
        11 => "0110",
        12 => "0000",
        13 => "0011",
        14 => "0110",
        15 => "1000");
BEGIN

    multisignal <= input;

    PROCESS (multisignal)
    BEGIN

        CASE multisignal IS

            WHEN "0000" => reslutofmultplication <= MY_rom(0);
            WHEN "0001" => reslutofmultplication <= MY_rom(1);
            WHEN "0010" => reslutofmultplication <= MY_rom(2);
            WHEN "0011" => reslutofmultplication <= MY_rom(3);
            WHEN "0100" => reslutofmultplication <= MY_rom(4);
            WHEN "0101" => reslutofmultplication <= MY_rom(5);
            WHEN "0110" => reslutofmultplication <= MY_rom(6);
            WHEN "0111" => reslutofmultplication <= MY_rom(7);
            WHEN "1000" => reslutofmultplication <= MY_rom(8);
            WHEN "1001" => reslutofmultplication <= MY_rom(9);
            WHEN "1010" => reslutofmultplication <= MY_rom(10);
            WHEN "1011" => reslutofmultplication <= MY_rom(11);
            WHEN "1100" => reslutofmultplication <= MY_rom(12);
            WHEN "1101" => reslutofmultplication <= MY_rom(13);
            WHEN "1110" => reslutofmultplication <= MY_rom(14);
            WHEN "1111" => reslutofmultplication <= MY_rom(15);
            WHEN OTHERS => reslutofmultplication <= "1111";
        END CASE;
    END PROCESS;

END rtl;