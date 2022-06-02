----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.05.2022 11:19:50
-- Design Name: 
-- Module Name: test_pipeline - Behavioral
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

entity test_pipeline is
--  Port ( );
end test_pipeline;

architecture Behavioral of test_pipeline is
    
    component pipeline
    port (    inOp : in STD_LOGIC_VECTOR (7 downto 0);
               inA : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               inC : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               outOp : out STD_LOGIC_VECTOR (7 downto 0);
               outA : out STD_LOGIC_VECTOR (7 downto 0);
               outB : out STD_LOGIC_VECTOR (7 downto 0);
               outC : out STD_LOGIC_VECTOR (7 downto 0)
              );
    end component;
    
    --Inputs
    signal A_in :STD_LOGIC_VECTOR ( 7 downto 0) := (others => '0');
    signal B_in :STD_LOGIC_VECTOR ( 7 downto 0) := (others => '0');
    signal C_in :STD_LOGIC_VECTOR ( 7 downto 0) := (others => '0');
    signal OP_in :STD_LOGIC_VECTOR ( 7 downto 0):= (others => '0');
    signal CLK : STD_LOGIC := '0';
    
    --Outputs
    signal A_out :STD_LOGIC_VECTOR ( 7 downto 0);
    signal B_out :STD_LOGIC_VECTOR ( 7 downto 0);
    signal C_out :STD_LOGIC_VECTOR ( 7 downto 0);
    signal OP_out :STD_LOGIC_VECTOR ( 7 downto 0);
    
    --Clock
    constant CLK_period : time := 10 ns;
    
    
begin

    --Instanciation
    pipe: pipeline
    port map(    inA => A_in,
                 inB => B_in,
                 inC => C_in,
                 inOP => OP_in,
                 CLK => CLK,
                 outA => A_out,
                 outB => B_out,
                 outC => C_out,
                 outOP => OP_out
                  );
    
    --clock processs
    clock_process : process
    begin
        CLK <= '0';
        wait for CLK_period / 2;
        CLK <= '1';
        wait for CLK_period / 2;
    end process;
    
    A_in<=X"01", X"02" after 50 ns;
    B_in<=X"AA", X"AB" after 100 ns;
    C_in<=X"FF", X"00" after 105 ns;
    OP_in<="00000000";
        
end Behavioral;
