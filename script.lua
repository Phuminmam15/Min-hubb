-- =====================================================================
-- Premium script by.Nongmin - Fixed Resize Bug & Clean RGB v2.3
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ลบ UI เก่าทิ้งเพื่อเคลียร์แคช
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "NongminFixedResizeRGB" then
        v:Destroy()
    end
end

-- =====================================================================
-- [PREMIUM SECURITY CORE] ระบบป้องกันระดับพรีเมี่ยม
-- =====================================================================
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "Kick" and self == LocalPlayer then return nil end
        if method == "Teleport" or method == "TeleportToNotInServer" then return nil end
        
        if method == "ReportAbuse" or method == "PostAsync" or method == "GetAsync" or method == "JSONEncode" then
            if type(args[1]) == "string" then
                local str = string.lower(args[1])
                if string.match(str, "ban") or string.match(str, "detect") or string.match(str, "telemetry") or string.match(str, "exploit") then
                    return nil
                end
            end
        end
        
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NongminFixedResizeRGB"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MinimalRGBStrokes = {}

local function AddRGBStroke(parent, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1.5
    stroke.Color = Color3.fromRGB(0, 162, 255)
    stroke.Parent = parent
    table.insert(MinimalRGBStrokes, stroke)
    return stroke
end

-- =====================================================================
-- หน้าต่างกรอก Key
-- =====================================================================
local KeyScreen = Instance.new("Frame", ScreenGui)
KeyScreen.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
KeyScreen.BorderSizePixel = 0
KeyScreen.AnchorPoint = Vector2.new(0.5, 0.5)
KeyScreen.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyScreen.Size = UDim2.new(0, 340, 0, 210)
KeyScreen.Active = true
KeyScreen.Draggable = true
AddRGBStroke(KeyScreen, 2)

local KeyCorner = Instance.new("UICorner", KeyScreen)
KeyCorner.CornerRadius = UDim.new(0, 8)

local KeyTitle = Instance.new("TextLabel", KeyScreen)
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
KeySub.Position = UDim2.new(0, 15, 0, 42)
KeySub.Size = UDim2.new(1, -30, 0, 20)
KeySub.Font = Enum.Font.Gotham
KeySub.Text = "Enter Security Key / กรอกรหัสผ่าน"
KeySub.TextColor3 = Color3.fromRGB(160, 180, 210)
KeySub.TextSize = 9
KeySub.TextXAlignment = Enum.TextXAlignment.Center

local KeyBox = Instance.new("TextBox", KeyScreen)
KeyBox.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
KeyBox.BorderColor3 = Color3.fromRGB(45, 60, 90)
KeyBox.BorderSizePixel = 1
KeyBox.Position = UDim2.new(0, 25, 0, 72)
KeyBox.Size = UDim2.new(1, -50, 0, 32)
KeyBox.Font = Enum.Font.GothamSemibold
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 130, 170)
KeyBox.TextSize = 11

local BoxCorner = Instance.new("UICorner", KeyBox)
BoxCorner.CornerRadius = UDim.new(0, 6)

local SubmitKeyBtn = Instance.new("TextButton", KeyScreen)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitKeyBtn.BorderSizePixel = 0
SubmitKeyBtn.Position = UDim2.new(0, 25, 0, 115)
SubmitKeyBtn.Size = UDim2.new(1, -50, 0, 30)
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.Text = "✨ VERIFY KEY / ยืนยันรหัส"
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyBtn.TextSize = 10

local SubmitCorner = Instance.new("UICorner", SubmitKeyBtn)
SubmitCorner.CornerRadius = UDim.new(0, 6)

local CancelKeyBtn = Instance.new("TextButton", KeyScreen)
CancelKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
CancelKeyBtn.BorderColor3 = Color3.fromRGB(50, 60, 85)
CancelKeyBtn.Position = UDim2.new(0, 25, 0, 155)
CancelKeyBtn.Size = UDim2.new(1, -50, 0, 28)
CancelKeyBtn.Font = Enum.Font.GothamBold
CancelKeyBtn.Text = "❌ CANCEL / ยกเลิก"
CancelKeyBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CancelKeyBtn.TextSize = 10

local CancelCorner = Instance.new("UICorner", CancelKeyBtn)
CancelCorner.CornerRadius = UDim.new(0, 6)

CancelKeyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- =====================================================================
-- หน้าต่างโหลด (Loading Screen)
-- =====================================================================
local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.Size = UDim2.new(0, 340, 0, 210)
LoadingFrame.Visible = false
AddRGBStroke(LoadingFrame, 2)

local LoadCorner = Instance.new("UICorner", LoadingFrame)
LoadCorner.CornerRadius = UDim.new(0, 8)

local LoadTitle = Instance.new("TextLabel", LoadingFrame)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 15, 0, 35)
LoadTitle.Size = UDim2.new(1, -30, 0, 20)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "Loading Premium v1.2..."
LoadTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
LoadTitle.TextSize = 12
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center

local LoadPercent = Instance.new("TextLabel", LoadingFrame)
LoadPercent.BackgroundTransparency = 1
LoadPercent.Position = UDim2.new(0, 15, 0, 65)
LoadPercent.Size = UDim2.new(1, -30, 0, 30)
LoadPercent.Font = Enum.Font.GothamBold
LoadPercent.Text = "0%"
LoadPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadPercent.TextSize = 18
LoadPercent.TextXAlignment = Enum.TextXAlignment.Center

local BarBg = Instance.new("Frame", LoadingFrame)
BarBg.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
BarBg.BorderSizePixel = 0
BarBg.Position = UDim2.new(0, 25, 0, 115)
BarBg.Size = UDim2.new(1, -50, 0, 10)
local BarBgCorner = Instance.new("UICorner", BarBg)
BarBgCorner.CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame", BarBg)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
BarFill.BorderSizePixel = 0
BarFill.Size = UDim2.new(0, 0, 1, 0)
local BarFillCorner = Instance.new("UICorner", BarFill)
BarFillCorner.CornerRadius = UDim.new(1, 0)

-- =====================================================================
-- หน้าต่างหลัก (Main Frame)
-- =====================================================================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.ClipsDescendants = true -- ตัดส่วนเกินไม่ให้ล้นออกนอกกรอบตอนย่อหน้าต่าง
AddRGBStroke(MainFrame, 2.5)

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

-- ระบบลากหน้าต่างหลัก
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ปุ่ม Toggle [H] (ลากย้ายที่ได้อิสระ)
local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Image = "rbxassetid://579271238"
ToggleButton.ScaleType = Enum.ScaleType.Crop
ToggleButton.Visible = false
AddRGBStroke(ToggleButton, 2)

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(0, 10)

local ToggleLabel = Instance.new("TextLabel", ToggleButton)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
ToggleLabel.Font = Enum.Font.GothamBold
ToggleLabel.Text = "[H]"
ToggleLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
ToggleLabel.TextSize = 14

local tDragging, tDragStart, tStartPos
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tDragging = true
        tDragStart = input.Position
        tStartPos = ToggleButton.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if tDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - tDragStart
        ToggleButton.Position = UDim2.new(tStartPos.X.Scale, tStartPos.X.Offset + delta.X, tStartPos.Y.Scale, tStartPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tDragging = false
    end
end)

local function ToggleMenu()
    MainFrame.Visible = not MainFrame.Visible
end
ToggleButton.MouseButton1Click:Connect(ToggleMenu)
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.H then ToggleMenu() end
end)

SubmitKeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "Min" then
        KeyScreen.Visible = false
        LoadingFrame.Visible = true
        for i = 1, 100 do
            LoadPercent.Text = i .. "%"
            BarFill.Size = UDim2.new(i/100, 0, 1, 0)
            task.wait(0.015)
        end
        LoadingFrame.Visible = false
        MainFrame.Visible = true
        ToggleButton.Visible = true
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "❌ Incorrect Key!"
    end
end)

-- Top Bar สำหรับปุ่มหมวดหมู่ (Tab Bar ด้านบน - ใช้ AutomaticSize ป้องกันการล้น)
local TopBarHolder = Instance.new("ScrollingFrame", MainFrame)
TopBarHolder.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
TopBarHolder.BorderSizePixel = 0
TopBarHolder.Size = UDim2.new(1, -35, 0, 36)
TopBarHolder.CanvasSize = UDim2.new(0, 450, 0, 0)
TopBarHolder.ScrollBarThickness = 0
TopBarHolder.ScrollingDirection = Enum.ScrollingDirection.X

