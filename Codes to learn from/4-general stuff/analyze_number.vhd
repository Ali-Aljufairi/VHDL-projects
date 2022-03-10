library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity analyze_number is
port(number : in std_logic_vector(7 downto 0);
	  no_hundreds: out std_logic_vector(3 downto 0);
	  no_tens: out std_logic_vector(3 downto 0);
	  no_ones: out std_logic_vector(3 downto 0)
);
end analyze_number;

architecture rtl of analyze_number is

signal number_i, number_minus_hundreds, hundreds, tens, y : integer range 0 to 255 := 0;

begin
number_i <= to_integer(unsigned(number));

process(number_i) --NUMBER OF HUNDREDS
begin
	if number_i >= 200 then
		no_hundreds <= x"2";
		hundreds <= 200;
	elsif number_i >= 100 then
		no_hundreds <= x"1";
		hundreds <= 100;
	else
		no_hundreds <= x"0";
		hundreds <= 0;
	end if;
end process;

number_minus_hundreds <= number_i - hundreds;
process(number_minus_hundreds)	--NUMBER OF TENS
begin
	if number_minus_hundreds >= 90 then
		no_tens <= x"9";
		tens <= 90;
	elsif number_minus_hundreds >= 80 then
		no_tens <= x"8";
		tens <= 80;
	elsif number_minus_hundreds >= 70 then
		no_tens <= x"7";
		tens <= 70;
	elsif number_minus_hundreds >= 60 then
		no_tens <= x"6";
		tens <= 60;
	elsif number_minus_hundreds >= 50 then
		no_tens <= x"5";
		tens <= 50;
	elsif number_minus_hundreds >= 40 then
		no_tens <= x"4";
		tens <= 40;
	elsif number_minus_hundreds >= 30 then
		no_tens <= x"3";
		tens <= 30;
	elsif number_minus_hundreds >= 20 then
		no_tens <= x"2";
		tens <= 20;	
	elsif number_minus_hundreds >= 10 then
		no_tens <= x"1";
		tens <= 10;
	else
		no_tens <= x"0";
		tens <= 0;
	end if;
end process;

y <= number_minus_hundreds - tens;
no_ones <= std_logic_vector(to_unsigned(y, 4));
		
end rtl;