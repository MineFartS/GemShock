local Player = script.Parent.Parent.Parent

Player.CharacterAdded:Connect(function(char)
	
	script.Parent:Destroy()
end)