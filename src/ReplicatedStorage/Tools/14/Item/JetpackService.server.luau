------------------------------------------

MAX_FUEL = 700

REFUEL_SPEED = 60

FUEL_SPEND_SPEED = 100

------------------------------------------

-- Roblox Services --
local RunService = game:GetService("RunService")

-- Utils --
local Utils = script.Parent:WaitForChild("Utils")
local Dumpster = require(Utils:WaitForChild("Dumpster"))

-- Fields --
local currentFuel: number = MAX_FUEL -- starting with max fuel
script.Parent:SetAttribute("CurrentFuel", currentFuel) -- for replicating to client
script.Parent:SetAttribute("MAX_FUEL", MAX_FUEL) -- for replicating to client

local tool: Tool = script.Parent
local handle = tool:WaitForChild("Handle")

local player: Player = tool.Parent.Parent

local networkFolder = script.Parent:WaitForChild("Network")
local jetpackRemote = networkFolder:WaitForChild("Jetpack")

local fuelDumpster = nil
local usageDumpster = nil

local toolDumpster = Dumpster.new()

toolDumpster:Add(function()
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)	
	end

	toolDumpster = nil
end)

toolDumpster:AttachTo(tool)
toolDumpster:AttachTo(player)

-- local functions --
local function toggleParticles(state: boolean): ()
	for _, desc in ipairs(handle:GetDescendants()) do
		if not desc:IsA("ParticleEmitter") then
			continue
		end
		
		desc.Enabled = state or false
	end	
end


-- Lifetime methods
toolDumpster:Connect(jetpackRemote.OnServerEvent, function(plr: Player, thrustState: boolean)
	if plr ~= player then
		-- player firing this doesn't own this tool
		return
	end
	
	if thrustState and currentFuel < 1 then
		-- not enough fuel to use this
		tool:SetAttribute("THRUSTING")
		return
	end
	
	tool:SetAttribute("THRUSTING", thrustState)
end)


toolDumpster:Connect(tool:GetAttributeChangedSignal("THRUSTING"), function()
	if not tool:GetAttribute("THRUSTING") then
		if usageDumpster then
			usageDumpster:Destroy()
		end
		
		toggleParticles(false)
		return
	end
	
	if not (player and player.Character and player.Character:IsDescendantOf(workspace)) then
		-- can't be used, one of these isn't true
		return
	end
	
	if usageDumpster then
		usageDumpster:Destroy()
	end
	
	toggleParticles(true)
	usageDumpster = toolDumpster:Extend()
	
	usageDumpster:Add(function()
		if player and player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)	
		end
		
		tool:SetAttribute("REFUELING", true)
		usageDumpster = nil
	end)
	
	tool:SetAttribute("REFUELING") -- remove refueling loop
	
	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)	
	end
	
	usageDumpster:Connect(RunService.Stepped, function(_, dt)
		local decreaseAmount: number = FUEL_SPEND_SPEED * dt

		currentFuel = math.clamp(currentFuel - decreaseAmount, 0, MAX_FUEL)
		tool:SetAttribute("CurrentFuel", currentFuel)

		if currentFuel < 1 then
			-- no longer thrusting as fuel has ran out
			tool:SetAttribute("THRUSTING")
			return
		end
	end)	
end)


toolDumpster:Connect(tool:GetAttributeChangedSignal("REFUELING"), function()
	if not tool:GetAttribute("REFUELING") then
		if fuelDumpster then
			fuelDumpster:Destroy()
		end
		
		return
	end	
	
	-- refuel time
	if fuelDumpster then
		fuelDumpster:Destroy()
	end

	fuelDumpster = toolDumpster:Extend()

	fuelDumpster:Add(function()
		tool:SetAttribute("REFUELING")
		fuelDumpster = nil
	end)


	fuelDumpster:Connect(RunService.Stepped, function(_, dt: number)
		currentFuel = math.clamp(currentFuel + (REFUEL_SPEED * dt), 0, MAX_FUEL)
		tool:SetAttribute("CurrentFuel", currentFuel)

		if currentFuel >= MAX_FUEL then
			tool:SetAttribute("REFUELING")
			return
		end
	end)
end)

toolDumpster:Connect(tool.Unequipped, function()
	tool:SetAttribute("THRUSTING")
	tool:SetAttribute("REFUELING")
end)