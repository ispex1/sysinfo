----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 13:34:18
-- Design Name: 
-- Module Name: Banc_Registres - Behavioral
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

entity Banc_Registres is
    Port ( ADDR_A : in STD_LOGIC_VECTOR (3 downto 0);
           ADDR_B : in STD_LOGIC_VECTOR (3 downto 0);
           ADDR_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_Registres;

architecture Behavioral of Banc_Registres is

type tab is array(15 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
signal tabRegistres : tab := (others => (others => '0'));

begin
    process
    begin
        wait until CLK'event and CLK= '1'; 
            if RST = '0' then
                for i in 0 to 15 loop 
                    tabRegistres(i) <= "00000000";
                 end loop;
            end if;
            
            if W = '1' then 
                tabRegistres(to_integer(unsigned(Addr_W))) <= DATA;
            end if; 
    end process;
    
    QA <= tabRegistres(to_integer(unsigned(ADDR_A))) when W = '0' or ADDR_A /= ADDR_W else DATA ;
    QB <= tabRegistres(to_integer(unsigned(ADDR_B))) when W = '0' or ADDR_B /= ADDR_W else DATA ;
    
end Behavioral;
