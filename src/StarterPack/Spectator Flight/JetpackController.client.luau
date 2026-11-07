--[[
	@author: Stephen Englet | KinqSodie
	@date: 4/26/2023
	@description: Updated performance, and added garbage collection
]]


-- Roblox Services --
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Utils --
local Utils = script.Parent:WaitForChild("Utils")
local Dumpster = require(Utils:WaitForChild("Dumpster"))

-- Constants --
local MOBILE_USER: boolean = if (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled) then true else false
local CONSOLE_USER: boolean = UserInputService.GamepadEnabled

-- Fields --
local tool: Tool = script.Parent
local player: Player = tool.Parent.Parent
local playerGui: PlayerGui = player:WaitForChild("PlayerGui")

local fuelUI: ScreenGui = script.Parent:WaitForChild("FuelGui")

local networkFolder = script.Parent:WaitForChild("Network")
local jetpackRemote = networkFolder:WaitForChild("Jetpack")

local bodyVelocity: BodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.P = 2000
bodyVelocity.MaxForce = Vector3.zero
bodyVelocity.Velocity = Vector3.zero

local toolEquipped: boolean = false

local toolDumpster = Dumpster.new()

toolDumpster:Add(function()
	toolDumpster = nil
end)

toolDumpster:AttachTo(tool)
toolDumpster:Add(bodyVelocity)

-- local functions --
local function characterAdded(char: Model)
	local hrp = char:WaitForChild("HumanoidRootPart")
	bodyVelocity.Parent = hrp
end

-- Lifetime methods --
characterAdded(player.Character or player.CharacterAdded:Wait())
toolDumpster:Connect(player.CharacterAdded, characterAdded)

toolDumpster:Connect(UserInputService.InputBegan, function(input: InputObject, gameProcessed: boolean)
	if gameProcessed then
		return
	end

	if input.KeyCode ~= Enum.KeyCode.Space then
		return
	end
	
	if not toolEquipped then
		return
	end

	jetpackRemote:FireServer(true)
end)


toolDumpster:Connect(UserInputService.InputEnded, function(input: InputObject, gameProcessed: boolean)
	if gameProcessed then
		return
	end

	if input.KeyCode ~= Enum.KeyCode.Space then
		return
	end
	
	if not toolEquipped then
		return
	end
	
	jetpackRemote:FireServer(false)
end)

toolDumpster:Connect(tool:GetAttributeChangedSignal("THRUSTING"), function()
	if not tool:GetAttribute("THRUSTING") then
		tool.Parent.Humanoid.WalkSpeed = 16
		bodyVelocity.Velocity = Vector3.zero
		bodyVelocity.MaxForce = Vector3.zero
		return
	end
	tool.Parent.Humanoid.WalkSpeed = 80
	bodyVelocity.Velocity = Vector3.new(0, 20, 0)
	bodyVelocity.MaxForce = Vector3.new(0, 100000, 0)
end)

-- Fuel UI
local fuelGuageDumpster = nil

toolDumpster:Connect(tool.Equipped, function()
	toolEquipped = true
	
	local thisFuelUI: ScreenGui = fuelUI:Clone()
	thisFuelUI.MobileFrame.Visible = MOBILE_USER
	thisFuelUI.Parent = playerGui
	
	fuelGuageDumpster = toolDumpster:Extend()
	
	fuelGuageDumpster:Add(function()
		fuelGuageDumpster = nil
	end)
	
	fuelGuageDumpster:Add(thisFuelUI)
	
	if MOBILE_USER then
		fuelGuageDumpster:Connect(thisFuelUI.MobileFrame.FlyButton.InputBegan, function(input: InputObject)
			if input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			
			jetpackRemote:FireServer(true)
		end)
		
		fuelGuageDumpster:Connect(thisFuelUI.MobileFrame.FlyButton.InputEnded, function(input: InputObject)
			if input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			
			jetpackRemote:FireServer(false)
		end)
	end
	
	if CONSOLE_USER then
		fuelGuageDumpster:Connect(UserInputService.InputBegan, function(input: InputObject)
			if input.KeyCode ~= Enum.KeyCode.ButtonA then
				return
			end

			jetpackRemote:FireServer(true)
		end)

		fuelGuageDumpster:Connect(UserInputService.InputEnded, function(input: InputObject)
			if input.KeyCode ~= Enum.KeyCode.ButtonA then
				return
			end

			jetpackRemote:FireServer(false)
		end)
	end
	
	local function updateUI()
		local currentFuel: number = tool:GetAttribute("CurrentFuel")
		local maxFuel: number = tool:GetAttribute("MAX_FUEL")

		local fuelEmptyPercent: number = currentFuel/maxFuel
		
		if fuelEmptyPercent >= 0.7 then
			thisFuelUI.Bar.Fill.BackgroundColor3 = Color3.fromRGB(0, 221, 18)
		elseif fuelEmptyPercent < 0.7 and fuelEmptyPercent > 0.3 then
			thisFuelUI.Bar.Fill.BackgroundColor3 = Color3.fromRGB(255, 206, 0)
		elseif fuelEmptyPercent <= 0.3 then
			thisFuelUI.Bar.Fill.BackgroundColor3 = Color3.fromRGB(255, 51, 1)
		end
		
		thisFuelUI.Bar.Fill.Size = UDim2.fromScale(1, fuelEmptyPercent)
	end
	
	updateUI()
	
	fuelGuageDumpster:Connect(tool:GetAttributeChangedSignal("CurrentFuel"), function()
		updateUI()
	end)
end)

toolDumpster:Connect(tool.Unequipped, function()
	if fuelGuageDumpster then
		fuelGuageDumpster:Destroy()
	end
	
	toolEquipped = false
end)