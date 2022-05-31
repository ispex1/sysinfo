----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2022 15:05:16
-- Design Name: 
-- Module Name: CPU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
    Port ( CLK_CPU : in STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
   
    component counter 
        Port ( CLK : in STD_LOGIC;
               RESET : in STD_LOGIC;
               LOAD : in STD_LOGIC;
               SENS : in STD_LOGIC;
               ENABLE : in STD_LOGIC;
               D_IN : in STD_LOGIC_VECTOR (7 downto 0);
               D_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component UAL
        Port ( Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
               A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               S : out STD_LOGIC_VECTOR (7 downto 0);
               N : out STD_LOGIC;
               O : out STD_LOGIC;
               Z : out STD_LOGIC;
               C : out STD_LOGIC);
    end component;
    
    component Banc_Registres
        Port (  ADDR_A : in STD_LOGIC_VECTOR (3 downto 0);
                ADDR_B : in STD_LOGIC_VECTOR (3 downto 0);
                ADDR_W : in STD_LOGIC_VECTOR (3 downto 0);
                W : in STD_LOGIC;
                DATA : in STD_LOGIC_VECTOR (7 downto 0);
                RST : in STD_LOGIC;
                CLK : in STD_LOGIC;
                QA : out STD_LOGIC_VECTOR (7 downto 0);
                QB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component data_memory
        Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT : in STD_LOGIC_VECTOR (7 downto 0);
               RW : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component instruction_memory
        Port (  IN_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
                CLK : in STD_LOGIC;
                OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component pipeline1
        Port ( inOp : in STD_LOGIC_VECTOR (7 downto 0);
               inA : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               inC : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               outOp : out STD_LOGIC_VECTOR (7 downto 0);
               outA : out STD_LOGIC_VECTOR (7 downto 0);
               outB : out STD_LOGIC_VECTOR (7 downto 0);
               outC : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component pipeline2
        Port ( inOp : in STD_LOGIC_VECTOR (7 downto 0);
               inA : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               inC : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               outOp : out STD_LOGIC_VECTOR (7 downto 0);
               outA : out STD_LOGIC_VECTOR (7 downto 0);
               outB : out STD_LOGIC_VECTOR (7 downto 0);
               outC : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component pipeline3
        Port ( inOp : in STD_LOGIC_VECTOR (7 downto 0);
               inA : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               outOp : out STD_LOGIC_VECTOR (7 downto 0);
               outA : out STD_LOGIC_VECTOR (7 downto 0);
               outB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component pipeline4
        Port ( inOp : in STD_LOGIC_VECTOR (7 downto 0);
               inA : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               outOp : out STD_LOGIC;
               outA : out STD_LOGIC_VECTOR (3 downto 0);
               outB : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    --OUT Memoire des instructions
    signal OUT_IP : STD_LOGIC_VECTOR (7 downto 0);
    signal OUT_IM : STD_LOGIC_VECTOR (31 downto 0);
    --OUT Banc de registre
    signal OUT_BR_A, OUT_BR_B : STD_LOGIC_VECTOR (7 downto 0);
    --OUT ALU
    signal OUT_ALU_N,OUT_ALU_O,OUT_ALU_Z,OUT_ALU_C : STD_LOGIC;
    signal OUT_ALU_S : STD_LOGIC_VECTOR (7 downto 0);
    --OUT Memoire des Données
    signal OUT_MD : STD_LOGIC_VECTOR(7 downto 0);
    --OUT Pipeline 1
    signal OUT_PIP1_OP, OUT_PIP1_A, OUT_PIP1_B, OUT_PIP1_C :STD_LOGIC_VECTOR (7 downto 0);
    --OUT Pipeline 2
    signal OUT_PIP2_OP, OUT_PIP2_A, OUT_PIP2_B, OUT_PIP2_C :STD_LOGIC_VECTOR (7 downto 0);
    --OUT Pipeline 3
    signal OUT_PIP3_OP, OUT_PIP3_A, OUT_PIP3_B :STD_LOGIC_VECTOR (7 downto 0);
    --OUT Pipeline 4
    signal OUT_PIP4_A, OUT_PIP4_B :STD_LOGIC_VECTOR (3 downto 0);
    signal  OUT_PIP4_OP : STD_LOGIC;
    --autorise l'ecriture sur le banc de registre
    signal writing : STD_LOGIC;
    --signal de reset
    signal reset : STD_LOGIC;
        
begin
    
    --Instruction Pointer
    ip : counter 
    Port map( CLK => CLK_CPU, 
                  RESET => reset,
                  LOAD => '0',
                  SENS => '0',
                  ENABLE => '0',
                  D_IN => (others => '0'),
                  D_OUT => OUT_IP);
    
    --Instruction Memory            
    im : instruction_memory
    Port map (  IN_ADDR => OUT_IP,
                CLK => CLK_CPU,
                OUTPUT => OUT_IM);
                
    --Pipeline 1
    lidi : pipeline1
    Port map (  inOP => OUT_IM(31 downto 24),
                inA => OUT_IM(23 downto 16),
                inB => OUT_IM(15 downto 8),
                inC => OUT_IM(7 downto 0),
                CLK => CLK_CPU,
                outOp => OUT_PIP1_OP,
                outA => OUT_PIP1_A,
                outB => OUT_PIP1_B,
                outC => OUT_PIP1_C);

    --Banc de registre
    br : Banc_Registres
    Port map (  ADDR_A =>(others => '0'),--pas connecté pour AFC
                ADDR_B =>(others => '0'),
                ADDR_W => OUT_PIP4_A,
                W => writing,
                DATA => OUT_PIP4_B,
                RST => reset,
                CLK => CLK_CPU,
                QA => OUT_BR_A,
                QB => OUT_BR_B);
    
    --Pipeline 2
    diex : pipeline2
    Port map (  inOP => OUT_PIP1_OP,
                inA => OUT_PIP1_A,
                inB => OUT_PIP1_B,
                inC => (others => '0'),--pas connecté pour AFC
                CLK => CLK_CPU,
                outOp => OUT_PIP2_OP,
                outA => OUT_PIP2_A,
                outB => OUT_PIP2_B,
                outC => OUT_PIP2_C);
    
    --UAL 
    alu : UAL
    Port map (  Ctrl_Alu => (others => '0'),--pas connecté pour AFC
                A => (others => '0'),--pas connecté pour AFC
                B => (others => '0'),--pas connecté pour AFC
                S => OUT_ALU_S,
                N => OUT_ALU_N,
                O => OUT_ALU_O,
                Z => OUT_ALU_Z,
                C => OUT_ALU_C);
                
    --Pipeline 3
    exmem : pipeline3
    Port map (  inOP => OUT_PIP2_OP,
                inA => OUT_PIP2_A,
                inB => OUT_PIP2_B,
                CLK => CLK_CPU,
                outOp => OUT_PIP3_OP,
                outA => OUT_PIP3_A,
                outB => OUT_PIP3_B);
    
    --Data Memory
    md :Data_Memory
    Port map (  ADDR => (others => '0'),--pas connecté pour AFC
                INPUT => (others => '0'),--pas connecté pour AFC
                RW => '0',--pas connecté pour AFC
                RST => reset,
                CLK => CLK_CPU,
                OUTPUT => OUT_MD
    );
    --Pipeline 4
    memre : Pipeline4
    Port map(   inOP => OUT_PIP3_OP,
                inA => OUT_PIP3_A,
                inB => OUT_PIP3_B,
                CLK => CLK_CPU,
                outOp => OUT_PIP4_OP,
                outA => OUT_PIP4_A,
                outB => OUT_PIP4_B);
                
    -- LC (Logic Comparator) Autorisation en ecriture lorsque OP = ADD, MUL, SOU, DIV, COP, AFC, LOAD
    writing <= '0' when (      OUT_PIP4_OP = "00000001" 
                            or OUT_PIP4_OP = "00000010" 
                            or OUT_PIP4_OP = "00000011" 
                            or OUT_PIP4_OP = "00000100"
                            or OUT_PIP4_OP = "00000101"
                            or OUT_PIP4_OP = "00000110"
                            or OUT_PIP4_OP = "00000111") else '1' ;
                       
                       
    
end Behavioral;
