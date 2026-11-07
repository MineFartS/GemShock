--//Variables\\--
local tool = script.Parent
local handle = tool:WaitForChild("Handle")
local muzzle = tool:WaitForChild("Muzzle")
	local muzzleFlash = muzzle:WaitForChild("MuzzleFlash")
		local muzzleEffect = muzzleFlash:WaitForChild("MuzzleEffect")

local configs = tool:WaitForChild("Configurations")
	local fireRate = configs:FindFirstChild("FireRate")
	local maxDamage = configs:FindFirstChild("MaxDamage")
	local minDamage = configs:FindFirstChild("MinDamage")
	local velocity = configs:FindFirstChild("Velocity")
	local accuracy = configs:FindFirstChild("Accuracy")
	local specialDuration = configs:FindFirstChild("SpecialDuration")
	local specialRechargeTime = configs:FindFirstChild("SpecialRechargeTime")

local showDamageText = true

local debris = game:GetService("Debris")

local fire = tool:WaitForChild("Fire")
local activateSpecial = tool:WaitForChild("ActivateSpecial")
local hit = tool:WaitForChild("Hit")

--//Custom Functions\\--
function TagHumanoid(humanoid, player)
	local Creator_Tag = Instance.new("ObjectValue")
	Creator_Tag.Name = "creator"
	Creator_Tag.Value = player
	debris:AddItem(Creator_Tag, 0.3)
	Creator_Tag.Parent = humanoid
end

function UntagHumanoid(humanoid)
	for i, v in pairs(humanoid:GetChildren()) do
		if v:IsA("ObjectValue") and v.Name == "creator" then
			v:Destroy()
		end
	end
end

function TextEffects(element, floatAmount, direction, style, duration)
	element:TweenPosition(UDim2.new(0, math.random(-40, 40), 0, -floatAmount), direction, style, duration)
	wait(0.5)

	for i = 1, 60 do
		element.TextTransparency = element.TextTransparency + 1/60
		element.TextStrokeTransparency = element.TextStrokeTransparency + 1/60
		wait(1/60)
	end

	element.TextTransparency = element.TextTransparency + 1
	element.TextStrokeTransparency = element.TextStrokeTransparency + 1
	element.Parent:Destroy()
end

function DynamicText(damage, criticalPoint, humanoid)
	local bill = Instance.new("BillboardGui", humanoid.Parent.Head)
	bill.Size = UDim2.new(0, 50, 0, 100) 
	local part = Instance.new("TextLabel", bill) 
	bill.AlwaysOnTop = true
	part.TextColor3 = Color3.fromRGB(255, 0, 0)
	part.Text = damage
	part.Font = Enum.Font.SourceSans
	part.TextStrokeTransparency = 0
	part.Size = UDim2.new(1, 0, 1, 0) 
	part.Position = UDim2.new(0, 0, 0, 0) 
	part.BackgroundTransparency = 1
	bill.Adornee = bill.Parent
			
	if damage < criticalPoint then
		part.TextSize = 28
		part.TextColor3 = Color3.new(1, 0, 0)
	elseif damage >= criticalPoint then
		part.TextSize = 32
		part.TextColor3 = Color3.new(1, 1, 0)
	end 
	
	spawn(function()
		TextEffects(part, 85, Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.75)
	end)
end

function DamageAndTagHumanoid(player, humanoid, damage)
	hit:FireClient(player)
	UntagHumanoid(handle)
	humanoid:TakeDamage(damage) TagHumanoid(humanoid, player)
end

