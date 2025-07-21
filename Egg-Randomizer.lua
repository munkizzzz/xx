-- Pet Age Visual Modifier (with Dragging)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- GUI setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "SetPetAgeGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Text = "Set Pet Age to 50"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)

local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Text = "Equipped Pet: [None]"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 18
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 150)
statusLabel.BackgroundTransparency = 1
statusLabel.Position = UDim2.new(0, 0, 0, 40)
statusLabel.Size = UDim2.new(1, 0, 0, 30)

local button = Instance.new("TextButton", frame)
button.Text = "Set Age to 50"
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Size = UDim2.new(0, 220, 0, 40)
button.Position = UDim2.new(0.5, -110, 1, -50)
Instance.new("UICorner", button)

-- 🟡 DRAGGING FUNCTIONALITY
local dragging = false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- 🔍 Function to get equipped Tool
local function getEquippedPet()
	character = player.Character or player.CharacterAdded:Wait()
	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:find("Age") then
			return tool
		end
	end
	return nil
end

-- 🟢 Update UI
local function refresh()
	local pet = getEquippedPet()
	if pet then
		statusLabel.Text = "Equipped Pet: " .. pet.Name
	else
		statusLabel.Text = "Equipped Pet: [None]"
	end
end

-- 🖱️ Button click logic
button.MouseButton1Click:Connect(function()
	local pet = getEquippedPet()
	if pet then
		for i = 20, 1, -1 do
			button.Text = "Changing in " .. i .. "s"
			wait(1)
		end
		local updatedName = pet.Name:gsub("%[Age%s*%d+%]", "[Age 50]")
		pet.Name = updatedName
		statusLabel.Text = "Equipped Pet: " .. pet.Name
		button.Text = "Set Age to 50"
	else
		button.Text = "No Pet Equipped!"
		wait(2)
		button.Text = "Set Age to 50"
	end
end)

-- 🔁 Auto-refresh pet name
while true do
	wait(1)
	refresh()
end
