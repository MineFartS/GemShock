SprintSpeed = 35

local running = false
local Player = game.Players.LocalPlayer
local mouse = Player:GetMouse()

mouse.KeyDown:connect(function (key)
	key = string.lower(key)
	if string.byte(key) == 48 then
		running = true
		local keyConnection = mouse.KeyUp:connect(function (key)
			if string.byte(key) == 48 then
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