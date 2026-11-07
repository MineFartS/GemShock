rf = script.Parent:WaitForChild("rf") -- also by a_tophat
new = Instance.new
mainorb = script.Parent.Model.Shine
threshold = 100
function talk(ins,say,last)
	local bill = new("BillboardGui")
	bill.StudsOffsetWorldSpace = Vector3.new(0,3,0)
	bill.Size = UDim2.new(10,0,2,0)
	bill.Adornee = ins
	bill.ClipsDescendants = true
	local text = new("TextLabel")
	text.BackgroundTransparency = 1
	text.Font = Enum.Font.ArialBold
	text.TextStrokeTransparency = 0
	text.TextStrokeColor3 = Color3.fromRGB(255,255,255)
	text.TextSize = 30
	text.TextScaled = true
	text.Text = say
	text.Size = UDim2.new(1,0,1,0)
	text.Parent = bill
	bill.Parent = ins
	game:GetService("Debris"):AddItem(bill,last)
end
script.Parent.Equipped:Connect(function()
	chr = script.Parent.Parent
	local hum = chr:FindFirstChildOfClass("Humanoid")
	prevwalkspeed = hum.WalkSpeed
	hum.WalkSpeed = 32
	--talk(chr.Head,"Feel my wrath!",4)
end)
script.Parent.Unequipped:Connect(function()
	workspace:FindFirstChild(chr.Name.."parts"):Destroy()
	local billboard = chr.Head:FindFirstChild("BillboardGui")
	if billboard ~= nil then 
		billboard:Destroy()
	end
	local hum = chr:FindFirstChildOfClass("Humanoid")
	hum.WalkSpeed = prevwalkspeed
end)
rf.OnServerInvoke = function(p,hit)
	if workspace:FindFirstChild(p.Name.."parts") == nil then
		partz = new("Folder")
		partz.Name = p.Name.."parts"
		partz.Parent = workspace
	end
	local chr = p.Character
	local hum = chr:FindFirstChildOfClass("Humanoid")
	
	local mouseunit = (hit.p-mainorb.Position).Unit*50
	local cast = Ray.new(mainorb.Position,mouseunit)
	local nah,pos = workspace:FindPartOnRay(cast,chr)
	local torso = chr:FindFirstChild("Torso")
	local coolbeam = new("Part")
	coolbeam.Shape = Enum.PartType.Cylinder
	coolbeam.Anchored = true
	coolbeam.Color = Color3.fromRGB(107, 43, 160)
	coolbeam.CanCollide = false
	coolbeam.Transparency = 0.6
	local distance = (mainorb.Position - pos).magnitude
	coolbeam.Size = Vector3.new(distance,1.5,1.5)
	coolbeam.CFrame = CFrame.new(mainorb.Position, pos)*CFrame.Angles(0,math.rad(90),0) * CFrame.new(distance / 2, 0,0) 
	local sung = new("Sound")
	sung.SoundId = 'rbxassetid://'..75992638
	sung.Volume = 5
	local coh = new("Part")
	sung.Parent = coh
	coh.Anchored = true
	coh.Position = pos
	coh.Color = Color3.fromRGB(107, 43, 160)--outter ring 164, 75, 237
	coh.Shape = Enum.PartType.Ball
	local rad = coh:Clone()
	coolbeam.Parent = coh
	script.Parent.fire:Play()
	game:GetService("Debris"):AddItem(coolbeam,0.2)
	sung:Play()
	rad.Color = Color3.fromRGB(164, 75, 237)
	rad.CanCollide = false
	rad.Material = Enum.Material.ForceField
	rad.Transparency = 0.8
	rad.Size = rad.Size *1.5
	rad.Parent = coh
	coh.Parent = partz
	--game:GetService("Debris"):AddItem(coh,10)
	--[[local function checkpart(part,ignore)
	local newtab = {}
	local pass = true	
		for o,p in pairs(ignore) do
			if part == p or part:IsDescendantOf(p) then
				pass = false
				end
		if pass == true then
			--if v:IsA("BasePart") then
				if part.Locked == false or part.Anchored == false then
				--	if (v.Position-rad.Position).Magnitude < threshold then
				table.insert(newtab,1,part)
			--	end
			--	end
		end
		end
	end
	return newtab
	end]]
	allparts = {}
	local hitter = new('Explosion')

	hitter.BlastRadius = threshold
	hitter.BlastPressure = 0
	hitter.DestroyJointRadiusPercent = 0
	hitter.ExplosionType = Enum.ExplosionType.NoCraters
	hitter.Visible = false
	hitter.Position = pos
	hitter.Hit:Connect(function(h)
		if h ~= rad and h ~= coh and h ~= coolbeam and h:IsDescendantOf(chr) == false then
		table.insert(allparts,1,h)
		h.Parent = partz
						h.CanCollide = false
						h.Anchored = true
						h:BreakJoints()
						game.TweenService:Create(h,TweenInfo.new((rad.Position-h.Position).Magnitude/20,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{CFrame = CFrame.new(rad.Position)}):Play()
						delay(100,function()
							h:Destroy()
						end)
						while h.Parent ~= nil do -- and coh.Parent ~= nil do just let desinity do its thing
							--h.CFrame = CFrame.new(h.Position+(rad.Position-h.Position).Unit*4)
							--conform.Position = rad.Position
							if (h.Position-rad.Position).Magnitude < 2 then
								h:Destroy()
							end
							wait()
					end
					end
	end)
	hitter.Parent = workspace
	
	
	--[[for i,v in pairs(allparts) do
		print(i)
		print(v)
				--if (v.Position-rad.Position).Magnitude < threshold then
					v.Parent = partz
					spawn(function()
						v.CanCollide = false
						v.Anchored = true
						v:BreakJoints()
						while v.Parent ~= nil do -- and coh.Parent ~= nil do just let desinity do its thing
							v.CFrame = CFrame.new(v.Position+(rad.Position-v.Position).Unit*3)
							--conform.Position = rad.Position
							if (v.Position-rad.Position).Magnitude < 2 then
								v:Destroy()
							end
							wait()
						end
						if v.Parent ~= nil then
							conform:Destroy()
							--v.Anchored = false 
						end
						end)
		--end
				end]]
					local function cleanup()
						partz:Destroy()
					end
					local function leaveclean(plr)
						if plr == game.Players:GetPlayerFromCharacter(hum.Parent) then
							partz:Destroy()
						end
					end
					local deathclean = hum.Died:Connect(cleanup)
					local leaveclean = game.Players.PlayerRemoving:Connect(leaveclean)
					repeat
					wait()
					for o,p in pairs(allparts) do
						if p.Parent == nil then
							table.remove(allparts,o)
						end
					end
					until #allparts == 0
	--repeat wait(1) until coh.Parent == nil
	coh:Destroy()
	deathclean:Disconnect()
	leaveclean:Disconnect()
end
