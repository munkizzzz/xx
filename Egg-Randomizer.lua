-- Click to visually update the name after a 20-second countdown
button.MouseButton1Click:Connect(function()
	local tool = getEquippedPetTool()
	if tool then
		-- Countdown before changing age
		for i = 20, 1, -1 do
			button.Text = "Changing Age in " .. i .. "..."
			wait(1)
		end

		-- Change name visually
		local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age 50]")
		tool.Name = newName
		petInfo.Text = "Equipped Pet: " .. tool.Name
		button.Text = "Set Age to 50"
	else
		button.Text = "No Pet Equipped!"
		wait(2)
		button.Text = "Set Age to 50"
	end
end)
