----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 17:59:36
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end UAL;

    -- OOO : add
    -- 001 : sub
    -- 010 : mul
    -- 011 : div

architecture Behavioral of UAL is
        
    signal Add_Res : std_logic_vector (8 downto 0) := (others => '0');
    signal Sub_Res : std_logic_vector (7 downto 0) := (others => '0');
    signal Mul_Res : std_logic_vector (15 downto 0):= (others => '0');
    signal Div_Res : std_logic_vector (7 downto 0) := (others => '0');

    signal Aux : std_logic_vector (7 downto 0) := (others => '0');
     
begin
    
    Add_Res <= ('0'& A) + ('0' & B);
    Sub_Res <= A - B;
    Mul_Res <= A * B;
    
    Aux <=  Add_Res(7 downto 0) when Ctrl_Alu="000" else
            Mul_Res(7 downto 0) when Ctrl_Alu="001" else
            Sub_Res when Ctrl_Alu="010" else
            Div_Res when Ctrl_Alu="011" ;
    
    -- FLAGS
    C <= Add_Res(8) when Ctrl_Alu = "000";                                          --Carry
    Z <= '1' when Aux = 0 else '0';                                                 --Zero
    O <= '1' when Mul_Res(15 downto 8) /= X"0" and Ctrl_Alu="001" else '0';   --Overflow
    N <= '1' when A < B and Ctrl_Alu="010" else '0';        --Negative
    
    S <= Aux;
        
end Behavioral;
