-- =====================================================================
-- Min Hub - Maximum Security & Stealth Edition (Bilingual / Dual Language)
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- =====================================================================
-- ระบบฝังป้องกันอัตโนมัติเบื้องหลัง (Maximum Anti-Ban & Anti-Kick Hooks)
-- =====================================================================
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" and self == LocalPlayer then
            return
        end
        
        if method == "ReportAbuse" or method == "PostAsync" or method == "GetAsync" then
            if type(args[1]) == "string" and (string.match(args[1], "ban") or string.match(args[1], "detect") or string.match(args[1], "telemetry")) then
                return
            end
        end
        
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
    
    pcall(function()
        for _, conn in pairs(getconnections(game:GetService("ScriptContext").Error)) do
            conn:Disable()
        end
    end)
end)

if CoreGui:FindFirstChild("MinHubFixedMenu") then
    CoreGui.MinHubFixedMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MinHubFixedMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- =====================================================================
-- หน้าต่างระบบกรอก Key (Key System UI)
-- =====================================================================
local KeyScreen = Instance.new("Frame", ScreenGui)
KeyScreen.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
KeyScreen.BorderColor3 = Color3.fromRGB(0, 255, 128)
KeyScreen.BorderSizePixel = 1
KeyScreen.AnchorPoint = Vector2.new(0.5, 0.5)
KeyScreen.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyScreen.Size = UDim2.new(0, 380, 0, 240)
KeyScreen.Active = true
KeyScreen.Draggable = true

local KeyTitle = Instance.new("TextLabel", KeyScreen)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 20, 0, 20)
KeyTitle.Size = UDim2.new(1, -40, 0, 30)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "MIN HUB - SECURITY KEY"
KeyTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
KeyTitle.TextSize = 16
KeyTitle.TextXAlignment = Enum.TextXAlignment.Center

local KeySub = Instance.new("TextLabel", KeyScreen)
KeySub.BackgroundTransparency = 1
KeySub.Position = UDim2.new(0, 20, 0, 50)
KeySub.Size = UDim2.new(1, -40, 0, 20)
KeySub.Font = Enum.Font.Gotham
KeySub.Text = "Enter Security Key / กรอกรหัสความปลอดภัย"
KeySub.TextColor3 = Color3.fromRGB(150, 150, 170)
KeySub.TextSize = 10
KeySub.TextXAlignment = Enum.TextXAlignment.Center

local KeyBox = Instance.new("TextBox", KeyScreen)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
KeyBox.BorderColor3 = Color3.fromRGB(40, 40, 55)
KeyBox.Position = UDim2.new(0, 30, 0, 85)
KeyBox.Size = UDim2.new(1, -60, 0, 35)
KeyBox.Font = Enum.Font.GothamSemibold
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
KeyBox.TextSize = 12

local SubmitKeyBtn = Instance.new("TextButton", KeyScreen)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
SubmitKeyBtn.BorderSizePixel = 0
SubmitKeyBtn.Position = UDim2.new(0, 30, 0, 130)
SubmitKeyBtn.Size = UDim2.new(1, -60, 0, 32)
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.Text = "VERIFY KEY / ยืนยันรหัส"
SubmitKeyBtn.TextColor3 = Color3.fromRGB(12, 12, 16)
SubmitKeyBtn.TextSize = 11

local CancelKeyBtn = Instance.new("TextButton", KeyScreen)
CancelKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
CancelKeyBtn.BorderColor3 = Color3.fromRGB(50, 50, 65)
CancelKeyBtn.Position = UDim2.new(0, 30, 0, 172)
CancelKeyBtn.Size = UDim2.new(1, -60, 0, 30)
CancelKeyBtn.Font = Enum.Font.GothamBold
CancelKeyBtn.Text = "CANCEL / ยกเลิก"
CancelKeyBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
CancelKeyBtn.TextSize = 11

CancelKeyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- หน้าต่างโหลดแอนิเมชั่น (Loading Screen)
local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
LoadingFrame.BorderColor3 = Color3.fromRGB(0, 255, 128)
LoadingFrame.BorderSizePixel = 1
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.Size = UDim2.new(0, 380, 0, 220)
LoadingFrame.Visible = false

