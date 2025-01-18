library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Parity_Checker_XOR is
    generic(
        N : integer := 8
    );
    Port (
        data_in   : in  STD_LOGIC_VECTOR(N-1 downto 0); 
        selects    : in  STD_LOGIC;               
        parity_out : out STD_LOGIC                  
    );
end Parity_Checker_XOR;

architecture Behavioral of Parity_Checker_XOR is
begin
    process(data_in,selects)
    variable i :     integer;
    variable result: std_logic;
    begin
      result := data_in(0);
    for i in 1 to N-1 loop
      result := result xor data_in(i);
    end loop;
      if selects = '0' then 
      parity_out <= NOT result; 
      else 
         parity_out <= result; 
    end if;
    end process;
end Behavioral;