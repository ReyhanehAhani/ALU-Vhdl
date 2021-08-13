library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEQ_ALU is
    Port ( CLK: in STD_LOGIC;
           RES: in STD_LOGIC;
           I: in STD_LOGIC_VECTOR(7 downto 0);
           LOAD: in STD_LOGIC;
           SEL_IN: in STD_LOGIC;
           OP: in STD_LOGIC_VECTOR(3 downto 0);
           RUN: in STD_LOGIC;
           SEL_OUT: in STD_LOGIC;
           R: out STD_LOGIC_VECTOR(7 downto 0);
           Z: inout STD_LOGIC;
           Cout: inout STD_LOGIC;
           V: inout STD_LOGIC;
           F_active: out STD_LOGIC;
           X_bin_pal: out STD_LOGIC;
           X_prime: out STD_LOGIC;
           N: out STD_LOGIC );
end SEQ_ALU;

architecture Behavioral of SEQ_ALU is
--- Signals to for enabling specific parts
signal en_C, en_V, en_N, en0, en1, cinSig, coutSig, zSig, vSig, xPrimeSig, xBinPalSig, nSig: STD_LOGIC;
signal A_reg: STD_LOGIC_VECTOR(7 downto 0);
signal B_reg: STD_LOGIC_VECTOR(7 downto 0);

signal X_reg: STD_LOGIC_VECTOR(7 downto 0);
signal Y_reg: STD_LOGIC_VECTOR(7 downto 0);

signal X_reg_flip: STD_LOGIC_VECTOR(7 downto 0);
signal Y_reg_flip: STD_LOGIC_VECTOR(7 downto 0);

begin
    
    --- Store the value of A to I if en0 is selected, if it's not, then load value of en1
    REG_I_1: entity work.PIPO port map(E => en0, CLK => CLK, RES => RES, A => I, B => A_reg);
    REG_I_2: entity work.PIPO port map(E => en1, CLK => CLK, RES => RES, A => I, B => B_reg);
    
    
    --- Connecte the ALU inputs and outputs
    ALU1: entity work.ALU port map(
        A => A_reg, B => B_reg, 
        OPCODE => OP, Cin => cinSig, 
        X => X_reg, Y => Y_reg, 
        Cout => coutSig, Z => zSig, 
        V => vSig, X_prime => xPrimeSig,
        X_Bin_Pal => xBinPalSig, N => nSig);
    
    --- Flip flop for enabling the cout function of ALU
    FLIP_Cout: entity work.FlipFlop port map(A => coutSig, B => cinSig, CLK => CLK, E => en_C, RES => RES);
    Cout <= cinSig;
    
    --- Flip flops for enabling Zero, overflow, prime and negetive
    FLIP_Z: entity work.FlipFlop port map(A => zSig, B => Z, CLK => CLK, E => RUN, RES => RES);
    FLIP_V: entity work.FlipFlop port map(A => vSig, B => V, CLK => CLK, E => RUN, RES => RES);
    FLIP_X_prime: entity work.FlipFlop port map(A => xPrimeSig, B => X_prime, CLK => CLK, E => RUN, RES => RES);
    FLIP_N: entity work.FlipFlop port map(A => nSig, B => N, CLK => CLK, E => RUN, RES => RES);
    
    --- Output the selected byte of data to R using MUXs and Flip PIPO shift registers
    REG_O_1: entity work.PIPO port map(E => RUN, CLK => CLK, RES => RES, A => Y_reg, B => Y_reg_flip);
    REG_O_2: entity work.PIPO port map(E => RUN, CLK => CLK, RES => RES, A => X_reg, B => X_reg_flip);
    MUX_O: entity work.MUX21 port map(I0 => X_reg_flip, I1 => Y_reg_flip, SEL => SEL_OUT, Q => R);
    
    Process(OP, LOAD)
    begin
        --- if the LOAD clk is rising, then select the input byte from the SEL_IN pin
        if rising_edge(LOAD) then
            if (SEL_IN = '0') then
                en0<= '1';
                en1<= '0';
            elsif (SEL_IN = '1') then
                en0<= '0';
                en1<= '1';
            end if;
        end if;
        
        --- Enable/Disable CarryOut, Overflow and Negetive function using the selected OPCODE
        if OP = "0000" or OP = "0001" or OP = "0010" or OP = "0011" or OP = "1000" or OP = "1010" then
            en_C <= '0';
            en_V <= '0';
            en_N <= '0';
        elsif OP = "0100" or OP = "0110" or OP = "1001" or OP = "1011" or OP = "1100" or OP = "1111" then
            en_C <= '1';
            en_V <= '0';
            en_N <= '0';
        elsif OP = "0101" then
            en_C <= '0';
            en_V <= '1';
            en_N <= '1';
        elsif OP = "0111" then
            en_C <= '0';
            en_V <= '0';
            en_N <= '1';
        elsif OP = "1101" then
            en_C <= '1';
            en_V <= '1';
            en_N <= '0';
        elsif OP = "1110" then
            en_C <= '1';
            en_V <= '1';
            en_N <= '1';
        end if;
    end process;
    
    --- Output the failure Flag 
    F_active <= Cout or Z or V;
    
end Behavioral;
