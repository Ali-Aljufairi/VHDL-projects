LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY new4bitAdder IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        c_in : IN STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        c_sig : INOUT STD_LOGIC_VECTOR(0 TO 3);
        c_out : OUT STD_LOGIC
    );
END new4bitAdder;
ARCHITECTURE data_flow OF new4bitAdder IS

BEGIN
    s(0) <= a(0) XOR b (0) XOR c_in;
    c_sig(0) <= (((a(0) AND b(0)) OR c_in) AND (a(0) XOR b(0)));

    s(1) <= a(1) XOR b (1) XOR c_sig(0);
    c_sig(1) <= (((a(1) AND b(1)) OR c_sig(0)) AND (a(1) XOR b(1)));

    s(2) <= a(2) XOR b (2) XOR c_sig(1);
    c_sig(2) <= (((a(2) AND b(2)) OR c_sig(1)) AND (a(2) XOR b(2)));

    s(3) <= a(3) XOR b (3) XOR c_sig(2);
    c_out <= (((a(3) AND b(3)) OR c_sig(2)) AND (a(3) XOR b(3)));
END data_flow;