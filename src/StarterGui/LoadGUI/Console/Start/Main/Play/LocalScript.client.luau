----------------------------
-- Main > Play
----------------------------

ConsoleButton = Enum.KeyCode.ButtonX
GUIRoot = script.Parent.Parent

function run()
	
	GUIRoot.Parent.Hide:FireServer()
	
end

----------------------------

script.Parent.MouseButton1Click:Connect(run)

game.UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == ConsoleButton and GUIRoot.Visible then run() end
end)

if game.UserInputService.GamepadEnabled then
	script.Parent.Console.Image = game.UserInputService:GetImageForKeyCode(ConsoleButton)
end

