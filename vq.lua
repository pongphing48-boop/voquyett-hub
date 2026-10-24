local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")

local AutoTap = false
local AutoSpin = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoQuyettHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Icon = Instance.new("ImageButton")
Icon.Parent = ScreenGui
Icon.Size = UDim2.new(0, 50, 0, 50)
Icon.Position = UDim2.new(0, 20, 0.5, -25)
Icon.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Icon.BorderSizePixel = 0
Icon.ScaleType = Enum.ScaleType.Crop

Icon.Image = "rbxassetid://13163071002" 

local UICornerIcon = Instance.new("UICorner", Icon)
UICornerIcon.CornerRadius = UDim.new(1, 0)

local IconStroke = Instance.new("UIStroke", Icon)
IconStroke.Color = Color3.fromRGB(0, 255, 255)
IconStroke.Thickness = 2

local Menu = Instance.new("Frame")
Menu.Parent = ScreenGui
Menu.Size = UDim2.new(0, 200, 0, 160)
Menu.Position = UDim2.new(0.5, -100, 0.5, -80)
Menu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Menu.BorderSizePixel = 0
Menu.Visible = false
Instance.new("UICorner", Menu).CornerRadius = UDim.new(0, 8)
local MenuStroke = Instance.new("UIStroke", Menu)
MenuStroke.Color = Color3.fromRGB(0, 255, 255)

local Title = Instance.new("TextLabel")
Title.Parent = Menu
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "VOQUYETT HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)

local TapBtn = Instance.new("TextButton")
TapBtn.Parent = Menu
TapBtn.Size = UDim2.new(0.85, 0, 0, 35)
TapBtn.Position = UDim2.new(0.075, 0, 0.3, 0)
TapBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TapBtn.Text = "Auto Tap: OFF"
TapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TapBtn.Font = Enum.Font.SourceSansBold
TapBtn.TextSize = 14
Instance.new("UICorner", TapBtn).CornerRadius = UDim.new(0, 6)

local SpinBtn = Instance.new("TextButton")
SpinBtn.Parent = Menu
SpinBtn.Size = UDim2.new(0.85, 0, 0, 35)
SpinBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
SpinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpinBtn.Text = "Auto Spin: OFF"
SpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinBtn.Font = Enum.Font.SourceSansBold
SpinBtn.TextSize = 14
Instance.new("UICorner", SpinBtn).CornerRadius = UDim.new(0, 6)

local MenuOpen = false
Icon.MouseButton1Click:Connect(function()
    MenuOpen = not MenuOpen
    Menu.Visible = MenuOpen
end)

local dragging, dragInput, dragStart, startPos
Menu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Menu.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Menu.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Menu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

TapBtn.MouseButton1Click:Connect(function()
    AutoTap = not AutoTap
    if AutoTap then
        TapBtn.Text = "Auto Tap: ON"
        TapBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        TapBtn.Text = "Auto Tap: OFF"
        TapBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)

SpinBtn.MouseButton1Click:Connect(function()
    AutoSpin = not AutoSpin
    if AutoSpin then
        SpinBtn.Text = "Auto Spin: ON"
        SpinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        SpinBtn.Text = "Auto Spin: OFF"
        SpinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end
end)

RunService.RenderStepped:Connect(function()
    if AutoTap then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2))
    end

    if AutoSpin then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(5), 0)
        end
    end
end)
