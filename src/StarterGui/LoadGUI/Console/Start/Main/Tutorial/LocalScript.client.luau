----------------------------
-- Main > Tutorial
----------------------------

ConsoleButton = Enum.KeyCode.ButtonY
GUIRoot = script.Parent.Parent

function run()

	script.Parent.Parent.Visible = false
	GUIRoot.Parent.Tutorial.Visible = true

end

----------------------------

script.Parent.MouseButton1Click:Connect(run)

game.UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == ConsoleButton and GUIRoot.Visible then run() end
end)

if game.UserInputService.GamepadEnabled then
	script.Parent.Console.Image = game.UserInputService:GetImageForKeyCode(ConsoleButton)
end

