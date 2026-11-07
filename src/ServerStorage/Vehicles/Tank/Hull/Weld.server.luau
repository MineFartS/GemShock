local Tank = script.Parent.Parent
local DriverSeat = Tank.DriverSeat

for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("BasePart") or v:IsA("UnionOperation") and v ~= DriverSeat then
		local weld = Instance.new("Weld")
		weld.Name = "Sanctioned"
		
		weld.C0 = DriverSeat.CFrame:inverse() * v.CFrame
		
		weld.Part0 = DriverSeat
		weld.Part1 = v
		
		weld.Parent = DriverSeat
	elseif v:IsA("Model") then
		for o,b in pairs(v:GetChildren()) do
			local weld = Instance.new("Weld")
			weld.Name = "Sanctioned"
			
			weld.C0 = DriverSeat.CFrame:inverse() * b.CFrame
		
			weld.Part0 = DriverSeat
			weld.Part1 = b
			
			weld.Parent = DriverSeat
		end
	end
end