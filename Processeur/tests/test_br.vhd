----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.06.2022 14:09:54
-- Design Name: 
-- Module Name: test_br - Behavioral
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

entity test_br is
--  Port ( );
end test_br;

architecture Behavioral of test_br is

component Banc_Registres is
    Port ( ADDR_A : in STD_LOGIC_VECTOR (3 downto 0);
           ADDR_B : in STD_LOGIC_VECTOR (3 downto 0);
           ADDR_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;


-- ======= SIGNAL =======
-- INPUTS
signal AddrA_test : std_logic_vector(3 downto 0) := (others => '0');
signal AddrB_test : std_logic_vector(3 downto 0) := (others => '0');
signal AddrW_test : std_logic_vector(3 downto 0) := (others => '0');

signal W_test : std_logic := '0';
signal Data_test : std_logic_vector (7 downto 0) := (others => '0');

signal RST_test : std_logic := '1';
signal CLK_test : std_logic := '0';

-- OUTPUT
signal QA_test : std_logic_vector(7 downto 0) := (others => '0');
signal QB_test : std_logic_vector(7 downto 0) := (others => '0');


---Clock period 
constant Clock_period : time := 10 ns;


begin

    --unit under test
    uut : Banc_registres
    port map (      ADDR_A => AddrA_test,
                    ADDR_B => AddrB_test,
                    ADDR_W => AddrW_test,
                    W => W_test,
                    DATA => Data_test,
                    RST => RST_test,
                    CLK => CLK_test,
                    QA => QA_test,
                    QB => QB_test);
                    
    --clock process
    Clock_process : process
    begin
        CLK_test <= not(CLK_test);
        wait for Clock_period/2;
    end process;
    
    --Test
    AddrA_test  <= X"0", X"1" after 100 ns;
    AddrB_test  <= X"0", X"2" after 100ns;
    W_test      <= '0', '1' after 200ns, '0' after 220ns; -- actif sur 1
    AddrW_test  <= X"1"; --ecriture en 0x01
    DATA_test   <= "10101010";
    RST_test    <='1' after 400 ns, '0' after 410 ns;
    

end Behavioral;
