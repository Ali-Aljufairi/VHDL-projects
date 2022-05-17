library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.ITCE364Project_labs.all;

entity lab1_part2 is
  port (
    A : in std_logic_vector(length - 1 downto 0) := Ali_Redha_A;
    B : in std_logic_vector(length - 1 downto 0) := Ali_Redha_B;
    R : out std_logic_vector(length - 1 downto 0));
end entity;

architecture rtl of lab1_part2 is

  signal op : integer range 0 to 7 := 0;
begin

  process (A, B, op)

  begin
    if op = 0 then
      R <= (others => '0');
    elsif op = 1 then
      R <= A - B;
    elsif op = 2 then
      R <= A + B;
    elsif op = 3 then
      R <= A and B;
    elsif op = 4 then
      R <= A or B;
    elsif op = 5 then
      R <= A xor B;
    elsif op = 6 then
      R <= not A;
    elsif op = 7 then
      R <= (others => '1');
    else
      R <= (others => 'Z');
    end if;
  end process;
end architecture;