local TopBarList = Instance.new("UIListLayout", TopBarHolder)
TopBarList.FillDirection = Enum.FillDirection.Horizontal
TopBarList.SortOrder = Enum.SortOrder.LayoutOrder
TopBarList.Padding = UDim.new(0, 2)

-- ปุ่มปิดเมนู
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -30, 0, 7)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 9
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseBtn.ZIndex = 5

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ปุ่มสำหรับขยาย/ย่อขนาดหน้าต่าง (Resize Handle มุมขวาล่าง - ใช้ Scale ขนาดหน้าต่างให้ยืดหยุ่น)
local ResizeBtn = Instance.new("TextButton", MainFrame)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
ResizeBtn.BorderSizePixel = 0
ResizeBtn.Position = UDim2.new(1, -22, 1, -22)
ResizeBtn.Size = UDim2.new(0, 18, 0, 18)
ResizeBtn.Text = "◢"
ResizeBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
ResizeBtn.TextSize = 10
ResizeBtn.ZIndex = 10
AddRGBStroke(ResizeBtn, 1.5)

local ResizeCorner = Instance.new("UICorner", ResizeBtn)
ResizeCorner.CornerRadius = UDim.new(0, 4)

local resizing = false
local resizeStart, startSize
ResizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
        startSize = MainFrame.AbsoluteSize
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - resizeStart
        -- ล็อกขนาดหน้าต่างไม่ให้เล็กเกินไปจนบั๊ก (ขั้นต่ำ กว้าง 380, สูง 240)
        local newWidth = math.clamp(startSize.X + delta.X, 380, 750)
        local newHeight = math.clamp(startSize.Y + delta.Y, 240, 520)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = false
    end
end)

-- หน้าต่างแสดงเนื้อหา (ปรับขนาดให้สัมพันธ์กับ MainFrame อัตโนมัติ)
local PagesHolder = Instance.new("Frame", MainFrame)
PagesHolder.BackgroundTransparency = 1
PagesHolder.Position = UDim2.new(0, 10, 0, 45)
PagesHolder.Size = UDim2.new(1, -20, 1, -52)

local Pages = {}
local MenuButtons = {}

local function CreatePage(name, customHeight)
    local page = Instance.new("ScrollingFrame", PagesHolder)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, customHeight or 380)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    Pages[name] = page
    return page
end

local function AddTabButton(name, thaiName)
    local btn = Instance.new("TextButton", TopBarHolder)
    btn.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(0, 65, 1, 0)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(160, 180, 210)
    btn.TextSize = 8
    
    table.insert(MenuButtons, {Button = btn, Name = name})
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, mb in ipairs(MenuButtons) do
            mb.Button.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
            mb.Button.TextColor3 = Color3.fromRGB(160, 180, 210)
        end
        if Pages[name] then
            Pages[name].Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)
end

local function CreateToggle(parent, title, thaiTitle, callback)
    local toggleBtn = Instance.new("TextButton", parent)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
    toggleBtn.BorderColor3 = Color3.fromRGB(45, 60, 90)
    toggleBtn.BorderSizePixel = 1
    toggleBtn.Size = UDim2.new(1, -6, 0, 30)
    toggleBtn.Font = Enum.Font.GothamSemibold
    toggleBtn.Text = "  " .. title .. " / " .. thaiTitle
    toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    toggleBtn.TextSize = 8
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    
    local c = Instance.new("UICorner", toggleBtn)
    c.CornerRadius = UDim.new(0, 5)

    local statusLbl = Instance.new("TextLabel", toggleBtn)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Position = UDim2.new(1, -55, 0, 0)
    statusLbl.Size = UDim2.new(0, 45, 1, 0)
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.Text = "[ OFF ]"
    statusLbl.TextColor3 = Color3.fromRGB(255, 90, 90)
    statusLbl.TextSize = 9

    local enabled = false
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            statusLbl.Text = "[ ON ]"
            statusLbl.TextColor3 = Color3.fromRGB(50, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 40, 70)
        else
            statusLbl.Text = "[ OFF ]"
            statusLbl.TextColor3 = Color3.fromRGB(255, 90, 90)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
        end
        pcall(function() callback(enabled) end)
    end)
    return toggleBtn
