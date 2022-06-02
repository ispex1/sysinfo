----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2022 11:39:58
-- Design Name: 
-- Module Name: test_md - Behavioral
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

entity test_md is
--  Port ( );
end test_md;

architecture Behavioral of test_md is

component Data_Memory is
    Port ( ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

-- ======= SIGNAL =======
-- INPUTS
signal Addr_test : std_logic_vector(7 downto 0) := (others => '0');
signal Input_test : std_logic_vector (7 downto 0) := (others => '0');
signal RW_test : std_logic := '0';
signal RST_test : std_logic := '0';
signal CLK_test : std_logic := '0';

-- OUTPUT
signal Output_test : std_logic_vector(7 downto 0) := (others => '0');


---Clock period 
constant Clock_period : time := 10 ns;


begin
    
    --unit under test
    uut : Data_Memory
    port map (      ADDR => Addr_test,
                    INPUT => Input_test,
                    RW => RW_test,
                    RST => RST_test,
                    CLK => CLK_test,
                    OUTPUT => Output_test);
    
    --clock process
    Clock_process : process
    begin
        CLK_test <= not(CLK_test);
        wait for Clock_period/2;
    end process;
    
    --Test
    Addr_test <= "00000001";
    Input_test <= "11111111";
    RST_test <= '1', '0' after 300 ns;
    -- RW = 1 : lecture ;;;; RW = 0 : ecriture
    RW_test <= '1', '0' after 100 ns, '1' after 200 ns;

end Behavioral;
