----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2022 11:42:39
-- Design Name: 
-- Module Name: test_ual - Behavioral
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

entity test_ual is
--  Port ( );
end test_ual;

architecture Behavioral of test_ual is
    -- Component Declaration for the Unit Under Test (UUT)

COMPONENT UAL
PORT(
     A : IN  std_logic_vector(7 downto 0);
     B : IN  std_logic_vector(7 downto 0);
     Ctrl_Alu : IN  std_logic_vector(2 downto 0);
     S : OUT  std_logic_vector(7 downto 0);
     N : OUT  std_logic;
     O : OUT  std_logic;
     Z : OUT  std_logic;
     C : OUT  std_logic
    );
END COMPONENT;


--Inputs
signal A : std_logic_vector(7 downto 0) := (others => '0');
signal B : std_logic_vector(7 downto 0) := (others => '0');
signal Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');

 --Outputs
signal S : std_logic_vector(7 downto 0);
signal N : std_logic;
signal O : std_logic;
signal Z : std_logic;
signal C : std_logic;
-- No clocks detected in port list. Replace <clock> below with 
-- appropriate port name 



BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: UAL PORT MAP (
      A => A,
      B => B,
      Ctrl_Alu => Ctrl_Alu,
      S => S,
      N => N,
      O => O,
      Z => Z,
      C => C
    );


A <= X"01" , X"02" after 100 ns, X"03" after 200 ns, X"FF" after 300 ns;
B<= X"10", X"11" after 100 ns, X"04" after 200 ns, X"0A" after 300ns;
Ctrl_Alu <= "000";


end Behavioral;
