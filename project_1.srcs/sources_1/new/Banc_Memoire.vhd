----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 13:43:32
-- Design Name: 
-- Module Name: Banc_Memoire - Behavioral
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

entity Banc_Memoire is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           IN_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUT_DATA : in STD_LOGIC_VECTOR (7 downto 0);
           OUT_INSTRUCT : in STD_LOGIC_VECTOR (31 downto 0));
end Banc_Memoire;

architecture Behavioral of Banc_Memoire is

begin


end Behavioral;
