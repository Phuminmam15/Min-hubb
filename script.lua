-- =====================================================================
-- Premium script by.Nongmin - Ultimate Hub v7.6 (Dev Panel UI Fixed)
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local Camera = Workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- รายชื่อ Owner และ Admin
local Owners = {["Terx_83"] = true, ["Olish_Knky"] = true} -- เพิ่มชื่อไอดีในรูปเข้าไปด้วยเพื่อความชัวร์
local Admins = {["AdminFriend01"] = true}

local WEBHOOK_URL = "https://discord.com/api/webhooks/1566517565755363499/iuxqTJwHVaHVzBTxwJRbBYUkvDeL5sZIzRfdAt4mF004cyLRGyWz8W1-piHHL3cH-dnh"

local function SendDiscordWebhook(title, description, colorCode)
    pcall(function()
        if WEBHOOK_URL == "" or string.match(WEBHOOK_URL, "YOUR_WEBHOOK") then return end
        local data = {
            ["embeds"] = {{
                ["title"] = title,
                ["description"] = description,
                ["color"] = colorCode or 3447003,
                ["footer"] = {["text"] = "Nongmin Ultimate Hub | Discord: https://discord.gg/FuC9cme7ht"}
            }}
        }
        local encodedData = HttpService:JSONEncode(data)
        local requestFunc = syn and syn.request or http and http.request or http_request or request
        if requestFunc then
            requestFunc({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = encodedData
            })
        end
    end)
end

getgenv().HubLoaded = false
getgenv().CurrentKeyInfo = {Key = "None", ExpiresAt = 0}

for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "NongminUltimateHub" then
        v:Destroy()
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NongminUltimateHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MinimalRGBStrokes = {}
local RenderConnection = nil
local ESPContainer = {}
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 2.0
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Transparency = 0.9

