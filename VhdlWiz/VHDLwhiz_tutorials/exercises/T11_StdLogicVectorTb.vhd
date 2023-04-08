library ieee;
use ieee.std_logic_1164.all;

entity T11_StdLogicVectorTb is
end entity;

architecture sim of T11_StdLogicVectorTb is

    -- TODO: Declare the following 8-bit std_logic_vectors:
    --       
    --       - downto, no initial value
    --       - downto, initial value of all zeros using aggregate assignment
    --       - downto, initial value of all ones using aggregate assignment
    --       - downto, initial value: hex AA
    --       - to, inital value: binary 10101010
    --       - downto, initial value: 1
	signal test1 : std_logic_vector(7 downto 0);
	signal test2 : std_logic_vector(7 downto 0) := (others => '0');
	signal test3 : std_logic_vector(7 downto 0) := (others => '1');
	signal test4 : std_logic_vector(7 downto 0) := x"AA";
	signal test5 : std_logic_vector(0 to 7)		:= "10101010";
	signal test6 : std_logic_vector(7 downto 0) := "00000001";
begin

    -- Shift register
    process is
    begin

        wait for 10 ns;
        
        -- TODO: Create a looping shift register here which operates
        --       on the vector which has an inital value of 1.
        --       
        --       The shift register shall perform a barrel shift of
        --       all the bits every 10 nanoseconds.
        --
        --       First, use hard-coded bit indexes.
        --       Verified that it works in the waveform.
        --       Then, replace the hard coded values with the
        --       'left and 'right attributes.
        --       Verify that it still works.
		--		 left attribute gets the left most bit(in our case downto which is msb), right is opposite
		for i in test6'left downto test6'right + 1 loop -- he use test'6right + 1 for the statement below
			test6(i) <= test6(i - 1);--for test6(i - 1) when it gets to 0 it would be (0 - 1) which would 
			--cause an index of -1; so by adding (test6'right + 1 = 0 + 1 = 1);
			-- i = 7	7 - 1 = 6
			-- i = 6	6 - 1 = 5
			-- i = 5	5 - 1 = 4
			-- i = 4	4 - 1 = 3
			-- i = 3	3 - 1 = 2
			-- i = 2	2 - 1 = 1
			-- i = 1	1 - 1 = 0
			-- i = 0	
			
		end loop;
        test6(test6'right) <= test6(test6'left);--so we wont use the msb when shifting
    end process;

end architecture;