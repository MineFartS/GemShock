local Hits = {}
script.Parent.Touched:Connect(function(Hit)
	if Hit.Parent ~= script.Owner.Value and not game.Players:GetPlayerFromCharacter(Hit.Parent) then
		local Humanoid = Hit.Parent:FindFirstChildOfClass("Humanoid")
		if Hits[Hit.Parent] == nil and Humanoid then
			Hits[Hit.Parent] = true
			local rootPart = Hit.Parent:FindFirstChild("HumanoidRootPart")
			if rootPart then
				local force = Instance.new("BodyVelocity")
				force.MaxForce = Vector3.new(20000, 20000, 20000)
				force.P = 20000
				force.Velocity = ((rootPart.Velocity.Unit) * -100) + Vector3.new(0, 10, 0)
				force.Parent = rootPart
				game.Debris:AddItem(force, 0.5)
				if not Hit.Parent:FindFirstChildOfClass("Fire") then
					local fire = Instance.new("Fire")
					fire.Heat = 25
					fire.Size = 30
					fire.Parent = Hit
					game.Debris:AddItem(fire, 10)
				end
			end
			Humanoid:TakeDamage(9000)
		end
	end
	wait(1)
	Hits[Hit.Parent] = nil
end)
