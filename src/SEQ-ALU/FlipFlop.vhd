library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlop is  
    Port ( A: in STD_LOGIC;
           B: out STD_LOGIC;
           E: in STD_LOGIC;
           CLK: in STD_LOGIC;
           RES: in STD_LOGIC);
end FlipFlop;

architecture Behavioral of FlipFlop is

begin
    
    --- D Flip flop
    Process(CLK, E, RES)
    begin
        --- async reset, reset even if the clock isn't rising
        if RES = '1' then
            B <= '0';
        
        --- If the Flip flop is enabled and the clk is rising, change the value of B to A
        elsif E = '1' then
            if rising_edge(CLK) then
                B <= A;
            end if;
        end if;
    end process;

end Behavioral;
