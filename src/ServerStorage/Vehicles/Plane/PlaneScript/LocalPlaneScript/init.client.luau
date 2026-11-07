local userInputService = game:GetService("UserInputService")
local camera = game.Workspace.CurrentCamera
local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character.Humanoid
local mouse = player:GetMouse()
local plane = script:WaitForChild("Plane").Value
local body = plane:WaitForChild("Body")
local config = plane:WaitForChild("Configurations")

-- You don't need to touch any of this
local cameraType = camera.CameraType
camera.CameraType = Enum.CameraType.Scriptable

local aimGui

if config.GunsEnabled.Value then
	aimGui = plane.AimPart.GUI:Clone()
	aimGui.Parent = player.PlayerGui
	aimGui.Enabled = true
	aimGui.Adornee = plane.AimPart
	
	if plane:FindFirstChild("Guns") then
		for _, gun in pairs(plane.Guns:GetChildren()) do
			gun.ChildAdded:connect(function(bullet)
				if bullet.Name == "Bullet" then
					bullet.CFrame = gun.Muzzle.CFrame
				end
			end)
		end
	end
end

local rs = game:GetService("RunService").RenderStepped

local mobileGui = script.MobileGui
local sliding = false

local thumb1, thumb2 = Vector2.new(), Vector2.new()
local x, y = 0, 0
local speed = 0

if userInputService.TouchEnabled then
	userInputService.ModalEnabled = true
	mobileGui.Parent = player.PlayerGui
	mobileGui.Throttle.Slider.MouseButton1Down:connect(function()
		sliding = true
		local mu
		mu = userInputService.TouchEnded:connect(function()
			sliding = false
			mu:disconnect()
		end)
		while sliding do
			rs:wait()
			local mouseY = mouse.Y - mobileGui.Throttle.AbsolutePosition.Y
			local s = math.min(math.max(mouseY / mobileGui.Throttle.AbsoluteSize.Y, 0), 1)
			speed = (1 - s) * config.Speed.Value
			mobileGui.Throttle.Slider.Position = UDim2.new(0, -10, s, -35)
		end
	end)
else
	mobileGui:Destroy()
end

local bodyGyro = Instance.new("BodyGyro", body)
bodyGyro.D = 30
bodyGyro.P = 300
bodyGyro.MaxTorque = Vector3.new()

local bodyVelocity = Instance.new("BodyVelocity", body)
bodyVelocity.P = math.huge
bodyVelocity.MaxForce = Vector3.new()

--Input
userInputService.InputBegan:connect(function(inputObject, processed)
	if not processed then
		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			plane.Shoot:FireServer(true)
		end
	end
end)

userInputService.InputEnded:connect(function(inputObject, processed)
	if not processed then
		if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			plane.Shoot:FireServer(false)
		end
	end
end)

userInputService.InputChanged:connect(function(inputObject)
	if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 then
		thumb1 = Vector2.new(0, inputObject.Position.Y)
		if math.abs(thumb1.Y) <= 0.1 then
			thumb1 = Vector2.new(thumb1.X, 0)
		end
		speed = math.max(thumb1.Y, 0) * config.Speed.Value
	elseif inputObject.KeyCode == Enum.KeyCode.Thumbstick2 then
		thumb2 = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
		if math.abs(thumb2.X) <= 0.1 then
			thumb2 = Vector2.new(0, thumb2.Y)
		end
		if math.abs(thumb2.Y) <= 0.1 then
			thumb2 = Vector2.new(thumb2.X, 0)
		end
	end
end)

while plane.Seat.Occupant == humanoid and humanoid.Health > 0 do
	local deltaTime = rs:wait()
	
	local mouseX = -thumb2.X
	local mouseY = -thumb2.Y
	
	if thumb2.magnitude <= 0 and not sliding then
		mouseX = ((camera.ViewportSize.X / 2) - mouse.X) / (camera.ViewportSize.X / 2)
		mouseY = ((camera.ViewportSize.Y / 2) - mouse.Y) / (camera.ViewportSize.Y / 2)
	end
	
	y = mouseY * 1.4
	x = (x + (mouseX / 50) * (config.TurnSpeed.Value / 10)) % (math.pi * 2)
	
	if userInputService:IsKeyDown(Enum.KeyCode.W) then
		speed = math.min(speed + deltaTime * 100, config.Speed.Value)
	elseif userInputService:IsKeyDown(Enum.KeyCode.S) then
		speed = math.max(speed - deltaTime * 100, 0)
	end
	
	local power = speed / config.Speed.Value
	
	camera.CoordinateFrame = camera.CoordinateFrame:lerp(CFrame.new(body.Position) * CFrame.Angles(0, x, 0) * CFrame.Angles(y, 0, 0) * CFrame.new(0, 10, 30), deltaTime * 15)
	
	bodyGyro.CFrame = camera.CoordinateFrame * CFrame.Angles(0, 0, mouseX)
	bodyGyro.MaxTorque = Vector3.new(power, power, power) * config.TurnSpeed.Value
	bodyVelocity.Velocity = body.CFrame.lookVector * config.Speed.Value
	bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000) * power
	
	if config.GunsEnabled.Value then
		plane.AimPart.CFrame = body.CFrame * CFrame.new(0, 8, -100)
	end
end

bodyGyro:Destroy()
bodyVelocity:Destroy()
if aimGui then
	aimGui:Destroy()
end
if mobileGui then
	mobileGui:Destroy()
end
camera.CameraType = cameraType
userInputService.ModalEnabled = false
script:Destroy()