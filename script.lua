-- =====================================================================
-- Premium script by.Nongmin - Ultimate Multi-RGB Anime v1.2 Edition (Compact)
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local NetworkSettings = settings():GetService("NetworkSettings")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- =====================================================================
-- [PREMIUM SECURITY CORE] ระบบป้องกันระดับพรีเมี่ยมขั้นสูงสุด
-- =====================================================================
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    local oldIndex = mt.__index
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" and self == LocalPlayer then
            return nil
        end
        
        if method == "Teleport" or method == "TeleportToNotInServer" then
            return nil
        end
        
        if method == "ReportAbuse" or method == "PostAsync" or method == "GetAsync" or method == "JSONEncode" then
            if type(args[1]) == "string" then
                local str = string.lower(args[1])
                if string.match(str, "ban") or string.match(str, "detect") or string.match(str, "telemetry") or string.match(str, "hook") or string.match(str, "exploit") or string.match(str, "report") then
                    return nil
                end
            end
        end
        
        if method == "FireServer" or method == "InvokeServer" then
            if self and self.Name then
                local remoteName = string.lower(self.Name)
                if string.match(remoteName, "anticheat") or string.match(remoteName, "ac") or string.match(remoteName, "ban") or string.match(remoteName, "security") then
                    return nil
                end
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    mt.__index = newcclosure(function(self, k)
        if tostring(self) == "CoreGui" and (k == "Name" or k == "GetChildren") then
        end
        return oldIndex(self, k)
    end)
    
    task.spawn(function()
        while task.wait(15) do
            pcall(function()
                collectgarbage("collect")
                for _, obj in pairs(Workspace:GetChildren()) do
                    if (obj.Name == "MinGlowEffect" or obj.Name == "MinCacheTemp") and not obj.Parent:FindFirstChild("Humanoid") then
                        obj:Destroy()
                    end
                end
            end)
        end
    end)
    
    setreadonly(mt, true)
end)

if CoreGui:FindFirstChild("NongminScriptFixedMenu") then
    CoreGui.NongminScriptFixedMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NongminScriptFixedMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- =====================================================================
-- หน้าต่างระบบกรอก Key (Key System UI - ปรับขนาดกะทัดรัด)
-- =====================================================================
local KeyScreen = Instance.new("Frame", ScreenGui)
KeyScreen.BackgroundColor3 = Color3.fromRGB(10, 12, 22)
KeyScreen.BorderColor3 = Color3.fromRGB(0, 162, 255)
KeyScreen.BorderSizePixel = 1
KeyScreen.AnchorPoint = Vector2.new(0.5, 0.5)
KeyScreen.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyScreen.Size = UDim2.new(0, 320, 0, 200)
KeyScreen.Active = true
KeyScreen.Draggable = true

local KeyTitle = Instance.new("TextLabel", KeyScreen)
KeyTitle.Name = "RGBText"
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 15, 0, 15)
KeyTitle.Size = UDim2.new(1, -30, 0, 25)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "⚡ Premium Script v1.2 ⚡"
KeyTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Center

local KeySub = Instance.new("TextLabel", KeyScreen)
KeySub.BackgroundTransparency = 1
KeySub.Position = UDim2.new(0, 15, 0, 40)
KeySub.Size = UDim2.new(1, -30, 0, 20)
KeySub.Font = Enum.Font.Gotham
KeySub.Text = "Enter Security Key / กรอกรหัสผ่าน"
KeySub.TextColor3 = Color3.fromRGB(150, 180, 220)
KeySub.TextSize = 9
KeySub.TextXAlignment = Enum.TextXAlignment.Center

local KeyBox = Instance.new("TextBox", KeyScreen)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
KeyBox.BorderColor3 = Color3.fromRGB(0, 162, 255)
KeyBox.Position = UDim2.new(0, 25, 0, 70)
KeyBox.Size = UDim2.new(1, -50, 0, 30)
KeyBox.Font = Enum.Font.GothamSemibold
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 120, 160)
KeyBox.TextSize = 11

local SubmitKeyBtn = Instance.new("TextButton", KeyScreen)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitKeyBtn.BorderSizePixel = 0
SubmitKeyBtn.Position = UDim2.new(0, 25, 0, 110)
SubmitKeyBtn.Size = UDim2.new(1, -50, 0, 28)
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.Text = "✨ VERIFY KEY / ยืนยันรหัส"
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyBtn.TextSize = 10

local CancelKeyBtn = Instance.new("TextButton", KeyScreen)
CancelKeyBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
CancelKeyBtn.BorderColor3 = Color3.fromRGB(40, 50, 75)
CancelKeyBtn.Position = UDim2.new(0, 25, 0, 145)
CancelKeyBtn.Size = UDim2.new(1, -50, 0, 26)
CancelKeyBtn.Font = Enum.Font.GothamBold
CancelKeyBtn.Text = "❌ CANCEL / ยกเลิก"
CancelKeyBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CancelKeyBtn.TextSize = 10

CancelKeyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- =====================================================================
-- หน้าต่างโหลดแอนิเมชั่น (Loading Screen)
-- =====================================================================
local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 22)
LoadingFrame.BorderColor3 = Color3.fromRGB(0, 162, 255)
LoadingFrame.BorderSizePixel = 1
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.Size = UDim2.new(0, 320, 0, 200)
LoadingFrame.Visible = false

local LoadTitle = Instance.new("TextLabel", LoadingFrame)
LoadTitle.Name = "RGBText"
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 15, 0, 25)
LoadTitle.Size = UDim2.new(1, -30, 0, 20)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "Loading Premium v1.2..."
LoadTitle.TextColor3 = Color3.fromRGB(0, 220, 255)
LoadTitle.TextSize = 12
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center

local LoadPercent = Instance.new("TextLabel", LoadingFrame)
LoadPercent.BackgroundTransparency = 1
LoadPercent.Position = UDim2.new(0, 15, 0, 50)
LoadPercent.Size = UDim2.new(1, -30, 0, 30)
LoadPercent.Font = Enum.Font.GothamBold
LoadPercent.Text = "0%"
LoadPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadPercent.TextSize = 18
LoadPercent.TextXAlignment = Enum.TextXAlignment.Center

local BarBackground = Instance.new("Frame", LoadingFrame)
BarBackground.BackgroundColor3 = Color3.fromRGB(15, 20, 35)
BarBackground.BorderColor3 = Color3.fromRGB(30, 45, 75)
BarBackground.Position = UDim2.new(0, 25, 0, 95)
BarBackground.Size = UDim2.new(1, -50, 0, 12)

local BarFill = Instance.new("Frame", LoadingFrame)
BarFill.Name = "RGBBar"
BarFill.Parent = BarBackground
BarFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
BarFill.BorderSizePixel = 0
BarFill.Size = UDim2.new(0, 0, 1, 0)

local LoadSubText = Instance.new("TextLabel", LoadingFrame)
LoadSubText.BackgroundTransparency = 1
LoadSubText.Position = UDim2.new(0, 15, 0, 125)
LoadSubText.Size = UDim2.new(1, -30, 0, 25)
LoadSubText.Font = Enum.Font.Gotham
LoadSubText.Text = "Initializing Core Assets..."
LoadSubText.TextColor3 = Color3.fromRGB(120, 150, 190)
LoadSubText.TextSize = 8
LoadSubText.TextXAlignment = Enum.TextXAlignment.Center

-- =====================================================================
-- หน้าต่างหลักของเมนู (Main Frame - ปรับขนาดเล็กลงพอดีตา)
-- =====================================================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "RGBMain"
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 25)
MainFrame.BorderColor3 = Color3.fromRGB(0, 162, 255)
MainFrame.BorderSizePixel = 2
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 420, 0, 250)
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- =====================================================================
-- โลโก้ปุ่มเปิด-ปิดเมนู: ปรับขนาดให้เล็กลงกำลังดี (Compact Toggle)
-- =====================================================================
local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.Name = "RGBToggle"
ToggleButton.BackgroundColor3 = Color3.fromRGB(10, 12, 22)
ToggleButton.BorderColor3 = Color3.fromRGB(0, 162, 255)
ToggleButton.BorderSizePixel = 2
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Image = "rbxassetid://579271238" 
ToggleButton.ScaleType = Enum.ScaleType.Crop
ToggleButton.Visible = false
ToggleButton.Active = true

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(0, 12)

-- ตัวอักษร "H" ตรงกลางปุ่ม
local ToggleCenterH = Instance.new("TextLabel", ToggleButton)
ToggleCenterH.Name = "RGBTextH"
ToggleCenterH.BackgroundTransparency = 1
ToggleCenterH.Size = UDim2.new(1, 0, 1, 0)
ToggleCenterH.Font = Enum.Font.GothamBold
ToggleCenterH.Text = "[ H ]"
ToggleCenterH.TextColor3 = Color3.fromRGB(0, 220, 255)
ToggleCenterH.TextSize = 16
ToggleCenterH.TextXAlignment = Enum.TextXAlignment.Center
ToggleCenterH.TextYAlignment = Enum.TextYAlignment.Center

-- ข้อความบอกปุ่มเปิด-ปิด [H] ด้านล่าง
local ToggleHint = Instance.new("TextLabel", ToggleButton)
ToggleHint.Name = "RGBHint"
ToggleHint.BackgroundTransparency = 0.3
ToggleHint.BackgroundColor3 = Color3.fromRGB(5, 5, 12)
ToggleHint.Position = UDim2.new(0, 0, 1, 2)
ToggleHint.Size = UDim2.new(1, 0, 0, 15)
ToggleHint.Font = Enum.Font.GothamBold
ToggleHint.Text = "Toggle"
ToggleHint.TextColor3 = Color3.fromRGB(0, 200, 255)
ToggleHint.TextSize = 8
ToggleHint.TextXAlignment = Enum.TextXAlignment.Center

