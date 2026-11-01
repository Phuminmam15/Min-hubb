-- =====================================================================
-- Premium script by.Nongmin - Ultimate Hub v8.1 (Fixed & Updated)
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
local LocalPlayer = Players.LocalPlayer

-- รายชื่อ Owner หลัก (สิทธิ์สูงสุด สร้างคีย์ถาวรได้ และเพิ่มแอดมินได้)
local Owners = {["Terx_83"] = true}

-- รายชื่อ Admin เริ่มต้น (สร้างคีย์ได้ แต่ห้ามสร้างถาวร)
local Admins = {["AdminFriend01"] = true}

-- ลิงก์ Discord Webhook
local WEBHOOK_URL = "https://discord.com/api/webhooks/1566517565755363499/iuxqTJwHVaHVzBTxwJRbBYUkvDeL5sZIzRfdAt4mF004cyLRGyWz8W1-piHHL3cH-dnh"

local function SendDiscordWebhook(title, description, colorCode)
    pcall(function()
        if WEBHOOK_URL == "" or string.match(WEBHOOK_URL, "YOUR_WEBHOOK") then return end
        local data = {
            ["embeds"] = {{
                ["title"] = title,
                ["description"] = description,
                ["color"] = colorCode or 3447003,
                ["footer"] = {["text"] = "Nongmin Ultimate Hub | Key System & Admin Panel"}
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
        NotifTitle.ZIndex = 501

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
        NotifDesc.ZIndex = 501

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

local ConfigFileName = "NongminHub_Config.json"

local function SaveConfig()
    pcall(function()
        if writefile then
            local jsonDecoded = HttpService:JSONEncode(getgenv().UltimateStg)
            writefile(ConfigFileName, jsonDecoded)
            ShowNotification("💾 CONFIG SAVED", "บันทึกการตั้งค่าสำเร็จแล้ว!")
        end
    end)
end

local function LoadConfig()
    pcall(function()
        if readfile and isfile and isfile(ConfigFileName) then
            local fileContent = readfile(ConfigFileName)
            local data = HttpService:JSONDecode(fileContent)
            if data and type(data) == "table" then
                for k, v in pairs(data) do
                    if getgenv().UltimateStg[k] ~= nil then
                        getgenv().UltimateStg[k] = v
                    end
                end
                ShowNotification("📂 CONFIG LOADED", "โหลดค่าตั้งค่าเดิมสำเร็จ!")
            end
        end
    end)
end

LoadConfig()

local KeyDatabase = {
    ["MIN-VIP-1111"] = {Used = false, ExpiresAt = 0}, -- 0 คือถาวร
    ["MIN-VIP-7DAYS"] = {Used = false, ExpiresAt = os.time() + (7 * 24 * 60 * 60)}
}

-- Popup เตือนเมื่อ Admin พยายามสร้างคีย์ถาวร
local AlertPopup = Instance.new("Frame", ScreenGui)
AlertPopup.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
AlertPopup.BorderSizePixel = 0
AlertPopup.AnchorPoint = Vector2.new(0.5, 0.5)
AlertPopup.Position = UDim2.new(0.5, 0, 0.5, 0)
AlertPopup.Size = UDim2.new(0, 300, 0, 150)
AlertPopup.Visible = false
AlertPopup.ZIndex = 600
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
AP_Title.ZIndex = 601

local AP_Desc = Instance.new("TextLabel", AlertPopup)
AP_Desc.BackgroundTransparency = 1
AP_Desc.Position = UDim2.new(0, 15, 0, 42)
AP_Desc.Size = UDim2.new(1, -30, 0, 45)
AP_Desc.Font = Enum.Font.Gotham
AP_Desc.Text = "คุณไม่มีสิทธิ์สร้างคีย์ถาวร\n(เฉพาะ Owner หรือเจ้าของสคริปต์เท่านั้น)"
AP_Desc.TextColor3 = Color3.fromRGB(200, 210, 230)
AP_Desc.TextSize = 8
AP_Desc.TextWrapped = true
AP_Desc.ZIndex = 601

local AP_OkBtn = Instance.new("TextButton", AlertPopup)
AP_OkBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
AP_OkBtn.BorderSizePixel = 0
AP_OkBtn.Position = UDim2.new(0.5, -60, 0, 100)
AP_OkBtn.Size = UDim2.new(0, 120, 0, 30)
AP_OkBtn.Font = Enum.Font.GothamBold
AP_OkBtn.Text = "ตกลง (OK)"
AP_OkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AP_OkBtn.TextSize = 9
AP_OkBtn.ZIndex = 601
Instance.new("UICorner", AP_OkBtn).CornerRadius = UDim.new(0, 6)

AP_OkBtn.MouseButton1Click:Connect(function()
    AlertPopup.Visible = false
end)

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
KeyTitle.TextXAlignment = Enum.TextXAlignment.Center

local KeySub = Instance.new("TextLabel", KeyScreen)
KeySub.BackgroundTransparency = 1
KeySub.Position = UDim2.new(0, 15, 0, 42)
KeySub.Size = UDim2.new(1, -30, 0, 20)
KeySub.Font = Enum.Font.Gotham
KeySub.Text = "✨ Secure Key System with Expiry Tracker ✨"
KeySub.TextColor3 = Color3.fromRGB(160, 180, 210)
KeySub.TextSize = 8
KeySub.TextXAlignment = Enum.TextXAlignment.Center

local KeyBox = Instance.new("TextBox", KeyScreen)
KeyBox.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
KeyBox.BorderColor3 = Color3.fromRGB(45, 60, 90)
KeyBox.BorderSizePixel = 1
KeyBox.Position = UDim2.new(0, 25, 0, 75)
KeyBox.Size = UDim2.new(1, -50, 0, 35)
KeyBox.Font = Enum.Font.GothamSemibold
KeyBox.PlaceholderText = "👉 Enter your key here..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 130, 170)
KeyBox.TextSize = 10
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 6)

local SubmitKeyBtn = Instance.new("TextButton", KeyScreen)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitKeyBtn.BorderSizePixel = 0
SubmitKeyBtn.Position = UDim2.new(0, 25, 0, 122)
SubmitKeyBtn.Size = UDim2.new(1, -50, 0, 32)
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.Text = "🚀 VERIFY KEY / ยืนยันคีย์"
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyBtn.TextSize = 9
Instance.new("UICorner", SubmitKeyBtn).CornerRadius = UDim.new(0, 6)

local CancelKeyBtn = Instance.new("TextButton", KeyScreen)
CancelKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
CancelKeyBtn.BorderColor3 = Color3.fromRGB(50, 60, 85)
CancelKeyBtn.Position = UDim2.new(0, 25, 0, 162)
CancelKeyBtn.Size = UDim2.new(1, -50, 0, 28)
CancelKeyBtn.Font = Enum.Font.GothamBold
CancelKeyBtn.Text = "❌ CANCEL / ยกเลิก"
CancelKeyBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CancelKeyBtn.TextSize = 9
Instance.new("UICorner", CancelKeyBtn).CornerRadius = UDim.new(0, 6)

CancelKeyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local LoadingFrame = Instance.new("Frame", ScreenGui)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.Size = UDim2.new(0, 340, 0, 210)
LoadingFrame.Visible = false
AddRGBStroke(LoadingFrame, 2)
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 8)

local LoadTitle = Instance.new("TextLabel", LoadingFrame)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 15, 0, 35)
LoadTitle.Size = UDim2.new(1, -30, 0, 20)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = "⭐ Key Verified! Loading Hub... ⭐"
LoadTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
LoadTitle.TextSize = 11
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center

local LoadPercent = Instance.new("TextLabel", LoadingFrame)
LoadPercent.BackgroundTransparency = 1
LoadPercent.Position = UDim2.new(0, 15, 0, 65)
LoadPercent.Size = UDim2.new(1, -30, 0, 30)
LoadPercent.Font = Enum.Font.GothamBold
LoadPercent.Text = "0%"
LoadPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadPercent.TextSize = 16
LoadPercent.TextXAlignment = Enum.TextXAlignment.Center

local BarBg = Instance.new("Frame", LoadingFrame)
BarBg.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
BarBg.BorderSizePixel = 0
BarBg.Position = UDim2.new(0, 25, 0, 115)
BarBg.Size = UDim2.new(1, -50, 0, 10)
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame", BarBg)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
BarFill.BorderSizePixel = 0
BarFill.Size = UDim2.new(0, 0, 1, 0)
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.ClipsDescendants = false
AddRGBStroke(MainFrame, 2.5)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local ToggleButton = Instance.new("ImageButton", ScreenGui)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Image = "rbxassetid://579271238"
ToggleButton.ScaleType = Enum.ScaleType.Crop
ToggleButton.Visible = false
AddRGBStroke(ToggleButton, 2)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

local ToggleLabel = Instance.new("TextLabel", ToggleButton)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
ToggleLabel.Font = Enum.Font.GothamBold
ToggleLabel.Text = "💖[H]"
ToggleLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
ToggleLabel.TextSize = 14

SubmitKeyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyBox.Text
    local keyData = KeyDatabase[userKey]
    
    if Owners[LocalPlayer.Name] or Admins[LocalPlayer.Name] then
        getgenv().CurrentKeyInfo = {Key = "DEVELOPER / ADMIN PASS", ExpiresAt = 0}
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
        getgenv().HubLoaded = true
        local roleTitle = Owners[LocalPlayer.Name] and "🌟 WELCOME OWNER" or "🛡️ WELCOME ADMIN"
        ShowNotification(roleTitle, "ยินดีต้อนรับผู้ดูแลระบบ เข้าสู่ Nongmin Hub!")
        return
    end

    if keyData then
        if keyData.Used == true then
            KeyBox.Text = ""
            KeyBox.PlaceholderText = "❌ Key already used!"
        elseif keyData.ExpiresAt > 0 and os.time() > keyData.ExpiresAt then
            KeyBox.Text = ""
            KeyBox.PlaceholderText = "❌ Key expired!"
        else
            keyData.Used = true
            getgenv().CurrentKeyInfo = {Key = userKey, ExpiresAt = keyData.ExpiresAt}
            
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
            
            getgenv().HubLoaded = true
            ShowNotification("🌟 WELCOME", "ยินดีต้อนรับเข้าสู่ Nongmin Hub!")
            SendDiscordWebhook("🚀 Key Verified Successfully", "Player: **" .. LocalPlayer.Name .. "**\nKey Used: `" .. userKey .. "`\nGame ID: `" .. game.PlaceId .. "`", 65280)
        end
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "❌ Invalid Key!"
    end
end)

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

