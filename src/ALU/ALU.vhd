library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ALU is
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
end ALU;


architecture Behavioral of ALU is

begin
    F_active <= Z or Cout or V;
    Z <= '1' when X = "00000000" else '0';
    PRIME1: entity work.PRIME port map(N => X, F => X_prime);
    CHECK_REVERSE1: entity work.CHECK_REVERSE port map(N => X, F => X_Bin_pal);
    N <= '1' when signed(X) < 0 else '0';
    
    Process(OPCODE)
        variable ADD_R: STD_LOGIC_VECTOR(8 downto 0);
        variable SUB_R: std_logic_vector(8 downto 0);
        variable MUL_R: std_logic_vector(15 downto 0);
        variable ROT_TMP: std_logic_vector(7 downto 0);
        variable LRS: std_logic_vector(7 downto 0);
        variable RLS: std_logic_vector(8 downto 0);
        variable ARS: std_logic_vector(8 downto 0);
        variable BCD: STD_LOGIC_VECTOR(13 downto 0);
    begin
        if OPCODE = "0000" then
            X <= A and B;
            Y <= "00000000";
        elsif OPCODE = "0001" then
            X <= A or B;
            Y <= "00000000";
        elsif OPCODE = "0010" then
            X <= A xor B;
            Y <= "00000000";
        elsif OPCODE = "0011" then
            X <= A xnor B;
            Y <= "00000000";
        elsif OPCODE = "0100" then
            ADD_R := std_logic_vector(resize(unsigned(A), 9) + resize(unsigned(B), 9));
            X <= ADD_R(7 downto 0);
            Cout <= ADD_R(8);
            Y <= "00000000";
        elsif OPCODE = "0101" then
            ADD_R := std_logic_vector(resize(signed(A),9) + resize(signed(B), 9));
            X <= ADD_R(7 downto 0);
            if ADD_R(8) = '1' then
                    V <= '1';
                else
                    V <= '0';    
            end if;
            Y <= "00000000";
        elsif OPCODE = "0110" then
            ADD_R := std_logic_vector(resize(unsigned(A), 9) + resize(unsigned(B), 9) + resize(unsigned'('0' & Cin), 9));
            X <= ADD_R(7 downto 0);
            Cout <= ADD_R(8);
            Y <= "00000000";
        elsif OPCODE = "0111" then
            MUL_R := std_logic_vector(signed(A) * signed(B));
            X <= MUL_R(7 downto 0);
            Y <= MUL_R(15 downto 8);
        elsif OPCODE = "1000" then
            MUL_R := std_logic_vector(unsigned(A) * unsigned(B));
            X <= MUL_R(7 downto 0);
            Y <= MUL_R(15 downto 8);
        elsif OPCODE = "1001" then
            SUB_R := std_logic_vector(resize(unsigned(A), 9) - resize(unsigned(B), 9));
            X <= SUB_R(7 downto 0);
            Cout <= SUB_R(8);
            Y <= "00000000";
        elsif OPCODE = "1010" then
            X <= std_logic_vector(rotate_left(unsigned(A), 1));
            Y <= "00000000";
        elsif OPCODE = "1011" then
            ROT_TMP := A(6 downto 0) & Cin;
            Cout <= A(7);
            X <= ROT_TMP;
            Y <= "00000000";
        elsif OPCODE = "1100" then
            LRS(7 downto 0) := std_logic_vector(shift_right(unsigned(A), 1));
            Cout <= '0';
            X <= LRS;
            Y <= "00000000";
        elsif OPCODE = "1101" then
            ARS(7 downto 0) := std_logic_vector(shift_right(signed(A), 1));
            ARS(8) := A(7);
            Cout <= ARS(8);
            X <= ARS(7 downto 0);
            Y <= "00000000";
        elsif OPCODE = "1110" then
            RLS(7 downto 0) := std_logic_vector(shift_left(signed(A), 1));
            Cout <= A(7);
            x <= RLS(7 downto 0);
            Y <= "00000000";
        elsif OPCODE = "1111" then
            BCD := std_logic_vector(unsigned(unsigned(A(3 downto 0)) * "01")  --multiply by 1
                + unsigned(unsigned(A(7 downto 4)) * "1010") --multiply by 10
                + unsigned(unsigned(B(3 downto 0)) * "1100100") --multiply by 100
                + unsigned(unsigned(B(7 downto 4)) * "1111101000" )); --multiply by 1000
            Y <= "00" & BCD(13 downto 8);  
            X <= BCD(7 downto 0);
        end if;
    end process;
    
    
end Behavioral;
