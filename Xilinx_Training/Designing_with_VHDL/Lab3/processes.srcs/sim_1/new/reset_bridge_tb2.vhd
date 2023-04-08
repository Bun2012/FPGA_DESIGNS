----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/10/2022 11:54:28 AM
-- Design Name: 
-- Module Name: reset_bridge_tb - Behavioral
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

entity reset_bridge_tb2 is
--  Port ( );
end reset_bridge_tb2;

architecture Behavioral of reset_bridge_tb2 is

Component reset_bridge
        port(
            clk_dst	: in std_logic;
            rst_in	: in std_logic;
            rst_out	: out std_logic
    
        );
end component reset_bridge;

--Signal Declaration
	signal rst_in	: std_logic := '0';
	signal clk_dst	: std_logic := '0';
	signal rst_out	: std_logic;
--Clock Constant
	--Clock period
	constant clock_period: time := 10 ns;

begin

--Component Instantiation
rst_bridge_tb: reset_bridge
    port map(
    
        clk_dst	=> clk_dst,
        rst_in	=> rst_in,
        rst_out	=> rst_out
    
    );

	rst_in <= not rst_in after (clock_period * 4);
	
	clk_dst <= not clk_dst after 5 ns;
	
	
end Behavioral;
