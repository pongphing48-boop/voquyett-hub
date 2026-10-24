
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")

local AutoTap = false
local AutoSpin = false
local PowerSaver = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoQuyettHubV7"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Icon bên phải, nhích lên trên
local Icon = Instance.new("ImageButton")
Icon.Parent = ScreenGui
Icon.Size = UDim2.new(0, 50, 0, 50)
Icon.Position = UDim2.new(1, -70, 0.4, -25)
Icon.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Icon.BorderSizePixel = 0
Icon.ScaleType = Enum.ScaleType.Crop
Icon.Image = "rbxassetid://13163071002" 

local UICornerIcon = Instance.new("UICorner", Icon)
UICornerIcon.CornerRadius = UDim.new(1, 0)

local IconStroke = Instance.new("UIStroke", Icon)
IconStroke.Color = Color3.fromRGB(0, 255, 255)
IconStroke.Thickness = 2

-- Menu
local Menu = Instance.new("Frame")
Menu.Parent = ScreenGui
Menu.Size = UDim2.new(0, 200, 0, 210)
Menu.Position = UDim2.new(0.5, -100, 0.5, -105)
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
Title.Text = "VOQUYETT HUB V7"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)

-- Nút Auto Tap
local TapBtn = Instance.new("TextButton")
TapBtn.Parent = Menu
TapBtn.Size = UDim2.new(0.85, 0, 0, 35)
TapBtn.Position = UDim2.new(0.075, 0, 0.22, 0)
TapBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TapBtn.Text = "Auto Tap: OFF"
TapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TapBtn.Font = Enum.Font.SourceSansBold
TapBtn.TextSize = 14
Instance.new("UICorner", TapBtn).CornerRadius = UDim.new(0, 6)

-- Nút Auto Spin
local SpinBtn = Instance.new("TextButton")
SpinBtn.Parent = Menu
SpinBtn.Size = UDim2.new(0.85, 0, 0, 35)
SpinBtn.Position = UDim2.new(0.075, 0, 0.46, 0)
SpinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpinBtn.Text = "Auto Spin: OFF"
SpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinBtn.Font = Enum.Font.SourceSansBold
SpinBtn.TextSize = 14
Instance.new("UICorner", SpinBtn).CornerRadius = UDim.new(0, 6)

-- Nút Tiết kiệm pin
local PowerBtn = Instance.new("TextButton")
PowerBtn.Parent = Menu
PowerBtn.Size = UDim2.new(0.85, 0, 0, 35)
PowerBtn.Position = UDim2.new(0.075, 0, 0.70, 0)
PowerBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PowerBtn.Text = "Tiet Kiem Pin: OFF"
PowerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PowerBtn.Font = Enum.Font.SourceSansBold
PowerBtn.TextSize = 14
Instance.new("UICorner", PowerBtn).CornerRadius = UDim.new(0, 6)

local MenuOpen = false
Icon.MouseButton1Click:Connect(function()
    MenuOpen = not MenuOpen
    Menu.Visible = MenuOpen
end)

-- Kéo thả Menu
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

-- Bật tắt Tap
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

-- Bật tắt Spin
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

-- Bật tắt Tiết kiệm pin
PowerBtn.MouseButton1Click:Connect(function()
    PowerSaver = not PowerSaver
    if PowerSaver then
        PowerBtn.Text = "Tiet Kiem Pin: ON"
        PowerBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Lighting.GlobalShadows = false
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
            if v:IsA("BasePart") then
                v.CastShadow = false
            end
        end
    else
        PowerBtn.Text = "Tiet Kiem Pin: OFF"
        PowerBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Lighting.GlobalShadows = true
    end
end)

-- Vòng lặp chạy ngầm (10 FPS) - Tối ưu không mất năng lượng
local tickAccumulator = 0
local targetTickRate = 0.1 

RunService.Heartbeat:Connect(function(deltaTime)
    if not (AutoTap or AutoSpin) then return end
    
    tickAccumulator = tickAccumulator + deltaTime
    if tickAccumulator < targetTickRate then return end
    tickAccumulator = 0 
    
    if AutoTap then
        VirtualUser:CaptureController()
        -- Nhấn vào giữa màn hình liên tục
        VirtualUser:ClickButton1(Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2))
    end

    if AutoSpin then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            -- Xoay nhân vật 360 độ
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(15), 0)
        end
    end
end)
