game.ReplicatedStorage.ClearSpectatorFlight.OnClientEvent:Connect(function()
	
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16

	script.Parent:Destroy()
	
end)