----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/08/2022 02:36:12 PM
-- Design Name: 
-- Module Name: LED_manager_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LED_manager_tb is
--  Port ( );
end LED_manager_tb;

architecture Behavioral of LED_manager_tb is
    Component LED_manager
        port(
            Channel_1_data  : in std_logic_vector(7 downto 0);
            Channel_2_data  : in std_logic_vector(7 downto 0);
            Channel_1_enable: in std_logic;
            Channel_2_enable: in std_logic;
            Selector        : in std_logic;
            clock           : in std_logic;
            reset           : in std_logic;
            data_out        : out std_logic_vector(7 downto 0)
    
        );
end component LED_manager;

--Signal declaration
	signal Channel_1_data  : std_logic_vector(7 downto 0) := (others => '0');
	signal Channel_2_data  : std_logic_vector(7 downto 0) := (others => '0');
	signal Channel_1_enable: std_logic := '0';
	signal Channel_2_enable: std_logic := '0';
	signal Selector        : std_logic := '0';
	signal clock           : std_logic := '0';
	signal reset           : std_logic := '0';
	--Outputs
	signal data_out		  : std_logic_vector(7 downto 0);

--Clock period
	constant clock_period: time := 10 ns;

begin

--Component Instantiation
led_tb: LED_manager
    port map(
    
        Channel_1_data      => Channel_1_data,
        Channel_2_data      => Channel_2_data,
        Channel_1_enable    => Channel_1_enable,
        Channel_2_enable    => Channel_2_enable,
        Selector            => Selector,
        clock               => clock,
        reset               => reset,
        data_out            => data_out
    
    
    );

	--reset is active high. Reset the signal by making it 10 times the
	--clock period and deasserting
	--the one below was my code
	--reset <= not reset after (clock_period * 10)
	--the one below was the books code
	reset <= '1', '0' after (clock_period * 10);
	
	
	--clock has a period of 5 ns b/w begin and uut instatantiation
	clock <= not clock after 5 ns;
	
	-- Write code to generate stimulus for the selector signal as follows:
	-- For the first 20 times of the clock period, the selector signal should be '0', then becomes '1.'
	-- Then after 50 times of the clock period, the selector signal should be '0.'
	-- Finally after 100 times of the clock period, the selector signal should be '1.'
	
	Selector <= '0', '1' after (clock_period * 20), '0' after (clock_period * 50), '1' after (clock_period * 100);
	
	--Data Generation
	--Add the previous channel_1_data with 0x03 and assign to the channel_1_data signal after 2 
	--times of the clock period.
	Channel_1_data <= Channel_1_data + X"03" after (clock_period * 2);
	
	--Add the previous channel_2_data with 0x04 and assign to the channel_2_data signal after 
	--3 times of the clock period
	Channel_2_data <= Channel_2_data + X"04" after (clock_period * 3);
	
	--Enable the channel_1_enable and channel_2_enable signals.
	Channel_1_enable <= '1';
	Channel_2_enable <= '1';
end Behavioral;

