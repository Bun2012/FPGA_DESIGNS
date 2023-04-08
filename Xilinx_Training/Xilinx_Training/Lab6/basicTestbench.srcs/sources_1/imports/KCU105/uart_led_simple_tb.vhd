--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:56:19 05/08/2008
-- Design Name:   
-- Module Name:   test_uart_rx.vhd
-- Project Name:  LabFlow
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FPGAFlowDesign
-- 
-- Dependencies:
-- 
-- Revision:
--
------------------------------------------------------------------------------------
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
--
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.all;

--library utilities_lib;
--use utilities_lib.time_utilities_pkg.all;
--use utilities_lib.string_utilities_synth_pkg.all;
--
--library specific_support_lib;
--use specific_support_lib.tb_fifo_pkg.all;

 
ENTITY uart_led_simple_tb IS
     Generic (CLOCK_RATE       : integer := 100_000_000;              -- clock rate
              BAUD_RATE        : integer :=     115_200               -- desired baud rate
             );
END uart_led_simple_tb;


ARCHITECTURE behavior OF uart_led_simple_tb IS 
 
        -- Component Declaration for the Unit Under Test (UUT)
			component uart_led is
				  Generic (CLOCK_RATE : integer := 50_000_000;
							  BAUD_RATE  : integer :=    115_200
							 );
				 Port ( clk_pin       : in  STD_LOGIC;
						  rst_pin       : in  STD_LOGIC;
						  rxd_pin       : in  STD_LOGIC;
						  sel_pin		 : in  STD_LOGIC;
						  led_pins      : out STD_LOGIC_VECTOR (7 downto 0)
						);
			end component uart_led;	
       
       component tb_uart_driver is
          generic ( 
                MESSAGE    : String := "default";
                BIT_PERIOD : time := 10 ns 
            );
          port ( 
             rst_clk_rx        : in  std_logic;
             data_sent         : out std_logic;
             data_to_send      : out std_logic_vector(7 downto 0);
             data_out_serial   : out std_logic
            );          
       end component tb_uart_driver;  
		 
		 -- Connections to UUT
		 signal clk_pin             : std_logic := '0';
		 signal rst_pin             : std_logic := 'U';
		 signal rxd_pin             : std_logic := 'U';
		 signal sel_pin             : std_logic := 'U';
		 signal led_pins            : std_logic_vector(7 downto 0) := (others=>'U');
       

       -- System signals
       signal clk_rx              : std_logic := 'U';
       signal rst_clk_rx          : std_logic := 'U';
       
       -- Internal data signals
       signal frm_err             : std_logic := 'U';
       signal data_to_send        : std_logic_vector(7 downto 0) := (others=>'U');
       signal delayed_data_to_send: std_logic_vector(7 downto 0) := (others=>'U');
       signal data_sent           : std_logic := 'U';
       signal rxd_clk_rx          : std_logic := 'U';
       signal rx_data             : std_logic_vector(7 downto 0) := (others=>'U');   -- from output of FIFO to the data checker
       signal rx_data_rdy         : std_logic := 'U';                                -- indicates that data is valid from the UART rx
       
       -- FIFO to manage data 
       --signal data_fifo            : FIFO_TYPE := (width=>8, depth=>256, read_ptr=>0, write_ptr=>0, volume=>0, empty=>true, full=>false, contents=>(others=>(others=>'0')));
       

       -- Clock period definitions

       constant CLK_RX_PERIOD     : time := 1.0 sec / real(CLOCK_RATE);     -- test! and use instead of line above
       constant BIT_PERIOD        : time := 1.0 sec / real(BAUD_RATE);
       
       signal   preferred_units   : string (1 to 3) := "ns ";
          
 
    BEGIN
        --For some reason, I could not get this to work, even with answers
        --I am skipping
       -- generate the clk_rx signal
		 -- code this as either a process or a concurrent statement
		--rxd_clk_rx <= '1' after 50us, '0' after 50us;-- 100MHz clock frequency with 50% duty cycle		
       --clk_rx <= '1';--I made this. I think this caused issues
       --clk_rx <= not clk_rx after CLK_RX_PERIOD/2;--I made this
       clk_pin <= not clk_pin after CLK_RX_PERIOD / 2;
       -- generate the reset signal
       --rst_clk_rx <= '1';--I think this caused issues
       --gives me error when using wait for 100 ns or wait for any time?
       --because wait for can only be used in a process
       --rst_clk_rx <= '1','0' after 100*CLK_RX_PERIOD;
       rst_pin <= '1','0' after 100*CLK_RX_PERIOD;
       -- code this as either a process or a concurrent statement
       -- code this so that the reset de-asserts after 100 clock periods
			 
		 -- generate select signal
		 sel_pin <= '0','1' after 4.5 ms;
		 -- code this as either a process or a concurrent statement
          
       -- Instantiate the data generator - uses the predefined character sequence and transmits bit-by-bit
       tb_uart_driver_i0: tb_uart_driver 
          generic map (BIT_PERIOD => BIT_PERIOD, MESSAGE => "Welcome to Xilinx's Designing with VHDL!")
          port map (  rst_clk_rx       => rst_pin,
                      data_to_send      => data_to_send,
                      data_sent         => data_sent,
                      data_out_serial   => rxd_clk_rx
                     );
--		port map (  rst_clk_rx        => rst_pin,
--                      data_to_send      => data_to_send,
--                      data_sent         => data_sent,
--                      data_out_serial   => rxd_clk_rx
--                     );
								

       -- Instantiate the unit under test 
		 UUT: uart_led 
			generic map (CLOCK_RATE => CLOCK_RATE,						-- generics defined in the entity of this test-bench
                      BAUD_RATE  =>  BAUD_RATE
                    )
			port map ( clk_pin      => clk_pin,
                    rst_pin      => rst_pin,
                    rxd_pin      => rxd_clk_rx,
                    sel_pin      => sel_pin,-- connect to selector stimulus,
                    led_pins     => led_pins
				      );			

    END;

