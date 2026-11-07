
-- Damage per touch
damage = 20

local debounce = true
script.Parent.Touched:Connect(function (prt)
	if debounce and prt and prt.Parent and ((prt.Parent:IsA("Tool") and script.Parent.BurnTools.Value) or game.Players:GetPlayerFromCharacter(prt.Parent)) then
		if (prt.Parent:FindFirstChild('Humanoid') and prt.Parent.Humanoid.Health == 0) or prt:FindFirstChild('Sssh') then return end
		debounce = false
		local snd = script.Parent.Sssh:Clone()
		snd.Parent = prt
		snd.PlaybackSpeed = math.random(80,150)/100
		snd:Play()
		if prt.Parent:FindFirstChild("Humanoid") then
			prt.Parent.Humanoid:TakeDamage(damage)
		elseif prt.Parent:IsA("Tool") then
			game.Debris:AddItem(prt.Parent,.5)	
		end
		wait(.5)
		debounce = true
	end
end)