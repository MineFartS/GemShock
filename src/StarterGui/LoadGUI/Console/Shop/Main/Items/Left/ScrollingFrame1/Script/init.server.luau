local frames = script.Parent

while script.Parent.Parent.Parent.Parent.Parent.Parent.Parent:IsA('Script') do
	wait(.01)
end

for _, Tool in ipairs(game.ReplicatedStorage.Tools:GetChildren()) do
	if Tool:IsA('Folder') then
		local frame = script.Frame:Clone()
		frame.Name = Tool.Name
		frame.Parent = frames
		frame.Script.Enabled = true
	end
end