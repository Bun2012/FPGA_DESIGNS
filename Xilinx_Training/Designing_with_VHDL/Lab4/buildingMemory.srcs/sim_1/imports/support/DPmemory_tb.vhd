--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:21:05 06/11/2009
-- Design Name:   
-- Module Name:   C:/training/dsgnVHDL/labs/Spartan3E/buildingMemory/DPmemory_tb.vhd
-- Project Name:  buildingMemory
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: memory
-- 
-- Dependencies:
-- 
-- Revision:
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
 
ENTITY DPmemory_tb IS
END DPmemory_tb;
 
ARCHITECTURE behavior OF DPmemory_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    component DP_memory
--     Generic (WIDTH    : integer range 1 to 32 := 8;
--	           DEPTH    : integer range 0 to 1024 := 10
--			    );
		 PORT(
				PortA_clk 			: IN  std_logic;
				PortB_clk 			: IN  std_logic;
				PortA_addr 			: IN  std_logic_vector(9 downto 0);
				PortB_addr 			: IN  std_logic_vector(9 downto 0);
				PortA_writeEnable : IN  std_logic;
				PortB_writeEnable : IN  std_logic;
				PortA_dataIn 		: IN  std_logic_vector(7 downto 0);
				PortB_dataIn 		: IN  std_logic_vector(7 downto 0);
				PortA_dataOut 		: OUT  std_logic_vector(7 downto 0);
				PortB_dataOut 		: OUT  std_logic_vector(7 downto 0)
			  );
    end component DP_memory;
    

   --Inputs
   signal PortA_clk : std_logic := '0';
   signal PortB_clk : std_logic := '0';
   signal PortA_addr : std_logic_vector(9 downto 0) := (others => '0');
   signal PortB_addr : std_logic_vector(9 downto 0) := (others => '0');
   signal PortA_writeEnable : std_logic := '0';
   signal PortB_writeEnable : std_logic := '0';
   signal PortA_dataIn : std_logic_vector(7 downto 0) := (others => '0');
   signal PortB_dataIn : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal PortA_dataOut : std_logic_vector(7 downto 0);
   signal PortB_dataOut : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant PortA_clk_period : time := 10ns;
   constant PortB_clk_period : time := 11ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DP_memory PORT MAP (
          PortA_clk => PortA_clk,
          PortB_clk => PortB_clk,
          PortA_addr => PortA_addr,
          PortB_addr => PortB_addr,
          PortA_writeEnable => PortA_writeEnable,
          PortB_writeEnable => PortB_writeEnable,
          PortA_dataIn => PortA_dataIn,
          PortB_dataIn => PortB_dataIn,
          PortA_dataOut => PortA_dataOut,
          PortB_dataOut => PortB_dataOut
        );

   -- Clock process definitions
   PortA_clk_process :process
   begin
		PortA_clk <= '0';
		wait for PortA_clk_period/2;
		PortA_clk <= '1';
		wait for PortA_clk_period/2;
   end process;
 
   PortB_clk_process :process
   begin
		PortB_clk <= '0';
		wait for PortB_clk_period/2;
		PortB_clk <= '1';
		wait for PortB_clk_period/2;
   end process;
 
	PortA: process
		begin
			PortA_writeEnable <= '1';
			PortA_addr        <= "00"&X"00";
			PortA_dataIn      <= X"00";
			wait for PortA_clk_period;
			PortA_addr        <= "00"&X"01";
			PortA_dataIn      <= X"11";
			wait for PortA_clk_period;			
			PortA_addr        <= "00"&X"02";
			PortA_dataIn      <= X"22";
			wait for PortA_clk_period;		
			PortA_addr        <= "00"&X"03";
			PortA_dataIn      <= X"33";
			wait for PortA_clk_period;		
			PortA_addr        <= "00"&X"04";
			PortA_dataIn      <= X"44";
			wait for PortA_clk_period;					
			PortA_writeEnable <= '0';
			
			A_inf: while (true) loop
				A_addrs: for i in 0 to 6 loop
					PortA_addr <= std_logic_vector(to_unsigned(i,10));
					wait for PortA_clk_period;
				end loop;		-- for
			end loop;			-- while
		end process PortA;
		
	PortB: process
		begin
			PortB_writeEnable <= '1';
			PortB_addr        <= "00"&X"04";				-- deliberate overlap with data from port A
			PortB_dataIn      <= X"44";
			wait for PortB_clk_period;
			PortB_addr        <= "00"&X"05";
			PortB_dataIn      <= X"55";
			wait for PortB_clk_period;			
			PortB_addr        <= "00"&X"06";
			PortB_dataIn      <= X"66";
			wait for PortB_clk_period;		
			PortB_addr        <= "00"&X"07";
			PortB_dataIn      <= X"77";
			wait for PortB_clk_period;		
			PortB_addr        <= "00"&X"08";
			PortB_dataIn      <= X"88";
			wait for PortB_clk_period;					
			PortB_writeEnable <= '0';
			wait for 500 ns;
			PortB_writeEnable <= '1';
			PortB_addr        <= "00"&X"04";				-- deliberate overlap with data from port A
			PortB_dataIn      <= X"EE";
			wait for PortB_clk_period;			
			PortB_writeEnable <= '0';
			
			B_inf: while (true) loop
				B_addrs: for i in 0 to 9 loop
					PortB_addr <= std_logic_vector(to_unsigned(i,10));
					wait for PortB_clk_period;
				end loop;		-- for
			end loop;			-- while		
		end process PortB;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      wait for 100ms;	

      wait for PortA_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
