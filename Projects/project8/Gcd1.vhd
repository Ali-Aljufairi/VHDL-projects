 library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

 entity gcd1 is 

 END ENTITY;

    architecture arch1 of gcd1 is    
   begin  
 
    process(x,y)
    variable r : integer;    
    variable n : integer := 40 ;        
    variable m : integer := 100 ;     
    begin 
        while (n != 0)  loop {
            
                r := m mod n;
                m:= n;
                n := r;
		
                }			 
            end loop;
    end process;
    end architecture;