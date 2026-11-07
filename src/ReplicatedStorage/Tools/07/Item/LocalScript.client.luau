tool = script.Parent

canClick = true

tool.Activated:Connect(function()
	if canClick == true then
		canClick = false

		tool.Sound:Play()
		
		local pos = Vector3.new(math.random(-2310, 2270), 300, math.random(-4320, 1810))

		game.Players.LocalPlayer.Character:MoveTo(pos)

		wait(5)
		canClick = true
	end
end)