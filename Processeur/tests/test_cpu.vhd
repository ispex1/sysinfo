----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2022 14:45:55
-- Design Name: 
-- Module Name: test_cpu - Behavioral
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

entity test_cpu is
--  Port ( );
end test_cpu;

architecture Behavioral of test_cpu is

component CPU is
    Port (  CLK_CPU : in STD_LOGIC;
            RST_CPU : in STD_LOGIC);
end component;

-- ====== SIGNALS ======
---inputs
signal CLK_test : STD_LOGIC := '1';
signal RST_test : STD_LOGIC := '1';

constant CLK_period : time := 10 ns;

begin

cpu_test : cpu
    port map (  CLK_CPU => CLK_test,
                RST_CPU => RST_test);
                
-- clock process
Clock_process : process
begin
    CLK_test <= not(CLK_test);
    wait for CLK_period/2;
end process;

RST_test <= '0' after 600 ns;

end Behavioral;
