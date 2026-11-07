function run()
	script.Parent.Parent.Visible = false
	script.Parent.Parent.Parent.Parent.Gem.Visible = true
	script.Parent.Parent.Parent.Open.Visible = true
end

script.Parent.MouseButton1Click:Connect(run)