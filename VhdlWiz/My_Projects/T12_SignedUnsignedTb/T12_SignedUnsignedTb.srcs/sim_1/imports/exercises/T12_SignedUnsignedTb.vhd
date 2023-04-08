library ieee;
use ieee.std_logic_1164.all;--able to use bit vectors
use IEEE.std_logic_unsigned.all;--able to use unsigned and signed
use ieee.numeric_std.all;-- able to use math functions with unsigned & signed
-- TODO: Import the IEEE library for using signed and unsigned types

entity T12_SignedUnsignedTb is
end entity;

architecture sim of T12_SignedUnsignedTb is

    -- TODO: Declare the following signals:
    --       
    --       - 8-bit unsigned counter with an initial value of all zeros
    --       - 8-bit signed counter with an initial value of all zeros
    --       - 4-bit unsigned with an initial value of binary 1000
    --       - 4-bit signed with an initial value of binary 1000
    --       - 8-bit unsigned with an initial value of all zeros
    --       - 8-bit signed with an initial value of all zeros
	signal counter1	: unsigned(7 downto 0) := (others => '0');
	signal counter2	: signed(7 downto 0)   := (others => '0');
	signal test1	: unsigned(3 downto 0) := "1000";
	signal test2	: signed(3 downto 0)   := "1000";
	signal test3	: unsigned(7 downto 0) := (others => '0');
	signal test4	: signed(7 downto 0)   := (others => '0');
	
begin

    process is
    begin
    
        wait for 10 ns;

        -- Wrapping counter
        
        -- TODO: Increment the signed and unsigned counters by 1
        counter1 <= counter1 + 1;
		counter2 <= counter2 + 1;
        -- Adding signals
        
        -- TODO: Increment the unsigned 8-bit signal with the value of the
        --       4-bit unsigned signal
        --counter1 <= counter1 + test1;
		test3 <= test3 + test1;
        -- TODO: Increment the signed 8-bit signal with the value of the
        --       4-bit signed signal
		--counter2 <= counter2 + test2;
		test4 <= test4 + test2;
		--if you have multiple assignments in the process like you see above, the last assignment will triumph
		--over the assignment before even in a process
		--in this case, it will ignore counter1 <= counter+1 and counter2 + 1;
    end process;
    
end architecture;