end

local function CreateSlider(parent, title, thaiTitle, min, max, default, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
    sliderFrame.BorderColor3 = Color3.fromRGB(45, 60, 90)
    sliderFrame.BorderSizePixel = 1
    sliderFrame.Size = UDim2.new(1, -6, 0, 42)
    
    local c = Instance.new("UICorner", sliderFrame)
    c.CornerRadius = UDim.new(0, 5)

    local titleLbl = Instance.new("TextLabel", sliderFrame)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.Size = UDim2.new(1, -16, 0, 18)
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.Text = title .. " / " .. thaiTitle .. " (" .. default .. ")"
    titleLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    titleLbl.TextSize = 8
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("TextButton", sliderFrame)
    bar.BackgroundColor3 = Color3.fromRGB(35, 45, 75)
    bar.BorderSizePixel = 0
    bar.Position = UDim2.new(0, 8, 0, 25)
    bar.Size = UDim2.new(1, -16, 0, 6)
    bar.Text = ""
    local bc = Instance.new("UICorner", bar)
    bc.CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bar)
    fill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    local fc = Instance.new("UICorner", fill)
    fc.CornerRadius = UDim.new(1, 0)

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

getgenv().FixResizeStg = {
    SpeedEnabled = false,
    WalkSpeedValue = 16,
    ESPGlow = false,
    ESPBoxTracer = false,
    AimbotHead = false,
    AimbotTorso = false,
    ShowFOV = false,
    FOVSize = 100,
    FOVColorIndex = 1,
    FPSBoost = false,
    FloatingStats = false
}

local FOVColors = {
    Color3.fromRGB(0, 162, 255),
    Color3.fromRGB(255, 60, 60),
    Color3.fromRGB(50, 255, 120),
    Color3.fromRGB(255, 220, 0)
}
local FOVColorNames = {"[ Blue / ฟ้า ]", "[ Red / แดง ]", "[ Green / เขียว ]", "[ Yellow / เหลือง ]"}

local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Color = FOVColors[1]
FOVCircle.Thickness = 2.0
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Transparency = 0.9

-- Stats ลอย
local FloatFrame = Instance.new("Frame", ScreenGui)
FloatFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
FloatFrame.BorderSizePixel = 0
FloatFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
FloatFrame.Size = UDim2.new(0, 140, 0, 36)
FloatFrame.Visible = false
FloatFrame.Active = true
FloatFrame.Draggable = true
AddRGBStroke(FloatFrame, 1)

local FloatCorner = Instance.new("UICorner", FloatFrame)
FloatCorner.CornerRadius = UDim.new(0, 6)

local FloatText = Instance.new("TextLabel", FloatFrame)
FloatText.BackgroundTransparency = 1
FloatText.Size = UDim2.new(1, 0, 1, 0)
FloatText.Font = Enum.Font.GothamBold
FloatText.Text = "FPS: 60 | Ping: 0ms"
FloatText.TextColor3 = Color3.fromRGB(0, 180, 255)
FloatText.TextSize = 9

-- 1. หน้า Home
local HomePage = CreatePage("Home")
HomePage.Visible = true
AddTabButton("Home", "หน้าหลัก")
MenuButtons[1].Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MenuButtons[1].Button.TextColor3 = Color3.fromRGB(255, 255, 255)

local WelcomeCard = Instance.new("Frame", HomePage)
WelcomeCard.BackgroundColor3 = Color3.fromRGB(0, 90, 180)
WelcomeCard.BorderSizePixel = 0
WelcomeCard.Size = UDim2.new(1, -6, 0, 50)
local WC_Corner = Instance.new("UICorner", WelcomeCard)
WC_Corner.CornerRadius = UDim.new(0, 6)

local WC_Text1 = Instance.new("TextLabel", WelcomeCard)
WC_Text1.BackgroundTransparency = 1
WC_Text1.Position = UDim2.new(0, 10, 0, 8)
WC_Text1.Size = UDim2.new(1, -20, 0, 16)
WC_Text1.Font = Enum.Font.GothamBold
WC_Text1.Text = "⚡ PREMIUM SCRIPT v1.2"
WC_Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
WC_Text1.TextSize = 9