local HintCorner = Instance.new("UICorner", ToggleHint)
HintCorner.CornerRadius = UDim.new(0, 4)

local btnDragging, btnDragInput, btnDragStart, btnStartPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = ToggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then btnDragging = false end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        btnDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == btnDragInput and btnDragging then
        local delta = input.Position - btnDragStart
        ToggleButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)

local function ToggleMenuVisible()
    if not ToggleButton.Visible then return end
    if MainFrame.Visible then
        local tweenOut = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tweenOut:Play()
        tweenOut.Completed:Wait()
        MainFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 420, 0, 250)
    else
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        local tweenIn = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 420, 0, 250)})
        tweenIn:Play()
    end
end

ToggleButton.MouseButton1Click:Connect(ToggleMenuVisible)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
        ToggleMenuVisible()
    end
end)

SubmitKeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "Min" then
        KeyScreen.Visible = false
        LoadingFrame.Visible = true
        
        local totalDuration = 2.0
        local steps = 100
        for i = 1, steps do
            LoadPercent.Text = i .. "%"
            BarFill.Size = UDim2.new(i / 100, 0, 1, 0)
            if i == 33 then LoadTitle.Text = "Loading Modules v1.2..."
            elseif i == 66 then LoadTitle.Text = "Activating Shield System..."
            elseif i == 90 then LoadTitle.Text = "Ready to Launch!" end
            task.wait(totalDuration / steps)
        end
        
        LoadingFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.Visible = true
        ToggleButton.Visible = true
        
        local introTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 420, 0, 250)})
        introTween.Play()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "❌ Incorrect Key! / รหัสผิด"
    end
end)

-- Sidebar ด้านซ้าย
local Sidebar = Instance.new("Frame", ScreenGui)
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 10, 18)
Sidebar.BorderSizePixel = 0
Sidebar.Size = UDim2.new(0, 130, 1, 0)

local LogoTitle = Instance.new("TextLabel", Sidebar)
LogoTitle.BackgroundTransparency = 1
LogoTitle.Position = UDim2.new(0, 8, 0, 10)
LogoTitle.Size = UDim2.new(0, 115, 0, 16)
LogoTitle.Font = Enum.Font.GothamBold
LogoTitle.Text = "Premium Script"
LogoTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
LogoTitle.TextSize = 10
LogoTitle.TextXAlignment = Enum.TextXAlignment.Left

local LogoSub = Instance.new("TextLabel", Sidebar)
LogoSub.Name = "RGBSub"
LogoSub.BackgroundTransparency = 1
LogoSub.Position = UDim2.new(0, 8, 0, 25)
LogoSub.Size = UDim2.new(0, 115, 0, 15)
LogoSub.Font = Enum.Font.GothamBold
LogoSub.Text = "by.Nongmin" 
LogoSub.TextColor3 = Color3.fromRGB(150, 100, 255)
LogoSub.TextSize = 9
LogoSub.TextXAlignment = Enum.TextXAlignment.Left

-- RGB Engine
task.spawn(function()
    while task.wait(0.03) do
        pcall(function()
            local t = tick() * 3
            
            local r1 = math.sin(t) * 127 + 128
            local g1 = math.sin(t + 2) * 127 + 128
            local b1 = math.sin(t + 4) * 127 + 128
            local rgbColor1 = Color3.fromRGB(r1, g1, b1)
            
            local r2 = math.sin(t + 1.5) * 127 + 128
            local g2 = math.sin(t + 3.5) * 127 + 128
            local b2 = math.sin(t + 5.5) * 127 + 128
            local rgbColor2 = Color3.fromRGB(r2, g2, b2)

            local r3 = math.sin(t * 0.8) * 50 + 40
            local g3 = math.sin(t * 1.2) * 100 + 120
            local b3 = 255
            local rgbColor3 = Color3.fromRGB(r3, g3, b3)

            MainFrame.BorderColor3 = rgbColor1
            ToggleButton.BorderColor3 = rgbColor1
            KeyScreen.BorderColor3 = rgbColor2
            LoadingFrame.BorderColor3 = rgbColor2
            
            LogoSub.TextColor3 = rgbColor2
            ToggleCenterH.TextColor3 = rgbColor1
            ToggleHint.TextColor3 = rgbColor1
            
            if BarFill then
                BarFill.BackgroundColor3 = rgbColor3
            end
        end)
    end
end)

