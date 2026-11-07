ButtonCode = Enum.KeyCode.ButtonB

script.Parent.Console.Image = game.UserInputService:GetImageForKeyCode(ButtonCode)

function run()
	game.GuiService.GuiNavigationEnabled = false
	script.Parent.Parent.Visible = false
	script.Parent.Parent.Parent.Parent.Gem.Visible = true
	script.Parent.Parent.Parent.Open.Visible = true
end

game.UserInputService.InputBegan:Connect(function(input, processed)
	if input.KeyCode == ButtonCode and script.Parent.Parent.Visible then
		run()
	end
end)