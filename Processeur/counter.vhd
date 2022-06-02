----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.03.2022 14:42:41
-- Design Name: 
-- Module Name: td1_source - Behavioral
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

-- Uncomment the following library                                                                                                      declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           LOAD : in STD_LOGIC;
           SENS : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           D_IN : in STD_LOGIC_VECTOR (7 downto 0);
           D_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end counter;

architecture Behavioral of counter is    
    signal OLCO : STD_LOGIC_VECTOR(7 downto 0);
                                                        
begin
    
    D_OUT <= OLCO;
    process    
    begin 
        wait until CLK'Event and CLK = '1'; 
        if(RESET = '0')then
            OLCO <= (others => '0');
        elsif (LOAD='1') then
            OLCO <= D_IN;
        elsif (ENABLE = '0') then
            if (SENS = '1') then
                OLCO <= OLCO+1;
            else
                D_OUT <= OLCO-1;
            end if;
        end if; 
    end process;
end Behavioral;