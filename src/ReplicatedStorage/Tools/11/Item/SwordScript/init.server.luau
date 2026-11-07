--Stickmasterluke


sp=script.Parent


r=game:service("RunService")
debris=game:GetService("Debris")

anims={"RightSlash","LeftSlash","LeftSwingFast","RightSwingFast","OverHeadSwing"}

sword=sp.Handle


local UnsheathSound=Instance.new("Sound")
UnsheathSound.SoundId="rbxasset://sounds\\unsheath.wav"
UnsheathSound.Parent=sword
UnsheathSound.Volume=.5

function waitfor(parent,name)
	while true do
		local child=parent:FindFirstChild(name)
		if child~=nil then
			return child
		end
		wait()
	end
end
waitfor(sp,"RunAnim")

local debounce = false
function blow(hit)
	if not debounce then
		debounce = true
		if hit.Parent~=nil then
			local humanoid=hit.Parent:findFirstChild("Humanoid")
			local vCharacter=sp.Parent
			if vCharacter~=nil and humanoid then
				local vPlayer=game.Players:GetPlayerFromCharacter(vCharacter)
				if vPlayer~=nil then
					local hum=vCharacter:findFirstChild("Humanoid")
					if hum~=nil and humanoid~=hum and hum.Health>0 and not game.Players:GetPlayerFromCharacter(hit.Parent) then
						local right_arm=vCharacter:FindFirstChild("Right Arm")
						if right_arm~=nil then
							local joint=right_arm:FindFirstChild("RightGrip")
							if joint~=nil and (joint.Part0==sword or joint.Part1==sword) then
								tagHumanoid(humanoid,vPlayer)
							end
						end
					end
				end
			end
		end
		wait(0.5)
		debounce = false
	end
end


function tagHumanoid(humanoid,player)
	for i,v in ipairs(humanoid:GetChildren()) do
		if v.Name=="creator" then
			v:remove()
		end
	end
	local creator_tag=Instance.new("ObjectValue")
	creator_tag.Value=player
	creator_tag.Name="creator"
	creator_tag.Parent=humanoid
	debris:AddItem(creator_tag,1)
end

sp.Enabled=true
function onActivated()
	if sp.Enabled then
		sp.Enabled=false
		local character=sp.Parent
		local humanoid=character:FindFirstChildOfClass("Humanoid")
		if humanoid==nil then
			print("Humanoid not found")
			return 
		end
		humanoid.WalkSpeed = 300
		newanim=anims[math.random(1,#anims)]
		while newanim==sp.RunAnim.Value do
			newanim=anims[math.random(1,#anims)]
		end
		sp.RunAnim.Value=newanim
		coroutine.resume(coroutine.create(function()
			for x = 1, 10 do
				wait()
				local attack = Instance.new("Part")
				attack.Shape = Enum.PartType.Ball
				attack.Size = Vector3.new(6, 6, 6)
				attack.Color = Color3.fromRGB(255, 100, 0)
				attack.Material = "Neon"
				attack.Transparency = 0.3
				attack.CanCollide = false
				attack.Massless = true
				attack.Anchored = true
				attack.Position = sword.Position
				attack.Parent = game.Workspace

				game.Debris:AddItem(attack, 0.6)

				local Change = {
					Transparency = 0.9,
					Size = Vector3.new(60, 60, 60)
				}

				local PartSlideInfo = TweenInfo.new(
					0.5, --- Time to tween from position to position
					Enum.EasingStyle.Sine, 
					Enum.EasingDirection.Out, 
					0, --- Times repeated
					false, --- Reverse the tween or not
					0 --- Delay time
				)

				local PartSlideTween = game.TweenService:Create(attack, PartSlideInfo, Change)

				PartSlideTween:Play()

				local damageScript = script.MainAttackDamage:Clone()
				damageScript.Parent = attack
				damageScript.Owner.Value = character
				damageScript.Enabled = true
				wait(0.06)
			end
		end))
		if newanim=="OverHeadSwing" then
			wait(.2)
		end
		wait(.6)
		humanoid.WalkSpeed = 100
		sp.Enabled=true
	end
end

function onEquipped()
	UnsheathSound:play()
end

sp.Equipped:connect(onEquipped)
sp.Activated:connect(onActivated)

connection=sword.Touched:connect(blow)