local LoadTitle = Instance.new("TextLabel", LoadingFrame)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 20, 0, 50)
LoadTitle.Size = UDim2.new(1, -40, 0, 30)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "Loading Anti-Ban System..."
LoadTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
LoadTitle.TextSize = 13
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center

local LoadPercent = Instance.new("TextLabel", LoadingFrame)
LoadPercent.BackgroundTransparency = 1
LoadPercent.Position = UDim2.new(0, 20, 0, 90)
LoadPercent.Size = UDim2.new(1, -40, 0, 30)
LoadPercent.Font = Enum.Font.GothamBold
LoadPercent.Text = "0%"
LoadPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadPercent.TextSize = 20
LoadPercent.TextXAlignment = Enum.TextXAlignment.Center

local LoadSubText = Instance.new("TextLabel", LoadingFrame)
LoadSubText.BackgroundTransparency = 1
LoadSubText.Position = UDim2.new(0, 20, 0, 140)
LoadSubText.Size = UDim2.new(1, -40, 0, 30)
LoadSubText.Font = Enum.Font.Gotham
LoadSubText.Text = "Anti-Ban & Anti-Kick Active"
LoadSubText.TextColor3 = Color3.fromRGB(120, 120, 140)
LoadSubText.TextSize = 9
LoadSubText.TextXAlignment = Enum.TextXAlignment.Center

-- หน้าต่างหลักของเมนู
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 128)
MainFrame.BorderSizePixel = 1
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleButton.BorderColor3 = Color3.fromRGB(0, 255, 128)
ToggleButton.BorderSizePixel = 1
ToggleButton.Position = UDim2.new(0, 20, 0.5, -20)
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "MIN"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 128)
ToggleButton.TextSize = 12
ToggleButton.Visible = false

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

SubmitKeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "Min" then
        KeyScreen.Visible = false
        LoadingFrame.Visible = true
        
        for i = 1, 100 do
            LoadPercent.Text = i .. "%"
            task.wait(0.015)
        end
        
        LoadTitle.Text = "Security Complete! Starting..."
        task.wait(5)
        
        LoadingFrame.Visible = false
        MainFrame.Visible = true
        ToggleButton.Visible = true
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "❌ Incorrect Key! / รหัสไม่ถูกต้อง"
    end
end)

-- Sidebar ด้านซ้าย
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Sidebar.BorderSizePixel = 0
Sidebar.Size = UDim2.new(0, 150, 1, 0)

local LogoTitle = Instance.new("TextLabel", Sidebar)
LogoTitle.BackgroundTransparency = 1
LogoTitle.Position = UDim2.new(0, 12, 0, 12)
LogoTitle.Size = UDim2.new(0, 120, 0, 20)
LogoTitle.Font = Enum.Font.GothamBold
LogoTitle.Text = "MIN HUB"
LogoTitle.TextColor3 = Color3.fromRGB(0, 255, 128)
LogoTitle.TextSize = 16
LogoTitle.TextXAlignment = Enum.TextXAlignment.Left

local LogoSub = Instance.new("TextLabel", Sidebar)
LogoSub.BackgroundTransparency = 1
LogoSub.Position = UDim2.new(0, 12, 0, 32)
LogoSub.Size = UDim2.new(0, 120, 0, 15)
LogoSub.Font = Enum.Font.Gotham
LogoSub.Text = "MAX SECURITY"
LogoSub.TextColor3 = Color3.fromRGB(120, 120, 140)
LogoSub.TextSize = 8
LogoSub.TextXAlignment = Enum.TextXAlignment.Left

local MenuHolder = Instance.new("Frame", Sidebar)
MenuHolder.BackgroundTransparency = 1
MenuHolder.Position = UDim2.new(0, 0, 0, 55)
MenuHolder.Size = UDim2.new(1, 0, 1, -110)

local UIList = Instance.new("UIListLayout", MenuHolder)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 5)

local ProfileFrame = Instance.new("Frame", Sidebar)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Position = UDim2.new(0, 8, 1, -48)
ProfileFrame.Size = UDim2.new(1, -16, 0, 40)

local ProfileName = Instance.new("TextLabel", ProfileFrame)
ProfileName.BackgroundTransparency = 1
ProfileName.Position = UDim2.new(0, 10, 0, 5)
ProfileName.Size = UDim2.new(1, -10, 0, 15)
ProfileName.Font = Enum.Font.GothamBold
ProfileName.Text = LocalPlayer.Name
ProfileName.TextColor3 = Color3.fromRGB(240, 240, 240)
ProfileName.TextSize = 10
ProfileName.TextXAlignment = Enum.TextXAlignment.Left

