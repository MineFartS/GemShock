Tool = script.Parent

Tool.Activated:Connect(function()

	local Player = game.Players[Tool.Parent.Name]

	local Rocket = script.Parent.Handle:Clone()

	local bodyForce = Instance.new('BodyForce', Rocket)
	bodyForce.Force = Vector3.new(0, (Rocket:GetMass() * workspace.Gravity)/1.02, 0)

	local MouseLoc = Tool:WaitForChild("MouseLoc"):InvokeClient(Player)

	-- Position the rocket clone and launch
	local spawnPosition = Player.Character.PrimaryPart.Position
	Rocket.CFrame = CFrame.new(spawnPosition, MouseLoc)
	Rocket.Velocity = Rocket.CFrame.lookVector * 25

	Rocket.Parent = game.Workspace

	Rocket.Touched:Connect(function(obj)
		
		if not string.match(obj:GetFullName(), 'Workspace.'..Player.Name) then

			local explosion = Instance.new('Explosion')
			explosion.BlastRadius = 15
			explosion.Position = Rocket.Position
			explosion.DestroyJointRadiusPercent = 0
			explosion.ExplosionType = Enum.ExplosionType.NoCraters

			Rocket:Destroy()
			explosion.Parent = game.Workspace

			explosion.Hit:Connect(function(part)
				local hrp = part.Parent:FindFirstChild('HumanoidRootPart')
				local bodyVel = hrp:FindFirstChildWhichIsA('BodyVelocity')
				if hrp and not bodyVel then
					local newVel = Instance.new('BodyVelocity')
					newVel.Velocity = Vector3.new(0,100,0)
					newVel.MaxForce = Vector3.new(10000,10000,10000)
					newVel.P = 5000
					newVel.Parent = hrp
					wait(1)
					newVel:Destroy()
				end
			end)

		end

	end)

	Tool.Enabled = false
	wait(2)
	Tool.Enabled = true

end)