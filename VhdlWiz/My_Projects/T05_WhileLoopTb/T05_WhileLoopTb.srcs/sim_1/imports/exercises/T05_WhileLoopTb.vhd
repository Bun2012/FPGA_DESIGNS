entity T05_WhileLoopTb is
end entity;

architecture sim of T05_WhileLoopTb is
begin

    process is
        -- TODO: Declare a variable here of type integer
        --       with an initial value of 0.
		variable good_burger	: integer := 0;
    begin

        -- TODO: Create a While-loop which which has a condition that
        --       tests if the variable is less than 10.
        --       Increment the variable by 2 inside of the loop.
        while(good_burger < 10) loop
			good_burger := good_burger + 2;
		end loop;
		report "good burger is:" & integer'image(good_burger);
        wait;

    end process;

end architecture;