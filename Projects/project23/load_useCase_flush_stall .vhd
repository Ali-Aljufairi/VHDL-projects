library ieee;
use ieee.std_logic_1164.all;

Entity load_suse_case_flush_stalling is
port(

load_use_case,rst,CLK:in std_logic;
Pc_enable_out,D_E_buffer_flush_out,F_D_buffer_EN_out,D_E_buffer_EN_out:out std_logic

);
end Entity;

ARCHITECTURE load_suse_case_flush_stalling_structure of load_suse_case_flush_stalling is
begin

PROCESS (CLK)
begin
if rst='0' then

IF rising_edge(Clk) THEN
if(load_use_case='1') then
D_E_buffer_flush_out<= '1';
Pc_enable_out<='0';
F_D_buffer_EN_out<='0';
D_E_buffer_EN_out<='0';
else
D_E_buffer_flush_out<= '0';
Pc_enable_out<='1';
F_D_buffer_EN_out<='1';
D_E_buffer_EN_out<='1';
End if;        
End if;
END IF;

END PROCESS;







end load_suse_case_flush_stalling_structure;
