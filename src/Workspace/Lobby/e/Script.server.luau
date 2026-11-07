model = script.Parent

while true do
	rotation = CFrame.Angles(math.rad(.5), 0, 0)
	modelCFrame = model:GetPivot()
	model:PivotTo(modelCFrame * rotation)
	wait(.005)
end