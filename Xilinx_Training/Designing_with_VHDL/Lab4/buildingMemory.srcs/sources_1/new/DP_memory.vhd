----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2022 09:18:52 AM
-- Design Name: Building Memory
-- Module Name: DP_memory - Behavioral
-- Project Name: Designing with VHDL
-- Target Devices: 
-- Tool Versions: 
-- Description: This lab illustrates how to design a dual-port memory in VHDL.  
-- The source code that you will write will support the full reading and writing
-- of the DP_memory and will be tested using a pre-written testbench.
-- You will then comment out the items marked with the ‘X’ in the figure above
-- and synthesize, using block RAM resources.
-- 
-- Dependencies: This lab illustrates how to design a dual-port memory in VHDL. 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DP_memory is
    Port ( PortA_clk : in STD_LOGIC;
           PortA_addr : in STD_LOGIC_VECTOR (9 downto 0);
           PortA_datain : in STD_LOGIC_VECTOR (7 downto 0);
           PortA_writeEnable : in STD_LOGIC;
           PortA_dataOut : out STD_LOGIC_VECTOR (7 downto 0);
           PortB_clk : in STD_LOGIC;
           PortB_addr : in STD_LOGIC_VECTOR (9 downto 0);
           PortB_datain : in STD_LOGIC_VECTOR (7 downto 0);
           PortB_writeEnable : in STD_LOGIC;
           PortB_dataOut : out STD_LOGIC_VECTOR (7 downto 0));
end DP_memory;

architecture Behavioral of DP_memory is

--Memory array
	type memoryByteArray is array(0 to 1023) of std_logic_vector(7 downto 0);
	
	--shared variable: Shared variables are declared with the key words "shared variable" 
	--instead of variable or signal and are used to share data between processes.
	--shared variable memoryBlock : memoryByteArray := (others =>(others=> '0');
	shared variable memoryBlock : memoryByteArray;

begin

--Step 1
	Aside: process(PortA_clk)
	--proc declaration
	--Step 2
	variable address: integer range 0 to 1023;
	begin
		if(rising_edge(PortA_clk)) then
			--Step 3
			--address conversion
			address := (to_integer(unsigned(PortA_addr)));
			if(PortA_writeEnable = '1') then
				--Step 4
				--assign datain to memory on every writeEnable on each rising clk
				memoryBlock(address) := PortA_datain;
				
				--Step 5
				--data_out assignment
				--PortA_dataOut <= memoryBlock(address);
				--incremeant address
				--address := address + 1;
			PortA_dataOut <= memoryBlock(address);--I moved this out of the enable if
			end if;
		end if;
	end process Aside;

--Step 1
	Bside: process(PortB_clk)
	--proc declaration
	--Step 2
	variable address: integer range 0 to 1023;
	begin
		if(rising_edge(PortB_clk)) then
			--Step 3
			--address conversion
			address := (to_integer(unsigned(PortB_addr)));
			if(PortB_writeEnable = '1') then
				-- --Step 4
				-- --assign datain to memory on every writeEnable on each rising clk
				memoryBlock(address) := PortB_datain;
				
				--Step 5
				--data_out assignment
				--PortB_dataOut <= memoryBlock(address);--This was where I placed the assignment at first
				--incremeant address
				--address := address + 1;
			end if;
			PortB_dataOut <= memoryBlock(address);--I moved this out of enable if
		end if;
	end process Bside;


end Behavioral;
