Bolts = {}

for _, Item in pairs(script.Parent:GetChildren()) do
	if Item:IsA("UnionOperation") then
		Bolts[1+#Bolts] = Item
	end
end

params = RaycastParams.new()
params.FilterDescendantsInstances = {game.Workspace.Terrain}
params.FilterType = Enum.RaycastFilterType.Include

while true do
	
	local Bolt = Bolts[math.random(1, #Bolts)]
	
	Bolt.Transparency = 0
	
	script.Parent.Sound:Play()
	
	local explosion = Instance.new("Explosion", game.Workspace)
	explosion.Visible = false
	explosion.ExplosionType = Enum.ExplosionType.NoCraters
	explosion.BlastRadius = 25
	
	local raycast = game.Workspace:Raycast(Bolt.Position + Vector3.new(0, 100, 0), Vector3.new(0, -1000, 0), params)
	
	if raycast then
		explosion.Position = raycast.Position
	else
		explosion.Position = Bolt.BlastCenter.Position
	end
		
	task.wait(.75)
	
	Bolt.Transparency = 1

	task.wait(math.random(1, 3000)/100)
	
end