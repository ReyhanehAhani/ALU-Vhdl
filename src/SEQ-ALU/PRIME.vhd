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
                Ni := conv_integer(unsigned(N)); --- Convert STD_LOGIC_VECTOR to integer
                for i in 2 to 253 loop --- Loop from 2 until 253 ( 2^8 - 1 (because we count from 0) - 1(because we don't want to check the number itself) )
                    if Ni rem i = 0 then --- if the reminder of Ni / i is zero and isn't Ni itself ( because a prime number is only dividable by 1 and itself )
                        if Ni /= i then
                            prime := false; --- Set prime to false
                        end if;
                        exit;
                    end if;
                end loop;
                
                if prime then --- Set F to 1 if N is prime
                    F <= '1';
                else
                    F <= '0';
                end if;

        end process;

end Behavioral;
