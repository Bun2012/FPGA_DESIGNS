library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T18_Timer is
generic(ClockFrequencyHz : integer);
port(
    Clk     : in std_logic;
    nRst    : in std_logic; -- Negative reset
    Seconds : out integer;
    Minutes : out integer;
    Hours   : out integer);
end entity;

architecture rtl of T18_Timer is

    -- Signal for counting clock periods
    signal Ticks	: integer;
    signal Sec		: integer;
	signal Min		: integer;
	signal Hr		: integer;
begin
	Seconds <= Sec;
	Minutes <= Min;
	Hours	<= Hr;
	
    process(Clk) is
    begin
        if rising_edge(Clk) then

            -- If the negative reset signal is active
            if nRst = '0' then
            
                -- TODO: Reset all the outputs and the Ticks signal
				Sec <= 0;
				Min <= 0;
				Hr	<= 0;
				Ticks <= 0;
            else

                -- True once every second
                if Ticks = ClockFrequencyHz - 1 then
                    Ticks <= 0;
            
                    -- TODO: Implement the Seconds, Minutes and Hours counter
                    --       here by using nested If-Then-Else statements.
					if(Hr < 23) then
						if(Min < 59) then
							if(Sec < 59) then
								Sec <= Sec + 1;
							else
								Sec <= 0;
							end if;
							Min <= Min + 1;
						else
							Min <= 0;
						end if;
						Hr <= Hr + 1;
					else
						Hr <= 0;
					
					end if;
                else
                    Ticks <= Ticks + 1;
                end if;
            
            end if;
        end if;
    end process;

end architecture;