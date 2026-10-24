-- ============================================================
-- VOQUYETT HUB V10 - ULTRA STAMINA HACK & MAX SPIN
-- ============================================================

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")

local AutoTap = false
local AutoSpin = false
local InfStamina = false

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoQuyettHubV10"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

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
Title.Text = "VOQUYETT HUB V10"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)

local TapBtn = Instance.new("TextButton")
TapBtn.Parent = Menu
TapBtn.Size = UDim2.new(0.85, 0, 0, 35)
TapBtn.Position = UDim2.new(0.075, 0, 0.18, 0)
TapBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TapBtn.Text = "Auto Tap: OFF"
TapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TapBtn.Font = Enum.Font.SourceSansBold
TapBtn.TextSize = 14
Instance.new("UICorner", TapBtn).CornerRadius = UDim.new(0, 6)

local SpinBtn = Instance.new("TextButton")
SpinBtn.Parent = Menu
SpinBtn.Size = UDim2.new(0.85, 0, 0, 35)
SpinBtn.Position = UDim2.new(0.075, 0, 0.38, 0)
SpinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpinBtn.Text = "Auto Spin Max: OFF"
SpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinBtn.Font = Enum.Font.SourceSansBold
SpinBtn.TextSize = 14
Instance.new("UICorner", SpinBtn).CornerRadius = UDim.new(0, 6)

local StamBtn = Instance.new("TextButton")
StamBtn.Parent = Menu
StamBtn.Size = UDim2.new(0.85, 0, 0, 35)
StamBtn.Position = UDim2.new(0.075, 0, 0.58, 0)
StamBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
StamBtn.Text = "Infinite Energy: OFF"
StamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StamBtn.Font = Enum.Font.SourceSansBold
StamBtn.TextSize = 14
Instance.new("UICorner", StamBtn).CornerRadius = UDim.new(0, 6)

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
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
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
    TapBtn.Text = "Auto Tap: " .. (AutoTap and "ON" or "OFF")
    TapBtn.BackgroundColor3 = AutoTap and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
end)

SpinBtn.MouseButton1Click:Connect(function()
    AutoSpin = not AutoSpin
    SpinBtn.Text = "Auto Spin Max: " .. (AutoSpin and "ON" or "OFF")
    SpinBtn.BackgroundColor3 = AutoSpin and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
end)

StamBtn.MouseButton1Click:Connect(function()
    InfStamina = not InfStamina
    StamBtn.Text = "Infinite Energy: " .. (InfStamina and "ON" or "OFF")
    StamBtn.BackgroundColor3 = InfStamina and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
end)

RunService.RenderStepped:Connect(function(deltaTime)
    local char = LocalPlayer.Character
    
    if AutoTap then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2))
    end

    if AutoSpin then
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(360) * deltaTime, 0)
        end
    end

    if InfStamina and char then
        -- 1. Khóa tốc độ chạy (Đảm bảo game không trừ năng lượng vì tội chạy nhanh)
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid and humanoid.WalkSpeed > 16 then
            humanoid.WalkSpeed = 16
        end

        -- 2. Quét toàn bộ Value (Số) trong nhân vật và Player
        for _, obj in pairs(char:GetDescendants()) do
            if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                local name = string.lower(obj.Name)
                if string.find(name, "stamina") or string.find(name, "energy") or string.find(name, "power") then
                    obj.Value = 999999
                end
            end
        end
        for _, obj in pairs(LocalPlayer:GetDescendants()) do
            if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                local name = string.lower(obj.Name)
                if string.find(name, "stamina") or string.find(name, "energy") or string.find(name, "power") then
                    obj.Value = 999999
                end
            end
        end

        -- 3. Quét Attribute (Thuộc tính ẩn của game)
        for _, obj in pairs(char:GetChildren()) do
            for _, attr in pairs(obj:GetAttributes()) do
                local attrName = string.lower(attr)
                if string.find(attrName, "stamina") or string.find(attrName, "energy") then
                    obj:SetAttribute(attr, 999999)
                end
            end
        end
    end
end)
