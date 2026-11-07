-- Main Variables
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = game.Players.LocalPlayer
local Character = player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local mouse = player:GetMouse()

-- Properties
local tankSpeed = script:WaitForChild("localspeed").Value
local MaxSpeed = tankSpeed.Value + 15
local ActualSpeed = 0

local Seat = script:WaitForChild("seat").Value
local BAV = Seat.BodyAngularVelocity
local BV = Seat.BodyVelocity

local ForwardKeyDown, BackwardKeyDown, RightTurnKeyDown, LeftTurnKeyDown
local move = Seat.runSound
local Tank = Seat.Parent

local UpdateBV = Tank.Events:WaitForChild("UpdateBV")
local UpdateAV = Tank.Events:WaitForChild("UpdateAV")
local Mouse_Click = Tank.Events:WaitForChild("Mouse_Click")
local Mouse_Move = Tank.Events:WaitForChild("Mouse_Move")
local Sound = Tank.Events:WaitForChild("Sound")
local Stop = Tank.Events:WaitForChild("Stop")


if UserInputService.TouchEnabled then
	local gui = script.TankMobile:Clone()
	gui.Parent = player.PlayerGui
	gui.Button.MouseButton1Click:Connect(function()
		Mouse_Click:FireServer()
	end)
end

-- Methods
-- || Tank Main movement
function Forward()
	Sound:FireServer(true)
	while RunService.RenderStepped:Wait() do
		if ForwardKeyDown then
			if ActualSpeed < MaxSpeed then
				ActualSpeed = ActualSpeed + tankSpeed.Value
			else
				ActualSpeed = MaxSpeed
			end
			local maxVelo = ((2 * Seat.CFrame.LookVector) * MaxSpeed)
			local newVelo = ((2 * Seat.CFrame.LookVector) * ActualSpeed)
			UpdateBV:FireServer(newVelo, BV)
		end
		if not ForwardKeyDown and not BackwardKeyDown then
			ActualSpeed = ActualSpeed - 1
			local newVelo = ((2 * Seat.CFrame.LookVector) * ActualSpeed)
			UpdateBV:FireServer(newVelo, BV)
			if ActualSpeed <= 0 then
				ActualSpeed = 0
				newVelo = ((2 * Seat.CFrame.LookVector ) * 0)
				UpdateBV:FireServer(newVelo, BV)
				Sound:FireServer(false)
				break
			end
			if BackwardKeyDown and not ForwardKeyDown then break end
		end
	end
end

function Backwards()
	Sound:FireServer(true)
	while RunService.RenderStepped:Wait() do
		if BackwardKeyDown then
			if ActualSpeed > -MaxSpeed then
				ActualSpeed = ActualSpeed - tankSpeed.Value
			else
				ActualSpeed = -MaxSpeed
			end
			local newVelo = ((2 * Seat.CFrame.LookVector) * ActualSpeed)
			UpdateBV:FireServer(newVelo, BV)
		end
		if not BackwardKeyDown and not ForwardKeyDown then
			ActualSpeed = ActualSpeed + 1
			local newVelo = ((2 * Seat.CFrame.LookVector) * ActualSpeed)
			UpdateBV:FireServer(newVelo, BV)
			if ActualSpeed <= 0 then
				ActualSpeed = 0
				local newVelo = ((2 * Seat.CFrame.LookVector) * 0)
				UpdateBV:FireServer(newVelo, BV)
				Sound:FireServer(false)
				break
			end
		end
		if not BackwardKeyDown and ForwardKeyDown then break end
	end
end

function turnRight()
	while RightTurnKeyDown do
		task.wait()
		local newAV = nil
		if ForwardKeyDown or BackwardKeyDown then
			newAV = Vector3.new(0,-0.5,0)
		else
			newAV = Vector3.new(0,-0.4,0)
		end
		UpdateAV:FireServer(newAV, BAV)

		if not RightTurnKeyDown then
			local newAV = Vector3.new(0,0,0)
			UpdateAV:FireServer(newAV, BAV)
		end
	end
end

function turnLeft()
	while LeftTurnKeyDown do
		task.wait()
		local newAV = nil
		if ForwardKeyDown or BackwardKeyDown then
			newAV = Vector3.new(0,0.5,0)
		else
			newAV = Vector3.new(0,0.4,0)
		end
		UpdateAV:FireServer(newAV, BAV)
		if not LeftTurnKeyDown then
			local newAV = Vector3.new(0,0,0)
			UpdateAV:FireServer(newAV, BAV)
		end
	end
end

