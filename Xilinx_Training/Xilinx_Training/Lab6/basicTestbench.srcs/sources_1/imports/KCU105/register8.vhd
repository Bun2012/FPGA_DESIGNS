----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:12 06/02/2009 
-- Design Name: 
-- Module Name:    register8 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity register8 is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end register8;

architecture Behavioral of register8 is
 
begin

	process (clock)
	begin
		if clock'event and clock='1' then  
			if reset='1' then   
				data_out <= (others=>'0');
			elsif enable ='1' then
				data_out <= data_in;
			end if;
		end if;
	end process;

end Behavioral;

