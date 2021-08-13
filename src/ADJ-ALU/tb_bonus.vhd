library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_bonus is
--  Port ( );
end tb_bonus;

architecture Behavioral of tb_bonus is

-- COMPONENT ALU is removable
      component ALU
      
         Port ( A: in STD_LOGIC_VECTOR(7 downto 0);
           B: in STD_LOGIC_VECTOR(7 downto 0);
           OPCODE: in STD_LOGIC_VECTOR(3 downto 0);
           Cin: in STD_LOGIC;
           X: inout STD_LOGIC_VECTOR(7 downto 0);
           Y: inout STD_LOGIC_VECTOR(7 downto 0);
           Cout: inout STD_LOGIC;
           V: inout STD_LOGIC;
           Z: inout STD_LOGIC;
           F_active: out STD_LOGIC;
           X_bin_pal: out STD_LOGIC;
           X_prime: out STD_LOGIC;
           N: out STD_LOGIC);
           
       end component; 
       
     signal    A_test1: STD_LOGIC_VECTOR(7 downto 0);
     signal    B_test1: STD_LOGIC_VECTOR(7 downto 0);
     signal    OPCODE_test1: STD_LOGIC_VECTOR(3 downto 0);
     signal    Cin_test1: STD_LOGIC;
     signal    X_test1: STD_LOGIC_VECTOR(7 downto 0);
     signal    Y_test1: STD_LOGIC_VECTOR(7 downto 0);
     signal    Cout_test1: STD_LOGIC;
     signal    V_test1: STD_LOGIC;
     signal    Z_test1: STD_LOGIC;
     signal    F_active_test1: STD_LOGIC;
     signal    X_bin_pal_test1: STD_LOGIC;
     signal    X_prime_test1: STD_LOGIC;
     signal    N_test1: STD_LOGIC;


begin

ALU_tb1: ALU port map(A => A_test1, B => B_test1, OPCODE => OPCODE_test1,
             Cin => Cin_test1, X => X_test1, Y => Y_test1, Cout => Cout_test1, 
				 V => V_test1, Z => Z_test1,F_active => F_active_test1,
				 X_bin_pal => X_bin_pal_test1, X_prime => X_prime_test1, N => N_test1);

--ALU_tb1: entity work.ALU port map(A => A_test1, B => B_test1, 
--        OPCODE => OPCODE_test1, Cin => Cin_test1, X => X_test1, Y => Y_test1, Cout => Cout_test1,
--         V => V_test1, Z => Z_test1, F_active => F_active_test1, X_bin_pal => X_bin_pal_test1,
--          X_prime => X_prime_test1, N => N_test1);


--Testing A
testA: process
begin

A_test1 <= "00100101";
wait for 700 ns;
A_test1 <= "00001011";
wait for 750 ns;
A_test1 <= "11000000";
wait for 200 ns;
A_test1 <= "00111000";
wait for 300 ns;
A_test1 <= "00000101";
wait;
end process;

--Testing B
testB: process
begin

B_test1 <= "01000100";
wait for 700 ns;
B_test1 <= "10000011";
wait for 1100 ns;
B_test1 <= "11100001";
wait for 300 ns;
B_test1 <= "00000011";
wait;
end process;

--Testing Cin
testCin: process
begin

Cin_test1 <= '0';
wait for 600 ns;
Cin_test1 <= '1';

wait;
end process;

--Testing OPCODE
testOpcode: process
begin

OPCODE_test1 <= "0000";
wait for 250 ns;
OPCODE_test1 <= "0001";
wait for 250 ns;
OPCODE_test1 <= "0010";
wait for 250 ns;
OPCODE_test1 <= "0011";
wait for 250 ns;
OPCODE_test1 <= "0100";
wait for 250 ns;
OPCODE_test1 <= "0101";
wait for 250 ns;
OPCODE_test1 <= "0110";
wait for 250 ns;
OPCODE_test1 <= "0111";
wait for 250 ns;
OPCODE_test1 <= "1000";
wait for 250 ns;
OPCODE_test1 <= "1001";
wait for 250 ns;
OPCODE_test1 <= "1010";
wait for 250 ns;
OPCODE_test1 <= "1011";
wait for 250 ns;
OPCODE_test1 <= "1100";
wait for 250 ns;
OPCODE_test1 <= "1101";
wait for 250 ns;
OPCODE_test1 <= "1110";
wait for 250 ns;
OPCODE_test1 <= "1111";

wait;
end process;

end Behavioral;