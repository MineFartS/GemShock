script.Parent.ChildAdded:connect(function(child) 
	if child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then 
		local P=game.Players:GetPlayerFromCharacter(child.Part1.Parent) 
		local S=script.L:Clone() S.Parent=P.PlayerGui 
		S.Seat.Value=script.Parent 
		S.Disabled=false 
	end 
end)