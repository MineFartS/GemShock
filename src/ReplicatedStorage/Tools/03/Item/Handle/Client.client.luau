local DebrisService = game:GetService("Debris")
local tool = script.Parent.Parent
local Mouse = game.Players.LocalPlayer:GetMouse()
local CameraShakerMod = require(game.ReplicatedStorage.CameraShaker)
local Camera = workspace.CurrentCamera
local CameraShake = CameraShakerMod.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
	Camera.CFrame = Camera.CFrame * shakeCFrame
end)
CameraShake:Start()
function Recoil()
	CameraShake:Shake(CameraShakerMod.Presets.Vibration)
end
script.Parent.Parent.Activated:Connect(function()
	script.Parent.Fire:FireServer(Mouse.Hit.p)
	Recoil()
	script.Parent.Shell.shel.Enabled = true
	wait(.45)
	script.Parent.Shell.shel.Enabled = false
end)