local ProfileRole = Instance.new("TextLabel", ProfileFrame)
ProfileRole.BackgroundTransparency = 1
ProfileRole.Position = UDim2.new(0, 10, 0, 20)
ProfileRole.Size = UDim2.new(1, -10, 0, 15)
ProfileRole.Font = Enum.Font.Gotham
ProfileRole.Text = "Stealth Mode"
ProfileRole.TextColor3 = Color3.fromRGB(0, 255, 128)
ProfileRole.TextSize = 8
ProfileRole.TextXAlignment = Enum.TextXAlignment.Left

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 150, 0, 0)
ContentArea.Size = UDim2.new(1, -150, 1, 0)

local TopBar = Instance.new("Frame", ContentArea)
TopBar.BackgroundTransparency = 1
TopBar.Position = UDim2.new(0, 15, 0, 10)
TopBar.Size = UDim2.new(1, -30, 0, 30)

local PageTitle = Instance.new("TextLabel", TopBar)
PageTitle.BackgroundTransparency = 1
PageTitle.Size = UDim2.new(0, 200, 1, 0)
PageTitle.Font = Enum.Font.GothamBold
PageTitle.Text = "Home / หน้าหลัก"
PageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PageTitle.TextSize = 14
PageTitle.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -25, 0, 2)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 10

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local PagesHolder = Instance.new("Frame", ContentArea)
PagesHolder.BackgroundTransparency = 1
PagesHolder.Position = UDim2.new(0, 15, 0, 45)
PagesHolder.Size = UDim2.new(1, -30, 1, -85)

local Pages = {}
local MenuButtons = {}

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame", PagesHolder)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 420)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    Pages[name] = page
    return page
end

local function AddMenuButton(name, icon, thaiName)
    local btn = Instance.new("TextButton", MenuHolder)
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -15, 0, 30)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = "  " .. icon .. "   " .. name .. " / " .. thaiName
    btn.TextColor3 = Color3.fromRGB(140, 140, 160)
    btn.TextSize = 9
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    table.insert(MenuButtons, {Button = btn, Name = name})
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, mb in ipairs(MenuButtons) do
            mb.Button.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
            mb.Button.TextColor3 = Color3.fromRGB(140, 140, 160)
        end
        if Pages[name] then
            Pages[name].Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
            btn.TextColor3 = Color3.fromRGB(15, 15, 20)
            PageTitle.Text = name .. " / " .. thaiName
        end
    end)
end

local function CreateToggle(parent, title, thaiTitle, callback)
    local toggleBtn = Instance.new("TextButton", parent)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    toggleBtn.BorderColor3 = Color3.fromRGB(40, 40, 55)
    toggleBtn.Size = UDim2.new(1, -5, 0, 35)
    toggleBtn.Font = Enum.Font.GothamSemibold
    toggleBtn.Text = "   " .. title .. " / " .. thaiTitle
    toggleBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    toggleBtn.TextSize = 9
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left

    local statusLbl = Instance.new("TextLabel", toggleBtn)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Position = UDim2.new(1, -60, 0, 0)
    statusLbl.Size = UDim2.new(0, 50, 1, 0)
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.Text = "[ OFF ]"
    statusLbl.TextColor3 = Color3.fromRGB(220, 50, 50)
    statusLbl.TextSize = 10

    local enabled = false
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            statusLbl.Text = "[ ON ]"
            statusLbl.TextColor3 = Color3.fromRGB(0, 255, 128)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 35, 25)
        else
            statusLbl.Text = "[ OFF ]"
            statusLbl.TextColor3 = Color3.fromRGB(220, 50, 50)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        end
        pcall(function() callback(enabled) end)
    end)
    return toggleBtn
end

