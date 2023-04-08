entity T01_HelloWorldTb is
end T01_HelloWorldTb;

architecture sim of T01_HelloWorldTb is
begin

    -- TODO: Create process with Hello World code here
	process 
		begin
			report "Hello World";
			wait;--will not repeat hello world, it will run forever
	end process;
end sim;