local WC_Text2 = Instance.new("TextLabel", WelcomeCard)
WC_Text2.BackgroundTransparency = 1
WC_Text2.Position = UDim2.new(0, 10, 0, 26)
WC_Text2.Size = UDim2.new(1, -20, 0, 16)
WC_Text2.Font = Enum.Font.Gotham
WC_Text2.Text = "Protected with Fixed Resize Engine"
WC_Text2.TextColor3 = Color3.fromRGB(200, 220, 255)
WC_Text2.TextSize = 8

local DiscordCard = Instance.new("Frame", HomePage)
DiscordCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
DiscordCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
DiscordCard.BorderSizePixel = 1
DiscordCard.Size = UDim2.new(1, -6, 0, 60)
local DC_Corner = Instance.new("UICorner", DiscordCard)
DC_Corner.CornerRadius = UDim.new(0, 6)

local DC_Title = Instance.new("TextLabel", DiscordCard)
DC_Title.BackgroundTransparency = 1
DC_Title.Position = UDim2.new(0, 10, 0, 6)
DC_Title.Size = UDim2.new(1, -20, 0, 14)
DC_Title.Font = Enum.Font.GothamBold
DC_Title.Text = "💬 ช่องทางติดต่อหลัก: discord.gg/FuC9cme7ht"
DC_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
DC_Title.TextSize = 8
DC_Title.TextXAlignment = Enum.TextXAlignment.Left

local CopyDiscordBtn = Instance.new("TextButton", DiscordCard)
CopyDiscordBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
CopyDiscordBtn.BorderSizePixel = 0
CopyDiscordBtn.Position = UDim2.new(0, 10, 0, 28)
CopyDiscordBtn.Size = UDim2.new(1, -20, 0, 22)
CopyDiscordBtn.Font = Enum.Font.GothamBold
CopyDiscordBtn.Text = "📋 คัดลอกลิงก์ติดต่อ (Copy Link)"
CopyDiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyDiscordBtn.TextSize = 8
local CopyCorner = Instance.new("UICorner", CopyDiscordBtn)
CopyCorner.CornerRadius = UDim.new(0, 4)

CopyDiscordBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/FuC9cme7ht") end)
    CopyDiscordBtn.Text = "✅ คัดลอกลิงก์สำเร็จ!"
    task.wait(1.5)
    CopyDiscordBtn.Text = "📋 คัดลอกลิงก์ติดต่อ (Copy Link)"
end)

local StatsGrid = Instance.new("Frame", HomePage)
StatsGrid.BackgroundTransparency = 1
StatsGrid.Size = UDim2.new(1, -6, 0, 42)

local function CreateStatBox(posX, title)
    local box = Instance.new("Frame", StatsGrid)
    box.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
    box.BorderColor3 = Color3.fromRGB(45, 60, 90)
    box.BorderSizePixel = 1
    box.Position = UDim2.new(posX, 0, 0, 0)
    box.Size = UDim2.new(0.32, 0, 1, 0)
    local c = Instance.new("UICorner", box)
    c.CornerRadius = UDim.new(0, 5)
    
    local valLabel = Instance.new("TextLabel", box)
    valLabel.Name = "Val"
    valLabel.BackgroundTransparency = 1
    valLabel.Position = UDim2.new(0, 0, 0, 4)
    valLabel.Size = UDim2.new(1, 0, 0, 16)
    valLabel.Font = Enum.Font.GothamBold
    valLabel.Text = "0"
    valLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
    valLabel.TextSize = 11
    
    local titleLabel = Instance.new("TextLabel", box)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 0, 0, 22)
    titleLabel.Size = UDim2.new(1, 0, 0, 14)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(130, 150, 180)
    titleLabel.TextSize = 7
    return box
end

local FpsBox = CreateStatBox(0, "FPS")
local PingBox = CreateStatBox(0.34, "PING")
local PlayerBox = CreateStatBox(0.68, "PLAYER")

-- 2. หน้า Player
AddTabButton("Player", "ผู้เล่น")
local PlayerPage = CreatePage("Player")

CreateToggle(PlayerPage, "Speed Hack (Safe)", "เปิดเดินเร็ว", function(state)
    getgenv().FixResizeStg.SpeedEnabled = state
    if not state then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end)
    end
