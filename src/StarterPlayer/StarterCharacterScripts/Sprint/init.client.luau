Player = game.Players.LocalPlayer

-- Get Platform	
Console = game.UserInputService.GamepadEnabled
Mobile = game.UserInputService.TouchEnabled
VR = game.UserInputService.VREnabled
PC = (not Console) and (not Mobile) and (not VR)

-- Reset Mouse Icon
Player:GetMouse().Icon = ""

if Console then Name = 'Console' end
if Mobile then Name = 'Mobile' end
if VR then Name = 'VR' end
if PC then Name = 'PC' end

if script:FindFirstChild(Name) then
	script:WaitForChild(Name):Clone().Parent = Player.Character
end

script:Destroy()