--//Remote Functions\\--
fire.OnServerEvent:Connect(function(player, mouseHit)
	local character = player.Character
	local humanoid = character:FindFirstChild("Humanoid")
	local weaponAccuracy = Vector3.new(math.random(-accuracy.Value * 2, accuracy.Value * 2), math.random(-accuracy.Value * 2, accuracy.Value * 2), math.random(-accuracy.Value * 2, accuracy.Value * 2))
	
	if humanoid and humanoid ~= 0 then
		local projectile = Instance.new("Part", workspace)
		
			local trail = Instance.new("Trail", projectile)
			trail.FaceCamera = true
			trail.Lifetime = 0.3
			trail.MinLength = 0.15	
			trail.LightEmission = 0.25
						
			local attachment0 = Instance.new("Attachment", projectile)
			attachment0.Position = Vector3.new(0.35, 0, 0)
			attachment0.Name = "Attachment1"
			local attachment1 = Instance.new("Attachment", projectile)
			attachment1.Position = Vector3.new(-0.35, 0, 0)
			attachment1.Name = "Attachment1"
			
			trail.Attachment0 = attachment0
			trail.Attachment1 = attachment1
			
		projectile.Name = "Bullet"
		projectile.BrickColor = BrickColor.new("Smoky gray")
		projectile.Shape = "Ball"
		projectile.Material = Enum.Material.Metal
		projectile.TopSurface = 0
		projectile.BottomSurface = 0
		projectile.Size = Vector3.new(1, 1, 1)	
		projectile.Transparency = 1
		projectile.CFrame = CFrame.new(muzzle.CFrame.p, mouseHit.p)
		projectile.CanCollide = false

			local transparencyPoints = {}
			local startColor = Color3.new(255, 255, 0)
			local endColor = Color3.new(213, 115, 61)
			
			table.insert(transparencyPoints, NumberSequenceKeypoint.new(0, 1))
			table.insert(transparencyPoints, NumberSequenceKeypoint.new(0.25, 0))
			table.insert(transparencyPoints, NumberSequenceKeypoint.new(1, 1))
			
			local determinedTransparency = NumberSequence.new(transparencyPoints)
			local determinedColors = ColorSequence.new(startColor, endColor)
			
			trail.Transparency = determinedTransparency
			trail.Color = determinedColors
		
			local bodyVelocity = Instance.new("BodyVelocity", projectile)
			bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			bodyVelocity.Velocity = (mouseHit.lookVector * velocity.Value) + weaponAccuracy
			
		debris:AddItem(projectile, 20)
		
		projectile.Touched:Connect(function(hit)
			local eHumanoid = hit.Parent:FindFirstChild("Humanoid") or hit.Parent.Parent:FindFirstChild("Humanoid")
			local damage = math.random(minDamage.Value, maxDamage.Value)
			if not eHumanoid and not hit.Anchored and not hit:IsDescendantOf(character) then
				
				projectile:Destroy()
			elseif eHumanoid and eHumanoid ~= humanoid and eHumanoid.Health > 0 and hit ~= projectile then
				
				if hit.Name == "Head" or hit:IsA("Hat") then
					damage = damage * 10.5
				end
				
				local criticalPoint = maxDamage.Value
				DamageAndTagHumanoid(player, eHumanoid, damage) 
				
				if showDamageText then
					DynamicText(damage, criticalPoint, eHumanoid)
				else
				end
				
				projectile:Destroy()
			elseif hit.CanCollide == true and not hit:IsDescendantOf(player.Character) and hit.Anchored == true then
		
				projectile:Destroy()
			end
		end)
		
		handle.Fire:Play()
		muzzleEffect.Visible = true
		muzzleEffect.Rotation = math.random(-360, 360)
		
		delay(0.1, function()
			muzzleEffect.Visible = false
		end)
		
	end
end)

activateSpecial.OnServerEvent:Connect(function(player)
	accuracy.Value, fireRate.Value = accuracy.Value / 2, fireRate.Value / 2
	minDamage.Value, maxDamage.Value = minDamage.Value / 2, maxDamage.Value / 2
	
	spawn(function()
		local chargeSound = Instance.new("Sound", player.PlayerGui)
		chargeSound.Name = "ChargeSound"
		chargeSound.SoundId = "rbxassetid://163619849"
		chargeSound:Play()
		
		chargeSound.Ended:Connect(function() chargeSound:Destroy() end)
		
		local sparkles = Instance.new("Sparkles", handle)
		sparkles.SparkleColor = Color3.fromRGB(255, 236, 21)
		
		local activatedGui = Instance.new("ScreenGui", player.PlayerGui)
		activatedGui.Name = "SpecialActivated"
			local textLabel = Instance.new("TextLabel", activatedGui) 
			textLabel.TextColor3 = Color3.fromRGB(0, 180, 30)
			textLabel.Text = "Trigger Happy activated!"
			textLabel.Font = Enum.Font.SourceSans
			textLabel.TextScaled = true
			textLabel.TextStrokeTransparency = 0
			textLabel.Size = UDim2.new(0, 300, 0, 50) 
			textLabel.Position = UDim2.new(2.5, 0, 0.15, -10) 
			textLabel.BackgroundTransparency = 1
			textLabel:TweenPosition(UDim2.new(0.5, -(textLabel.Size.X.Offset / 2),  0.1, -10), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 1)
		
		debris:AddItem(sparkles, specialDuration.Value)
		debris:AddItem(chargeSound, 3)
		
		wait(3)
		TextEffects(textLabel, 200, Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 1)
	end)
	
	for i = specialDuration.Value, 0, -1 do
		wait(1)
		print("Special activated: "..i)
	end
	
	accuracy.Value, fireRate.Value = accuracy.Value * 5, fireRate.Value * 10
	minDamage.Value, maxDamage.Value = minDamage.Value * 4, maxDamage.Value * 8
	activateSpecial:FireClient(player)
end)