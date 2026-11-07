function run()
	script.Parent.Visible = false
	script.Parent.Parent.Main.Visible = true
	script.Parent.Parent.Parent.Gem.Visible = false	
end

script.Parent.MouseButton1Click:Connect(run)