-- LocalScript (put in StarterPlayerScripts or StarterGui)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FakeAgeChanger"
screenGui.ResetOnSpawn = false

-- GUI setup
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 350, 0, 160)
frame.Position = UDim2.new(0.5, -175, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Text = "Set Equipped Pet Age to 50"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)

local petInfo = Instance.new("TextLabel", frame)
petInfo.Text = "Equipped Pet: [None]"
petInfo.Font = Enum.Font.Gotham
petInfo.TextSize = 18
petInfo.TextColor3 = Color3.fromRGB(255, 255, 150)
petInfo.BackgroundTransparency = 1
petInfo.Position = UDim2.new(0, 0, 0, 40)
petInfo.Size = UDim2.new(1, 0, 0, 30)

local button = Instance.new("TextButton", frame)
button.Text = "Set Age to 50"
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Size = UDim2.new(0, 240, 0, 40)
button.Position = UDim2.new(0.5, -120, 1, -50)
Instance.new("UICorner", button)

-- Function to find the equipped pet Tool
local function getEquippedPetTool()
	character = player.Character or player.CharacterAdded:Wait()
	for _, child in pairs(character:GetChildren()) do
		if child:IsA("Tool") and child.Name:find("Age") then
			return child
		end
	end
	return nil
end

-- Update the GUI with the currently equipped pet
local function updateGUI()
	local pet = getEquippedPetTool()
	if pet then
		petInfo.Text = "Equipped Pet: " .. pet.Name
	else
		petInfo.Text = "Equipped Pet: [None]"
	end
end

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

-- Periodically update GUI
while true do
	task.wait(1)
	updateGUI()
end