function End()
	Sound:FireServer(false)
	script:Destroy()
	Stop:FireServer(BV, BAV)
	if player.PlayerGui.TankMobile then
		player.PlayerGui.TankMobile:Destroy()
	end
end

local X, Y = 0, 0
local PlayerModule = require(player.PlayerScripts.PlayerModule)

UserInputService.InputChanged:Connect(function(input)
	
	if input.KeyCode == Enum.KeyCode.Thumbstick1 then
		X += input.Delta.X
		Y += input.Delta.Y

		if X > .3 then
			ForwardKeyDown = false
			BackwardKeyDown = false
			RightTurnKeyDown = true
			LeftTurnKeyDown = false
			turnRight()
			
		elseif X < -.3 then
			ForwardKeyDown = false
			BackwardKeyDown = false
			RightTurnKeyDown = false
			LeftTurnKeyDown = true
			turnLeft()
			
		elseif Y > .3 then
			ForwardKeyDown = true
			BackwardKeyDown = false
			RightTurnKeyDown = false
			LeftTurnKeyDown = false
			Forward()
			
		elseif Y < -.3 then
			ForwardKeyDown = false
			BackwardKeyDown = true
			RightTurnKeyDown = false
			LeftTurnKeyDown = false
			Backwards()
			
		else
			ForwardKeyDown = false
			BackwardKeyDown = false
			RightTurnKeyDown = false
			LeftTurnKeyDown = false
		end
		
	elseif input.KeyCode == Enum.KeyCode.Thumbstick2 then
		Mouse_Move:FireServer(mouse.Hit.Position)
	end

	if UserInputService.TouchEnabled then
		local moveVector = PlayerModule:GetControls():GetMoveVector()
		
		local X, Y = moveVector.X, -moveVector.Z

		if X > .3 then
			ForwardKeyDown = false
			BackwardKeyDown = false
			RightTurnKeyDown = true
			LeftTurnKeyDown = false
			turnRight()

		elseif X < -.3 then
			ForwardKeyDown = false
			BackwardKeyDown = false
			RightTurnKeyDown = false
			LeftTurnKeyDown = true
			turnLeft()

		elseif Y > .3 then
			ForwardKeyDown = true
			BackwardKeyDown = false
			RightTurnKeyDown = false
			LeftTurnKeyDown = false
			Forward()

		elseif Y < -.3 then
			ForwardKeyDown = false
			BackwardKeyDown = true
			RightTurnKeyDown = false
			LeftTurnKeyDown = false
			Backwards()

		else
			ForwardKeyDown = false
			BackwardKeyDown = false
			RightTurnKeyDown = false
			LeftTurnKeyDown = false
		end
		
	end
	
end)

-- || player starts calling tank
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent then			
		-- Drive Forwards
		if input.KeyCode == Enum.KeyCode.W and not BackwardKeyDown then
			ForwardKeyDown = true
			Forward()

			-- Drive Backwards
		elseif input.KeyCode == Enum.KeyCode.S and not ForwardKeyDown then
			BackwardKeyDown = true
			Backwards()

			-- Turn Right
		elseif input.KeyCode == Enum.KeyCode.D and not LeftTurnKeyDown then
			RightTurnKeyDown = true
			turnRight()

			-- Turn Left
		elseif input.KeyCode == Enum.KeyCode.A and not RightTurnKeyDown then
			LeftTurnKeyDown = true
			turnLeft()
			
			-- Flip the Tank
		elseif input.KeyCode == Enum.KeyCode.Q then
			Tank.Events.Flip:FireServer(Seat)
		end
	end
end)

-- || player stops calling tank
UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent then			
		if input.KeyCode == Enum.KeyCode.W then
			ForwardKeyDown = false
		elseif input.KeyCode == Enum.KeyCode.S then
			BackwardKeyDown = false
		elseif input.KeyCode == Enum.KeyCode.D then
			RightTurnKeyDown = false
		elseif input.KeyCode == Enum.KeyCode.A then
			LeftTurnKeyDown = false
		end
	end
end)

-- || TankTurret main movement
mouse.Move:Connect(function()
	Mouse_Move:FireServer(mouse.Hit.p)
end)

mouse.Button1Down:Connect(function()
	if not UserInputService.TouchEnabled then
		Mouse_Click:FireServer()
	end
end)

-- || player died
Humanoid.Died:Connect(End)

-- || player wants to leave the tank
UserInputService.JumpRequest:Connect(End)

-- || Avoid extreme speed
while Tank do
	task.wait()
	if ActualSpeed > (MaxSpeed + 5) then
		ActualSpeed = MaxSpeed
	end
end

