
local Fire = script.Parent

local Damage = Fire:WaitForChild("DamageLocator")
local CDelay = Fire:WaitForChild("DelayLocator")

local Damaged = false
Fire.Touched:Connect(function(hit)
	
	local Humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
	
	if Damaged == false and Humanoid and Humanoid.Health > 0 then
		
		Damaged = true
		
		Humanoid.Health = Humanoid.Health - Damage.Value.Value
		
		wait(CDelay.Value.Value)
		
		Damaged = false
		
	end
end)