local function CreateSlider(parent, title, thaiTitle, min, max, default, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    sliderFrame.BorderColor3 = Color3.fromRGB(40, 40, 55)
    sliderFrame.Size = UDim2.new(1, -5, 0, 50)

    local titleLbl = Instance.new("TextLabel", sliderFrame)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, 10, 0, 5)
    titleLbl.Size = UDim2.new(1, -20, 0, 20)
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.Text = title .. " / " .. thaiTitle .. " (" .. default .. ")"
    titleLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleLbl.TextSize = 9
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("TextButton", sliderFrame)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    bar.BorderSizePixel = 0
    bar.Position = UDim2.new(0, 10, 0, 30)
    bar.Size = UDim2.new(1, -20, 0, 8)
    bar.Text = ""

    local fill = Instance.new("Frame", bar)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)

    local dragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + ((max - min) * pos))
            titleLbl.Text = title .. " / " .. thaiTitle .. " (" .. val .. ")"
            pcall(function() callback(val) end)
        end
    end)
end

-- ตัวแปรตั้งค่าระบบ
getgenv().MinSettings = {
    SpeedEnabled = false,
    JumpEnabled = false,
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
FOVCircle.Color = Color3.fromRGB(0, 255, 128)
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8

local FloatFrame = Instance.new("Frame", ScreenGui)
FloatFrame.Name = "FloatingStatsFrame"
FloatFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
FloatFrame.BorderColor3 = Color3.fromRGB(0, 255, 128)
FloatFrame.BorderSizePixel = 1
FloatFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
FloatFrame.Size = UDim2.new(0, 160, 0, 45)
FloatFrame.Visible = false
FloatFrame.Active = true
FloatFrame.Draggable = true

local FloatText = Instance.new("TextLabel", FloatFrame)
FloatText.BackgroundTransparency = 1
FloatText.Size = UDim2.new(1, 0, 1, 0)
FloatText.Font = Enum.Font.GothamBold
FloatText.Text = "FPS: 60 | Ping: 0ms"
FloatText.TextColor3 = Color3.fromRGB(0, 255, 128)
FloatText.TextSize = 11

-- =====================================================================
-- 1. หน้า Home (หน้าหลัก)
-- =====================================================================
local HomePage = CreatePage("Home")
HomePage.Visible = true
AddMenuButton("Home", "H", "หน้าหลัก")
MenuButtons[1].Button.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
MenuButtons[1].Button.TextColor3 = Color3.fromRGB(15, 15, 20)

local WelcomeCard = Instance.new("Frame", HomePage)
WelcomeCard.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
WelcomeCard.BorderSizePixel = 0
WelcomeCard.Size = UDim2.new(1, -5, 0, 65)

local WC_Text1 = Instance.new("TextLabel", WelcomeCard)
WC_Text1.BackgroundTransparency = 1
WC_Text1.Position = UDim2.new(0, 12, 0, 12)
WC_Text1.Size = UDim2.new(1, -24, 0, 20)
WC_Text1.Font = Enum.Font.GothamBold
WC_Text1.Text = "Welcome, " .. LocalPlayer.Name .. " 🚀"
WC_Text1.TextColor3 = Color3.fromRGB(15, 15, 20)
WC_Text1.TextSize = 12
WC_Text1.TextXAlignment = Enum.TextXAlignment.Left

local WC_Text2 = Instance.new("TextLabel", WelcomeCard)
WC_Text2.BackgroundTransparency = 1
WC_Text2.Position = UDim2.new(0, 12, 0, 32)
WC_Text2.Size = UDim2.new(1, -24, 0, 20)
WC_Text2.Font = Enum.Font.Gotham
WC_Text2.Text = "Stealth Mode & Auto Anti-Ban Enabled!"
WC_Text2.TextColor3 = Color3.fromRGB(30, 30, 40)
WC_Text2.TextSize = 9
WC_Text2.TextXAlignment = Enum.TextXAlignment.Left

local DiscordCard = Instance.new("Frame", HomePage)
DiscordCard.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
DiscordCard.BorderColor3 = Color3.fromRGB(0, 255, 128)
DiscordCard.BorderSizePixel = 1
DiscordCard.Size = UDim2.new(1, -5, 0, 75)

local DC_Title = Instance.new("TextLabel", DiscordCard)
DC_Title.BackgroundTransparency = 1
DC_Title.Position = UDim2.new(0, 12, 0, 8)
DC_Title.Size = UDim2.new(1, -24, 0, 18)
DC_Title.Font = Enum.Font.GothamBold
DC_Title.Text = "💬 Discord & Contact / ติดต่อผู้ดูแล"
DC_Title.TextColor3 = Color3.fromRGB(0, 255, 128)
DC_Title.TextSize = 11
DC_Title.TextXAlignment = Enum.TextXAlignment.Left

local DC_Desc = Instance.new("TextLabel", DiscordCard)
DC_Desc.BackgroundTransparency = 1
DC_Desc.Position = UDim2.new(0, 12, 0, 26)
DC_Desc.Size = UDim2.new(1, -24, 0, 15)
DC_Desc.Font = Enum.Font.Gotham
DC_Desc.Text = "discord.gg/3hFUegUh8a (Click to Copy / คลิกเพื่อคัดลอก)"
DC_Desc.TextColor3 = Color3.fromRGB(180, 180, 200)
DC_Desc.TextSize = 9
DC_Desc.TextXAlignment = Enum.TextXAlignment.Left

local CopyDiscordBtn = Instance.new("TextButton", DiscordCard)
CopyDiscordBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
CopyDiscordBtn.BorderSizePixel = 0
CopyDiscordBtn.Position = UDim2.new(0, 12, 0, 45)
CopyDiscordBtn.Size = UDim2.new(1, -24, 0, 22)
CopyDiscordBtn.Font = Enum.Font.GothamBold
CopyDiscordBtn.Text = "📋 Copy Discord Link / คัดลอกลิงก์ Discord"
CopyDiscordBtn.TextColor3 = Color3.fromRGB(15, 15, 20)
CopyDiscordBtn.TextSize = 9

CopyDiscordBtn.MouseButton1Click:Connect(function()
    local discordLink = "https://discord.gg/3hFUegUh8a"
    pcall(function()
        setclipboard(discordLink)
    end)
    CopyDiscordBtn.Text = "✅ Copied Successfully / คัดลอกลิงก์สำเร็จ!"
    task.wait(1.5)
    CopyDiscordBtn.Text = "📋 Copy Discord Link / คัดลอกลิงก์ Discord"
end)

local StatsGrid = Instance.new("Frame", HomePage)
StatsGrid.BackgroundTransparency = 1
StatsGrid.Size = UDim2.new(1, -5, 0, 55)

local function CreateStatBox(posX, title)
    local box = Instance.new("Frame", StatsGrid)
    box.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    box.BorderColor3 = Color3.fromRGB(40, 40, 55)
    box.Position = UDim2.new(posX, 0, 0, 0)
    box.Size = UDim2.new(0.32, 0, 1, 0)
    
    local valLabel = Instance.new("TextLabel", box)
    valLabel.Name = "Val"
    valLabel.BackgroundTransparency = 1
    valLabel.Position = UDim2.new(0, 0, 0, 8)
    valLabel.Size = UDim2.new(1, 0, 0, 20)
    valLabel.Font = Enum.Font.GothamBold
    valLabel.Text = "0"
    valLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
    valLabel.TextSize = 14
    
    local titleLabel = Instance.new("TextLabel", box)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 0, 0, 30)
    titleLabel.Size = UDim2.new(1, 0, 0, 15)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
    titleLabel.TextSize = 8
    
    return box
