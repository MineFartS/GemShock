Tool = script.Parent
Remote = Tool:WaitForChild("MouseLoc")
Mouse = game.Players.LocalPlayer:GetMouse()

function Remote.OnClientInvoke()
	return Mouse.Hit.p
end

local function UpdateIcon(...)
	if Tool.Enabled == true then
		Mouse.Icon = 'rbxasset://textures/GunCursor.png'
	else
		Mouse.Icon = 'rbxasset://textures/GunWaitCursor.png'
	end
end

Tool.Equipped:Connect(UpdateIcon)
Tool.Changed:Connect(UpdateIcon)