end)

CreateSlider(PlayerPage, "WalkSpeed Value", "ระดับความเร็ว", 16, 150, 16, function(val)
    getgenv().FixResizeStg.WalkSpeedValue = val
end)

-- 3. หน้า ESP
AddTabButton("ESP", "การมองเห็น")
local EspPage = CreatePage("ESP")

CreateToggle(EspPage, "ESP Glow", "เรืองแสง (Glow)", function(state)
    getgenv().FixResizeStg.ESPGlow = state
    if not state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("FixResizeGlow") then
                plr.Character.FixResizeGlow:Destroy()
            end
        end
    end
end)

CreateToggle(EspPage, "ESP Box + Tracer", "กรอบ + เส้นโยง", function(state)
    getgenv().FixResizeStg.ESPBoxTracer = state
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.Box then espData.Box.Visible = false end
            if espData.Tracer then espData.Tracer.Visible = false end
        end
    end
end)

-- 4. หน้า Aimbot
AddTabButton("Aimbot", "ล็อคเป้า")
local AimbotPage = CreatePage("Aimbot", 420)

CreateToggle(AimbotPage, "Aimbot - Head Lock", "ล็อคหัว", function(state)
    getgenv().FixResizeStg.AimbotHead = state
    if state then getgenv().FixResizeStg.AimbotTorso = false end
end)

CreateToggle(AimbotPage, "Aimbot - Torso Lock", "ล็อคตัว", function(state)
    getgenv().FixResizeStg.AimbotTorso = state
    if state then getgenv().FixResizeStg.AimbotHead = false end
end)

CreateToggle(AimbotPage, "Show FOV", "แสดงวง FOV", function(state)
    getgenv().FixResizeStg.ShowFOV = state
    FOVCircle.Visible = state
end)

CreateSlider(AimbotPage, "FOV Size", "ขนาด FOV", 30, 300, 100, function(val)
    getgenv().FixResizeStg.FOVSize = val
end)

local FOVColorBtn = Instance.new("TextButton", AimbotPage)
FOVColorBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
FOVColorBtn.BorderColor3 = Color3.fromRGB(45, 60, 90)
FOVColorBtn.BorderSizePixel = 1
FOVColorBtn.Size = UDim2.new(1, -6, 0, 30)
FOVColorBtn.Font = Enum.Font.GothamSemibold
FOVColorBtn.Text = "  FOV Color / สีวง FOV"
FOVColorBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
FOVColorBtn.TextSize = 8
FOVColorBtn.TextXAlignment = Enum.TextXAlignment.Left

local fovcc = Instance.new("UICorner", FOVColorBtn)
fovcc.CornerRadius = UDim.new(0, 5)

local FOVColorLbl = Instance.new("TextLabel", FOVColorBtn)
FOVColorLbl.BackgroundTransparency = 1
FOVColorLbl.Position = UDim2.new(1, -110, 0, 0)
FOVColorLbl.Size = UDim2.new(0, 100, 1, 0)
FOVColorLbl.Font = Enum.Font.GothamBold
FOVColorLbl.Text = FOVColorNames[1]
FOVColorLbl.TextColor3 = Color3.fromRGB(0, 180, 255)
FOVColorLbl.TextSize = 9
FOVColorLbl.TextXAlignment = Enum.TextXAlignment.Right

FOVColorBtn.MouseButton1Click:Connect(function()
    getgenv().FixResizeStg.FOVColorIndex = getgenv().FixResizeStg.FOVColorIndex + 1
    if getgenv().FixResizeStg.FOVColorIndex > #FOVColors then
        getgenv().FixResizeStg.FOVColorIndex = 1
    end
    local idx = getgenv().FixResizeStg.FOVColorIndex
    FOVCircle.Color = FOVColors[idx]
    FOVColorLbl.Text = FOVColorNames[idx]
    if idx == 1 then FOVColorLbl.TextColor3 = Color3.fromRGB(0, 180, 255)
    elseif idx == 2 then FOVColorLbl.TextColor3 = Color3.fromRGB(255, 60, 60)
    elseif idx == 3 then FOVColorLbl.TextColor3 = Color3.fromRGB(50, 255, 120)
    elseif idx == 4 then FOVColorLbl.TextColor3 = Color3.fromRGB(255, 220, 0) end
end)

