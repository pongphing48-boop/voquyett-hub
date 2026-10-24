-- ============================================================
-- VOQUYETT HUB V13 - TỐC ĐỘ AN TOÀN (CHỐNG LỖI 267)
-- ============================================================

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")

local AutoTap = false
local AutoSpin = false
local InfEnergy = false
local CustomSpeed = 32 -- Mức an toàn (chạy nhanh gấp đôi bình thường)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VoQuyettHubV13"
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
Menu.Size = UDim2.new(0, 200, 0, 260)
Menu.Position = UDim2.new(0.5, -100, 0.5, -130)
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
Title.Text = "VOQUYETT HUB V13"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 14
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)

local TapBtn = Instance.new("TextButton")
TapBtn.Parent = Menu
TapBtn.Size = UDim2.new(0.85, 0, 0, 30)
TapBtn.Position = UDim2.new(0.075, 0, 0.15, 0)
TapBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TapBtn.Text = "Auto Tap: OFF"
TapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TapBtn.Font = Enum.Font.SourceSansBold
TapBtn.TextSize = 13
Instance.new("UICorner", TapBtn).CornerRadius = UDim.new(0, 6)

local SpinBtn = Instance.new("TextButton")
SpinBtn.Parent = Menu
SpinBtn.Size = UDim2.new(0.85, 0, 0, 30)
SpinBtn.Position = UDim2.new(0.075, 0, 0.32, 0)
SpinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SpinBtn.Text = "Auto Spin Max: OFF"
SpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinBtn.Font = Enum.Font.SourceSansBold
SpinBtn.TextSize = 13
Instance.new("UICorner", SpinBtn).CornerRadius = UDim.new(0, 6)

local EnergyBtn = Instance.new("TextButton")
EnergyBtn.Parent = Menu
EnergyBtn.Size = UDim2.new(0.85, 0, 0, 30)
EnergyBtn.Position = UDim2.new(0.075, 0, 0.49, 0)
EnergyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
EnergyBtn.Text = "Vo Han Nang Luong: OFF"
EnergyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnergyBtn.Font = Enum.Font.SourceSansBold
EnergyBtn.TextSize = 13
Instance.new("UICorner", EnergyBtn).CornerRadius = UDim.new(0, 6)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = Menu
SpeedLabel.Size = UDim2.new(0.85, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0.075, 0, 0.70, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Toc Do: " .. CustomSpeed
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.TextSize = 14

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = Menu
MinusBtn.Size = UDim2.new(0.4, 0, 0, 25)
MinusBtn.Position = UDim2.new(0.075, 0, 0.85, 0)
MinusBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
MinusBtn.Text = "- Giam Toc"
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.Font = Enum.Font.SourceSansBold
MinusBtn.TextSize = 12
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 6)

local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = Menu
PlusBtn.Size = UDim2.new(0.4, 0, 0, 25)
PlusBtn.Position = UDim2.new(0.525, 0, 0.85, 0)
PlusBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
PlusBtn.Text = "+ Tang Toc"
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.Font = Enum.Font.SourceSansBold
PlusBtn.TextSize = 12
Instance.new("UICorner", PlusBtn).CornerRadius = UDim.new(0, 6)

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

-- Bật tắt
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

EnergyBtn.MouseButton1Click:Connect(function()
    InfEnergy = not InfEnergy
    EnergyBtn.Text = "Vo Han Nang Luong: " .. (InfEnergy and "ON" or "OFF")
    EnergyBtn.BackgroundColor3 = InfEnergy and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    
    if not InfEnergy then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

-- Tùy chỉnh tốc độ (Giới hạn an toàn 35)
PlusBtn.MouseButton1Click:Connect(function()
    CustomSpeed = CustomSpeed + 1
    if CustomSpeed > 35 then CustomSpeed = 35 end -- Đã hạ trần an toàn xuống 35
    SpeedLabel.Text = "Toc Do: " .. CustomSpeed
    if InfEnergy then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = CustomSpeed end
    end
end)

MinusBtn.MouseButton1Click:Connect(function()
    CustomSpeed = CustomSpeed - 1
    if CustomSpeed < 16 then CustomSpeed = 16 end
    SpeedLabel.Text = "Toc Do: " .. CustomSpeed
    if InfEnergy then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = CustomSpeed end
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    local char = LocalPlayer.Character
    
    if AutoTap then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2))
    end

    if AutoSpin and char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(360) * deltaTime, 0)
    end

    if InfEnergy and char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid and humanoid.WalkSpeed ~= CustomSpeed then
            humanoid.WalkSpeed = CustomSpeed 
        end

        -- Bơm năng lượng
        for _, obj in pairs(char:GetDescendants()) do
            if (obj:IsA("NumberValue") or obj:IsA("IntValue")) and (string.find(string.lower(obj.Name), "stamina") or string.find(string.lower(obj.Name), "energy")) then
                obj.Value = 999999
            end
        end
        for _, obj in pairs(LocalPlayer:GetDescendants()) do
            if (obj:IsA("NumberValue") or obj:IsA("IntValue")) and (string.find(string.lower(obj.Name), "stamina") or string.find(string.lower(obj.Name), "energy")) then
                obj.Value = 999999
            end
        end
    end
end)
