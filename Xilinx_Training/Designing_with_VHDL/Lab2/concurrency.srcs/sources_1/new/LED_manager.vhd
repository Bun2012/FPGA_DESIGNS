----------------------------------------------------------------------------------
-- Company: TSC
-- Engineer: Anderson Young
-- 
-- Create Date: 06/07/2022 11:01:52 AM
-- Design Name: Using concurrent statements
-- Module Name: LED_manager - Behavioral
-- Project Name: Concurrency
-- Target Devices: ZedBoard
-- Tool Versions: 
-- Description: This design is intended for use in the wave_gen.vhd module 
--(commonly used in other Xilinx courses) and will steer either data from the 
--UART receiver or the Sample Generator module to the LEDs on the development board. 
--Additional registers are added for the sake of demonstrating instantiation and other concurrent statements.
-- 
-- Dependencies: 
--register8  
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

--LED manager is the top level 8 bit register described in the 
--Lab 2 pdf in figure 2-1

entity LED_manager is
    Port ( Channel_1_data : in STD_LOGIC_VECTOR (7 downto 0);
           Channel_2_data : in STD_LOGIC_VECTOR (7 downto 0);
           Channel_1_enable : in STD_LOGIC;
           Channel_2_enable : in STD_LOGIC;
           selector : in STD_LOGIC;
           clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (7 downto 0));
end LED_manager;

architecture Behavioral of LED_manager is
--Initialize Component map in between architecture and the 
--begin statement

--Component Declaration
Component register8
	port(
		clock 	: in std_logic;
		reset 	: in std_logic;
		enable	: in std_logic;
		data_in	: in std_logic_vector (7 downto 0);
		data_out: out std_logic_vector (7 downto 0)
	);
end component register8;
--Signals declaration
signal Channel_1_registered_data : std_logic_vector(7 downto 0);
signal Channel_2_registered_data : std_logic_vector(7 downto 0);
signal mux_data_selected : std_logic_vector(7 downto 0);

begin

--Components instantiation should be in between begin and end
--of the architecture

regCh1: register8
	port map(
		clock		=> clock,
		reset		=> reset,
		enable		=> Channel_1_enable,
		data_in		=> Channel_1_data,
		data_out	=> Channel_1_registered_data
		
	);
	
regCh2: register8
	port map(
		clock		=> clock,
		reset		=> reset,
		enable		=> Channel_2_enable,
		data_in		=> Channel_2_data,
		data_out	=> Channel_2_registered_data
		
	);

	with selector select
		mux_data_selected <= Channel_1_registered_data when '0',
		Channel_2_registered_data when '1',
		(others => '-') when others;	--when there are more than one bit, use this
	
	--the statement below means the top level output will update the mux's
	--data whenever the clock is high. Since this is an instantiation of
	--register8, it will comply with its process statement.(see register8
	--code in Lab1)
	data_out <= mux_data_selected when rising_edge(clock);
	
	
end Behavioral;
