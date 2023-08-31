if not isfolder("Smoke") then
	makefolder("Smoke")
end
if not isfolder("Smoke/assets") then
	makefolder("Smoke/assets")
end

if not isfile("Smoke/assets/SmokeLogo.png") then
	writefile("Smoke/assets/SmokeLogo.png", game:HttpGet('https://github.com/SmokeXDev/SmokeXClient/blob/main/assets/SmokeLogo.png?raw=true'))
end
if not isfile("Smoke/assets/Cape.png") then
    writefile("Smoke/assets/Cape.png", game:HttpGet("https://raw.githubusercontent.com/SmokeXDev/SmokeXClient/main/assets/Cape.png"))
end

wait(.5)

local SmokeLogo = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local Logo = Instance.new("ImageLabel")
SmokeLogo.Name = "SmokeLogo"
SmokeLogo.Parent = game.CoreGui
SmokeLogo.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SmokeLogo.ResetOnSpawn = false
Frame.Parent = SmokeLogo
Frame.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.00451127812, 0, 0.42539683, 0)
Frame.Size = UDim2.new(0, 146, 0, 89)
UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = Frame
UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 255))}
UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.50), NumberSequenceKeypoint.new(1.00, 0.50)}
UIGradient.Parent = Frame
Logo.Name = "Logo"
Logo.Parent = Frame
Logo.Image = getcustomasset("Smoke/assets/SmokeLogo.png")
Logo.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
Logo.BackgroundTransparency = 0.500
Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0.0479452051, 0, 0.0674157292, 0)
Logo.Size = UDim2.new(0, 132, 0, 74)
local function VHCHIK_fake_script()
	local script = Instance.new('LocalScript', Frame)
	local UserInputService = game:GetService("UserInputService")
	local gui = script.Parent
	local dragging
	local dragInput
	local dragStart
	local startPos
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(VHCHIK_fake_script)()