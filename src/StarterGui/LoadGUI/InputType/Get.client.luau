local Name
UIS = game.UserInputService

script.Parent.OnClientInvoke = function()
	
	local Console = UIS.GamepadEnabled
	local Mobile = UIS.TouchEnabled
	local VR = UIS.VREnabled
	local PC = (not Console) and (not Mobile) and (not VR)

	if Console then Name = 'Console' end
	if Mobile then Name = 'Mobile' end
	if VR then Name = 'VR' end
	if PC then Name = 'PC' end
	
	return Name
	
end

		