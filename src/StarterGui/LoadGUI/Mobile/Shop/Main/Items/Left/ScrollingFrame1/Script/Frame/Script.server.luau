local Player = script.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent.Parent

local ID = script.Parent.Name
local Cost = game.ReplicatedStorage.Tools[ID].Cost.Value
local Title = game.ReplicatedStorage.Tools[ID].Item.ToolTip
local Image = game.ReplicatedStorage.Tools[ID].Item.TextureId

script.Parent.TextLabel.Text = Title
script.Parent.Image = Image

function run()
	
	script.Parent.Parent.Parent.Parent.Right.Template.Buy.Visible = true
	script.Parent.Parent.Parent.Parent.Right.Template.Center.Frame.ImageLabel.Visible = true

	if Player.RedGems.Value >= Cost then
		script.Parent.Parent.Parent.Parent.Right.Template.Buy.Frame.TextLabel.Text = 'Buy'
		script.Parent.Parent.Parent.Parent.Right.Template.Buy.BackgroundColor3 = Color3.new(0.462745, 0.862745, 0.298039)
	else
		script.Parent.Parent.Parent.Parent.Right.Template.Buy.Frame.TextLabel.Text = 'Locked'
		script.Parent.Parent.Parent.Parent.Right.Template.Buy.BackgroundColor3 = Color3.new(1, 0.666667, 0)
	end

	script.Parent.Parent.Parent.Parent.Right.Template.Top.ImageLabel.Image = Image
	script.Parent.Parent.Parent.Parent.Right.Template.Buy.ID.Value = ID
	script.Parent.Parent.Parent.Parent.Right.Template.Top.TextLabel.Text = Title
	script.Parent.Parent.Parent.Parent.Right.Template.Center.Frame.Cost.Text = Cost
end

script.Parent.MouseButton1Click:Connect(run)