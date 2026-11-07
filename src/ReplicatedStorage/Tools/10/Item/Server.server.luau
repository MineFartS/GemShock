local tool = script.Parent
local remote = tool:FindFirstChild("Remote")

local ammo = 9999
local damage = 15

local debounce = false

local fireDelay = 0.05

local holdAnim = nil
local shootAnim = nil

local bullet = Instance.new("Part")

bullet.Color = Color3.fromRGB(255, 170, 0)
bullet.Material = "Neon"
bullet.CanCollide = false
bullet.Anchored = true

function createBullet(player, origin, hitpos)
	bullet.Transparency = 0
	
	local distance = (origin - hitpos).Magnitude
	local oldCFrame = CFrame.lookAt(origin,hitpos) * CFrame.new(0,0,-distance/2)
	bullet.CFrame = oldCFrame
	bullet.Size = Vector3.new(0.1,0.1,distance)

	bullet.Parent = workspace

	spawn(function()
		wait(0.1)
		if bullet.CFrame == oldCFrame then
			bullet.Transparency = 1
		end
	end)
end

remote.OnServerEvent:Connect(function(plr, hitPos)
	if not debounce and plr.Character == tool.Parent then
		debounce = true
		
		tool.FirePart.ParticleEmitter.Enabled = true
		
		local humanoid = tool.Parent:WaitForChild("Humanoid")
		
		shootAnim = humanoid:LoadAnimation(tool.Recoil)
		shootAnim:Play()
		
		local sound = tool.Handle.Fire:Clone()
		sound.Parent = tool.Handle
		sound.PlayOnRemove = true
		sound:Destroy()
		
		local origin = tool.FirePart.Position
		local direction = (hitPos -tool.FirePart.Position).Unit * 1000
		
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = tool.Parent:GetDescendants()
		params.IgnoreWater = true
		params.FilterType = Enum.RaycastFilterType.Blacklist
		
		local ray = workspace:Raycast(origin, direction, params)

		if ray and ray.Instance then
			local part = ray.Instance
			print(part.Name)
			local char = part.Parent
			local hum = char:FindFirstChild("Humanoid")
			if hum then
				if part.Name == "Head" then
					hum:TakeDamage(30)
				else
					hum:TakeDamage(10)
				end
			end
		end
		createBullet(plr, origin, hitPos)
		wait(fireDelay)
		debounce = false
		tool.FirePart.ParticleEmitter.Enabled = false
	end
end)

tool.Equipped:Connect(function()
	local char = tool.Parent
	local hum = char:FindFirstChild("Humanoid")
	if hum then
		holdAnim = hum:LoadAnimation(tool.Hold)
		holdAnim:Play()
	end
	tool.Handle.Equip:Play()
end)

tool.Unequipped:Connect(function()
	if holdAnim then
		holdAnim:Stop()
		holdAnim = nil
	end
end)