local TopBarHolder = Instance.new("ScrollingFrame", MainFrame)
TopBarHolder.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
TopBarHolder.BorderSizePixel = 0
TopBarHolder.Position = UDim2.new(0, 0, 0, 0)
TopBarHolder.Size = UDim2.new(1, -35, 0, 36)
TopBarHolder.CanvasSize = UDim2.new(0, 600, 0, 0)
TopBarHolder.ScrollBarThickness = 0
TopBarHolder.ScrollingDirection = Enum.ScrollingDirection.X

local TopBarList = Instance.new("UIListLayout", TopBarHolder)
TopBarList.FillDirection = Enum.FillDirection.Horizontal
TopBarList.SortOrder = Enum.SortOrder.LayoutOrder
TopBarList.Padding = UDim.new(0, 2)

local ConfirmDialog = Instance.new("Frame", ScreenGui)
ConfirmDialog.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ConfirmDialog.BorderSizePixel = 0
ConfirmDialog.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmDialog.Position = UDim2.new(0.5, 0, 0.5, 0)
ConfirmDialog.Size = UDim2.new(0, 320, 0, 160)
ConfirmDialog.Visible = false
ConfirmDialog.ZIndex = 100
AddRGBStroke(ConfirmDialog, 2)
Instance.new("UICorner", ConfirmDialog).CornerRadius = UDim.new(0, 8)

