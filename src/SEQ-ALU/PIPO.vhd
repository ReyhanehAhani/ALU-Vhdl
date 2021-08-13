library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PIPO is
    Port ( A: in STD_LOGIC_VECTOR(7 downto 0);
           B: out STD_LOGIC_VECTOR(7 downto 0);
           CLK: in STD_LOGIC;
           RES: in STD_LOGIC;
           E: in STD_LOGIC);
end PIPO;

architecture Behavioral of PIPO is
begin
    
    --- PIPO shift register
    Process(A, RES, E, CLK)
    begin
        --- async reset, reset even if the clock isn't rising
        if RES = '1' then 
            B <= (others => '0');
        end if;
        
        --- If the PIPO is enabled and the clk is rising, change the value of B to A
        if E = '1' then
            if rising_edge(CLK) then
                B <= A;
            end if;
        end if;
    end process;

end Behavioral;
