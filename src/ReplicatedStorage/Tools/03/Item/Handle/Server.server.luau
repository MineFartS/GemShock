local tool = script.Parent.Parent
script.Parent.Fire.OnServerEvent:Connect(function(Player,MousePosition)
	local RaycastParams = RaycastParams.new()
	RaycastParams.FilterDescendantsInstances = {Player.Character}
	RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	
	local RaycastResualt = workspace:Raycast(script.Parent.Position, (MousePosition - script.Parent.Position) * 300, RaycastParams)
	
	if RaycastResualt then
		local HitPart = RaycastResualt.Instance
		local Model = HitPart:FindFirstAncestorOfClass("Model")
		
		if Model then
			if Model:FindFirstChild("Humanoid") then
				Model.Humanoid.Health -= 30
			end
		end
	end
end)

local Tool = script.Parent.Parent
local Sounds = script.Parent.Sounds


Tool.Equipped:Connect(function()
	Sounds.Equip:Play()
end)
Tool.Unequipped:Connect(function()
	Sounds.Unequip:Play()
end)
local player = game:GetService("Players").LocalPlayer
Tool.Activated:Connect(function()
	Sounds.Activated:Play()
	script.Parent.Shot.GunShotLight.Enabled = true
	script.Parent.Shot.Transparency = 0
	script.Parent.Shot.Smoke1.Enabled = true
	script.Parent.Shot.Smoke2.Enabled = true
	script.Parent.Dispenser.s1.Enabled = true
	script.Parent.Dispenser.s2.Enabled = true
	script.Parent.Dispenser.s3.Enabled = true	
	script.Parent.Dispenser.s4.Enabled = true
	script.Parent.Dispenser.s5.Enabled = true

	script.Parent.Dispenser.Decal1.Transparency = 0
	script.Parent.Dispenser.Decal2.Transparency = 0
	wait(.01)
	script.Parent.Shot.Transparency = 1
	script.Parent.Shot.GunShotLight.Enabled = false
	script.Parent.Shot.Smoke1.Enabled = false
	script.Parent.Shot.Smoke2.Enabled = false
	script.Parent.Dispenser.s1.Enabled = false
	script.Parent.Dispenser.s2.Enabled = false
	script.Parent.Dispenser.s3.Enabled = false	
	script.Parent.Dispenser.s4.Enabled = false
	script.Parent.Dispenser.s5.Enabled = false
	script.Parent.Dispenser.Decal1.Transparency = 1
	script.Parent.Dispenser.Decal2.Transparency = 1
end)

local Mouse = game.Players.LocalPlayer:GetMouse()
Mouse.Button1Down:Connect(function()

end)