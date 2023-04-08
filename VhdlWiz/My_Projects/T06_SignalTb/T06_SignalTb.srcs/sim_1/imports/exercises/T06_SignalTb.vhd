entity T06_SignalTb is
end entity;

architecture sim of T06_SignalTb is

    -- TODO: Declare a signal of type integer with initial value 0
	signal oodlesNnoodles : integer := 0;
begin

    process is
        -- TODO: Declare a variable of type integer with initial value 0
		variable rings	: integer := 0;
	begin

        report "*** Process begin ***";

        -- TODO: Increment the signal and variable here
		oodlesNnoodles <= oodlesNnoodles + 1;
		rings := rings + 1;--note: rings start off as one, not 0
		--that's because variable changes instantly and signals change after wait statements:
		--in this case wait for 10ns
        -- TODO: Print the signal and variable values here
		report "Oddles is: " & integer'image(oodlesNnoodles);
		report "Rings is: " & integer'image(rings);
        -- TODO: Increment the signal and variable here

        -- TODO: Print the signal and variable values here

        wait for 10 ns;
		report "After wait Oddles is: " & integer'image(oodlesNnoodles);
		report "After wait Rings is: " & integer'image(rings);
        -- TODO: Print the signal and variable values here

    end process;

end architecture;