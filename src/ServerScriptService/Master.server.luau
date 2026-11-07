--------------------------------------------

-- Length of Round (s)
roundLength = 240

-- Length of Intermission between rounds (s)
Intermission = 15

-- Green Gems Granted Upon Victory
survivalReward = 100

-- Green Gems Taken Upon Death
deathPenalty = 50

-- Green Gems Granted on Initial Spawn
startingGems = 350

--------------------------------------------

-- Lava Y Axis Range
y1, y2 = -370, 25

-- Start Minutes and Seconds at 0
M, S = 0, 0

game:WaitForChild('Workspace')

GemStore = game:GetService("DataStoreService"):GetDataStore("Gems")

-- Get List of Vehicles and Animals
Vehicles = game.ServerStorage.Vehicles:GetChildren()
Animals = game.ServerStorage.Animals:GetChildren()

-- Function to get a random position on the ground
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

function repeatFunctionUntilSuccess(func)
	local done = false
	while not done do
		done = pcall(func)
		task.wait()	
	end
end

----------------------------------------------------

game.Players.PlayerAdded:Connect(function(Player)

	-- Create InMatch value
	local InMatch = Instance.new('BoolValue')
	InMatch.Parent = Player
	InMatch.Name = 'InMatch'
	
	-- Create Green Gems value
	local GG = Instance.new('IntValue')
	GG.Parent = Player
	GG.Name = 'GreenGems'
		
	-- Create Red Gems Value
	local RG = Instance.new('IntValue')
	RG.Parent = Player
	RG.Name = 'RedGems'
	
	-- Create Rank Value
	local Rank = Instance.new('IntValue')
	Rank.Parent = Player
	Rank.Name = 'Rank'
	
	-- Restore Gems from save or grant starting gems
	if GemStore:GetAsync(Player.UserId) then
		GG.Value = GemStore:GetAsync(Player.UserId)
	else
		GG.Value = startingGems
	end
	
	-- Create barrier for Player
	local barrier = game.ReplicatedStorage.Barrier:Clone()
	barrier.Name = Player.Name..'_Barrier'
	barrier.Parent = game.Workspace

	Player.CharacterAdded:Connect(function(Character)
		
		Player.PlayerGui:WaitForChild('GUI')
		
		-- Reset GUIs
		Player.PlayerGui.GUI.Shop.Open.Visible = false
		Player.PlayerGui.GUI.Shop.Main.Visible = false
		Player.PlayerGui.GUI.Gem.Red.Visible = false
		
		Character:WaitForChild("Humanoid").Died:Connect(function()

			game.ServerScriptService.Gems:Fire(Player, -deathPenalty, 'Green', 'Death')

			Player.InMatch.Value = false

		end)
		
		local LastGems = Player:WaitForChild('GreenGems').Value
		
		while task.wait(.5) do
			pcall(function()
				
				-- Update Player's Save Data if Gem Count changed
				if Player.GreenGems.Value ~= LastGems then
					GemStore:SetAsync(Player.UserId, Player.GreenGems.Value)
					local LastGems = Player.GreenGems.Value
				end
				
				-- Update Gui
				Player.PlayerGui.GUI.Gem.Green.TextLabel.Text = Player.GreenGems.Value
				Player.PlayerGui.GUI.Gem.Red.TextLabel.Text = Player.RedGems.Value
				Player.PlayerGui.GUI.Timer.Text = M..':'..S
				
				-- Teleport Player's Barrier to player at y500
				local PP = Player.Character.PrimaryPart.Position
				barrier.Position = Vector3.new(PP.X, 500, PP.Z)
				
				-- TODO Rank Rewards - Speed/Health/Jump Boosts
				Player.Rank.Value = math.floor(Player.GreenGems.Value / 100)
				
			end)
			
		end

	end)

end)

----------------------------------------------------

function everyTick(Tick)
	
	-- Calculate Seconds and Minutes
	M = math.floor(Tick/60)
	S = Tick - M*60
	if S < 10 then S = '0'..S end
	if M < 10 then M = '0'..M end
	
	-- Raise Lava
	for _, obj in ipairs(game.Workspace.Lava:GetChildren()) do
		obj.Position = Vector3.new(obj.Position.X, obj.Position.Y + math.floor(y2-y1)/roundLength, obj.Position.Z)
	end
	
	-- Get The Number of players still in the match
	local PlayersAlive = 0
	for _, Player in ipairs(game.Players:GetChildren()) do
		if Player:WaitForChild('InMatch').Value == true then
			PlayersAlive += 1
		end
	end
	
	if PlayersAlive == 0 then
		return 0 -- End Round
	else
		return Tick - 1
	end
	
end

----------------------------------------------------

function resetTick()

	M, S = '--', '--'
	
	-- Play Random Video on the TVs at the lobby
	game.Workspace.Lobby.TVs.Play:Fire()

	-- Grant Reward Gems to surviving players
	for _, Player in ipairs(game.Players:GetChildren()) do
		if Player:WaitForChild('InMatch').Value == true then
			game.ServerScriptService.Gems:Fire(Player, survivalReward, 'Green', 'Survived Round')
			Player:LoadCharacter()
		end
	end
	
	-- Destroy Storm
	if game.Workspace:FindFirstChild('Storm') then
		game.Workspace.Storm:Destroy()
	end

	-- Spawn New Vehicles
	game.Workspace.Vehicles:ClearAllChildren()
	for x = 1, 75, 1 do
		local clone = Vehicles[math.random(1, #Vehicles)]:Clone()
		clone.Parent = game.Workspace.Vehicles
		clone:MoveTo(getRandomTerrainPosition())
		task.wait()
	end

	-- Spawn New Animals
	game.Workspace.Animals:ClearAllChildren()
	for x = 1, 125, 1 do
		local clone = Animals[math.random(1, #Animals)]:Clone()
		clone.Parent = game.Workspace.Animals
		clone:MoveTo(getRandomTerrainPosition())
		task.wait()
	end

	-- Reset Lava
	for _, obj in ipairs(game.Workspace.Lava:GetChildren()) do
		obj.Position = Vector3.new(math.random(-2310, 2270), y1, math.random(-4320, 1810))
	end
	
	for x = Intermission, 0, -1 do
		
		M = math.floor(x/60)
		S = x - M*60
		if S < 10 then S = '0'..S end
		if M < 10 then M = '0'..M end
		task.wait(1)
	end

	game.ReplicatedStorage.ClearSpectatorFlight:FireAllClients()
	
	for _, Player in ipairs(game.Players:GetChildren()) do
		
		if Player.PlayerGui:WaitForChild('GUI').Start.Enabled == false then

			-- Reset Red Gems
			Player.RedGems.Value = Player.GreenGems.Value
			
			Player.InMatch.Value = true
			
			-- Unhide GUI
			Player.PlayerGui.GUI.Shop.Open.Visible = true
			Player.PlayerGui.GUI.Gem.Red.Visible = true
			
			-- Randomize Player Position
			Player.Character.PrimaryPart.Position = getRandomTerrainPosition() + Vector3.new(0, 30, 0)
			
		end

	end
	
	-- Chance of Spawning a Storm
	if math.random(1, 5) == 1 then
		game.ServerStorage.Storm:Clone().Parent = game.Workspace
	end
	
	return roundLength
	
end

Tick = resetTick()

while true do
	
	Tick = everyTick(Tick)
	
	if Tick <= 0 then
		Tick = resetTick()
	end
	
	task.wait(1)

end