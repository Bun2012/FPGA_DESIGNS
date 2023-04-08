entity T04_ForLoopTb is
end entity;

architecture sim of T04_ForLoopTb is
begin

    process is
		variable roku : integer := 5;
	begin

        -- TASK: Create For-loop here.
        --       Print the value of the implicit variable inside of the loop
        for k in 0 to 2 loop
			report "roku is:" & integer'image(roku);--used to convert integer to string;
			--& is used to join the two together. image is an attribute;
			wait for 10 ns;
		end loop;
		
		report "out of the box";
        wait;--without wait it'll just keep running the process
        --for infinity

    end process;

end architecture;