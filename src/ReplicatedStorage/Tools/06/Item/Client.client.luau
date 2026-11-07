--//Variables\\--
local tool = script.Parent
	local handle = tool:WaitForChild("Handle")

local contextActionService = game:GetService("ContextActionService")
	
local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()
	local character = player.Character or player.CharacterAdded:Wait()	
	
local enabled = true
local specialDB = true

local cursorId = "http://www.roblox.com/asset/?id=251497633"
local hitId = "http://www.roblox.com/asset/?id=70785856"

local configs = tool:WaitForChild("Configurations")
	local fireRate = configs:FindFirstChild("FireRate")
	local specialRechargeTime = configs:FindFirstChild("SpecialRechargeTime")

local fire = tool:WaitForChild("Fire")
local activateSpecial = tool:WaitForChild("ActivateSpecial")
local hit = tool:WaitForChild("Hit")

--//Custom Functions\\--
function activate()
	if specialDB then
		specialDB = false
		activateSpecial:FireServer()
	else
	end
end

--//Tool Function\\--
tool.Equipped:Connect(function()
	contextActionService:BindAction("ActivateSpecial", activate, true, Enum.KeyCode.E)
	contextActionService:SetImage("ActivateSpecial", tool.TextureId)
	contextActionService:SetPosition("ActivateSpecial", UDim2.new(0.72, -25, 0.20, -25))
	mouse.Icon = cursorId
end)

tool.Unequipped:Connect(function()
	contextActionService:UnbindAction("ActivateSpecial")
	mouse.Icon = ""
end)

tool.Activated:Connect(function()
	if not enabled then return end
	
	enabled = false
	fire:FireServer(mouse.Hit)
	wait(fireRate.Value)
	enabled = true
end)

hit.OnClientEvent:Connect(function()
	mouse.Icon = hitId
	handle.Hitmark:Play()
	wait(0.075)
	mouse.Icon = cursorId
end)

activateSpecial.OnClientEvent:Connect(function()
	
	for i = specialRechargeTime.Value, 0, -1 do
		wait(1)
		specialDB = false
		print("Recharging: "..i)
	end
	
	specialDB = true
end)