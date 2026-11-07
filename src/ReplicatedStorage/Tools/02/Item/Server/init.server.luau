----------------------------------------------------

BlastRadius = 6

BlastDamage = 300

----------------------------------------------------

Tool = script.Parent

Tool.Activated:Connect(function()

	local Player = game.Players[Tool.Parent.Name]

	local Rocket = Tool.Handle:Clone()

	local bodyForce = Instance.new('BodyForce', Rocket)
	bodyForce.Name = 'Antigravity'
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
			explosion.BlastPressure = 0
			explosion.BlastRadius = BlastRadius
			explosion.ExplosionType = Enum.ExplosionType.NoCraters
			explosion.Position = Rocket.Position
			explosion.Parent = game.Workspace

			Rocket:Destroy()

			explosion.Hit:Connect(function(part, distance)
				local hitCharacter = part.Parent
				local hitHumanoid = hitCharacter:FindFirstChildOfClass("Humanoid")
				if hitHumanoid then
					local damage = BlastDamage * (BlastRadius-distance)/BlastRadius
					hitHumanoid:TakeDamage(damage)
					print('Damage: '..damage)
				end
				
			end)

		end

	end)

	Tool.Enabled = false
	wait(5)
	Tool.Enabled = true

end)