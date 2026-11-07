while(wait(1))do
local l = game.Lighting:GetMinutesAfterMidnight()/60 -- Get hours after midnight :3
script.Parent.Enabled = l<6 or l>18 -- If it's before 6AM, or after 7PM turn it on
end