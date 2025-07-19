local machine = findMachine()
if not machine or not machine:FindFirstChildWhichIsA("BasePart") then
	warn("Pet Mutation Machine not found.")
	return
end

local basePart = machine:FindFirstChildWhichIsA("BasePart")

local espGui = Instance.new("BillboardGui", basePart)
espGui.Name = "MutationESP"
espGui.Adornee = basePart
espGui.Size = UDim2.new(0, 200, 0, 40)
espGui.StudsOffset = Vector3.new(0, 3, 0)
espGui.AlwaysOnTop = true

local espLabel = Instance.new("TextLabel", espGui)
espLabel.Size = UDim2.new(1, 0, 1, 0)
espLabel.BackgroundTransparency = 1
espLabel.Font = Enum.Font.GothamBold
espLabel.TextSize = 24
espLabel.TextStrokeTransparency = 0.3
espLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
espLabel.Text = currentMutation

local hue = 0
RunService.RenderStepped:Connect(function()
	if espVisible then
		hue = (hue + 0.01) % 1
		espLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
	end
end)

local function animateMutationReroll()
	reroll.Text = "⏳ Rerolling..."
	local duration = 2
	local interval = 0.1
	for i = 1, math.floor(duration / interval) do
		espLabel.Text = mutations[math.random(#mutations)]
		wait(interval)
	end
	currentMutation = mutations[math.random(#mutations)]
	espLabel.Text = currentMutation
	reroll.Text = "Reroll Mutation"
end

toggle.MouseButton1Click:Connect(function()
	espVisible = not espVisible
	espGui.Enabled = espVisible
end)

reroll.MouseButton1Click:Connect(animateMutationReroll)
end)
