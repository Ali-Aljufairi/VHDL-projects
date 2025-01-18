ibrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

entity MuxMx1Nb is
    generic (
        N : integer := 8;
        M : integer := 16
    );
    port (
        I : in  STD_LOGIC_VECTOR(M*N-1 downto 0);
        S : in  STD_LOGIC_VECTOR(integer(ceil(log2(real(M))))-1 downto 0);
        Y : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end MuxMx1Nb;

architecture structural of MuxMx1Nb is
    component MUX2X1
        generic (N : integer := 8);
        port (
            A : in  STD_LOGIC_VECTOR(N-1 downto 0);
            B : in  STD_LOGIC_VECTOR(N-1 downto 0);
            S : in  STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(N-1 downto 0)
        );
    end component;

    constant stages : integer := integer(ceil(log2(real(M))));
    type stage_array is array (0 to stages) of STD_LOGIC_VECTOR(M*N-1 downto 0);
    signal Y_stage : stage_array;

begin

    Y_stage(0) <= I;

    gen_stage : for i in 0 to stages-1 generate
        gen_mux : for j in 0 to (M / (2**(i+1)))-1 generate
            mux2x1_inst : MUX2X1
                generic map (N => N)
                port map (
                    A => Y_stage(i)((2*j+1)*N-1 downto 2*j*N),   
                    B => Y_stage(i)((2*j+2)*N-1 downto (2*j+1)*N), 
                    S => S(i),                                   
                    Y => Y_stage(i+1)((j+1)*N-1 downto j*N)      
                );
        end generate;
    end generate;

    Y <= Y_stage(stages)(N-1 downto 0);
end structural;