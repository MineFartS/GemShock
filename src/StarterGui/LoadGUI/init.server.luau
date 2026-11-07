Player = script.Parent.Parent

while task.wait(.1) do

	pcall(function()
		
		local Name = script.InputType:InvokeClient(Player)

		if script:FindFirstChild(Name) then
			local clone = script[Name]:Clone()
			clone.Name = 'GUI'
			clone.Parent = script.Parent

			script:Destroy()
		
		end

	end)
	
end