local CDTitle = Instance.new("TextLabel", ConfirmDialog)
CDTitle.BackgroundTransparency = 1
CDTitle.Position = UDim2.new(0, 15, 0, 15)
CDTitle.Size = UDim2.new(1, -30, 0, 20)
CDTitle.Font = Enum.Font.GothamBold
CDTitle.Text = "⚠️ ยืนยันการปิดใช้งาน (Confirm Exit)"
CDTitle.TextColor3 = Color3.fromRGB(255, 90, 90)
CDTitle.TextSize = 11
CDTitle.ZIndex = 101

local CDDesc = Instance.new("TextLabel", ConfirmDialog)
CDDesc.BackgroundTransparency = 1
CDDesc.Position = UDim2.new(0, 15, 0, 42)
CDDesc.Size = UDim2.new(1, -30, 0, 40)
CDDesc.Font = Enum.Font.Gotham
CDDesc.Text = "คุณแน่ใจหรือไม่ว่าต้องการปิดสคริปต์?\nฟังก์ชันทั้งหมดจะหยุดทำงานและปิดลงทันที"
CDDesc.TextColor3 = Color3.fromRGB(180, 190, 210)
CDDesc.TextSize = 8
CDDesc.TextWrapped = true
CDDesc.ZIndex = 101

local ConfirmYesBtn = Instance.new("TextButton", ConfirmDialog)
ConfirmYesBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
ConfirmYesBtn.BorderSizePixel = 0
ConfirmYesBtn.Position = UDim2.new(0, 20, 0, 105)
ConfirmYesBtn.Size = UDim2.new(0, 130, 0, 32)
ConfirmYesBtn.Font = Enum.Font.GothamBold
ConfirmYesBtn.Text = "✓ ยืนยัน (Confirm)"
ConfirmYesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmYesBtn.TextSize = 9
ConfirmYesBtn.ZIndex = 101
Instance.new("UICorner", ConfirmYesBtn).CornerRadius = UDim.new(0, 6)

