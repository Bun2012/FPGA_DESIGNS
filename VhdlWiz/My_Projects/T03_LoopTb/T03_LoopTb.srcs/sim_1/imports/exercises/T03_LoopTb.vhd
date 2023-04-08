entity T03_LoopTb is
end entity;

architecture sim of T03_LoopTb is
begin

    process is
    begin
    
        report "Hello!";

        -- TODO: Create loop.
        --       Then, exit the loop.
		--using loop without exit will run this loop for infinity; 
		loop 
			report "here";
			wait for 10 ns;
			exit; -- will exit the loop and skip the comment below since we added exit statement
		end loop;--loop backs to loop and report here
        
        report "Goodbye!";
        wait;
        
    end process;

end architecture;