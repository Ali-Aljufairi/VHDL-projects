library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.ITCE211Project_library.all;

entity pe is

  port (
    clk : in std_logic;
    eni, reset : in std_logic;
    numberin : in std_logic_vector(data_width - 1 downto 0) := (others => '0');
    numberout : out std_logic_vector(data_width - 1 downto 0) := (others => '0');
    eno : out std_logic := '0';
    number : out std_logic_vector(data_width - 1 downto 0) := (others => '0')
  );

end entity;

architecture rtl of pe is

  signal stored : std_logic_vector (data_width - 1 downto 0) := (others => '0');
begin

  number <= stored;

  process (clk, reset, eni)
  begin
    if reset = '1' then
      eno <= '0';
      stored <= (others => '0');
      numberout <= (others => '0');

    elsif rising_edge (clk) then

      if eni = '0' then
        eno <= '0';
        numberout <= (others => '0');

      elsif numberin > stored and eni = '1' then
        eno <= '1';
        numberout <= stored;
        stored <= numberin;

      else
        eno <= '1';
        numberout <= numberin;

      end if;

    end if;
  end process;

end architecture;