local Player = script.Parent.Parent.Parent

Player.CharacterAdded:Connect(function(char)
	char.Humanoid.WalkSpeed = 16
	script.Parent:Destroy()
end)