LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY lab3 IS
    PORT (
        up_down, clk, reset, e : IN STD_LOGIC;
        out_hun, out_ten, out_one : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)

    );
END lab3;

ARCHITECTURE rtl OF lab3 IS

    SIGNAL sig8out : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 0);
    SIGNAL sighun, sigten, sigone : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => 0);

    COMPONENT eightbitcounter
        PORT (

            up_down, clk, reset : IN STD_LOGIC; -- up_down control for counter
            count : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT sevenseg IS

        PORT (
            number : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
            e : IN STD_LOGIC;
            seg7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)

        );

    END COMPONENT;
    COMPONENT h_t_o IS PORT (

        number : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        n_hun : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        n_ten : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        n_one : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );

    END COMPONENT;

BEGIN

    counter : eightbitcounter PORT MAP(up_down => up_down, clk => clk, reset => reset, count => sig8out);
    distrubter : h_t_o PORT MAP(number => sig8out, n_hun => sighun, n_ten => sigten, n_one => sigone);
    sevenseghunderd : sevenseg PORT MAP(number => sighun, e => e, seg7 => out_hun);
    sevensegtens : evenseg PORT MAP(number => sighun, e => e, seg7 => sigten);
    sevensegones : evenseg PORT MAP(number => sighun, e => e, seg7 => sigone);

END ARCHITECTURE;