local ConfirmNoBtn = Instance.new("TextButton", ConfirmDialog)
ConfirmNoBtn.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
ConfirmNoBtn.BorderSizePixel = 0
ConfirmNoBtn.Position = UDim2.new(1, -150, 0, 105)
ConfirmNoBtn.Size = UDim2.new(0, 130, 0, 32)
ConfirmNoBtn.Font = Enum.Font.GothamBold
ConfirmNoBtn.Text = "✕ ยกเลิก (Cancel)"
ConfirmNoBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
ConfirmNoBtn.TextSize = 9
ConfirmNoBtn.ZIndex = 101
Instance.new("UICorner", ConfirmNoBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -30, 0, 7)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 9
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)
CloseBtn.ZIndex = 5

local function UnloadAllScript()
    if RenderConnection then
        RenderConnection:Disconnect()
        RenderConnection = nil
    end
    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character then
                for _, obj in pairs(plr.Character:GetChildren()) do
                    if obj.Name == "UltimateGlow" then obj:Destroy() end
                end
            end
        end
    end)
    for _, espData in pairs(ESPContainer) do
        if espData.Box then pcall(function() espData.Box:Remove() end) end
        if espData.Tracer then pcall(function() espData.Tracer:Remove() end) end
        if espData.NameTag then pcall(function() espData.NameTag:Remove() end) end
    end
    ESPContainer = {}
    pcall(function() FOVCircle:Remove() end)
    ScreenGui:Destroy()
end

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmDialog.Visible = true
end)
ConfirmNoBtn.MouseButton1Click:Connect(function()
    ConfirmDialog.Visible = false
end)
ConfirmYesBtn.MouseButton1Click:Connect(function()
    UnloadAllScript()
end)

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
Instance.new("UICorner", ResizeBtn).CornerRadius = UDim.new(0, 4)

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

local PagesHolder = Instance.new("Frame", MainFrame)
PagesHolder.BackgroundTransparency = 1
PagesHolder.Position = UDim2.new(0, 10, 0, 45)
PagesHolder.Size = UDim2.new(1, -20, 1, -52)
PagesHolder.ClipsDescendants = false

local Pages = {}
local MenuButtons = {}

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame", PagesHolder)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 3
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
    btn.Size = UDim2.new(0, 62, 1, 0)
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

