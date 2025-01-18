library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_8x1 is
    Port (
        D0, D1, D2, D3, D4, D5, D6, D7 : in STD_LOGIC_VECTOR(7 downto 0);
        Sel : in STD_LOGIC_VECTOR(2 downto 0);
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end mux_8x1;

architecture Structural of mux_8x1 is

    -- Component declaration
    component mux_2x1
        Port (
            A : in STD_LOGIC_VECTOR(7 downto 0);
            B : in STD_LOGIC_VECTOR(7 downto 0);
            Sel : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Signals for intermediate connections
    signal Y0, Y1, Y2, Y3 : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instantiate first layer of 2×1 multiplexers
    MUX0 : mux_2x1 Port Map (A => D0, B => D1, Sel => Sel(0), Y => Y0);
    MUX1 : mux_2x1 Port Map (A => D2, B => D3, Sel => Sel(0), Y => Y1);
    MUX2 : mux_2x1 Port Map (A => D4, B => D5, Sel => Sel(0), Y => Y2);
    MUX3 : mux_2x1 Port Map (A => D6, B => D7, Sel => Sel(0), Y => Y3);

    -- Instantiate second layer of 2×1 multiplexers
    MUX4 : mux_2x1 Port Map (A => Y0, B => Y1, Sel => Sel(1), Y => Y4);
    MUX5 : mux_2x1 Port Map (A => Y2, B => Y3, Sel => Sel(1), Y => Y5);

    -- Final layer of 2×1 multiplexer
    MUX6 : mux_2x1 Port Map (A => Y4, B => Y5, Sel => Sel(2), Y => Y);

end Structural;