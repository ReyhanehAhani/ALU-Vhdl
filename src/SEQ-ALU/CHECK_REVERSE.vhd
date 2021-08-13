library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity CHECK_REVERSE is
    Port ( N: in STD_LOGIC_VECTOR(7 downto 0);
           F: out STD_LOGIC);
end CHECK_REVERSE;

architecture Behavioral of CHECK_REVERSE is
signal tmp: STD_LOGIC;

begin
    
    Process(N)
        variable rev: STD_LOGIC_VECTOR(7 downto 0);
        variable k: STD_LOGIC_VECTOR(7 downto 0);
    begin
            tmp <= '0';
            --- Store N into k (because we need N to compare the result with)
            k := N;
            
            --- Reverse the number and save it in rev
            for i in 7 downto 0 loop
                rev(i) := N(7 - i);
            end loop;
            
            --- Loop through the number and shift the to right to remove reminder zero bits to reverse the number fully
            for i in 7 downto 0 loop
                if (rev and "00000001") = "00000000" then --- Check the LSB using and
                    rev := std_logic_vector(shift_right(unsigned(rev), 1));
                else
                    exit; --- Exit if it's shifted enough
                end if;
            end loop;
        
            if rev = N then
                tmp <= '1';
            else
                tmp <= '0';
            end if;

    end process;
    
    F <= tmp;

end Behavioral;