end

local FpsBox = CreateStatBox(0, "FPS")
local PingBox = CreateStatBox(0.34, "PING")
local PlayerBox = CreateStatBox(0.68, "PLAYER")

-- =====================================================================
-- 2. หน้า Player (ผู้เล่น)
-- =====================================================================
AddMenuButton("Player", "P", "ผู้เล่น")
local PlayerPage = CreatePage("Player")

CreateToggle(PlayerPage, "Speed Hack", "เดินเร็ว (WalkSpeed 32)", function(state)
    getgenv().MinSettings.SpeedEnabled = state
end)

CreateToggle(PlayerPage, "High Jump", "กระโดดสูง (JumpPower 100)", function(state)
    getgenv().MinSettings.JumpEnabled = state
end)

-- =====================================================================
-- 3. หน้า ESP (การมองเห็น)
-- =====================================================================
AddMenuButton("ESP", "E", "การมองเห็น")
local EspPage = CreatePage("ESP")

CreateToggle(EspPage, "ESP Glow", "ตัวละครเรืองแสง (Glow)", function(state)
    getgenv().MinSettings.ESPGlow = state
    if not state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("MinGlow") then
                plr.Character.MinGlow:Destroy()
            end
        end
    end
end)

CreateToggle(EspPage, "ESP Box + Tracer", "กรอบสี่เหลี่ยม + เส้นโยง (Box/Tracer)", function(state)
    getgenv().MinSettings.ESPBoxTracer = state
end)