local function CreateToggle(parent, title, thaiTitle, initialValue, callback)
    local toggleBtn = Instance.new("TextButton", parent)
    toggleBtn.BackgroundColor3 = initialValue and Color3.fromRGB(15, 40, 70) or Color3.fromRGB(22, 26, 40)
    toggleBtn.BorderColor3 = Color3.fromRGB(45, 60, 90)
    toggleBtn.BorderSizePixel = 1
    toggleBtn.Size = UDim2.new(1, -6, 0, 30)
    toggleBtn.Font = Enum.Font.GothamSemibold
    toggleBtn.Text = "  " .. title .. " / " .. thaiTitle
    toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    toggleBtn.TextSize = 8
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 5)

    local statusLbl = Instance.new("TextLabel", toggleBtn)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Position = UDim2.new(1, -55, 0, 0)
    statusLbl.Size = UDim2.new(0, 45, 1, 0)
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.Text = initialValue and "[ ON ]" or "[ OFF ]"
    statusLbl.TextColor3 = initialValue and Color3.fromRGB(50, 255, 150) or Color3.fromRGB(255, 90, 90)
    statusLbl.TextSize = 9

    local enabled = initialValue
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
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 5)

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
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bar)
    fill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

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

local FOVColorList = {
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(180, 50, 255),
    Color3.fromRGB(50, 255, 100),
    Color3.fromRGB(255, 255, 255)
}
local FOVColorNames = {"[ Rainbow / สีรุ้ง ]", "[ Cyan / ฟ้าไซเบอร์ ]", "[ Purple / ม่วงนีออน ]", "[ Green / เขียวมรกต ]", "[ White / สีขาว ]"}

local FloatFrame = Instance.new("Frame", ScreenGui)
FloatFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
FloatFrame.BorderSizePixel = 0
FloatFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
FloatFrame.Size = UDim2.new(0, 140, 0, 36)
FloatFrame.Visible = false
FloatFrame.Active = true
FloatFrame.Draggable = true
AddRGBStroke(FloatFrame, 1)
Instance.new("UICorner", FloatFrame).CornerRadius = UDim.new(0, 6)

local FloatText = Instance.new("TextLabel", FloatFrame)
FloatText.BackgroundTransparency = 1
FloatText.Size = UDim2.new(1, 0, 1, 0)
FloatText.Font = Enum.Font.GothamBold
FloatText.Text = "📊 FPS: 60 | Ping: 0ms"
FloatText.TextColor3 = Color3.fromRGB(0, 180, 255)
FloatText.TextSize = 9

-- 1. Home
local HomePage = CreatePage("🏠 Home")
HomePage.Visible = true
AddTabButton("🏠 Home", "หน้าหลัก")
MenuButtons[1].Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MenuButtons[1].Button.TextColor3 = Color3.fromRGB(255, 255, 255)

local KeyInfoCard = Instance.new("Frame", HomePage)
KeyInfoCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
KeyInfoCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
KeyInfoCard.BorderSizePixel = 1
KeyInfoCard.Size = UDim2.new(1, -6, 0, 55)
Instance.new("UICorner", KeyInfoCard).CornerRadius = UDim.new(0, 6)

local KI_Title = Instance.new("TextLabel", KeyInfoCard)
KI_Title.BackgroundTransparency = 1
KI_Title.Position = UDim2.new(0, 10, 0, 6)
KI_Title.Size = UDim2.new(1, -20, 0, 16)
KI_Title.Font = Enum.Font.GothamBold
KI_Title.Text = "⏳ Key Expiry Status (สถานะเวลาคีย์ของคุณ)"
KI_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
KI_Title.TextSize = 8
KI_Title.TextXAlignment = Enum.TextXAlignment.Left

