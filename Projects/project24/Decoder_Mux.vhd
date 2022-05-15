library ieee;
use ieee.std_logic_1164.all;

ENTITY Decoder_Mux IS

port(
Data_in1,Data_in2: in std_logic_vector(15 downto 0);
Data_out:out std_logic_vector (15 downto 0);
sel:in std_logic
);
end Entity;

ARCHITECTURE Structure OF Decoder_Mux IS

begin
Data_out <= Data_in1 WHEN sel = '0' ELSE
		   Data_in2;



end Structure;