-- =====================================================================
-- 4. หน้า Aimbot (ล็อคเป้าหมาย)
-- =====================================================================
AddMenuButton("Aimbot", "A", "ล็อคเป้าหมาย")
local AimbotPage = CreatePage("Aimbot")

CreateToggle(AimbotPage, "Aimbot - Head Lock", "ล็อคหัวเป้าหมาย", function(state)
    getgenv().MinSettings.AimbotHead = state
    if state then getgenv().MinSettings.AimbotTorso = false end
end)

CreateToggle(AimbotPage, "Aimbot - Torso Lock", "ล็อคตัวเป้าหมาย", function(state)
    getgenv().MinSettings.AimbotTorso = state
    if state then getgenv().MinSettings.AimbotHead = false end
end)

CreateToggle(AimbotPage, "Show FOV", "แสดงวงล็อคเป้าหมายกลางจอ", function(state)
    getgenv().MinSettings.ShowFOV = state
    FOVCircle.Visible = state
end)

CreateSlider(AimbotPage, "FOV Size", "ขนาดวง FOV", 30, 300, 100, function(val)
    getgenv().MinSettings.FOVSize = val
end)

-- =====================================================================
-- 5. หน้า Settings (ตั้งค่า)
-- =====================================================================
AddMenuButton("Settings", "S", "ตั้งค่า")
local SettingsPage = CreatePage("Settings")

CreateToggle(SettingsPage, "Floating FPS/Ping", "เปิดกล่องสถิติลอยได้", function(state)
    getgenv().MinSettings.FloatingStats = state
    FloatFrame.Visible = state
end)

CreateToggle(SettingsPage, "FPS Booster", "เพิ่มความลื่นไหล / ลดแลค", function(state)
    getgenv().MinSettings.FPSBoost = state
    if state then
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end
    else
        Lighting.GlobalShadows = true
    end
end)

-- =====================================================================
-- 6. หน้า Security (ความปลอดภัย - ย้ายมาไว้ข้างล่าง Settings)
-- =====================================================================
AddMenuButton("Security", "🛡️", "ความปลอดภัย")
local SecurityPage = CreatePage("Security")

local SecInfoCard = Instance.new("Frame", SecurityPage)
SecInfoCard.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
SecInfoCard.BorderColor3 = Color3.fromRGB(0, 255, 128)
SecInfoCard.BorderSizePixel = 1
SecInfoCard.Size = UDim2.new(1, -5, 0, 110)

local SI_Title = Instance.new("TextLabel", SecInfoCard)
SI_Title.BackgroundTransparency = 1
SI_Title.Position = UDim2.new(0, 12, 0, 10)
SI_Title.Size = UDim2.new(1, -24, 0, 20)
SI_Title.Font = Enum.Font.GothamBold
SI_Title.Text = "🛡️ Maximum Stealth Security System"
SI_Title.TextColor3 = Color3.fromRGB(0, 255, 128)
SI_Title.TextSize = 11
SI_Title.TextXAlignment = Enum.TextXAlignment.Left

local SI_Desc = Instance.new("TextLabel", SecInfoCard)
SI_Desc.BackgroundTransparency = 1
SI_Desc.Position = UDim2.new(0, 12, 0, 35)
SI_Desc.Size = UDim2.new(1, -24, 0, 65)
SI_Desc.Font = Enum.Font.Gotham
SI_Desc.Text = "• Anti-Ban: Auto background protection (บล็อกการตรวจจับ)\n• Anti-Kick: 100% kick protection (ป้องกันการถูกเตะ)\n• Safe Mode: Script check bypass (ป้องกันเกมตรวจสคริปต์)"
SI_Desc.TextColor3 = Color3.fromRGB(180, 180, 200)
SI_Desc.TextSize = 9
SI_Desc.TextXAlignment = Enum.TextXAlignment.Left

-- Footer ด้านล่างสุด
local Footer = Instance.new("Frame", ContentArea)
Footer.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Footer.BorderSizePixel = 0
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.Size = UDim2.new(1, 0, 0, 30)

