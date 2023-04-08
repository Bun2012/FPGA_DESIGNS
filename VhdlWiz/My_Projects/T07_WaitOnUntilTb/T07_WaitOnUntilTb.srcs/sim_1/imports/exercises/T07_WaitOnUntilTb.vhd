entity T07_WaitOnUntilTb is
end entity;

architecture sim of T07_WaitOnUntilTb is

    signal CountUp   : integer := 0;
    signal CountDown : integer := 10;

begin

    process is
    begin

        -- TODO: Increment CountUp by 1,
        --       and decrement CountDown by 1 every 10 nanoseconds
		CountUp <= CountUp + 1;
		CountDown <= CountDown - 1;
		wait for 10 ns;
    end process;

    process is
    begin

        -- TODO: Use the Wait-On statement to wait until any of the
        --       two signals change
		wait on CountUp, CountDown;
		report "CountUp is: " & integer'image(CountUp);
		report "CountDown is: " & integer'image(CountDown);
		
        -- TODO: Print the values of both of the counter signals

    end process;

    process is
    begin

        -- TODO: Use the Wait-Until statement to wait until
        --       the two signals are equal.
		wait until CountDown = CountUp;
        -- TODO: Print "Jackpot!"
		report "Jackpot";
    end process;

end architecture;