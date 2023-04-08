library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T19_Timer is
generic(ClockFrequencyHz : integer);
port(
    Clk     : in std_logic;
    nRst    : in std_logic; -- Negative reset
    Seconds : inout integer;
    Minutes : inout integer;
    Hours   : inout integer);
end entity;

architecture rtl of T19_Timer is

    -- Signal for counting clock periods
    signal Ticks : integer;

    -- TODO: Implement the IncrementWrap procedure here
	procedure IncrementWrap(signal Counter				: inout integer;--increamenting value
							constant Wrapped_val		: in	integer;--used for reseting counter
							variable Enable				: in	boolean;--used for firng off procedure
							variable Wrap				: out	boolean) is--used for enable

		begin
			if(Enable) then
				if(Counter = Wrapped_val - 1) then
					Counter <= 0;
					Wrap := true;
				else
					Wrap := false;
					Counter <= Counter + 1;
				end if;
			end if;
			wait for 10 ns;
		end procedure;


begin

    process(Clk) is
        variable Wrap : boolean;
		variable truth: boolean := true;--For some reason, i couldn't put true where truth is attribute
		-- it had to be another variable intialized to true;
    begin
        if rising_edge(Clk) then

            -- If the negative reset signal is active
            if nRst = '0' then
                Ticks   <= 0;
                Seconds <= 0;
                Minutes <= 0;
                Hours   <= 0;
            else

                -- Cascade counters
                IncrementWrap(Ticks, ClockFrequencyHz, truth, Wrap);--we put true here because ticks should count every second
                IncrementWrap(Seconds,             60, Wrap, Wrap);--if seconds \= 59, wrap = false, making enable false which
				--will ignore the statements would below
                
                -- TODO: Add calls to the IncrementWrap procedure
                --       for the Minutes and Hours as well
				IncrementWrap(Minutes,             60, Wrap, Wrap);--same statement for seconds
				IncrementWrap(Hours,			   24, Wrap, Wrap);--does not matter what Wrap is here since this is the last statement
				--to be evaluated. Why: Since the above wraps are true, that means the enable is true and will increament when both
				--statements are true; The ticks statement is always true so it can be ignored
            end if;
        end if;
    end process;

end architecture;