local KI_Desc = Instance.new("TextLabel", KeyInfoCard)
KI_Desc.BackgroundTransparency = 1
KI_Desc.Position = UDim2.new(0, 10, 0, 24)
KI_Desc.Size = UDim2.new(1, -20, 0, 22)
KI_Desc.Font = Enum.Font.GothamSemibold
KI_Desc.Text = "กำลังโหลดข้อมูลเวลา..."
KI_Desc.TextColor3 = Color3.fromRGB(50, 255, 150)
KI_Desc.TextSize = 9
KI_Desc.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if getgenv().HubLoaded then
                local info = getgenv().CurrentKeyInfo
                if info.ExpiresAt == 0 then
                    KI_Desc.Text = "🟢 สถานะ: ใช้งานได้ตลอดชีพ (Lifetime / ถาวร)"
                else
                    local timeLeft = info.ExpiresAt - os.time()
                    if timeLeft > 0 then
                        local days = math.floor(timeLeft / 86400)
                        local hours = math.floor((timeLeft % 86400) / 3600)
                        local mins = math.floor((timeLeft % 3600) / 60)
                        local secs = timeLeft % 60
                        if days > 0 then
                            KI_Desc.Text = string.format("⏳ เหลือเวลาอีก: %d วัน %d ชั่วโมง %d นาที", days, hours, mins)
                        else
                            KI_Desc.Text = string.format("⏳ เหลือเวลาอีก: %02d:%02d:%02d", hours, mins, secs)
                        end
                    else
                        KI_Desc.Text = "❌ คีย์ของคุณหมดอายุแล้ว!"
                        task.wait(2)
                        UnloadAllScript()
                    end
                end
            end
        end)
    end
end)

local ExecuterCard = Instance.new("Frame", HomePage)
ExecuterCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
ExecuterCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
ExecuterCard.BorderSizePixel = 1
ExecuterCard.Size = UDim2.new(1, -6, 0, 175)
Instance.new("UICorner", ExecuterCard).CornerRadius = UDim.new(0, 6)

local EC_Title = Instance.new("TextLabel", ExecuterCard)
EC_Title.BackgroundTransparency = 1
EC_Title.Position = UDim2.new(0, 10, 0, 6)
EC_Title.Size = UDim2.new(1, -20, 0, 16)
EC_Title.Font = Enum.Font.GothamBold
EC_Title.Text = "📝 Script Loadstring Input & Guide:"
EC_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
EC_Title.TextSize = 8
EC_Title.TextXAlignment = Enum.TextXAlignment.Left

local EC_Desc = Instance.new("TextLabel", ExecuterCard)
EC_Desc.BackgroundTransparency = 1
EC_Desc.Position = UDim2.new(0, 10, 0, 22)
EC_Desc.Size = UDim2.new(1, -20, 0, 22)
EC_Desc.Font = Enum.Font.Gotham
EC_Desc.Text = "วางลิงก์โค้ด loadstring ของสคริปต์ แล้วกดรันหรือเคลียร์ข้อความได้ทันที"
EC_Desc.TextColor3 = Color3.fromRGB(160, 180, 210)
EC_Desc.TextSize = 7
EC_Desc.TextWrapped = true
EC_Desc.TextXAlignment = Enum.TextXAlignment.Left

local ScriptBox = Instance.new("TextBox", ExecuterCard)
ScriptBox.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ScriptBox.BorderColor3 = Color3.fromRGB(45, 60, 90)
ScriptBox.BorderSizePixel = 1
ScriptBox.Position = UDim2.new(0, 10, 0, 46)
ScriptBox.Size = UDim2.new(1, -20, 0, 65)
ScriptBox.Font = Enum.Font.Gotham
ScriptBox.MultiLine = true
ScriptBox.ClearTextOnFocus = false
ScriptBox.PlaceholderText = 'loadstring(game:HttpGet("https://..."))()'
ScriptBox.Text = ""
ScriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptBox.PlaceholderColor3 = Color3.fromRGB(110, 130, 170)
ScriptBox.TextSize = 8
ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
ScriptBox.TextYAlignment = Enum.TextYAlignment.Top
Instance.new("UICorner", ScriptBox).CornerRadius = UDim.new(0, 4)

local RunScriptBtn = Instance.new("TextButton", ExecuterCard)
RunScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
RunScriptBtn.BorderSizePixel = 0
RunScriptBtn.Position = UDim2.new(0, 10, 0, 118)
RunScriptBtn.Size = UDim2.new(0.68, -5, 0, 28)
RunScriptBtn.Font = Enum.Font.GothamBold
RunScriptBtn.Text = "▶ EXECUTE / รันสคริปต์"
RunScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunScriptBtn.TextSize = 8
Instance.new("UICorner", RunScriptBtn).CornerRadius = UDim.new(0
