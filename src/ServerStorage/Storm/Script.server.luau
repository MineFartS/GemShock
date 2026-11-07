function getRandomTerrainPosition()
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {game.Workspace.Terrain}
	params.FilterType = Enum.RaycastFilterType.Include

	local pos = Vector3.new(math.random(-2310, 2270), 450, math.random(-4320, 1810))
	pos = game.Workspace:Raycast(pos, Vector3.new(0, -1000, 0), params)
	if pos then
		return pos.Position
	else
		return getRandomTerrainPosition()
	end
end

Objects = {}
for _, Item in pairs(script.Parent.Bolts:GetChildren()) do
	if Item:IsA("UnionOperation") then
		Objects[1+#Objects] = Item
	end
end
for _, Item in pairs(script.Parent.Clouds:GetChildren()) do
	if Item:IsA("Part") then
		Objects[1+#Objects] = Item
	end
end

tooclose = true
while tooclose do
	spawnpos = getRandomTerrainPosition() + Vector3.new(0, 50, 0)
	destpos = getRandomTerrainPosition() + Vector3.new(0, 50, 0)
	tooclose = math.abs(spawnpos.Magnitude - destpos.Magnitude) < 100
end

script.Parent:MoveTo(spawnpos)

while true do
	local z = math.random(1, 10) / 10
	for _, Object in pairs(Objects) do
		Object.CFrame = CFrame.new(Object.Position + Vector3.new(0, 0, z), destpos)
	end
	task.wait(.05)
end