local function AddRGBStroke(parent, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1.5
    stroke.Color = Color3.fromRGB(0, 162, 255)
    stroke.Parent = parent
    table.insert(MinimalRGBStrokes, stroke)
    return stroke
end

local function ShowNotification(title, message)
    pcall(function()
        local NotifFrame = Instance.new("Frame", ScreenGui)
        NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
        NotifFrame.BorderSizePixel = 0
        NotifFrame.Position = UDim2.new(1, 10, 0.82, 0)
        NotifFrame.Size = UDim2.new(0, 240, 0, 55)
        NotifFrame.ZIndex = 500
        AddRGBStroke(NotifFrame, 2)
        Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 6)

        local NotifTitle = Instance.new("TextLabel", NotifFrame)
        NotifTitle.BackgroundTransparency = 1
        NotifTitle.Position = UDim2.new(0, 10, 0, 6)
        NotifTitle.Size = UDim2.new(1, -20, 0, 16)
        NotifTitle.Font = Enum.Font.GothamBold
        NotifTitle.Text = title
        NotifTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
        NotifTitle.TextSize = 9
        NotifTitle.TextXAlignment = Enum.TextXAlignment.Left

        local NotifDesc = Instance.new("TextLabel", NotifFrame)
        NotifDesc.BackgroundTransparency = 1
        NotifDesc.Position = UDim2.new(0, 10, 0, 24)
        NotifDesc.Size = UDim2.new(1, -20, 0, 24)
        NotifDesc.Font = Enum.Font.Gotham
        NotifDesc.Text = message
        NotifDesc.TextColor3 = Color3.fromRGB(200, 210, 230)
        NotifDesc.TextSize = 8
        NotifDesc.TextWrapped = true
        NotifDesc.TextXAlignment = Enum.TextXAlignment.Left

        NotifFrame:TweenPosition(UDim2.new(1, -255, 0.82, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)

        task.spawn(function()
            task.wait(3.0)
            NotifFrame:TweenPosition(UDim2.new(1, 10, 0.82, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
            task.wait(0.3)
            NotifFrame:Destroy()
        end)
    end)
end

getgenv().UltimateStg = {
    NoclipEnabled = false,
    InfiniteJumpEnabled = false,
    AntiAFKEnabled = false,
    ESPGlow = false,
    ESPBox = false,
    ESPTracer = false,
    ESPNameInfo = false,
    ESPDistanceMax = 250,
    HitboxExpander = false,
    HitboxSize = 3,
    AimbotHead = false,
    AimbotTorso = false,
    ShowFOV = false,
    FOVSize = 100,
    FOVColorMode = 1,
    FPSBoost = false,
    FloatingStats = false
}

local KeyDatabase = {
    ["MIN-VIP-1111"] = {Used = false, ExpiresAt = 0},
    ["MIN-VIP-7DAYS"] = {Used = false, ExpiresAt = os.time() + (7 * 24 * 60 * 60)}
}

local KeyScreen = Instance.new("Frame", ScreenGui)
KeyScreen.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
KeyScreen.BorderSizePixel = 0
KeyScreen.AnchorPoint = Vector2.new(0.5, 0.5)
KeyScreen.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyScreen.Size = UDim2.new(0, 340, 0, 220)
KeyScreen.Active = true
KeyScreen.Draggable = true
AddRGBStroke(KeyScreen, 2)
Instance.new("UICorner", KeyScreen).CornerRadius = UDim.new(0, 8)

local KeyTitle = Instance.new("TextLabel", KeyScreen)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 15, 0, 15)
KeyTitle.Size = UDim2.new(1, -30, 0, 25)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "🔑 ENTER KEY SYSTEM"
KeyTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
KeyTitle.TextSize = 12

local KeyBox = Instance.new("TextBox", KeyScreen)
KeyBox.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
KeyBox.Position = UDim2.new(0, 25, 0, 75)
KeyBox.Size = UDim2.new(1, -50, 0, 35)
KeyBox.Font = Enum.Font.GothamSemibold
KeyBox.PlaceholderText = "👉 Enter your key here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 10
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 6)

local SubmitKeyBtn = Instance.new("TextButton", KeyScreen)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitKeyBtn.Position = UDim2.new(0, 25, 0, 122)
SubmitKeyBtn.Size = UDim2.new(1, -50, 0, 32)
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.Text = "🚀 VERIFY KEY / ยืนยันคีย์"
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyBtn.TextSize = 9
Instance.new("UICorner", SubmitKeyBtn).CornerRadius = UDim.new(0, 6)

local AlertPopup = Instance.new("Frame", ScreenGui)
AlertPopup.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
AlertPopup.AnchorPoint = Vector2.new(0.5, 0.5)
AlertPopup.Position = UDim2.new(0.5, 0, 0.5, 0)
AlertPopup.Size = UDim2.new(0, 300, 0, 150)
AlertPopup.Visible = false
AlertPopup.ZIndex = 200
AddRGBStroke(AlertPopup, 2)
Instance.new("UICorner", AlertPopup).CornerRadius = UDim.new(0, 8)

local AP_Title = Instance.new("TextLabel", AlertPopup)
AP_Title.BackgroundTransparency = 1
AP_Title.Position = UDim2.new(0, 15, 0, 15)
AP_Title.Size = UDim2.new(1, -30, 0, 20)
AP_Title.Font = Enum.Font.GothamBold
AP_Title.Text = "⚠️ แจ้งเตือนสิทธิ์การใช้งาน"
AP_Title.TextColor3 = Color3.fromRGB(255, 90, 90)
AP_Title.TextSize = 11

local AP_Desc = Instance.new("TextLabel", AlertPopup)
AP_Desc.BackgroundTransparency = 1
AP_Desc.Position = UDim2.new(0, 15, 0, 42)
AP_Desc.Size = UDim2.new(1, -30, 0, 45)
AP_Desc.Font = Enum.Font.Gotham
AP_Desc.Text = "คุณไม่มีสิทธิ์สร้างคีย์ถาวร\n(เฉพาะ Owner หรือเจ้าของสคริปต์เท่านั้น)"
AP_Desc.TextColor3 = Color3.fromRGB(200, 210, 230)
AP_Desc.TextSize = 8
AP_Desc.TextWrapped = true

local AP_OkBtn = Instance.new("TextButton", AlertPopup)
AP_OkBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
AP_OkBtn.Position = UDim2.new(0.5, -60, 0, 100)
AP_OkBtn.Size = UDim2.new(0, 120, 0, 30)
AP_OkBtn.Font = Enum.Font.GothamBold
AP_OkBtn.Text = "ตกลง (OK)"
AP_OkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AP_OkBtn.TextSize = 9
Instance.new("UICorner", AP_OkBtn).CornerRadius = UDim.new(0, 6)
AP_OkBtn.MouseButton1Click:Connect(function() AlertPopup.Visible = false end)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Active = true
MainFrame.Visible = false
AddRGBStroke(MainFrame, 2.5)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "HUB"
ToggleButton.TextColor3 = Color3.fromRGB(0, 180, 255)
ToggleButton.TextSize = 12
ToggleButton.Visible = false
AddRGBStroke(ToggleButton, 2)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

SubmitKeyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyBox.Text
    local keyData = KeyDatabase[userKey]
    
    if Owners[LocalPlayer.Name] or Admins[LocalPlayer.Name] or (keyData and not keyData.Used) then
        if keyData then keyData.Used = true end
        getgenv().CurrentKeyInfo = {Key = userKey ~= "" and userKey or "DEV/ADMIN PASS", ExpiresAt = keyData and keyData.ExpiresAt or 0}
        KeyScreen.Visible = false
        MainFrame.Visible = true
        ToggleButton.Visible = true
        getgenv().HubLoaded = true
        ShowNotification("🌟 WELCOME", "ยินดีต้อนรับเข้าสู่ Nongmin Hub!")
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "❌ คีย์ไม่ถูกต้องหรือถูกใช้แล้ว!"
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local TopBarHolder = Instance.new("ScrollingFrame", MainFrame)
TopBarHolder.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
TopBarHolder.BorderSizePixel = 0
TopBarHolder.Size = UDim2.new(1, -35, 0, 36)
TopBarHolder.CanvasSize = UDim2.new(0, 500, 0, 0)
TopBarHolder.ScrollBarThickness = 0

local TopBarList = Instance.new("UIListLayout", TopBarHolder)
TopBarList.FillDirection = Enum.FillDirection.Horizontal
TopBarList.Padding = UDim.new(0, 2)

local PagesHolder = Instance.new("Frame", MainFrame)
PagesHolder.BackgroundTransparency = 1
PagesHolder.Position = UDim2.new(0, 10, 0, 45)
PagesHolder.Size = UDim2.new(1, -20, 1, -52)

local Pages = {}
local MenuButtons = {}

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame", PagesHolder)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local layout = Instance.new("UIListLayout", page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    Pages[name] = page
    return page
end

local function AddTabButton(name)
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

-- 1. Home
local HomePage = CreatePage("🏠 Home")
HomePage.Visible = true
AddTabButton("🏠 Home")

local KI_Desc = Instance.new("TextLabel", HomePage)
KI_Desc.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
KI_Desc.Size = UDim2.new(1, 0, 0, 40)
KI_Desc.Font = Enum.Font.GothamSemibold
KI_Desc.Text = "⏳ สถานะคีย์: กำลังโหลด..."
KI_Desc.TextColor3 = Color3.fromRGB(50, 255, 150)
KI_Desc.TextSize = 9
Instance.new("UICorner", KI_Desc).CornerRadius = UDim.new(0, 6)

-- 2. Player, ESP, Aimbot, Settings, Security
AddTabButton("🏃‍♂️ Player") CreatePage("🏃‍♂️ Player")
AddTabButton("👀 ESP") CreatePage("👀 ESP")
AddTabButton("🎯 Aimbot") CreatePage("🎯 Aimbot")
AddTabButton("⚙️ Settings") CreatePage("⚙️ Settings")
AddTabButton("🛡️ Security") CreatePage("🛡️ Security")

-- 3. DEV / ADMIN PANEL (แก้ไขจุด Render บัคแล้ว)
local DevPage = CreatePage("🛠️ DEV")
AddTabButton("🛠️ DEV")

local DevCard = Instance.new("Frame", DevPage)
DevCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
DevCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
DevCard.BorderSizePixel = 1
DevCard.Size = UDim2.new(1, -6, 0, 215)
Instance.new("UICorner", DevCard).CornerRadius = UDim.new(0, 6)

local DC_Head = Instance.new("TextLabel", DevCard)
DC_Head.BackgroundTransparency = 1
DC_Head.Position = UDim2.new(0, 10, 0, 8)
DC_Head.Size = UDim2.new(1, -20, 0, 16)
DC_Head.Font = Enum.Font.GothamBold
DC_Head.Text = "🛠️ DEV / ADMIN KEY GENERATOR PANEL"
DC_Head.TextColor3 = Color3.fromRGB(255, 200, 0)
DC_Head.TextSize = 9
DC_Head.TextXAlignment = Enum.TextXAlignment.Left

local KeyInput = Instance.new("TextBox", DevCard)
KeyInput.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
KeyInput.Position = UDim2.new(0, 10, 0, 32)
KeyInput.Size = UDim2.new(1, -20, 0, 30)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "พิมพ์ชื่อคีย์ที่ต้องการสร้าง (เช่น MIN-VIP-XYZ)"
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 8
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 4)

