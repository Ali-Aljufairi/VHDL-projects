LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

Entity lab1 is port (

         A : in std_logic_vector(7 downto 0);
            B : in std_logic_vector(7 downto 0);
            op: in std_logic_vector(2 downto 0);
            R : out std_logic_vector(7 downto 0)


);  end entity;

Architecture rtl of lab1 is 
begin
process(op)
begin

    case op is 
          when "000" =>R <= "00000000";
           when "001" =>R <= (A + B);
           when "010" =>R <= (A - B);
           when "011" =>R <= (A and B);
           when "100" =>R <= (A or B);
           when "101" =>R <= (A xor B);
           when "110" =>R <= (not A);
           when "111" =>R <= "11111111";
          when others =>R <= "ZZZZZZZZ";
          end case;
end process;
end architecture;