local MenuHolder = Instance.new("Frame", Sidebar)
MenuHolder.BackgroundTransparency = 1
MenuHolder.Position = UDim2.new(0, 0, 0, 45)
MenuHolder.Size = UDim2.new(1, 0, 1, -90)

local UIList = Instance.new("UIListLayout", MenuHolder)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 3)

local ProfileFrame = Instance.new("Frame", Sidebar)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(12, 15, 25)
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Position = UDim2.new(0, 6, 1, -40)
ProfileFrame.Size = UDim2.new(1, -12, 0, 34)

local ProfileName = Instance.new("TextLabel", ProfileFrame)
ProfileName.BackgroundTransparency = 1
ProfileName.Position = UDim2.new(0, 6, 0, 3)
ProfileName.Size = UDim2.new(1, -6, 0, 14)
ProfileName.Font = Enum.Font.GothamBold
ProfileName.Text = LocalPlayer.Name
ProfileName.TextColor3 = Color3.fromRGB(240, 240, 240)
ProfileName.TextSize = 9
ProfileName.TextXAlignment = Enum.TextXAlignment.Left

local ProfileRole = Instance.new("TextLabel", ProfileFrame)
ProfileRole.BackgroundTransparency = 1
ProfileRole.Position = UDim2.new(0, 6, 0, 16)
ProfileRole.Size = UDim2.new(1, -6, 0, 14)
ProfileRole.Font = Enum.Font.GothamBold
ProfileRole.Text = "🛡️ Shadow Guard"
ProfileRole.TextColor3 = Color3.fromRGB(0, 200, 255)
ProfileRole.TextSize = 7
ProfileRole.TextXAlignment = Enum.TextXAlignment.Left

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 130, 0, 0)
ContentArea.Size = UDim2.new(1, -130, 1, 0)

local TopBar = Instance.new("Frame", ContentArea)
TopBar.BackgroundTransparency = 1
TopBar.Position = UDim2.new(0, 10, 0, 8)
TopBar.Size = UDim2.new(1, -20, 0, 24)

local PageTitle = Instance.new("TextLabel", TopBar)
PageTitle.BackgroundTransparency = 1
PageTitle.Size = UDim2.new(0, 150, 1, 0)
PageTitle.Font = Enum.Font.GothamBold
PageTitle.Text = "Home / หน้าหลัก"
PageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PageTitle.TextSize = 12
PageTitle.TextXAlignment = Enum.TextXAlignment.Left

local CharBanner = Instance.new("ImageLabel", TopBar)
CharBanner.BackgroundTransparency = 1
CharBanner.Position = UDim2.new(1, -50, 0, -2)
CharBanner.Size = UDim2.new(0, 26, 0, 26)
CharBanner.Image = "rbxassetid://579271238"
CharBanner.ScaleType = Enum.ScaleType.Crop
local BannerCorner = Instance.new("UICorner", CharBanner)
BannerCorner.CornerRadius = UDim.new(1, 0)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -18, 0, 1)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 9

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local ResizeBtn = Instance.new("TextButton", MainFrame)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
ResizeBtn.BorderSizePixel = 0
ResizeBtn.Position = UDim2.new(1, -20, 1, -20)
ResizeBtn.Size = UDim2.new(0, 20, 0, 20)
ResizeBtn.Text = "◢"
ResizeBtn.TextColor3 = Color3.fromRGB(12, 14, 25)
ResizeBtn.TextSize = 10
ResizeBtn.ZIndex = 10

local resizing = false
local resizeStart, startSize

ResizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        startSize = MainFrame.AbsoluteSize
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then resizing = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        local newWidth = math.clamp(startSize.X + delta.X, 360, 700)
        local newHeight = math.clamp(startSize.Y + delta.Y, 200, 500)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

local PagesHolder = Instance.new("Frame", ContentArea)
PagesHolder.BackgroundTransparency = 1
PagesHolder.Position = UDim2.new(0, 10, 0, 36)
PagesHolder.Size = UDim2.new(1, -20, 1, -66)

local Pages = {}
local MenuButtons = {}

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame", PagesHolder)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 350)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    Pages[name] = page
    return page
end

local function AddMenuButton(name, icon, thaiName)
    local btn = Instance.new("TextButton", MenuHolder)
    btn.BackgroundColor3 = Color3.fromRGB(12, 14, 25)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -10, 0, 26)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = " " .. icon .. "  " .. name .. " / " .. thaiName
    btn.TextColor3 = Color3.fromRGB(150, 170, 200)
    btn.TextSize = 8
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    table.insert(MenuButtons, {Button = btn, Name = name})
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, mb in ipairs(MenuButtons) do
            mb.Button.BackgroundColor3 = Color3.fromRGB(12, 14, 25)
            mb.Button.TextColor3 = Color3.fromRGB(150, 170, 200)
        end
        if Pages[name] then
            Pages[name].Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            PageTitle.Text = name .. " / " .. thaiName
        end
    end)
