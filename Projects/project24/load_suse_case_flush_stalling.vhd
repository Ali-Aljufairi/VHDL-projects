LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY load_suse_case_flush_stalling IS
  PORT (

    load_use_case, rst, CLK : IN std_logic;
    Pc_enable_out, D_E_buffer_flush_out, F_D_buffer_EN_out, D_E_buffer_EN_out : OUT std_logic);
END ENTITY;

ARCHITECTURE load_suse_case_flush_stalling_structure OF load_suse_case_flush_stalling IS
BEGIN
  PROCESS (CLK, rst)
  BEGIN
    IF rst = '0' THEN
      IF rising_edge(Clk) THEN
        IF (load_use_case = '1') THEN
          D_E_buffer_flush_out <= '1';
          Pc_enable_out <= '0';
          F_D_buffer_EN_out <= '0';
          D_E_buffer_EN_out <= '0';
        ELSE
          D_E_buffer_flush_out <= '0';
          Pc_enable_out <= '1';
          F_D_buffer_EN_out <= '1';
          D_E_buffer_EN_out <= '1';
        END IF;
      END IF;
    END IF;

  END PROCESS;

END ARCHITECTURE;