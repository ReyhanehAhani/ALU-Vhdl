library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX21 is
    Port ( I0: in STD_LOGIC_VECTOR(7 downto 0);
           I1: in STD_LOGIC_VECTOR(7 downto 0);
           Q: out STD_LOGIC_VECTOR(7 downto 0);
           SEL: in STD_LOGIC);
end MUX21;

architecture Behavioral of MUX21 is

begin
    --- 2 to 1 MUX, Output Ix based on the SEL pin
    Q <= I0 when SEL = '0' else I1;

end Behavioral;
