----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:11:08 06/04/2009 
-- Design Name: 
-- Module Name:    reset_bridge - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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


entity reset_bridge is
    Port ( clk_dst : in  STD_LOGIC;
           rst_in  : in  STD_LOGIC;
           rst_out : out STD_LOGIC);
end reset_bridge;

architecture Behavioral of reset_bridge is

	begin

		process (clk_dst,rst_in)
		   variable rst_meta : std_logic := 'U';
		begin  
			if rst_in = '1' then
				rst_meta := '1';		-- the meta-stable likely flop is driven high internal to the process
				rst_out  <= '1';		-- the output of the module is also driven high
			elsif (rising_edge(clk_dst)) then
				rst_out <= rst_meta;	-- feed the second flop the output of the first flop
				rst_meta := '0';		-- clear the meta-stable likely flop 				
			end if;
		end process;

	end Behavioral;

