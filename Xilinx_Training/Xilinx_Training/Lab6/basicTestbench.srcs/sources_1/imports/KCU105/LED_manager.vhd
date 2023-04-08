----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:06:14 06/03/2009 
-- Design Name: 
-- Module Name:    LED_manager - Behavioral 
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

entity LED_manager is
    Port ( Channel_1_data   : in  STD_LOGIC_VECTOR (7 downto 0);
           Channel_2_data   : in  STD_LOGIC_VECTOR (7 downto 0);
           Channel_1_enable : in  STD_LOGIC;
           Channel_2_enable : in  STD_LOGIC;
           Selector         : in  STD_LOGIC;
           clock            : in  STD_LOGIC;
           reset            : in  STD_LOGIC;
           data_out         : out STD_LOGIC_VECTOR (7 downto 0)
			 );
end LED_manager;

architecture Behavioral of LED_manager is

	COMPONENT register8
	PORT(
		clock : IN std_logic;
		reset : IN std_logic;
		enable : IN std_logic;
		data_in : IN std_logic_vector(7 downto 0);          
		data_out : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	signal Channel_1_registered_data : std_logic_vector(7 downto 0);
	signal Channel_2_registered_data : std_logic_vector(7 downto 0);
	
	signal mux_data_selected         : std_logic_vector(7 downto 0);		-- contains the output from the mux
	
	signal sychRun, syncReset : boolean;
	
begin

	regCh1: register8 PORT MAP(
		clock    => clock,
		reset    => reset,
		enable   => Channel_1_enable,
		data_in  => Channel_1_data,
		data_out => Channel_1_registered_data
	);
	
	regCh2: register8 PORT MAP(
		clock    => clock,
		reset    => reset,
		enable   => Channel_2_enable,
		data_in  => Channel_2_data,
		data_out => Channel_2_registered_data
	);
	
	--
	-- construct a 2 input mux
	with Selector select
	   mux_data_selected <= Channel_1_registered_data when '0',
		                     Channel_2_registered_data when '1',
									(others=>'-')             when others;
									
	--
	-- 8 bit register for output 
	data_out <= mux_data_selected when rising_edge(clock);


end Behavioral;

