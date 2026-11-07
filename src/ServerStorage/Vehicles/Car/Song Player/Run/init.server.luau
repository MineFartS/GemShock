function MakeWeld(x,y)
	local W = Instance.new("Weld")
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end
local weld=false
local nseats=0
for i,v in pairs(script.Parent.Parent:GetChildren()) do
	if v:IsA("VehicleSeat") or v:IsA("Seat") then
		if not weld then
			weld=true
			MakeWeld(script.Parent,v)
			script.Parent.Anchored=false
		end
		nseats=nseats+1
		v.ChildAdded:connect(function(child)
			if child.Name == "SeatWeld" then
				local player = game.Players:GetPlayerFromCharacter(child.Part1.Parent)
				if player ~= nil then
					local gui = script.RadioGui:Clone()
					gui.Radio.Value = script.Parent
					gui.Seat.Value = v
					gui.Parent = player.PlayerGui
					wait()
					gui.LocalScript.Disabled = false
				end
			end
		end)
	end
end
if nseats==0 then script.Parent:Destroy() end
wait(3)
local content = game:GetService("ContentProvider")
local trashcan = game:GetService("Debris")
local songs = script.Parent.Songs:GetChildren()
local debounce = false
script.Parent.Volume.Changed:connect(function()
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Sound") then v.Volume = script.Parent.Volume.Value/10 end
	end
end)
--------------------------
script.Parent.Pitch.Changed:connect(function()
	for i,v in pairs(script.Parent:GetChildren()) do
		if v:IsA("Sound") then v.Pitch = script.Parent.Pitch.Value/10 end
	end
end)
--------------------------
script.Parent.Paused.Changed:connect(function()
	if script.Parent.Paused.Value == true then
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("Sound") then v.Looped = true v:Pause() end
		end
	else
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("Sound") then 
				if script.Parent.Stopped.Value ~= true then
					v:Play() 
				end
				v.Looped = false
			end
		end
	end
end)
script.Parent.Stopped.Changed:connect(function()
	if script.Parent.Stopped.Value == true then
		script.Parent.Paused.Value = false
		for i,v in pairs(script.Parent:GetChildren()) do
			if v:IsA("Sound") then v:Stop() wait() v:Destroy() end
		end
	end
end)
script.Parent.Track.Changed:connect(function()
	if debounce == false then
	debounce = true
	local song = songs[script.Parent.Track.Value]
	script.Parent.TName.Value =  song.Name
	if script.Parent.Stopped.Value ~= true then
		script.Parent.Stopped.Value = true
		wait()
		script.Parent.Play.Value = not script.Parent.Play.Value
	end
	debounce = false
	end
end)
script.Parent.IdPlay.Changed:connect(function()
	if script.Parent.IdPlay.Value~="" then
		script.Parent.Stopped.Value=true
		local sound = Instance.new("Sound",script.Parent)
		sound.SoundId = "http://www.roblox.com/asset/?id="..script.Parent.IdPlay.Value
		sound.Volume = script.Parent.Volume.Value/10
		sound.Pitch = 1
		sound.Looped=true
		script.Parent.TName.Value=game:GetService("MarketplaceService"):GetProductInfo(script.Parent.IdPlay.Value).Name
		wait()
		script.Parent.Stopped.Value=false
		sound:Play()
	end
end)
local rgui=script.RadioGui.Draggable.Menu
rgui.CanvasSize=UDim2.new(0,0,0,15*#songs)
for i,v in pairs(songs) do
	for b,a in pairs(v:GetChildren()) do
		content:Preload(a.Id.Value)
	end
	local button=Instance.new("TextButton",rgui)
	button.Name=v.Name
	button.Size=UDim2.new(1,0,0,15)
	button.Position=UDim2.new(0,5,0,(i-1)*15)
	button.BackgroundTransparency=1
	button.Text=v.Name
	button.TextColor3=Color3.new(1,1,1)
	button.FontSize=Enum.FontSize.Size10
	button.TextXAlignment=Enum.TextXAlignment.Left
end
function play()
	script.Parent.Stopped.Value = false 
	script.Parent.Paused.Value = false
	local song = songs[script.Parent.Track.Value]
	script.Parent.TName.Value =  song.Name
	local playing = {}
	for i,v in pairs(song:GetChildren()) do
		local sound = Instance.new("Sound",script.Parent)
		sound.Name = v.Name
		sound.SoundId = v.Id.Value
		sound.Volume = 0
		sound.Pitch = 0
		table.insert(playing,sound)
	end
	wait()
	for i,v in pairs(song:GetChildren()) do
		if script.Parent.Stopped.Value ~= true then
			local a = playing[i]
			a:Stop()
			a.Pitch = v.Pitch.Value
			a.Volume = script.Parent.Volume.Value/10
			local dur = v.Duration.Value
			a:Play()
			local t = tick()
			local run = tick()-t
			repeat wait(0.001)
				if script.Parent.Paused.Value == true then
					t = tick()-run
				else
					run = tick()-t
				end
			until run >= dur or script.Parent.Stopped.Value == true
			a:Stop()
			a:Destroy()
		end
	end
	if script.Parent.Stopped.Value ~= true then
		if script.Parent.Autoplay.Value == true then
			local n = script.Parent.Track.Value+1
			if n > #songs then
				n = 1
			end	
			script.Parent.Track.Value = n
		else
			script.Parent.Stopped.Value = true
		end
	end
end
script.Parent.Play.Changed:connect(function() play() end)
