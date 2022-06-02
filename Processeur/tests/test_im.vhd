----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2022 13:26:43
-- Design Name: 
-- Module Name: test_im - Behavioral
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

entity test_im is
--  Port ( );
end test_im;

architecture Behavioral of test_im is

component Instruction_Memory is
    Port ( IN_ADDR : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

-- ======= SIGNAL =======
-- INPUTS
signal Addr_test : std_logic_vector(7 downto 0) := (others => '0');
signal CLK_test : std_logic := '0';

-- OUTPUT
signal Output_test : std_logic_vector(31 downto 0) := (others => '0');


---Clock period 
constant Clock_period : time := 10 ns;

begin

        --unit under test
    uut : Instruction_Memory
    port map (      IN_ADDR => Addr_test,
                    CLK => CLK_test,
                    OUTPUT => Output_test);
    
    --clock process
    Clock_process : process
    begin
        CLK_test <= not(CLK_test);
        wait for Clock_period/2;
    end process;
    
    --Test
    Addr_test <= X"01" after 100ns, X"02" after 200 ns, X"FF" after 300ns;

end Behavioral;
