LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY r_Register is
port(Clk,Rst,enable:in std_logic;
d:in std_logic_vector(15 downto 0 );
q:out std_logic_vector(15 downto 0)
);
end  ENTITY;

ARCHITECTURE Register_Structal of r_Register
is
begin
PROCESS (Clk,Rst)
begin
IF Rst='1' THEN
q<=(OTHERS =>'0'); 
ELSIF falling_edge(Clk) and enable='1'  THEN
q <= d;
END IF;

END PROCESS;

END Register_Structal;
