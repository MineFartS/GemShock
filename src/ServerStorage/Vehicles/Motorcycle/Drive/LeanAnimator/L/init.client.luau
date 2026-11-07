script:WaitForChild("Seat")
local C=game.Players.LocalPlayer.Character
local S=script.Seat.Value
local A=C.Animate
local WS={}
local HW={}

local LeanIn={
CFrame.new(-0.00961112976, 2.96485901, 0.00453150272, 0.999920249, -0.00497492962, -0.0116003798, 0.00836126786, 0.949554026, 0.313491672, 0.00945560541, -0.313563883, 0.949519694), --Torso
CFrame.new(0.000373840332, 1.5, -0.000749111176, 0.999999464, -0.000193906482, -0.000723375008, 7.91624188e-008, 0.965925872, -0.258819103, 0.000748950057, 0.258818865, 0.965924978), --Head
CFrame.new(-1.37503242, 0.233268738, -0.789457321, 0.998042047, -0.0622826964, -0.00521776918, 0.00785963796, 0.207890153, -0.978115261, 0.0620027781, 0.976170897, 0.207971364), --Larm
CFrame.new(1.37988281, 0.21909523, -0.821572304, 0.99619174, 0.0871564373, 1.59954652e-007, -0.0181206148, 0.207121223, -0.978142083, -0.0852497369, 0.974428773, 0.207910553), --Rarm
CFrame.new(-0.868040085, -1.40343285, -0.779897213, 0.988976836, -0.146221489, 0.0233104676, 0.146263912, 0.989247084, -0.000120046752, -0.0230422504, 0.00352804945, 0.999728084), --Lleg
CFrame.new(0.856435776, -1.41230774, -0.799999714, 0.987688005, 0.156434625, -2.70083547e-008, -0.156434491, 0.987689734, -1.05239451e-007, 9.03382897e-008, -4.67989594e-008, 0.999999821) --Rleg
}

local LeanRight={
CFrame.new(0.218900681, 2.95828819, -0.0185124874, 0.98821038, 0.0877148882, 0.125484601, -0.122245289, 0.945507169, 0.301781446, -0.0921758413, -0.313563943, 0.945081949), --Torso
CFrame.new(-0.000305175781, 1.5, -0.000779151917, 0.862261355, -0.101384543, -0.496211708, -0.0251806006, 0.969965339, -0.24193652, 0.505836129, 0.221106723, 0.833809555), --Head
CFrame.new(-1.36364365, 0.0730628967, -1.18271351, 0.99392426, -0.0962724611, 0.0533535331, 0.0754960924, 0.243553087, -0.966944873, 0.0800957978, 0.965096653, 0.249341458), --Larm
CFrame.new(1.44842339, 0.383333206, -0.443460464, 0.990335047, 0.124148548, 0.0618360974, 0.0329602808, 0.222404629, -0.974397182, -0.134722367, 0.967016876, 0.216163084), --Rarm
CFrame.new(-0.789440155, -1.52897644, -0.723406792, 0.98013407, -0.183182448, -0.0760363415, 0.170146763, 0.973585069, -0.152256951, 0.101918638, 0.136294559, 0.985410869), --Lleg
CFrame.new(1.61018753, -1.08927917, -1.0660553, 0.811410666, -0.554633379, 0.184376687, 0.309497237, 0.140127912, -0.940518916, 0.495806336, 0.820210278, 0.285358727) --Rleg
}

local LeanLeft={
CFrame.new(-0.218900681, 2.95828819, -0.0185124278, 0.98821032, -0.0877148882, -0.125484601, 0.122245282, 0.945507109, 0.301781446, 0.0921758413, -0.313563943, 0.94508189), --Torso
CFrame.new(0.000308990479, 1.49999905, -0.000779151917, 0.862261295, 0.101384528, 0.496211708, 0.025180608, 0.969965219, -0.241936564, -0.505836129, 0.221106723, 0.833809495), --Head
CFrame.new(-1.44842148, 0.38333416, -0.44346118, 0.990334988, -0.124148503, -0.0618360862, -0.0329602808, 0.222404569, -0.974397123, 0.134722352, 0.967016816, 0.216163069), --Larm
CFrame.new(1.36364746, 0.0730638504, -1.18271351, 0.993924201, 0.0962724686, -0.0533535257, -0.0754960924, 0.243552968, -0.966944873, -0.0800957903, 0.965096593, 0.249341428), --Rarm
CFrame.new(-1.61018562, -1.08927917, -1.06605554, 0.811410666, 0.554633319, -0.184376672, -0.309497207, 0.140127882, -0.940518916, -0.495806336, 0.820210218, 0.285358667), --Lleg
CFrame.new(0.789442062, -1.52897644, -0.723407269, 0.980133951, 0.183182418, 0.0760363489, -0.170146748, 0.97358501, -0.152256981, -0.10191863, 0.136294559, 0.98541081) --Rleg
}

