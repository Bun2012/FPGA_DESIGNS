entity T08_IfTb is
end entity;

architecture sim of T08_IfTb is

    signal CountUp   : integer := 0;
    signal CountDown : integer := 10;

begin

    process is
    begin

        CountUp   <= CountUp + 1;
        CountDown <= CountDown - 1;
        wait for 10 ns;

    end process;

    process is
    begin

        -- TODO: Use If-Then-Elsif-Else statements to
        --       print which of the two signals is larger
        
        wait on CountUp, CountDown;
		if(CountDown > CountUp) then
			report "CountDown is larger: " & integer'image(CountDown);
		else
		report "CountUp is larger: " & integer'image(CountUp);
		end if;
    end process;

end architecture;