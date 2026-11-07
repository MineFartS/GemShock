SprintSpeed = 35

local mouse = game.Players.LocalPlayer:GetMouse()
local running = false
local Player = game.Players.LocalPlayer

game.UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.ButtonL3 then
		running = true
		local keyConnection = game.UserInputService.InputEnded:connect(function(key)
			
			if key.KeyCode == Enum.KeyCode.ButtonL3 then
				running = false
			end
			
		end)
		for i = 1,5 do
			game.Workspace.CurrentCamera.FieldOfView = (70+(i*2))
			wait()
		end
		Player.Character.Humanoid.WalkSpeed = SprintSpeed
		repeat wait () until running == false
		keyConnection:disconnect()
		Player.Character.Humanoid.WalkSpeed = 16
		for i = 1,5 do
			game.Workspace.CurrentCamera.FieldOfView = (80-(i*2))
			wait()
		end
	end
end)