local selectedDays = 1
local DaysLabel = Instance.new("TextLabel", DevCard)
DaysLabel.BackgroundTransparency = 1
DaysLabel.Position = UDim2.new(0, 10, 0, 68)
DaysLabel.Size = UDim2.new(1, -20, 0, 16)
DaysLabel.Font = Enum.Font.GothamBold
DaysLabel.Text = "⏱️ เลือกอายุของคีย์: [ 1 วัน ]"
DaysLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
DaysLabel.TextSize = 8
DaysLabel.TextXAlignment = Enum.TextXAlignment.Left

local function CreateDayBtn(posX, text, daysVal)
    local btn = Instance.new("TextButton", DevCard)
    btn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
    btn.Position = UDim2.new(posX, 0, 0, 90)
    btn.Size = UDim2.new(0.15, -4, 0, 24)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 8
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(function()
        if daysVal == 0 and not Owners[LocalPlayer.Name] then
            AlertPopup.Visible = true
            return
        end
        selectedDays = daysVal
        DaysLabel.Text = "⏱️ เลือกอายุของคีย์: [ " .. text .. " ]"
    end)
end

CreateDayBtn(0.00, "1 วัน", 1)
CreateDayBtn(0.16, "3 วัน", 3)
CreateDayBtn(0.32, "7 วัน", 7)
CreateDayBtn(0.48, "15 วัน", 15)
CreateDayBtn(0.64, "30 วัน", 30)
CreateDayBtn(0.80, "ถาวร", 0)

