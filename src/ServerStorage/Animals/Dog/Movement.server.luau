--Made by Luckymaxer

Figure = script.Parent

RunService = game:GetService("RunService")

Creator = Figure:FindFirstChild("Creator")

Humanoid = Figure:WaitForChild("Humanoid")
Torso = Figure:WaitForChild("Torso")

Healing = Figure:WaitForChild("Healing", 5)

FollowingPath = false
WalkRadius = 25

WalkingPaused = false
OriginallyIgnored = false

Humanoid.Health = Humanoid.MaxHealth

function RayCast(Position, Direction, MaxDistance, IgnoreList)
	return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(Position, Direction.unit * (MaxDistance or 999.999)), IgnoreList) 
end

function MoveAround(TargetPoint)
	TargetPoint = ((not TargetPoint and (Torso.Position + Vector3.new(math.random(-WalkRadius, WalkRadius), 0, math.random(-WalkRadius, WalkRadius))) or TargetPoint))
	Humanoid:MoveTo(TargetPoint)
end

function SecureJump()
	if Humanoid.Jump then
		return
	end
	local TargetPoint = Humanoid.TargetPoint
	local Blockage, BlockagePos = RayCast((Torso.CFrame + CFrame.new(Torso.Position, Vector3.new(TargetPoint.X, Torso.Position.Y, TargetPoint.Z)).lookVector * (Torso.Size.Z / 2)).p, Torso.CFrame.lookVector, (Torso.Size.Z * 2.5), {Figure, (((Creator and Creator.Value and Creator.Value:IsA("Player") and Creator.Value.Character) and Creator.Value.Character) or nil)})
	local Jumpable = false
	if Blockage then
		Jumpable = true
		if Blockage:IsA("Terrain") then
			local CellPos = Blockage:WorldToCellPreferSolid((BlockagePos - Vector3.new(0, 2, 0)))
			local CellMaterial, CellShape, CellOrientation = Blockage:GetCell(CellPos.X, CellPos.Y, CellPos.Z)
			if CellMaterial == Enum.CellMaterial.Water then
				Jumpable = false
			end
		elseif Blockage.Parent:FindFirstChild("Humanoid") then
			Jumpable = false
		end
	end
	if Jumpable then
		Humanoid.Jump = true
	end
end

RunService.Stepped:connect(function()
	if WalkingPaused then
		return
	end
	local Wait = false
	local IgnoreDistance = false
	local CreatorValue = ((Creator and Creator.Value) or nil)
	local CreatorCharacter, CreatorTorso, TorsoPosition
	local DistanceApart
	if CreatorValue and CreatorValue:IsA("Player") and CreatorValue.Character then
		CreatorCharacter = CreatorValue.Character
		CreatorTorso = CreatorCharacter:FindFirstChild("Torso")
		if CreatorTorso then
			DistanceApart = (Torso.Position - CreatorTorso.Position).magnitude
			TorsoPosition = (CreatorTorso.CFrame + CreatorTorso.CFrame.lookVector * (CreatorTorso.Size.Z * ((not Healing.Value and -0.25) or -1.5)))
			if not Healing.Value then
				TorsoPosition = (TorsoPosition + (TorsoPosition * CFrame.Angles(0, (math.pi / 2), 0)).lookVector * (Torso.Size.X * 1.5)).p
			else
				TorsoPosition = TorsoPosition.p
				IgnoreDistance = true
				OriginallyIgnored = true
			end
		end
	end
	if DistanceApart then
		if DistanceApart > 6 or IgnoreDistance or OriginallyIgnored then
			if not IgnoreDistance then
				OriginallyIgnored = false
			end
			if Humanoid.Sit then
				Humanoid.Jump = true
			end
			local WalkSpeed = (((CreatorTorso and (Torso.Position - CreatorTorso.Position).magnitude >= 20) and 24) or 16)
			Humanoid.WalkSpeed = WalkSpeed
			MoveAround(TorsoPosition)
		end
	else
		MoveAround(nil)
		Wait = true
	end
	SecureJump()
	if Wait then
		WalkingPaused = true
		local RandomInterval = {Min = 1, Max = 3}
		RandomInterval = {Min = (RandomInterval.Min * 100), Max = (RandomInterval.Max * 100)}
		local WaitTime = (math.random(RandomInterval.Min, RandomInterval.Max) * 0.01)
		wait(WaitTime)
		WalkingPaused = false
	end
end)