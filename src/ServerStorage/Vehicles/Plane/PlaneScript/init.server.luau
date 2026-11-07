local plane = script.Parent
local config = plane.Configurations
local seat = plane.Seat

local shooting = false

if not config.GunsEnabled.Value then
	if plane:FindFirstChild("Guns") then
		plane.Guns:Destroy()
	end
	if plane:FindFirstChild("AimPart") then
		plane.AimPart:Destroy()
	end
elseif plane:FindFirstChild("Guns") then
	plane.Shoot.OnServerEvent:connect(function(player, shoot)
		shooting = shoot
	end)
end

-- For effects and stuff
local function Engine(on)
	local prop = plane.Propeller
	
	if on then
		prop.Hinge.DesiredAngle = 1e100 -- Super huge number so the propeller doesn't stop spinning :D
	else
		local angle = math.random(0, 10)
		prop.Hinge.DesiredAngle = angle
		prop.Hinge.CurrentAngle = angle
	end
end

seat.Changed:connect(function(p)
	if p == "Occupant" then
		local occupant = seat.Occupant
		
		if occupant then
			Engine(true)
			local player = game.Players:GetPlayerFromCharacter(occupant.Parent)
			if player then
				plane.Body:SetNetworkOwner(player)
				local localPlaneScript = script.LocalPlaneScript:Clone()
				localPlaneScript.Parent = player.PlayerGui
				localPlaneScript.Plane.Value = plane
				localPlaneScript.Disabled = false
			else
				shooting = false
			end
		else
			Engine(false)
		end
	end
end)

while true do
	if seat.Occupant and shooting then
		for _, gun in pairs(plane.Guns:GetChildren()) do
			if gun:FindFirstChild("Muzzle") then
				local bullet = Instance.new("Part")
				bullet.Parent = gun
				bullet.Anchored = false
				bullet.CanCollide = false
				bullet.FormFactor = Enum.FormFactor.Custom
				bullet.Size = Vector3.new(0.4, 10, 0.4)
				bullet.BrickColor = BrickColor.new("Bright yellow")
				bullet.Material = Enum.Material.Neon
				Instance.new("CylinderMesh", bullet)
				Instance.new("BodyForce", bullet).Force = Vector3.new(0, bullet:GetMass() * 196.2, 0)
				bullet.CFrame = gun.Muzzle.CFrame
				bullet.Velocity = bullet.CFrame:vectorToWorldSpace(Vector3.new(0, 1, 0)) * 2000
				bullet:SetNetworkOwner(game.Players:GetPlayerFromCharacter(seat.Occupant.Parent))
				
				bullet.Touched:connect(function(hit)
					if not hit:IsDescendantOf(plane) and not hit:IsDescendantOf(seat.Occupant.Parent) then
						local explosion = Instance.new("Explosion", game.Workspace)
						explosion.Position = bullet.Position
						explosion.BlastRadius = 4
						explosion.DestroyJointRadiusPercent = 1
						hit.Parent.Humanoid:TakeDamage(20)
						bullet:Destroy()
					end
				end)
				
				game.Debris:AddItem(bullet, 1)
			end
		end
	end
	wait(0.1)
end