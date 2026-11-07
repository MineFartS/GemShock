SprintSpeed = 35

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.ImageColor3 == Color3.new(0.392157, 0.392157, 0.392157) then
		script.Parent.ImageColor3 = Color3.new(0.580392, 0.580392, 0.580392)
	
		Humanoid.WalkSpeed = SprintSpeed
	else
		script.Parent.ImageColor3 = Color3.new(0.392157, 0.392157, 0.392157)
		
		Humanoid.WalkSpeed = 16
	end		
end)
