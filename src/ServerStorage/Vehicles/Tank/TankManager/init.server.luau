--[[
																							
████████╗█████╗███╗   ████╗  ██╗    ███╗   ███╗█████╗███╗   ██╗█████╗ ██████╗█████████████╗ 
╚══██╔══██╔══██████╗  ████║ ██╔╝    ████╗ ██████╔══██████╗  ████╔══████╔════╝██╔════██╔══██╗
   ██║  █████████╔██╗ ███████╔╝     ██╔████╔███████████╔██╗ ███████████║  ████████╗ ██████╔╝
   ██║  ██╔══████║╚██╗████╔═██╗     ██║╚██╔╝████╔══████║╚██╗████╔══████║   ████╔══╝ ██╔══██╗
   ██║  ██║  ████║ ╚██████║  ██╗    ██║ ╚═╝ ████║  ████║ ╚██████║  ██╚██████╔█████████║  ██║
   ╚═╝  ╚═╝  ╚═╚═╝  ╚═══╚═╝  ╚═╝    ╚═╝     ╚═╚═╝  ╚═╚═╝  ╚═══╚═╝  ╚═╝╚═════╝╚══════╚═╝  ╚═╝
																							
   || FREE VERSION ||                                                    made by @mari230899
   || PAID VERSION ||                             https://www.roblox.com/library/6213564347/
																							
]]--

-- Main Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tank = script.Parent
local DriverSeat = Tank:WaitForChild("DriverSeat")
local TankHead = Tank:WaitForChild("TankHead")
local TurretController = require(Tank.TurretController)

local GunHeadconst = TankHead.turret.Plataform.GunHead
local Gunconst = TankHead.turret.GunHead.Gun
local onReload = false
local Justflip = false

-- Properties
local health = Tank.Properties.health
local shield = Tank.Properties.shield
local speed = Tank.Properties.tankColor
local tankColor = Tank.Properties.tankColor
local reload_time = Tank.Properties.reload_time
local bulletPower = Tank.Properties.bulletPower

-- Mecanic Engineering
local validPainting = {
	table.unpack(Tank.TankHead.turret:GetChildren()), 
	table.unpack(Tank.Hull:GetChildren())
}
local GunHead = TurretController.new(
	GunHeadconst, {
		["YawLeft"] = 180;
		["YawRight"] = 180;
		["ElevationAngle"] = 10;
		["DepressionAngle"] = 8;
	})
for index, part in pairs(validPainting) do
	if part:IsA("BasePart") and part.Name ~= "Glass" then
		if part.Transparency == 0 then
			if part.Name ~= "Tracks" and part.Name ~= "Drive wheels" then
				part.Color = tankColor.Value
			end
		end
	end
end

-- Methods
-- || When the player sits on the tank head
DriverSeat.ChildAdded:Connect(function(child)
	if child:IsA("Weld") and child.Name ~= "Sanctioned" then
		local chartpart = child.Part1
		local Hum = chartpart.Parent:FindFirstChild("Humanoid")
		if Hum ~= nil then
			local Char = Hum.Parent
			local plr = game.Players:GetPlayerFromCharacter(Char)
			local lScript = script:WaitForChild("local"):Clone()

			lScript.Parent = plr.PlayerGui
			lScript.Disabled = false
		end
	end
end)

-- || When the tank is destroyed
Tank.Properties.health.Changed:Connect(function(value)
	if value <= 0 then
		DriverSeat.deactive:Play()
		Tank:BreakJoints()
		task.wait(DriverSeat.deactive.TimeLength)
		Tank:Destroy()
	end
end)

-- Events
-- || Velocity Updates
Tank.Events.UpdateBV.OnServerEvent:Connect(function(plr, newVelo, BV)
	BV.Velocity = newVelo
end)

Tank.Events.UpdateAV.OnServerEvent:Connect(function(plr, newAV, BAV)
	BAV.AngularVelocity = newAV
end)

Tank.Events.Stop.OnServerEvent:Connect(function(plr, BV, BAV)
	BV.Velocity = Vector3.new(0,0,0)
	BAV.AngularVelocity = Vector3.new(0,0,0)
end)

Tank.Events.Flip.OnServerEvent:Connect(function(plr, seat)
	if Justflip == false then
		Justflip = true
		local BodyGyro = Instance.new("BodyGyro")
		BodyGyro.CFrame = CFrame.new(0,0,0)
		BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		BodyGyro.Parent = seat
		game:GetService("Debris"):AddItem(BodyGyro, 0.8)
		
		task.wait(2)
		Justflip = false
	end
end)

-- || Player moves the mouse
Tank.Events.Mouse_Move.OnServerEvent:Connect(function(plr, pos)
	GunHead:LookAt(pos, 0.08)
end)

-- || Playing sounds on the server
Tank.Events.Sound.OnServerEvent:Connect(function(plr, bool)
	if bool == true then
		DriverSeat.runSound:Play()
	else
		DriverSeat.runSound:Stop()
	end
end)

-- || Player fires the TankGun
Tank.Events.Mouse_Click.OnServerEvent:Connect(function(plr)
	if onReload then return end
	local pos = TankHead.Gun.Shoot.CFrame.LookVector * 300
	DriverSeat.Fire:Play()
	onReload = true
	
	local bullet = Instance.new("Part")
	bullet.Size = Vector3.new(0.6, 0.6, 0.6)
	bullet.Color = Color3.fromRGB(206, 166, 56)
	bullet.Material = Enum.Material.Metal
	bullet.CFrame = CFrame.new(TankHead.Gun.Shoot.Position, pos)
	bullet.Parent = workspace
	
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.Velocity = pos
	BodyVelocity.Parent = bullet
	game:GetService("Debris"):AddItem(BodyVelocity, 1)
	
	bullet.Touched:Connect(function(hit)
		if not hit:IsDescendantOf(Tank) then
			local t = workspace:GetPartBoundsInBox(bullet.CFrame, Vector3.new(10, 10, 10))
			local Explosion = Instance.new("Explosion")
			Explosion.ExplosionType = Enum.ExplosionType.NoCraters
			Explosion.Position = bullet.Position
			Explosion.BlastRadius = 20
			Explosion.BlastPressure = 0
			Explosion.Parent = workspace

			for index, part in pairs(t) do
				if part.Parent then
					if string.find(part.Name, "hull_") and not part:IsDescendantOf(Tank) then
						local target = part.Parent.Parent
						local thealth = target.Properties.health
						local tshield = target.Properties.shield

						if thealth.Value > 0 then
							thealth.Value = thealth.Value - (bulletPower.Value - (
								tshield.Value * (math.random(5, 30)/100)))
							if thealth.Value < 0 then thealth.Value = 0 end
						end
					end
					if part.Parent:FindFirstChildOfClass("Humanoid") then
						part.Parent:FindFirstChildOfClass("Humanoid").Health = 0
					end
				end
			end
			bullet:Destroy()
		end
	end)
	task.wait(0.2)
	DriverSeat.reload:Play()
	task.wait(reload_time.Value)
	onReload = false
end)