images = {
	Red   = 'rbxassetid://122915690568969',
	Green = 'rbxassetid://112927438661465'
}

script.Parent.Event:Connect(function(Player, Amount, Color, Description)
	print('Gems Changed: '..Amount..', '..Color..', '..Description)
	
	Player[Color..'Gems'].Value += Amount
	
	-- Ensure that the Player's Gems stay between 0-maxGems
	if Player[Color..'Gems'].Value < 0 then 
		Player[Color..'Gems'].Value = 0
	end
	
	local frame = Player.PlayerGui.GUI.Notifications.Template:Clone()
	frame.Parent = Player.PlayerGui.GUI.Notifications
	frame.Visible = true
	frame.Name = os.time()
	
	frame.Description.Text = Description
	
	if Amount >= 0 then
		frame.Amount.Text = '+'..Amount
	else
		frame.Amount.Text = Amount
	end
	
	frame.ImageLabel.Image = images[Color]
	
	task.wait(5)
	
	frame:Destroy()
end)