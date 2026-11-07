plr = game.Players.LocalPlayer -- by a_tophat
mouse = plr:GetMouse()
rf = script.Parent:WaitForChild("rf")
db = false
script.Parent.Activated:Connect(function()
	if db == false then db = true else return end
	rf:InvokeServer(mouse.Hit)
	db = false
end)