local FooterText = Instance.new("TextLabel", Footer)
FooterText.BackgroundTransparency = 1
FooterText.Size = UDim2.new(1, 0, 1, 0)
FooterText.Font = Enum.Font.Gotham
FooterText.Text = "Min Hub Maximum Security Active"
FooterText.TextColor3 = Color3.fromRGB(120, 120, 140)
FooterText.TextSize = 9
FooterText.TextXAlignment = Enum.TextXAlignment.Center

-- =====================================================================
-- ระบบประมวลผลลูปหลัก (Main Loop)
-- =====================================================================
local ESPContainer = {}

RunService.RenderStepped:Connect(function()
    local currentFPS = math.floor(1 / RunService.RenderStepped:Wait())
    local pingVal = 0
    pcall(function()
        pingVal = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    
    FpsBox.Val.Text = tostring(currentFPS)
    PingBox.Val.Text = tostring(pingVal) .. "ms"
    PlayerBox.Val.Text = tostring(#Players:GetPlayers())

    if getgenv().MinSettings.FloatingStats then
        FloatText.Text = "FPS: " .. currentFPS .. " | Ping: " .. pingVal .. "ms"
    end

    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            if getgenv().MinSettings.SpeedEnabled then hum.WalkSpeed = 32 else if hum.WalkSpeed == 32 then hum.WalkSpeed = 16 end end
            if getgenv().MinSettings.JumpEnabled then hum.UseJumpPower = true; hum.JumpPower = 100 else if hum.JumpPower == 100 then hum.JumpPower = 50 end end
        end
    end)

    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local char = plr.Character
                if getgenv().MinSettings.ESPGlow and char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    local glow = char:FindFirstChild("MinGlow")
                    if not glow then
                        glow = Instance.new("Highlight")
                        glow.Name = "MinGlow"
                        glow.Adornee = char
                        glow.FillColor = Color3.fromRGB(255, 50, 50)
                        glow.OutlineColor = Color3.fromRGB(0, 255, 128)
                        glow.FillTransparency = 0.3
                        glow.OutlineTransparency = 0
                        glow.Parent = char
                    end
                else
                    if char and char:FindFirstChild("MinGlow") then
                        char.MinGlow:Destroy()
                    end
                end
            end
        end
    end)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if getgenv().MinSettings.ESPBoxTracer then
                if not ESPContainer[plr] then
                    local box = Drawing.new("Square")
                    box.Visible = false
                    box.Color = Color3.fromRGB(0, 255, 128)
                    box.Thickness = 1.5
                    box.Filled = false

                    local tracer = Drawing.new("Line")
                    tracer.Visible = false
                    tracer.Color = Color3.fromRGB(0, 255, 128)
                    tracer.Thickness = 1

                    ESPContainer[plr] = {Box = box, Tracer = tracer}
                end

                local char = plr.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    local hrp = char.HumanoidRootPart
                    local head = char:FindFirstChild("Head")
                    
                    if head then
                        local headPos, headOnScreen = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local rootPos, rootOnScreen = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))

                        if headOnScreen or rootOnScreen then
                            local box = ESPContainer[plr].Box
                            local tracer = ESPContainer[plr].Tracer

                            local height = math.abs(headPos.Y - rootPos.Y)
                            local width = height / 2

                            box.Size = Vector2.new(width, height)
                            box.Position = Vector2.new(headPos.X - width / 2, headPos.Y)
                            box.Visible = true

                            tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            tracer.To = Vector2.new(headPos.X, rootPos.Y)
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
        if getgenv().MinSettings.ShowFOV then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            FOVCircle.Radius = getgenv().MinSettings.FOVSize
            FOVCircle.Visible = true
        else
            FOVCircle.Visible = false
        end
    end)

    pcall(function()
        if getgenv().MinSettings.AimbotHead or getgenv().MinSettings.AimbotTorso then
            local closestTarget = nil
            local shortestDist = getgenv().MinSettings.FOVSize

            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                    local targetPart = nil
                    if getgenv().MinSettings.AimbotHead then
                        targetPart = plr.Character:FindFirstChild("Head")
                    elseif getgenv().MinSettings.AimbotTorso then
                        targetPart = plr.Character:FindFirstChild("UpperTorso") or plr.Character:FindFirstChild("Torso")
                    end

                    if targetPart then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local mouseDist = (Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                            if mouseDist < shortestDist then
                                shortestDist = mouseDist
                                closestTarget = targetPart
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
