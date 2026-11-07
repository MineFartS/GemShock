ButtonCode = Enum.KeyCode.ButtonY

script.Parent.Console.Image = game.UserInputService:GetImageForKeyCode(ButtonCode)

function run()
	script.Parent.Visible = false
	script.Parent.Parent.Main.Visible = true
	script.Parent.Parent.Parent.Gem.Visible = false
end

game.UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == ButtonCode and script.Parent.Visible then
		
		run()
		game.GuiService.GuiNavigationEnabled = true
		game.GuiService.SelectedObject = script.Parent.Parent.Main.Items.Left.ScrollingFrame1:FindFirstChildOfClass('ImageButton')
		
		while script.Parent.Parent.Main.Visible do
			if game.GuiService.SelectedObject.Parent ~= script.Parent.Parent.Main.Items.Left.ScrollingFrame1 then
				if game.GuiService.SelectedObject ~= script.Parent.Parent.Main.Items.Right.Template.Buy then
					if game.GuiService.SelectedObject ~= script.Parent.Parent.Main.Close then
						game.GuiService.SelectedObject = script.Parent.Parent.Main.Items.Left.ScrollingFrame1:FindFirstChildOfClass('ImageButton')
					end		
				end
			end
			task.wait(.05)
		end
	end
end)