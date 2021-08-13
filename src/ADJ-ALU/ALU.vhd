library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
--use ieee.STD_LOGIC_ARITH.all;

--- Declare ALU Ports

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
    F_active <= Z or Cout or V; --- OR of overflow, carry out and zero
    Z <= '1' when X = "00000000" else '0'; --- Z equals to 0 when X is zero
    PRIME1: entity work.PRIME port map(N => X, F => X_prime); --- Check if the number is prime and if it is, set X_prime to high
    CHECK_REVERSE1: entity work.CHECK_REVERSE port map(N => X, F => X_Bin_pal); --- Check if is the result of output of opreations is reversable(binary palindrome)

    Process(OPCODE)
        --- VARS for saving output of opreations
        variable ADD_R: STD_LOGIC_VECTOR(8 downto 0);
        variable SUB_R: std_logic_vector(8 downto 0);
        variable MUL_R: std_logic_vector(15 downto 0);
        variable ROT_TMP: std_logic_vector(8 downto 0);
        variable LRS: std_logic_vector(7 downto 0);
        variable RLS: std_logic_vector(8 downto 0);
        variable ARS: std_logic_vector(8 downto 0);
        variable BCD: STD_LOGIC_VECTOR(13 downto 0);
    begin
        --- AND OP
        if OPCODE = "0000" then
            X <= A and B;
            Y <= "00000000";
            cout <= '0';
				V <= '0';
				N <= '0';
        --- OR OP
        elsif OPCODE = "0001" then
            X <= A or B;
            Y <= "00000000";
            cout <= '0';
				V <= '0';
				N <= '0';
        --- XOR OP
        elsif OPCODE = "0010" then
            X <= A xor B;
            Y <= "00000000";
            cout <= '0';
				V <= '0';
				N <= '0';
        --- XNOR OP
        elsif OPCODE = "0011" then
            X <= A xnor B;
            Y <= "00000000";
            cout <= '0';
				V <= '0';
				N <= '0';
        --- UNSIGNED ADD OP
        elsif OPCODE = "0100" then
            ADD_R := std_logic_vector(resize(unsigned(A), 9) + resize(unsigned(B), 9)); --- Note: RESIZE is used for extending the output to 9 bits and using the 9th bit for carry
            X <= ADD_R(7 downto 0);
            Cout <= ADD_R(8);
            Y <= "00000000";
				V <= '0';
				N <= '0';
        --- SIGNED ADD OP
        elsif OPCODE = "0101" then
            ADD_R := std_logic_vector(resize(signed(A),9) + resize(signed(B), 9));
            X <= ADD_R(7 downto 0);
            if ADD_R(8) = '1' then --- OVERFLOW CHECK
                    V <= '1';
                else
                    V <= '0';    
            end if;
            cout <= '0';
            Y <= "00000000";
				if signed(X) < 0 then --- If the number is negetive, then set N flag on
					N <= '1';
				else
					N <= '0';
				end if;
        --- UNSIGNED ADD WITH CARRY OP
        elsif OPCODE = "0110" then
            ADD_R := std_logic_vector(resize(unsigned(A), 9) + resize(unsigned(B), 9) + resize(unsigned'('0' & Cin), 9));
            X <= ADD_R(7 downto 0);
            Cout <= ADD_R(8);
            Y <= "00000000";
				V <= '0';
				N <= '0';
        --- UNSIGNED MUL OP
        elsif OPCODE = "0111" then
            MUL_R := std_logic_vector(signed(A) * signed(B));
            X <= MUL_R(7 downto 0); --- first BYTE
            Y <= MUL_R(15 downto 8); --- 2nd BYTE 
            cout <= '0';
				V <= '0';
				if signed(X) < 0 then --- If the number is negetive, then set N flag on
					N <= '1';
				else
					N <= '0';
				end if;
        --- SIGNED MUL OP
        elsif OPCODE = "1000" then
            MUL_R := std_logic_vector(unsigned(A) * unsigned(B));
            X <= MUL_R(7 downto 0); --- first BYTE
            Y <= MUL_R(15 downto 8); --- 2nd BYTE 
            cout <= '0';
				V <= '0';
				N <= '0';
        --- UNSIGNED SUB OP
        elsif OPCODE = "1001" then
            SUB_R := std_logic_vector(resize(unsigned(A), 9) - resize(unsigned(B), 9));
            X <= SUB_R(7 downto 0);
            Cout <= SUB_R(8);
            Y <= "00000000";
				V <= '0';
				N <= '0';
        --- ROT LEFT OP
        elsif OPCODE = "1010" then
            X <= std_logic_vector(rotate_left(unsigned(A), to_integer(unsigned(B)))); --- ROT LEFT function rots X by N bits to left 
            Y <= "00000000";
            cout <= '0';
				V <= '0';
				N <= '0';
        --- ROT LEFT WITH CARRY OP
        elsif OPCODE = "1011" then
            ROT_TMP := std_logic_vector(rotate_left(unsigned(A & Cin), to_integer(unsigned(B))));
            Cout <= ROT_TMP(8); --- Carry out is MSB of previous state
            X <= ROT_TMP(7 downto 0);
            Y <= "00000000";
				V <= '0';
				N <= '0';
        --- RIGHT SHIFT OP
        elsif OPCODE = "1100" then
            LRS(7 downto 0) := std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B)))); --- SHIFT functions shifts X by N bits to R/L
            Cout <= '0';
            X <= LRS;
            Y <= "00000000";
				V <= '0';
				N <= '0';
        --- ARITH SHIFT
        elsif OPCODE = "1101" then
            ARS(7 downto 0) := std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
            ARS(8) := A(7);
            ARS := std_logic_vector(unsigned(ARS) + unsigned'('0' & A(to_integer(unsigned(B)) - 1)));
            Cout <= ARS(8);
            X <= ARS(7 downto 0);
            Y <= "00000000";
				V <= '0';
				if signed(X) < 0 then --- If the number is negetive, then set N flag on
					N <= '1';
				else
					N <= '0';
				end if;
        --- LEFT SHIFT
        elsif OPCODE = "1110" then
            RLS(7 downto 0) := std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
            Cout <= A(7);
            x <= RLS(7 downto 0);
            Y <= "00000000";
				V <= '0';
				if signed(X) < 0 then --- If the number is negetive, then set N flag on
					N <= '1';
				else
					N <= '0';
				end if;
        --- BCD TO BIN
        elsif OPCODE = "1111" then
            BCD := std_logic_vector(unsigned(unsigned(A(3 downto 0)) * "01")  --multiply by 1
                + unsigned(unsigned(A(7 downto 4)) * "1010") --multiply by 10
                + unsigned(unsigned(B(3 downto 0)) * "1100100") --multiply by 100
                + unsigned(unsigned(B(7 downto 4)) * "1111101000" )); --multiply by 1000
            Y <= "00" & BCD(13 downto 8);  
            X <= BCD(7 downto 0);
				V <= '0';
				N <= '0';
        end if;
    end process;
    
    
end Behavioral;