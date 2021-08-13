library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_ARITH.all;

entity PRIME is
    Port ( N: in STD_LOGIC_VECTOR(7 downto 0);
           F: out STD_LOGIC);
end PRIME;

architecture Behavioral of PRIME is
signal tmp: STD_LOGIC;

begin

    Process(N)
            variable prime: boolean;
            variable Ni: integer;
            
            begin
                prime := true;
                Ni := conv_integer(unsigned(N));
                for i in 2 to 253 loop
                    if Ni rem i = 0 then
                        if Ni /= i then
                            prime := false;
                        end if;
                        exit;
                    end if;
                end loop;
                
                if prime then
                    F <= '1';
                else
                    F <= '0';
                end if;

        end process;

end Behavioral;