end

local function CreateToggle(parent, title, thaiTitle, callback)
    local toggleBtn = Instance.new("TextButton", parent)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
    toggleBtn.BorderColor3 = Color3.fromRGB(40, 55, 85)
    toggleBtn.Size = UDim2.new(1, -4, 0, 30)
    toggleBtn.Font = Enum.Font.GothamSemibold
    toggleBtn.Text = "  " .. title .. " / " .. thaiTitle
    toggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    toggleBtn.TextSize = 8
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left

    local statusLbl = Instance.new("TextLabel", toggleBtn)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Position = UDim2.new(1, -55, 0, 0)
    statusLbl.Size = UDim2.new(0, 45, 1, 0)
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.Text = "[ OFF ]"
    statusLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
    statusLbl.TextSize = 9

    local enabled = false
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            statusLbl.Text = "[ ON ]"
            statusLbl.TextColor3 = Color3.fromRGB(0, 255, 128)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 30, 50)
        else
            statusLbl.Text = "[ OFF ]"
            statusLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
        end
        pcall(function() callback(enabled) end)
    end)
    return toggleBtn
end

local function CreateSlider(parent, title, thaiTitle, min, max, default, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
    sliderFrame.BorderColor3 = Color3.fromRGB(40, 55, 85)
    sliderFrame.Size = UDim2.new(1, -4, 0, 44)

    local titleLbl = Instance.new("TextLabel", sliderFrame)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.Size = UDim2.new(1, -16, 0, 18)
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.Text = title .. " / " .. thaiTitle .. " (" .. default .. ")"
    titleLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleLbl.TextSize = 8
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("TextButton", sliderFrame)
    bar.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    bar.BorderSizePixel = 0
    bar.Position = UDim2.new(0, 8, 0, 26)
    bar.Size = UDim2.new(1, -16, 0, 7)
    bar.Text = ""

    local fill = Instance.new("Frame", bar)
    fill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)

    local draggingSlider = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + ((max - min) * pos))
            titleLbl.Text = title .. " / " .. thaiTitle .. " (" .. val .. ")"
            pcall(function() callback(val) end)
        end
    end)
end

getgenv().PremiumSettings = {
    SpeedEnabled = false,
    WalkSpeedValue = 16,
    ESPGlow = false,
    ESPBoxTracer = false,
    AimbotHead = false,
    AimbotTorso = false,
    ShowFOV = false,
    FOVSize = 100,
    FPSBoost = false,
    FloatingStats = false
}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Color = Color3.fromRGB(0, 162, 255)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8

local FloatFrame = Instance.new("Frame", ScreenGui)
FloatFrame.Name = "FloatingStatsFrame"
FloatFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 25)
FloatFrame.BorderColor3 = Color3.fromRGB(0, 162, 255)
FloatFrame.BorderSizePixel = 1
FloatFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
FloatFrame.Size = UDim2.new(0, 140, 0, 38)
FloatFrame.Visible = false
FloatFrame.Active = true
FloatFrame.Draggable = true

local FloatText = Instance.new("TextLabel", FloatFrame)
FloatText.BackgroundTransparency = 1
FloatText.Size = UDim2.new(1, 0, 1, 0)
FloatText.Font = Enum.Font.GothamBold
FloatText.Text = "FPS: 60 | Ping: 0ms"
FloatText.TextColor3 = Color3.fromRGB(0, 180, 255)
FloatText.TextSize = 10

-- 1. หน้า Home
local HomePage = CreatePage("Home")
HomePage.Visible = true
AddMenuButton("Home", "H", "หน้าหลัก")
MenuButtons[1].Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MenuButtons[1].Button.TextColor3 = Color3.fromRGB(255, 255, 255)

local WelcomeCard = Instance.new("Frame", HomePage)
WelcomeCard.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
WelcomeCard.BorderSizePixel = 0
WelcomeCard.Size = UDim2.new(1, -4, 0, 55)

local WC_Text1 = Instance.new("TextLabel", WelcomeCard)
WC_Text1.BackgroundTransparency = 1
WC_Text1.Position = UDim2.new(0, 10, 0, 8)
WC_Text1.Size = UDim2.new(1, -20, 0, 18)
WC_Text1.Font = Enum.Font.GothamBold
WC_Text1.Text = "🌙 PREMIUM SCRIPT v1.2"
WC_Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
WC_Text1.TextSize = 10
WC_Text1.TextXAlignment = Enum.TextXAlignment.Left

local WC_Text2 = Instance.new("TextLabel", WelcomeCard)
WC_Text2.BackgroundTransparency = 1
WC_Text2.Position = UDim2.new(0, 10, 0, 28)
WC_Text2.Size = UDim2.new(1, -20, 0, 18)
WC_Text2.Font = Enum.Font.Gotham
WC_Text2.Text = "Protected with Dark Blue Engine"
WC_Text2.TextColor3 = Color3.fromRGB(200, 220, 255)
WC_Text2.TextSize = 8
WC_Text2.TextXAlignment = Enum.TextXAlignment.Left

