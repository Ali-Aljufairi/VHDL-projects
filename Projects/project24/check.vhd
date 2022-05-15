Library ieee;
use ieee.std_logic_1164.all;
Entity check is
port(
load_use_case,signal1,signal2:in std_logic;
signal_out:out std_logic

);
end entity;

ARCHITECTURE check_structure of check is
begin
signal_out<= '0'when load_use_case='1' else
signal1;





end check_structure;
