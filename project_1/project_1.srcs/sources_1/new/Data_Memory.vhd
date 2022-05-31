----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 13:49:38
-- Design Name: 
-- Module Name: Data_Memory - Behavioral
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

entity Data_Memory is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is

type mem is array(15 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
signal data_memory : mem;

begin

    process
    begin
        wait until CLK'event and CLK= '1'; 
            if RST = '0' then
                for i in 0 to 15 loop 
                    data_memory(i) <= "00000000";
                end loop;
            end if;
            
            if RW = '1' then
                OUTPUT <= data_memory(to_integer(unsigned(ADDR)));
            elsif RW = '0' then
                data_memory(to_integer(unsigned(ADDR))) <= INPUT;
            end if ;
            
    end process; 
end Behavioral;