local DiscordCard = Instance.new("Frame", HomePage)
DiscordCard.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
DiscordCard.BorderColor3 = Color3.fromRGB(0, 162, 255)
DiscordCard.BorderSizePixel = 1
DiscordCard.Size = UDim2.new(1, -4, 0, 65)

local DC_Title = Instance.new("TextLabel", DiscordCard)
DC_Title.BackgroundTransparency = 1
DC_Title.Position = UDim2.new(0, 10, 0, 6)
DC_Title.Size = UDim2.new(1, -20, 0, 16)
DC_Title.Font = Enum.Font.GothamBold
DC_Title.Text = "💬 Discord & Contact / ติดต่อผู้ดูแล"
DC_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
DC_Title.TextSize = 9
DC_Title.TextXAlignment = Enum.TextXAlignment.Left

local DC_Desc = Instance.new("TextLabel", DiscordCard)
DC_Desc.BackgroundTransparency = 1
DC_Desc.Position = UDim2.new(0, 10, 0, 22)
DC_Desc.Size = UDim2.new(1, -20, 0, 14)
DC_Desc.Font = Enum.Font.Gotham
DC_Desc.Text = "discord.gg/n6ngbTKaAe"
DC_Desc.TextColor3 = Color3.fromRGB(150, 170, 200)
DC_Desc.TextSize = 8
DC_Desc.TextXAlignment = Enum.TextXAlignment.Left

local CopyDiscordBtn = Instance.new("TextButton", DiscordCard)
CopyDiscordBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
CopyDiscordBtn.BorderSizePixel = 0
CopyDiscordBtn.Position = UDim2.new(0, 10, 0, 38)
CopyDiscordBtn.Size = UDim2.new(1, -20, 0, 20)
CopyDiscordBtn.Font = Enum.Font.GothamBold
CopyDiscordBtn.Text = "📋 Copy Link"
CopyDiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyDiscordBtn.TextSize = 8

CopyDiscordBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/n6ngbTKaAe") end)
    CopyDiscordBtn.Text = "✅ Copied!"
    task.wait(1.5)
    CopyDiscordBtn.Text = "📋 Copy Link"
end)

local StatsGrid = Instance.new("Frame", HomePage)
StatsGrid.BackgroundTransparency = 1
StatsGrid.Size = UDim2.new(1, -4, 0, 45)

local function CreateStatBox(posX, title)
    local box = Instance.new("Frame", StatsGrid)
    box.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
    box.BorderColor3 = Color3.fromRGB(40, 55, 85)
    box.Position = UDim2.new(posX, 0, 0, 0)
    box.Size = UDim2.new(0.32, 0, 1, 0)
    
    local valLabel = Instance.new("TextLabel", box)
    valLabel.Name = "Val"
    valLabel.BackgroundTransparency = 1
    valLabel.Position = UDim2.new(0, 0, 0, 5)
    valLabel.Size = UDim2.new(1, 0, 0, 18)
    valLabel.Font = Enum.Font.GothamBold
    valLabel.Text = "0"
    valLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
    valLabel.TextSize = 12
    
    local titleLabel = Instance.new("TextLabel", box)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 0, 0, 24)
    titleLabel.Size = UDim2.new(1, 0, 0, 14)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(120, 140, 170)
    titleLabel.TextSize = 7
    
    return box
end

local FpsBox = CreateStatBox(0, "FPS")
local PingBox = CreateStatBox(0.34, "PING")
local PlayerBox = CreateStatBox(0.68, "PLAYER")

-- 2. หน้า Player
AddMenuButton("Player", "P", "ผู้เล่น")
local PlayerPage = CreatePage("Player")

CreateToggle(PlayerPage, "Speed Hack (Anti-Ban Safe)", "เปิดเดินเร็ว", function(state)
    getgenv().PremiumSettings.SpeedEnabled = state
    if not state then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end)
    end
end)

CreateSlider(PlayerPage, "WalkSpeed Value", "ระดับความเร็ว", 16, 150, 16, function(val)
    getgenv().PremiumSettings.WalkSpeedValue = val
end)

-- 3. หน้า ESP
AddMenuButton("ESP", "E", "การมองเห็น")
local EspPage = CreatePage("ESP")

CreateToggle(EspPage, "ESP Glow", "เรืองแสง (Glow)", function(state)
    getgenv().PremiumSettings.ESPGlow = state
    if not state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("PremiumGlow") then
                plr.Character.PremiumGlow:Destroy()
            end
        end
    end
end)

