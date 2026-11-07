script.Parent:WaitForChild("Radio")
script.Parent:WaitForChild("Seat")
wait(1)
local radio = script.Parent.Radio.Value
local gui = script.Parent.Draggable
local seat = script.Parent.Seat.Value
seat.ChildRemoved:connect(function(child)
	if child.Name == "SeatWeld" then script.Parent:Destroy() end
end)
local vol = gui.VolumeControl
vol.TextLabel.Text = ("Volume: "..(radio.Volume.Value*50).."%")
radio.Volume.Changed:connect(function()
	vol.TextLabel.Text = ("Volume: "..(radio.Volume.Value*50).."%")
end)
vol.Up.MouseButton1Click:connect(function()
	radio.Volume.Value = math.min(radio.Volume.Value+.5,50)
end)
vol.Down.MouseButton1Click:connect(function()
	radio.Volume.Value = math.max(radio.Volume.Value-.5,0)
end)
------------------------------------------
local pit = gui.PitchControl
pit.TextLabel.Text = ("Pitch: "..(radio.Pitch.Value*50).."%")
radio.Pitch.Changed:connect(function()
	pit.TextLabel.Text = ("Pitch: "..(radio.Pitch.Value*50).."%")
end)
pit.Up.MouseButton1Click:connect(function()
	radio.Pitch.Value = math.min(radio.Pitch.Value+.5,300)
end)
pit.Down.MouseButton1Click:connect(function()
	radio.Pitch.Value = math.max(radio.Pitch.Value-.5,0)
end)
------------------------------------------
gui.Track.Text = radio.TName.Value
radio.TName.Changed:connect(function()
	gui.Track.Text = radio.TName.Value
end)
gui.Stop.MouseButton1Click:connect(function()
	if radio.Stopped.Value == false then
		radio.Stopped.Value = true
	end
end)
gui.Pause.MouseButton1Click:connect(function()
	if radio.Paused.Value == false and radio.Stopped.Value == false then
		radio.Paused.Value = true
	end
end)
gui.Play.MouseButton1Click:connect(function()
	if radio.Stopped.Value == true then
		radio.Play.Value = not radio.Play.Value
	else
		if radio.Paused.Value == true then
			radio.Paused.Value = false
		end
	end
end)
gui.Forward.MouseButton1Click:connect(function()
	local n = radio.Track.Value+1
	if n>#radio.Songs:GetChildren() then
		n = 1
	end
	radio.Track.Value = n
end)
gui.Back.MouseButton1Click:connect(function()
	local n = radio.Track.Value-1
	if n<=0 then
		n = #radio.Songs:GetChildren()
	end
	radio.Track.Value = n
end)
gui.AutoplayOn.MouseButton1Click:connect(function()
	if radio.Autoplay.Value == true then
		radio.Autoplay.Value = false
	end
end)
gui.AutoplayOff.MouseButton1Click:connect(function()
	if radio.Autoplay.Value == false then
		radio.Autoplay.Value = true
	end
end)
gui.List.MouseButton1Click:connect(function()
	gui.Menu.Visible=not gui.Menu.Visible
end)
gui.Id.MouseButton1Click:connect(function()
	gui.IdPlayer.Visible=not gui.IdPlayer.Visible
	if gui.IdPlayer.Visible then gui.Id.Rotation=180 else gui.Id.Rotation=0 end
end)
gui.IdPlayer.Play.MouseButton1Click:connect(function()
	if radio.IdPlay.Value==gui.IdPlayer.TextBox.Text then
		radio.IdPlay.Value=""
	wait()
	end
	radio.IdPlay.Value=gui.IdPlayer.TextBox.Text
end)
for i,v in pairs(gui.Menu:GetChildren()) do
	v.MouseButton1Click:connect(function()
		radio.Track.Value = i
	end)
end
function Stopped()
	if radio.Stopped.Value == true then
		gui.Pause.Visible = false
		gui.Play.Visible = true
	else
		gui.Play.Visible = false
		gui.Pause.Visible = true
	end
end
function Paused()
	if radio.Paused.Value == true then
		gui.Pause.Visible = false
		gui.Play.Visible = true
	else
		if radio.Stopped.Value == false then
			gui.Play.Visible = false
			gui.Pause.Visible = true
		end
	end
end
function Autoplay()
	if radio.Autoplay.Value == true then
		gui.AutoplayOff.Visible = false
		gui.AutoplayOn.Visible = true
	else
		gui.AutoplayOn.Visible = false
		gui.AutoplayOff.Visible = true
	end
end
radio.Stopped.Changed:connect(Stopped)
radio.Paused.Changed:connect(Paused)
radio.Autoplay.Changed:connect(Autoplay)
Stopped()
Paused()
Autoplay()
while wait(.5) do
	if seat:FindFirstChild("SeatWeld") == nil then
		script.Parent:Destroy()
	end
end