local Idle={
CFrame.new(-0.170080185, 2.81253815, 0.0662987232, 0.983277261, -0.169787675, -0.0658614039, 0.181868583, 0.934264243, 0.306714654, 0.00945560448, -0.313563883, 0.949519694), --Torso
CFrame.new(0.000411987305, 1.50681591, -0.052587986, 0.98484087, 0.173457116, -0.000723373145, -0.167731181, 0.951251209, -0.258819103, -0.0442058444, 0.255016834, 0.965924978), --Head
CFrame.new(-1.30443001, 0.43903923, -0.721480846, 0.982039213, -0.104319155, -0.157213971, -0.151802182, 0.0579820126, -0.986708701, 0.112048194, 0.992851794, 0.0411049053), --Larm
CFrame.new(1.3806839, 0.151473045, -0.909276009, 0.988525212, 0.0187509879, -0.149886772, -0.150417581, 0.213257641, -0.96534735, 0.0138633028, 0.976815641, 0.213631094), --Rarm
CFrame.new(-1.41144943, -1.86575317, -0.800272942, 0.979159772, 0.20296292, -0.00717788935, -0.197946846, 0.945861936, -0.257225275, -0.0454178043, 0.253284991, 0.966324806), --Lleg
CFrame.new(0.751859665, -1.3974762, -0.859110832, 0.946897864, 0.316866428, 0.0545861572, -0.317188442, 0.94835943, -0.00288144033, -0.0526801236, -0.0145858433, 0.998504698) --Rleg
}


S.ChildRemoved:connect(function(child) if child.Name=="SeatWeld" then for i,v in pairs(WS) do if v~=0 then if v[4]~=nil then v[4]:Destroy() v[1].Part1=v[5] else if v[2]~=nil then v[1].C0=v[2] v[1].C1=v[3] else v[1]:Destroy() end end end end for i,v in pairs(HW) do v[1]:Destroy() v[2]:Destroy() v[3].Transparency=0 end A.Parent=C A.Disabled=false script:Destroy() end end)
function MW(x,y)
	local WW=Instance.new("Weld",x) WW.Part0=x WW.Part1=y return WW
end


