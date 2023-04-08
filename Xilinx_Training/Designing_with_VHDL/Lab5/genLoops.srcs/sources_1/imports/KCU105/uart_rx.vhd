--<insert: c:\HW\releasedULD\headers\uart_rx.head>
-- -----------------------------------------------------------------------------
--
-- module:    uart_rx
-- project:   wave_gen
-- company:   Xilinx, Inc.
-- author:    WK, AW
-- 
-- comment:
--   Top level of the UART  receiver.
--   Brings together the metastability hardener for synchronizing the  
--   rxd pin, the baudrate generator for generating the proper x16  bit
--   enable, and the controller for the UART  itself.
--   
-- Multicycle and False  Paths
--   The uart_baud_gen module generates a 1-in-N pulse (where N  is
--   determined by the baud rate and the system clock frequency),  which
--   enables all flip-flops in the uart_rx_ctl module. Therefore, all  paths
--   within uart_rx_ctl are multicycle paths, as long as N > 2 (which  it
--   will be for all reasonable combinations of Baud rate and  system
--   frequency).
-- 
-- known issues:
-- status           id     found     description                      by fixed date  by    comment
-- 
-- version history:
--   version    date    author     description
--    11.1-001 20 APR 2009 WK       First version for 11.1          
-- 
-- ---------------------------------------------------------------------------
-- 
-- disclaimer:
--   Disclaimer: LIMITED WARRANTY AND DISCLAMER. These designs  are
--   provided to you as is . Xilinx and its licensors make, and  you
--   receive no warranties or conditions, express,  implied,
--   statutory or otherwise, and Xilinx specifically disclaims  any
--   implied warranties of merchantability, non-infringement,  or
--   fitness for a particular purpose. Xilinx does not warrant  that
--   the functions contained in these designs will meet  your
--   requirements, or that the operation of these designs will  be
--   uninterrupted or error free, or that defects in the  Designs
--   will be corrected. Furthermore, Xilinx does not warrant  or
--   make any representations regarding use or the results of  the
--   use of the designs in terms of correctness,  accuracy,
--   reliability, or  otherwise.
--   
-- LIMITATION OF LIABILITY. In no event will Xilinx or  its
--   licensors be liable for any loss of data, lost profits,  cost
--   or procurement of substitute goods or services, or for  any
--   special, incidental, consequential, or indirect  damages
--   arising from the use or operation of the designs  or
--   accompanying documentation, however caused and on any  theory
--   of liability. This limitation will apply even if  Xilinx
--   has been advised of the possibility of such damage.  This
--   limitation shall apply not-withstanding the failure of  the
--   essential purpose of any limited remedies  herein.
--   
-- Copyright © 2002, 2008, 2009 Xilinx,  Inc.
--   All rights reserved
-- 
-- -----------------------------------------------------------------------------
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


--library WORK;
--use work.wave_gen_pkg.ALL;                             -- load component definitions


entity uart_rx is
    generic (
             BAUD_RATE   : integer := 57600;           -- serves as clock divisor
             CLOCK_RATE  : integer := 100000000        -- freq of clk
          );
    Port ( rst_clk_rx    : in  STD_LOGIC;              -- active high, managed synchronously
           clk_rx        : in  STD_LOGIC;              -- operational clock
           rxd_i         : in  STD_LOGIC;              -- directly from pad - not yet associated with any time domain
           rx_data       : out STD_LOGIC_VECTOR (7 downto 0);   -- 8 bit data output valid when rx_data_rdy is asserted
           rx_data_rdy   : out STD_LOGIC;              -- active high signal indicating rx_data is valid
           frm_err       : out STD_LOGIC               -- framing error - active high when STOP bit not detected
          );
end uart_rx;


architecture Behavioral of uart_rx is

    component uart_baud_gen is
        Generic (CLOCK_RATE       : integer := 100_000_000;                    -- clock rate
                 BAUD_RATE        : integer :=     115_200                     -- desired baud rate
                );                   
        Port ( rst                : in  STD_LOGIC;                             -- external reset in
               clk                : in  STD_LOGIC;                             -- clock 
               baud_x16_en        : out STD_LOGIC
              );
    end component uart_baud_gen;
    
    component uart_rx_ctl
       PORT(
             clk_rx      : IN std_logic;
             rst_clk_rx  : IN std_logic;
             baud_x16_en : IN std_logic;
             rxd_clk_rx  : IN std_logic;          
             rx_data     : OUT std_logic_vector(7 downto 0);
             rx_data_rdy : OUT std_logic;
             frm_err     : OUT std_logic
          );
    END component uart_rx_ctl;   
    
    component meta_harden is
        port ( clk_dst      : in  STD_LOGIC;
               rst_dst      : in  STD_LOGIC;
               signal_src   : in  STD_LOGIC;
               signal_dst   : out STD_LOGIC);
    end component meta_harden;  
          
    
 
       signal baud_x16_en      : std_logic := 'U';
       signal rxd_clk_rx       : std_logic := 'U';     -- meta hardened serial data     

    begin
    
       --
       -- protect against meta-stability
       meta_harden_rxd_i0: meta_harden port map (rst_dst=>rst_clk_rx, clk_dst=>clk_rx, signal_src=>rxd_i, signal_dst=>rxd_clk_rx);
    
       -- 
       -- free running counter that divides the incoming clock by a value to generate
       -- a 16 x baud rate enable signal
       --
       -- all paths that start and end on flip-flops enabled by baud_x16_en are multi-cycle
       -- 
       uart_baud_gen_rx_i0: uart_baud_gen 
           generic map (CLOCK_RATE  => CLOCK_RATE,
                        BAUD_RATE   => BAUD_RATE)                      
           port map    (rst         => rst_clk_rx,
                        clk         => clk_rx, 
                        baud_x16_en => baud_x16_en
                 );
       
       --
       -- receiver state machine
       uart_rx_ctl_i0: uart_rx_ctl PORT MAP(
          clk_rx      => clk_rx,
          rst_clk_rx  => rst_clk_rx,
          baud_x16_en => baud_x16_en,
          rxd_clk_rx  => rxd_clk_rx,
          rx_data     => rx_data,
          rx_data_rdy => rx_data_rdy,
          frm_err     => frm_err 
       );
       
    
    end Behavioral;







