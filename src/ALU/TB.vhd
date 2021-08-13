library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_task1 is
--  Port ( );
end tb_task1;

architecture Behavioral of tb_task1 is


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

ALU_tb1: ALU port map(A => A_test1, B => B_test1, OPCODE => OPCODE_test1, Cin => Cin_test1, X => X_test1, Y => Y_test1,
 Cout => Cout_test1, V => V_test1, Z => Z_test1, F_active => F_active_test1, X_bin_pal => X_bin_pal_test1, X_prime => X_prime_test1, N => N_test1);

--Testing A
testA: process
begin

A_test1 <= "00000010";
wait for 250 ns;
A_test1 <= "00000011";

wait;
end process;

--Testing B
testB: process
begin

B_test1 <= "00000100";
wait for 250 ns;
B_test1 <= "00000001";

wait;
end process;

--Testing Cin
testCin: process
begin

Cin_test1 <= '0';
--wait for 150 ns;
--Cin_test1 <= '1';

wait;
end process;

--Testing OPCODE
testOpcode: process
begin

OPCODE_test1 <= "0000";
wait for 250 ns;
OPCODE_test1 <= "1000";

wait;
end process;

end Behavioral;