local GenBtn = Instance.new("TextButton", DevCard)
GenBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
GenBtn.Position = UDim2.new(0, 10, 0, 124)
GenBtn.Size = UDim2.new(1, -20, 0, 32)
GenBtn.Font = Enum.Font.GothamBold
GenBtn.Text = "➕ สร้างคีย์ & คัดลอก (Generate Key)"
GenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GenBtn.TextSize = 9
Instance.new("UICorner", GenBtn).CornerRadius = UDim.new(0, 4)

GenBtn.MouseButton1Click:Connect(function()
    if selectedDays == 0 and not Owners[LocalPlayer.Name] then
        AlertPopup.Visible = true
        return
    end

    local newKey = KeyInput.Text ~= "" and KeyInput.Text or ("MIN-" .. math.random(100000, 999999))
    local expiryTime = selectedDays > 0 and (os.time() + (selectedDays * 24 * 60 * 60)) or 0
    
    KeyDatabase[newKey] = {Used = false, ExpiresAt = expiryTime}
    pcall(function() setclipboard(newKey) end)
    
    GenBtn.Text = "✅ คัดลอกคีย์สำเร็จ: " .. newKey
    ShowNotification("🔑 KEY CREATED", "สร้างคีย์สำเร็จแล้ว!")
    SendDiscordWebhook("🛠️ New Key Generated", "Creator: **" .. LocalPlayer.Name .. "**\nKey: `" .. newKey .. "`", 16776960)
    task.wait(2)
    GenBtn.Text = "➕ สร้างคีย์ & คัดลอก (Generate Key)"
end)

-- Loop อัปเดตสี RGB และสถานะคีย์
RunService.RenderStepped:Connect(function()
    local tickVal = tick() * 0.4
    local rgbColor = Color3.fromHSV(tickVal % 1, 1, 1)
    for _, stroke in pairs(MinimalRGBStrokes) do
        if stroke and stroke.Parent then stroke.Color = rgbColor end
    end
end)
