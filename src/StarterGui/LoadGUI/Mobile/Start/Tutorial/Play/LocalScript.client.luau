----------------------------
-- Main > Play
----------------------------

ConsoleButton = Enum.KeyCode.ButtonA
GUIRoot = script.Parent.Parent.Parent

function run()

	GUIRoot.Hide:FireServer()

end

----------------------------

script.Parent.MouseButton1Click:Connect(run)

game.UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == ConsoleButton and GUIRoot.Visible then run() end
end)

if game.UserInputService.GamepadEnabled then
	script.Parent.Console.Image = game.UserInputService:GetImageForKeyCode(ConsoleButton)
end

