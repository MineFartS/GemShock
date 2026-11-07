--[[
		___      _______                _     
	   / _ |____/ ___/ /  ___ ____ ___ (_)__ 
	  / __ /___/ /__/ _ \/ _ `(_-<(_-</ (_-<
	 /_/ |_|   \___/_//_/\_,_/___/___/_/___/
 						SecondLogic @ Inspare
]]


local autoscaling	= false					--Estimates top speed

local UNITS	= {								--Click on speed to change units
											--First unit is default	
	{
		units			= "MPH"				,
		scaling			= (10/12) * (60/88)	, -- 1 stud : 10 inches | ft/s to MPH
		maxSpeed		= 250				,
		spInc			= 20				, -- Increment between labelled notches
	},
	
	{
		units			= "KM/H"			,
		scaling			= (10/12) * 1.09728	, -- 1 stud : 10 inches | ft/s to KP/H
		maxSpeed		= 240				,
		spInc			= 20				, -- Increment between labelled notches
	},
	
	{
		units			= "SPS"				,
		scaling			= 1					, -- Roblox standard
		maxSpeed		= 300				,
		spInc			= 60				, -- Increment between labelled notches
	}
}

-----------------------------------------------------------------------------------------------

script.Parent:WaitForChild("Gear")
script.Parent:WaitForChild("Speed")
script.Parent:WaitForChild("Needle")

local player=game.Players.LocalPlayer
local mouse=player:GetMouse()

local car = script.Parent.Parent.Parent.Car.Value
car.DriveSeat.HeadsUpDisplay = false

local _Tune = require(car["A-Chassis Tune"])

local _pRPM = _Tune.PeakRPM
local _lRPM = _Tune.Redline

local currentUnits = 1
local revEnd = math.ceil(_lRPM/1000)

script.Parent.Parent.Parent.Values.Gear.Changed:connect(function()
	local gearText = script.Parent.Parent.Parent.Values.Gear.Value
	if gearText == 0 then gearText = "N"
	elseif gearText == -1 then gearText = "R"
	end
	script.Parent.Gear.Text = gearText
end)

script.Parent.Parent.Parent.Values.RPM.Changed:connect(function()
	script.Parent.Needle.Rotation = 230 * math.min(1,script.Parent.Parent.Parent.Values.RPM.Value / (revEnd*1000))
end)

script.Parent.Parent.Parent.Values.Velocity.Changed:connect(function(property)
	script.Parent.Speed.Text = math.floor(UNITS[currentUnits].scaling*script.Parent.Parent.Parent.Values.Velocity.Value.Magnitude)
end)

script.Parent.Speed.MouseButton1Click:connect(function()
	if currentUnits==#UNITS then
		currentUnits = 1
	else
		currentUnits = currentUnits+1
	end
	script.Parent.Speed.Text = math.floor(UNITS[currentUnits].scaling*script.Parent.Parent.Parent.Values.Velocity.Value.Magnitude)
	script.Parent.Unit.Text = UNITS[currentUnits].units
end)

wait(.1)
