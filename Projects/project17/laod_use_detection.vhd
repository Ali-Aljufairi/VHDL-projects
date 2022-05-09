LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY laod_use_detection IS
    PORT (
        IR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        loadFlagEXMEM : IN STD_LOGIC;
        -- loadFlagMEMWB : IN STD_LOGIC;

        RdestNumEXMEM : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        -- RdestNumMEMWB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        loadUse : OUT STD_LOGIC

    );
END laod_use_detection;

ARCHITECTURE load_use_detection_arch OF laod_use_detection IS
Signal Rdest,Rsrc : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
Rsrc <= IR(19 DOWNTO 16);
Rdest <= IR(23 DOWNTO 20);

    loadUse <= '1' when ((loadFlagEXMEM = '1') AND ( (RdestNumEXMEM = IR(23 DOWNTO 20)) OR (RdestNumEXMEM = IR(19 DOWNTO 16)))) ELSE '0';
END load_use_detection_arch; -- load_use_detection_arch