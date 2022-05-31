----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2022 15:35:13
-- Design Name: 
-- Module Name: pipeline1 - Behavioral
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

entity pipeline1 is
    Port ( inOp : in STD_LOGIC_VECTOR (7 downto 0);
           inA : in STD_LOGIC_VECTOR (7 downto 0);
           inB : in STD_LOGIC_VECTOR (7 downto 0);
           inC : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           outOp : out STD_LOGIC_VECTOR (7 downto 0);
           outA : out STD_LOGIC_VECTOR (7 downto 0);
           outB : out STD_LOGIC_VECTOR (7 downto 0);
           outC : out STD_LOGIC_VECTOR (7 downto 0));
end pipeline1;

architecture Behavioral of pipeline1 is

begin
    process
    begin
        wait until CLK'event and CLK = '1'; 
            outA <= inA;
            outB <= inB; 
            outC <= inC; 
            outOp <= inOp;
    end process;        

end Behavioral;