if C:FindFirstChild("HumanoidRootPart")~=nil and C:FindFirstChild("Torso")~=nil then
	A.Disabled=true
	A.Parent=script
	S.SeatWeld.C0=CFrame.new()
	S.SeatWeld.C1=CFrame.new()
	C.HumanoidRootPart.RootJoint.Part1=nil
	table.insert(WS,{C.HumanoidRootPart.RootJoint,C.HumanoidRootPart.RootJoint.C0,C.HumanoidRootPart.RootJoint.C1,MW(C.HumanoidRootPart,C.Torso),C.Torso})
	if C.Torso:FindFirstChild("Neck")~=nil then
		local H=C.Head:Clone()
		H.Parent=S.Parent
		local WH=MW(C.Torso,H)
		WH.C0=C.Torso.Neck.C0
		WH.C1=C.Torso.Neck.C0
		C.Head.Transparency=1
		table.insert(HW,{H,WH,C.Head})
		table.insert(WS,{WH,nil,nil,nil,nil})
		for i,v in pairs(C.Head:GetChildren()) do
			if v:IsA("Weld") then
				local pp=v.Part1:Clone()
				pp.Parent=S.Parent
				v.Part1.Transparency=1
				local ww=MW(H,pp)
				ww.C0=v.C0
				ww.C1=v.C1
				table.insert(HW,{pp,ww,v.Part1})
			end
		end	
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Left Shoulder")~=nil then
		C.Torso:FindFirstChild("Left Shoulder").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Left Shoulder"),C.Torso:FindFirstChild("Left Shoulder").C0,C.Torso:FindFirstChild("Left Shoulder").C1,MW(C.Torso,C:FindFirstChild("Left Arm")),C:FindFirstChild("Left Arm")})
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Right Shoulder")~=nil then
		C.Torso:FindFirstChild("Right Shoulder").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Right Shoulder"),C.Torso:FindFirstChild("Right Shoulder").C0,C.Torso:FindFirstChild("Right Shoulder").C1,MW(C.Torso,C:FindFirstChild("Right Arm")),C:FindFirstChild("Right Arm")})
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Left Hip")~=nil then
		C.Torso:FindFirstChild("Left Hip").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Left Hip"),C.Torso:FindFirstChild("Left Hip").C0,C.Torso:FindFirstChild("Left Hip").C1,MW(C.Torso,C:FindFirstChild("Left Leg")),C:FindFirstChild("Left Leg")})
	else
		table.insert(WS,0)
	end
	if C.Torso:FindFirstChild("Right Hip")~=nil then
		C.Torso:FindFirstChild("Right Hip").Part1=nil
		table.insert(WS,{C.Torso:FindFirstChild("Right Hip"),C.Torso:FindFirstChild("Right Hip").C0,C.Torso:FindFirstChild("Right Hip").C1,MW(C.Torso,C:FindFirstChild("Right Leg")),C:FindFirstChild("Right Leg")})
	else
		table.insert(WS,0)
	end
end

for i,v in pairs(WS) do
	if v[4]~=nil then
		v[4].C0=LeanIn[i]
		v[4].C1=CFrame.new()
	else
		v[1].C0=LeanIn[i]
		v[1].C1=CFrame.new()
	end
end

function getC(w,c)
	local ax,ay,az,ar00,ar01,ar02,ar10,ar11,ar12,ar20,ar21,ar22=CFrame.new().components(w.C0)
	local bx,by,bz,br00,br01,br02,br10,ar11,br12,br20,br21,br22=CFrame.new().components(c)
	local ca={ax,ay,az,ar00,ar01,ar02,ar10,ar11,ar12,ar20,ar21,ar22}
	local cb={bx,by,bz,br00,br01,br02,br10,ar11,br12,br20,br21,br22}
	local cd={}
	for i,v in pairs(ca) do
		table.insert(cd,(cb[i]-v)/10)
	end
	return cd
end
function tween(w,cd)
	local cx,cy,cz,cr00,cr01,cr02,cr10,cr11,cr12,cr20,cr21,cr22=CFrame.new().components(w.C0)
	local cc={cx,cy,cz,cr00,cr01,cr02,cr10,cr11,cr12,cr20,cr21,cr22}
	local ce={}
	for i,v in pairs(cc) do
		table.insert(ce,v+cd[i])
	end
	w.C0=CFrame.new(ce[1],ce[2],ce[3],ce[4],ce[5],ce[6],ce[7],ce[8],ce[9],ce[10],ce[11],ce[12])
end
function setPose(p)
	for i,v in pairs(WS) do
		if v[4]~=nil then
			tween(v[4],p[i])
		else
			tween(v[1],p[i])
		end
	end
end
function getPose(p)
	local ps={}
	for i,v in pairs(WS) do
		if v[4]~=nil then
			table.insert(ps,getC(v[4],p[i]))
		else
			table.insert(ps,getC(v[1],p[i]))
		end
	end
	return(ps)
end

local steer=S.Steer
local idling=false
local frame=0
pose=getPose(LeanIn)
while wait() do
	if S.Velocity.Magnitude<3 and not idling then
		idling=true
		frame=0
		pose=getPose(Idle)
	else
		if S.Velocity.Magnitude>3 and (S.Steer~=steer or idling==true) then
			steer=S.Steer
			frame=0
			if steer==0 then
				pose=getPose(LeanIn)
			elseif steer==1 then
				pose=getPose(LeanRight)
			else
				pose=getPose(LeanLeft)
			end
			idling=false
		end
	end
	if frame<10 then
		frame=frame+1
		setPose(pose)
	end
end