CreateToggle(EspPage, "ESP Box + Tracer", "กรอบ + เส้นโยง", function(state)
    getgenv().PremiumSettings.ESPBoxTracer = state
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.Box then espData.Box.Visible = false end
            if espData.Tracer then espData.Tracer.Visible = false end
        end
    end
end)

-- 4. หน้า Aimbot
AddMenuButton("Aimbot", "A", "ล็อคเป้า")
local AimbotPage = CreatePage("Aimbot")

CreateToggle(AimbotPage, "Aimbot - Head Lock", "ล็อคหัว", function(state)
    getgenv().PremiumSettings.AimbotHead = state
    if state then getgenv().PremiumSettings.AimbotTorso = false end
end)

CreateToggle(AimbotPage, "Aimbot - Torso Lock", "ล็อคตัว", function(state)
    getgenv().PremiumSettings.AimbotTorso = state
    if state then getgenv().PremiumSettings.AimbotHead = false end
end)

CreateToggle(AimbotPage, "Show FOV", "แสดงวง FOV", function(state)
    getgenv().PremiumSettings.ShowFOV = state
    FOVCircle.Visible = state
end)

CreateSlider(AimbotPage, "FOV Size", "ขนาด FOV", 30, 300, 100, function(val)
    getgenv().PremiumSettings.FOVSize = val
end)

-- 5. หน้า Settings
AddMenuButton("Settings", "S", "ตั้งค่า")
local SettingsPage = CreatePage("Settings")

CreateToggle(SettingsPage, "Floating FPS/Ping", "สถิติลอย", function(state)
    getgenv().PremiumSettings.FloatingStats = state
    FloatFrame.Visible = state
end)

CreateToggle(SettingsPage, "FPS & Ping Booster", "บูสความลื่น", function(state)
    getgenv().PremiumSettings.FPSBoost = state
    if state then
        pcall(function()
            if NetworkSettings then NetworkSettings.IncomingReplicationLag = 0 end
            Lighting.GlobalShadows = false
        end)
    else
        pcall(function()
            if NetworkSettings then NetworkSettings.IncomingReplicationLag = 0.1 end
            Lighting.GlobalShadows = true
        end)
    end
end)

-- 6. หน้า Security
AddMenuButton("Security", "🛡", "ความปลอดภัย")
local SecurityPage = CreatePage("Security")

local SecInfoCard = Instance.new("Frame", SecurityPage)
SecInfoCard.BackgroundColor3 = Color3.fromRGB(18, 22, 35)
SecInfoCard.BorderColor3 = Color3.fromRGB(0, 162, 255)
SecInfoCard.BorderSizePixel = 1
SecInfoCard.Size = UDim2.new(1, -4, 0, 140)

local SI_Title = Instance.new("TextLabel", SecInfoCard)
SI_Title.BackgroundTransparency = 1
SI_Title.Position = UDim2.new(0, 10, 0, 8)
SI_Title.Size = UDim2.new(1, -20, 0, 16)
SI_Title.Font = Enum.Font.GothamBold
SI_Title.Text = "🛡️ Shield Protection Active"
SI_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
SI_Title.TextSize = 9
SI_Title.TextXAlignment = Enum.TextXAlignment.Left

local SI_Desc = Instance.new("TextLabel", SecInfoCard)
SI_Desc.BackgroundTransparency = 1
SI_Desc.Position = UDim2.new(0, 10, 0, 28)
SI_Desc.Size = UDim2.new(1, -20, 0, 105)
SI_Desc.Font = Enum.Font.Gotham
SI_Desc.Text = "• Anti-Ban & Telemetry: ป้องกันแบน\n• Anti-Report: บล็อกการรีพอร์ต\n• Anti-Kick: ป้องกันเตะ/ดึงตัว\n• Clean Cache: ล้างแรมอัตโนมัติ"
SI_Desc.TextColor3 = Color3.fromRGB(150, 170, 200)
SI_Desc.TextSize = 8
SI_Desc.TextXAlignment = Enum.TextXAlignment.Left

-- Footer
local Footer = Instance.new("Frame", ContentArea)
Footer.BackgroundColor3 = Color3.fromRGB(8, 10, 18)
Footer.BorderSizePixel = 0
Footer.Position = UDim2.new(0, 0, 1, -24)
Footer.Size = UDim2.new(1, 0, 0, 24)

local FooterText = Instance.new("TextLabel", Footer)
FooterText.BackgroundTransparency = 1
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.Font = Enum.Font.GothamBold
FooterText.Text = "Premium Script by.Nongmin - v1.2"
FooterText.TextColor3 = Color3.fromRGB(0, 180, 255)
FooterText.TextSize = 8
FooterText.TextXAlignment = Enum.TextXAlignment.Center

-- Main Loop
local ESPContainer = {}

