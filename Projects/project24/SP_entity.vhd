LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY SP_entity IS
    PORT (
        rst, clk : IN STD_LOGIC;
        datain : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE SP_instance OF SP_entity IS
BEGIN
    PROCESS (clk, rst) IS
    BEGIN
        IF rst = '1' THEN
            dataout <= x"000009c4"; 
        ELSIF (falling_edge(clk)) THEN
            dataout <= datain;
        END IF;
    END PROCESS;
END SP_instance;