-- 5. หน้า Settings
AddTabButton("Settings", "ตั้งค่า")
local SettingsPage = CreatePage("Settings")

CreateToggle(SettingsPage, "Floating FPS/Ping", "สถิติลอย", function(state)
    getgenv().FixResizeStg.FloatingStats = state
    FloatFrame.Visible = state
end)

CreateToggle(SettingsPage, "FPS & Ping Booster", "บูสความลื่น", function(state)
    getgenv().FixResizeStg.FPSBoost = state
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
AddTabButton("Security", "ความปลอดภัย")
local SecurityPage = CreatePage("Security")

local SecInfoCard = Instance.new("Frame", SecurityPage)
SecInfoCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
SecInfoCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
SecInfoCard.BorderSizePixel = 1
SecInfoCard.Size = UDim2.new(1, -6, 0, 130)

local secic = Instance.new("UICorner", SecInfoCard)
secic.CornerRadius = UDim.new(0, 6)

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
SI_Desc.Size = UDim2.new(1, -20, 0, 95)
SI_Desc.Font = Enum.Font.Gotham
SI_Desc.Text = "• Anti-Ban & Telemetry: ป้องกันแบน\n• Anti-Report: บล็อกการรีพอร์ต\n• Anti-Kick: ป้องกันเตะ/ดึงตัว\n• Clean Cache: ล้างแรมอัตโนมัติ"
SI_Desc.TextColor3 = Color3.fromRGB(160, 180, 210)
SI_Desc.TextSize = 8
SI_Desc.TextXAlignment = Enum.TextXAlignment.Left

-- Main Loop (Smooth RGB for Minimal Strokes)
local ESPContainer = {}

RunService.RenderStepped:Connect(function(dt)
    local tickVal = tick() * 0.4
    local rgbColor = Color3.fromHSV(tickVal % 1, 1, 1)
    
    for _, stroke in pairs(MinimalRGBStrokes) do
        if stroke and stroke.Parent then
            stroke.Color = rgbColor
        end
    end

    local currentFPS = math.floor(1 / math.max(dt, 0.001))
    local pingVal = 0
    pcall(function() pingVal = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
    
    FpsBox.Val.Text = tostring(currentFPS)
    PingBox.Val.Text = tostring(pingVal) .. "ms"
    PlayerBox.Val.Text = tostring(#Players:GetPlayers())

    if getgenv().FixResizeStg.FloatingStats then
        FloatText.Text = "FPS: " .. currentFPS .. " | Ping: " .. pingVal .. "ms"
    end

    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().FixResizeStg.SpeedEnabled then
            char.Humanoid.WalkSpeed = getgenv().FixResizeStg.WalkSpeedValue
        end
    end)

    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local char = plr.Character
                if getgenv().FixResizeStg.ESPGlow and char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    if not char:FindFirstChild("FixResizeGlow") then
                        local glow = Instance.new("Highlight")
                        glow.Name = "FixResizeGlow"
                        glow.Adornee = char
                        glow.FillColor = Color3.fromRGB(0, 120, 255)
                        glow.OutlineColor = Color3.fromRGB(150, 100, 255)
                        glow.FillTransparency = 0.3
                        glow.Parent = char
                    end
                else
                    if char and char:FindFirstChild("FixResizeGlow") then char.FixResizeGlow:Destroy() end
                end
            end
        end
    end)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if getgenv().FixResizeStg.ESPBoxTracer then
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
        if getgenv().FixResizeStg.ShowFOV then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            FOVCircle.Radius = getgenv().FixResizeStg.FOVSize
            FOVCircle.Visible = true
        else
            FOVCircle.Visible = false
        end
    end)

    pcall(function()
        if getgenv().FixResizeStg.AimbotHead or getgenv().FixResizeStg.AimbotTorso then
            local closestTarget = nil
            local shortestDist = getgenv().FixResizeStg.FOVSize
            local origin = Camera.CFrame.Position

            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                    local targetPart = nil
                    if getgenv().FixResizeStg.AimbotHead then
                        targetPart = plr.Character:FindFirstChild("Head")
                    elseif getgenv().FixResizeStg.AimbotTorso then
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