RunService.RenderStepped:Connect(function(dt)
    local currentFPS = math.floor(1 / math.max(dt, 0.001))
    local pingVal = 0
    pcall(function() pingVal = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    
    FpsBox.Val.Text = tostring(currentFPS)
    PingBox.Val.Text = tostring(pingVal) .. "ms"
    PlayerBox.Val.Text = tostring(#Players:GetPlayers())

    if getgenv().PremiumSettings.FloatingStats then
        FloatText.Text = "FPS: " .. currentFPS .. " | Ping: " .. pingVal .. "ms"
    end

    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().PremiumSettings.SpeedEnabled then
            char.Humanoid.WalkSpeed = getgenv().PremiumSettings.WalkSpeedValue
        end
    end)

    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local char = plr.Character
                if getgenv().PremiumSettings.ESPGlow and char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    if not char:FindFirstChild("PremiumGlow") then
                        local glow = Instance.new("Highlight")
                        glow.Name = "PremiumGlow"
                        glow.Adornee = char
                        glow.FillColor = Color3.fromRGB(0, 120, 255)
                        glow.OutlineColor = Color3.fromRGB(150, 100, 255)
                        glow.FillTransparency = 0.3
                        glow.Parent = char
                    end
                else
                    if char and char:FindFirstChild("PremiumGlow") then char.PremiumGlow:Destroy() end
                end
            end
        end
    end)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if getgenv().PremiumSettings.ESPBoxTracer then
                if not ESPContainer[plr] then
                    local box = Drawing.new("Square")
                    box.Visible = false
                    box.Color = Color3.fromRGB(0, 162, 255)
                    box.Thickness = 1.5
                    box.Filled = false

                    local tracer = Drawing.new("Line")
                    tracer.Visible = false
                    tracer.Color = Color3.fromRGB(150, 100, 255)
                    tracer.Thickness = 1

                    ESPContainer[plr] = {Box = box, Tracer = tracer}
                end

                local char = plr.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    local hrp = char.HumanoidRootPart
                    local head = char:FindFirstChild("Head")
                    if head then
                        local topPosition = head.Position + Vector3.new(0, 0.7, 0)
                        local bottomPosition = hrp.Position - Vector3.new(0, 2.8, 0)
                        
                        local topPos, topOnScreen = Camera:WorldToViewportPoint(topPosition)
                        local bottomPos, bottomOnScreen = Camera:WorldToViewportPoint(bottomPosition)

                        if topOnScreen or bottomOnScreen then
                            local box = ESPContainer[plr].Box
                            local tracer = ESPContainer[plr].Tracer
                            
                            local height = math.abs(bottomPos.Y - topPos.Y)
                            local width = height / 2

                            box.Size = Vector2.new(width, height)
                            box.Position = Vector2.new(topPos.X - width / 2, topPos.Y)
                            box.Visible = true

                            tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            tracer.To = Vector2.new(bottomPos.X, bottomPos.Y)
                            tracer.Visible = true
                        else
                            ESPContainer[plr].Box.Visible = false
                            ESPContainer[plr].Tracer.Visible = false
                        end
                    end
                else
                    if ESPContainer[plr] then
                        ESPContainer[plr].Box.Visible = false
                        ESPContainer[plr].Tracer.Visible = false
                    end
                end
            else
                if ESPContainer[plr] then
                    if ESPContainer[plr].Box then ESPContainer[plr].Box:Remove() end
                    if ESPContainer[plr].Tracer then ESPContainer[plr].Tracer:Remove() end
                    ESPContainer[plr] = nil
                end
            end
        end
    end

    pcall(function()
        if getgenv().PremiumSettings.ShowFOV then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            FOVCircle.Radius = getgenv().PremiumSettings.FOVSize
            FOVCircle.Visible = true
        else
            FOVCircle.Visible = false
        end
    end)

    pcall(function()
        if getgenv().PremiumSettings.AimbotHead or getgenv().PremiumSettings.AimbotTorso then
            local closestTarget = nil
            local shortestDist = getgenv().PremiumSettings.FOVSize
            local origin = Camera.CFrame.Position

            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                    local targetPart = nil
                    if getgenv().PremiumSettings.AimbotHead then
                        targetPart = plr.Character:FindFirstChild("Head")
                    elseif getgenv().PremiumSettings.AimbotTorso then
                        targetPart = plr.Character:FindFirstChild("UpperTorso") or plr.Character:FindFirstChild("Torso")
                    end

                    if targetPart then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local mouseDist = (Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                            if mouseDist < shortestDist then
                                local direction = targetPart.Position - origin
                                local raycastParams = RaycastParams.new()
                                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                                raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, plr.Character}

                                local raycastResult = Workspace:Raycast(origin, direction, raycastParams)

                                if not raycastResult then
                                    shortestDist = mouseDist
                                    closestTarget = targetPart
                                end
                            end
                        end
                    end
                end
            end

            if closestTarget then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position)
            end
        end
    end)
end)
