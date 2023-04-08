----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:38:30 12/18/2008 
-- Design Name: 
-- Module Name:    UART_project - Behavioral 
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
--
--  Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs are
--              provided to you "as is". Xilinx and its licensors make, and you
--              receive no warranties or conditions, express, implied,
--              statutory or otherwise, and Xilinx specifically disclaims any
--              implied warranties of merchantability, non-infringement, or
--              fitness for a particular purpose. Xilinx does not warrant that
--              the functions contained in these designs will meet your
--              requirements, or that the operation of these designs will be
--              uninterrupted or error free, or that defects in the Designs
--              will be corrected. Furthermore, Xilinx does not warrant or
--              make any representations regarding use or the results of the
--              use of the designs in terms of correctness, accuracy,
--              reliability, or otherwise.
--
--              LIMITATION OF LIABILITY. In no event will Xilinx or its
--              licensors be liable for any loss of data, lost profits, cost
--              or procurement of substitute goods or services, or for any
--              special, incidental, consequential, or indirect damages
--              arising from the use or operation of the designs or
--              accompanying documentation, however caused and on any theory
--              of liability. This limitation will apply even if Xilinx
--              has been advised of the possibility of such damage. This
--              limitation shall apply not-withstanding the failure of the
--              essential purpose of any limited remedies herein.
--
--  Copyright © 2002, 2008 Xilinx, Inc.
--  All rights reserved
--
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity uart_led is
     Generic (CLOCK_RATE : integer := 50_000_000;
              BAUD_RATE  : integer :=    115_200
             );
    Port ( clk_pin       : in  STD_LOGIC;
           rst_pin       : in  STD_LOGIC;
           rxd_pin       : in  STD_LOGIC;
           sel_pin       : in  STD_LOGIC;
           led_pins      : out STD_LOGIC_VECTOR (7 downto 0)
         );
end uart_led;


architecture Behavioral of uart_led is

    --
    -- module definitions
    --    
    component uart_rx is
       generic (
                BAUD_RATE         : integer := 57600;                 -- serves as clock divisor
                CLOCK_RATE        : integer := 100000000              -- freq of clk
             );
        Port ( rst_clk_rx         : in  STD_LOGIC;
               clk_rx             : in  STD_LOGIC;
               rxd_i              : in  STD_LOGIC;
               rx_data            : out STD_LOGIC_VECTOR (7 downto 0);
               rx_data_rdy        : out STD_LOGIC;
               frm_err            : out STD_LOGIC
             );
    end component uart_rx;  
	 
	 component reset_bridge
		 Port(clk_dst 		: IN std_logic;
				rst_in 		: IN std_logic;          
				rst_out 		: OUT std_logic
			);
	 end component reset_bridge;

    component meta_harden is
        Port ( clk_dst            : in  STD_LOGIC;
               rst_dst            : in  STD_LOGIC;
               signal_src         : in  STD_LOGIC;
               signal_dst         : out  STD_LOGIC);
    end component meta_harden;    
    
	component LED_manager
		Port(
			Channel_1_data 			: IN  std_logic_vector(7 downto 0);
			Channel_2_data 			: IN  std_logic_vector(7 downto 0);
			Channel_1_enable			: IN  std_logic;
			Channel_2_enable 			: IN  std_logic;
			Selector 					: IN  std_logic;
			clock 						: IN  std_logic;
			reset 						: IN  std_logic;          
			data_out 					: OUT std_logic_vector(7 downto 0)
		);
	end component LED_manager;
    
	 
	 ----
	 --
	 -- naming convention
	 --
	 -- _pin   		- indicates a connection to a pin of the FPGA
	 -- _i     		- indicates buffered version of a _pin signal
	 -- _<clkname> - indicates that a signal has been synchronized to the specified clock domain
	 --
	 ----
	 
	 
    -- clock and controls
    signal rst_i, rst_clk_rx      : std_logic := 'U';
    signal clk_i, clk_rx          : std_logic := 'U';
    signal rxd_i                  : std_logic := 'U';
	 signal sel_i						 : std_logic := 'U';
    signal led_o                  : std_logic_vector(7 downto 0) := (others=>'U');
	 signal sel_clk_rx				 : std_logic := 'U';
    
    signal rx_data_rdy            : std_logic := 'U';
    signal rx_data                : std_logic_vector(7 downto 0) := (others=>'U');

    constant gnd                  : std_logic_vector(7 downto 0) := (others=>'0');
    

begin

    --
    -- define the buffers for the incoming data, clocks, and control
    IBUF_rst_i0:    IBUF  port map (I=>rst_pin, O=>rst_i);
    IBUF_rxd_i0:    IBUF  port map (I=>rxd_pin, O=>rxd_i);
    IBUFG_clk_i0:   IBUFG port map (I=>clk_pin, O=>clk_i);
    BUFG_clk_rx_i0: BUFG  port map (I=>clk_i,   O=>clk_rx);
	IBUF_sel_i0:	  IBUF  port map (I=>sel_pin, O=>sel_i);
    
    --
    -- define the buffers for the outgoing data
    OBUF_led_ix: for i in 0 to 7 generate
          OBUF_led_i: OBUF port map (I=>LED_o(i), O=>LED_pins(i));
       end generate;
       
    --
    -- instantiate a metastability hardener for the incoming data
    meta_harden_rst_i0: reset_bridge port map (
			clk_dst => clk_rx,
			rst_in  => rst_i,
			rst_out => rst_clk_rx
		);	 
    
    -- since the UART will be tested separately from the application module, the meta hardener has been moved to the uart_rx
    --meta_harden_rxd_i0: meta_harden port map (rst_dst=>rst_clk_rx,clk_dst=>clk_rx, signal_src=>rxd_i, signal_dst=>rxd_clk_rx);  

    --
    -- instantiate a metastability hardener for the incoming data
    meta_harden_sel_i0: meta_harden port map (rst_dst=>gnd(0), clk_dst=>clk_rx, signal_src=>sel_i, signal_dst=>sel_clk_rx);	 

    --
    -- instantiate the receiver side of the UART
    uart_rx_i0: uart_rx
       generic map (
                BAUD_RATE   =>  BAUD_RATE,          -- serves as clock divisor
                CLOCK_RATE  => CLOCK_RATE           -- freq of clk
             )
        Port map ( 
               rst_clk_rx      => rst_clk_rx,
               clk_rx          => clk_rx,
               rxd_i           => rxd_i,
               rx_data         => rx_data,
               rx_data_rdy     => rx_data_rdy,
               frm_err         => open              -- this signal not used in this design
              );

    --
    -- instantiate the LED controller
	LEDman: LED_manager PORT MAP(
		Channel_1_data 		=> rx_data,
		Channel_2_data 		=> gnd,
		Channel_1_enable 	=> rx_data_rdy,
		Channel_2_enable 	=> gnd(0),--ground is 8 bits long
		Selector 			=> sel_i,
		clock 				=> clk_rx,
		reset 				=> rst_clk_rx,
		data_out 			=> LED_o
	);
	
end Behavioral;




