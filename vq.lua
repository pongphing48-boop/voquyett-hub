-- ============================================================
-- VOQUYETT HUB V3 - ANTIBAN & ULTRA OPTIMIZED
-- ============================================================

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")

local AutoTap = false
local AutoSpin = false
local BoostPerformance = false

-- Chống lag, tối ưu chạy ngầm (Antiban cơ bản)
pcall(function()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            return nil
        end
        return oldNamecall(self, ...)
    end)
end)

-- Giao diện
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoQuyettHubV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Icon bên phải màn hình
local Icon = Instance.new("ImageButton")
Icon.Parent = ScreenGui
Icon.Size = UDim2.new(0, 50, 0, 50)
Icon.Position = UDim2.new(1, -70, 0.5, -25) -- Nằm bên phải
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
Title.Text = "VOQUYETT HUB V3"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)

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

local PerfBtn = Instance.new("TextButton")
PerfBtn.Parent = Menu
PerfBtn.Size = UDim2.new(0.85, 0, 0, 35)
PerfBtn.Position = UDim2.new(0.075, 0, 0.70, 0)
PerfBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PerfBtn.Text = "Boost Performance: OFF"
PerfBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PerfBtn.Font = Enum.Font.SourceSansBold
PerfBtn.TextSize = 14
Instance.new("UICorner", PerfBtn).CornerRadius = UDim.new(0, 6)

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

-- Bật tắt
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

PerfBtn.MouseButton1Click:Connect(function()
    BoostPerformance = not BoostPerformance
    if BoostPerformance then
        PerfBtn.Text = "Boost Performance: ON"
        PerfBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        -- Tắt bóng đổ, hiệu ứng rác để tăng FPS
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
            if v:IsA("BasePart") then
                v.CastShadow = false
            end
        end
        game.Lighting.GlobalShadows = false
    else
        PerfBtn.Text = "Boost Performance: OFF"
        PerfBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        game.Lighting.GlobalShadows = true
    end
end)

-- Vòng lặp chạy ngầm tối ưu (Tick 10 FPS thay vì 60 FPS để không tốn pin, không lag)
local tickAccumulator = 0
local targetTickRate = 0.1 -- Chạy 10 lần/giây

RunService.Heartbeat:Connect(function(deltaTime)
    if not (AutoTap or AutoSpin) then return end
    
    tickAccumulator = tickAccumulator + deltaTime
    if tickAccumulator < targetTickRate then return end
    tickAccumulator = 0 -- Reset
    
    if AutoTap then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2))
    end

    if AutoSpin then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            -- Quay 360 độ siêu nhanh (45 độ mỗi lần tick)
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(45), 0)
        end
    end
end)
