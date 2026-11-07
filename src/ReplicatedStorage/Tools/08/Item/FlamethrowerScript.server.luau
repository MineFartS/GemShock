
local Tool = script.Parent
local ToolHandle = Tool:WaitForChild("Handle")

local ShootSound = ToolHandle:WaitForChild("ShootSound")
local FireSound = ToolHandle:WaitForChild("FireSound")
local StopShootingSound = ToolHandle:WaitForChild("StopShootingSound")

local FireAttachment = ToolHandle:WaitForChild("FireAttachment")

local FireEffect = FireAttachment:WaitForChild("Fire")
local FireLight = FireAttachment:WaitForChild("FireLight")
local FireCollider = FireAttachment:WaitForChild("Collider")

local FireDamageScript = FireCollider:WaitForChild("FireDamageScript")

local Configuration = Tool:WaitForChild("Configurations")
local ReloadTime = Configuration:WaitForChild("ReloadTime")
local ColliderSize = Configuration:WaitForChild("ColliderSize")

FireCollider.Size = ColliderSize.Value

local Shooting = false
function OnActivated()
	
	if Tool.Enabled and Shooting == false then
		
		ShootSound:Play()

		while ShootSound.IsPlaying do
			wait()
		end
		
		Shooting = true
		
		FireSound:Play()

		FireEffect.Enabled = true
		FireLight.Enabled = true
		FireCollider.CanTouch = true
		
		
		
	end
end

function Deactivate()
	
	if Shooting == true then
		
		Tool.Enabled = false
		
		FireSound:Stop()

		FireEffect.Enabled = false
		FireLight.Enabled = false
		FireCollider.CanTouch = false
		Shooting = false
		
		StopShootingSound:Play()

		wait(ReloadTime.Value)
		
		Tool.Enabled = true
		
	end
end

Tool.Unequipped:Connect(Deactivate)
Tool.Deactivated:Connect(Deactivate)
Tool.Activated:Connect(OnActivated)