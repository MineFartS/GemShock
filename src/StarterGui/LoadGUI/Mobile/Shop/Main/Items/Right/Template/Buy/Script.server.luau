Player = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent

function run()

	local ID = script.Parent.ID.Value	
	local Cost = game.ReplicatedStorage.Tools[ID].Cost.Value
	local Item = game.ReplicatedStorage.Tools[ID].Item
	local Title = game.ReplicatedStorage.Tools[ID].Item.ToolTip

	if Player.RedGems.Value >= Cost then
		Player.RedGems.Value -= Cost
		Item:Clone().Parent = Player.Backpack
		game.ServerScriptService.Gems:Fire(Player, -Cost, 'Red', 'Purchased Item')
	end

	if Player.RedGems.Value < Cost then
		script.Parent.Frame.TextLabel.Text = 'Locked'
		script.Parent.BackgroundColor3 = Color3.new(1, 0.666667, 0)
	end

end

script.Parent.MouseButton1Click:Connect(run)

game.UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.ButtonX then
		run()
	end
end)