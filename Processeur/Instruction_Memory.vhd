----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2022 14:41:43
-- Design Name: 
-- Module Name: Instruction_Memory - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Memory is
    Port ( IN_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

type mem is array(255 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
signal data_memory : mem := (others => (others => '0'));
signal indice : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin
    
    --LISTE DES INSTRUCTIONS
                                                          --                     C        B        OP       A        
    data_memory(0)  <= "00000000000000010000011000000001"; --AFC 1 1     /// 00000000 00000001 00000110 00000001
    data_memory(3)  <= "00000000000000110000011000000011"; --AFC 3 3     /// 00000000 00000011 00000110 00000011
    data_memory(6)  <= "00000000000001000000011000000100"; --AFC 4 4     /// 00000000 00000100 00000110 00000100
    data_memory(9)  <= "00000000000001010000011000000101"; --AFC 5 5     /// 00000000 00000101 00000110 00000101
    data_memory(12) <= "00000000000001100000011000000110"; --AFC 6 6     /// 00000000 00000110 00000110 00000110
    data_memory(15) <= "00000000000000010000010100000010"; --CPY 2 1     /// 00000000 00000001 00000101 00000010 
    data_memory(18) <= "00000100000001100000000100000101"; --ADD 5 6 4   /// 00000100 00000110 00000001 00000101      
    data_memory(24) <= "00000010000000110000001000000110"; --MUL 6 3 2   /// 00000010 00000011 00000010 00000110      
    data_memory(30) <= "00000010000001010000001100000111"; --SOU 7 5 2   /// 00000010 00000101 00000011 00000111 
    data_memory(35) <= "00000000000001010000100011111110"; --STORE 254 5 /// 00000000 00000101 00001000 11111110
    data_memory(40) <= "00000000111111100000011100001000"; --LOAD 8 254  /// 00000000 11111110 00000111 00001000 
             
    
    
    --data_memory(6) <= X"00000000"; --NOP 0X00
--    data_memory(1) <= X"00000001"; --ADD 0X01
--    data_memory(2) <= X"00000002"; --MUL 0X02
--    data_memory(3) <= X"00000003"; --SOU 0X03
--    data_memory(4) <= X"00000004"; --DIV 0X04
--    data_memory(5) <= X"00000005"; --COP 0X05
--                                   --AFC 0X06 00000000 00000001 00000110 00000001
--    data_memory(7) <= X"00000007"; --LOAD 0X07
--    data_memory(8) <= X"00000008"; --STORE 0X08
    
    
    process
    begin
        wait until CLK'event and CLK= '1'; 
            OUTPUT <= data_memory(to_integer(unsigned(indice)));
            indice <= indice + 1;

    end process;

end Behavioral;
