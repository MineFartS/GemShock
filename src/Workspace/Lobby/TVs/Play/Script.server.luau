Videos = {
	'rbxassetid://5670809466',
	'rbxassetid://5608285055',
	'rbxassetid://5608359401',
	'rbxassetid://5670802294',
	'rbxassetid://5608281849',
	'rbxassetid://5608304953',
	'rbxassetid://5608327482'
}

script.Parent.Event:Connect(function()
	local Video = Videos[math.random(1, #Videos)]
	
	script.Parent.Parent.A.Screen.SurfaceGui.Frame.Video.Video = Video	
	
	script.Parent.Parent.B.Screen.SurfaceGui.Frame.Video.Video = Video	
end)