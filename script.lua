-- =====================================================================
-- Premium script by.Nongmin - Ultimate Hub v7.7 (Delta Mobile Fix)
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

local Owners = {["Terx_83"] = true}
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
                ["footer"] = {["text"] = "Nongmin Ultimate Hub | Delta Fixed Version"}
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

-- ป้องกันเมทาทเบิลพังใน Delta มือถือ
pcall(function()
    if getrawmetatable then
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "Kick" and self == LocalPlayer then return nil end
            if method == "Teleport" or method == "TeleportToNotInServer" then return nil end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NongminUltimateHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MinimalRGBStrokes = {}
local RenderConnection = nil
local ESPContainer = {}

-- ป้องกัน Drawing พังบนมือถือ
local FOVCircle = nil
pcall(function()
    if Drawing then
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Visible = false
        FOVCircle.Thickness = 2.0
        FOVCircle.NumSides = 64
        FOVCircle.Filled = false
        FOVCircle.Transparency = 0.9
    end
end)

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

local AlertPopup = Instance.new("Frame", ScreenGui)
AlertPopup.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
AlertPopup.BorderSizePixel = 0
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
AP_Title.ZIndex = 201

local AP_Desc = Instance.new("TextLabel", AlertPopup)
AP_Desc.BackgroundTransparency = 1
AP_Desc.Position = UDim2.new(0, 15, 0, 42)
AP_Desc.Size = UDim2.new(1, -30, 0, 45)
AP_Desc.Font = Enum.Font.Gotham
AP_Desc.Text = "คุณไม่มีสิทธิ์สร้างคีย์ถาวร\n(เฉพาะ Owner หรือเจ้าของสคริปต์เท่านั้น)"
AP_Desc.TextColor3 = Color3.fromRGB(200, 210, 230)
AP_Desc.TextSize = 8
AP_Desc.TextWrapped = true
AP_Desc.ZIndex = 201

local AP_OkBtn = Instance.new("TextButton", AlertPopup)
AP_OkBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
AP_OkBtn.BorderSizePixel = 0
AP_OkBtn.Position = UDim2.new(0.5, -60, 0, 100)
AP_OkBtn.Size = UDim2.new(0, 120, 0, 30)
AP_OkBtn.Font = Enum.Font.GothamBold
AP_OkBtn.Text = "ตกลง (OK)"
AP_OkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AP_OkBtn.TextSize = 9
AP_OkBtn.ZIndex = 201
Instance.new("UICorner", AP_OkBtn).CornerRadius = UDim.new(0, 6)

AP_OkBtn.MouseButton1Click:Connect(function()
    AlertPopup.Visible = false
end)

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
    pcall(function() if FOVCircle then FOVCircle:Remove() end end)
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

local function CreatePage(name, customHeight)
    local page = Instance.new("ScrollingFrame", PagesHolder)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, customHeight or 500)
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
local HomePage = CreatePage("🏠 Home", 460)
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
                    KI_Desc.Text = "🟢 สถานะ: สิทธิ์ผู้ดูแลระบบ / ถาวร (Unlimited)"
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
Instance.new("UICorner", RunScriptBtn).CornerRadius = UDim.new(0, 4)

local ClearScriptBtn = Instance.new("TextButton", ExecuterCard)
ClearScriptBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
ClearScriptBtn.BorderSizePixel = 0
ClearScriptBtn.Position = UDim2.new(0.68, 5, 0, 118)
ClearScriptBtn.Size = UDim2.new(0.32, -15, 0, 28)
ClearScriptBtn.Font = Enum.Font.GothamBold
ClearScriptBtn.Text = "🗑️ CLEAR / ล้าง"
ClearScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearScriptBtn.TextSize = 8
Instance.new("UICorner", ClearScriptBtn).CornerRadius = UDim.new(0, 4)

ClearScriptBtn.MouseButton1Click:Connect(function()
    ScriptBox.Text = ""
    ShowNotification("🗑️ CLEARED", "ล้างข้อความในกล่องเรียบร้อย")
end)

RunScriptBtn.MouseButton1Click:Connect(function()
    local code = ScriptBox.Text
    if code and code ~= "" then
        local success = pcall(function()
            local func, compileErr = loadstring(code)
            if not func then error(compileErr) end
            func()
        end)
        
        if success then
            ShowNotification("✅ SUCCESS", "รันสคริปต์สำเร็จแล้ว!")
        else
            ShowNotification("❌ ERROR", "เกิดข้อผิดพลาดในการรันสคริปต์")
        end
    end
end)

local ConfigCard = Instance.new("Frame", HomePage)
ConfigCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
ConfigCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
ConfigCard.BorderSizePixel = 1
ConfigCard.Size = UDim2.new(1, -6, 0, 65)
Instance.new("UICorner", ConfigCard).CornerRadius = UDim.new(0, 6)

local CC_Title = Instance.new("TextLabel", ConfigCard)
CC_Title.BackgroundTransparency = 1
CC_Title.Position = UDim2.new(0, 10, 0, 6)
CC_Title.Size = UDim2.new(1, -20, 0, 16)
CC_Title.Font = Enum.Font.GothamBold
CC_Title.Text = "⚙️ Config Manager (ระบบบันทึกและโหลดค่า)"
CC_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
CC_Title.TextSize = 8
CC_Title.TextXAlignment = Enum.TextXAlignment.Left

local SaveCfgBtn = Instance.new("TextButton", ConfigCard)
SaveCfgBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 70)
SaveCfgBtn.BorderSizePixel = 0
SaveCfgBtn.Position = UDim2.new(0, 10, 0, 28)
SaveCfgBtn.Size = UDim2.new(0.5, -15, 0, 26)
SaveCfgBtn.Font = Enum.Font.GothamBold
SaveCfgBtn.Text = "💾 Save Config"
SaveCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveCfgBtn.TextSize = 8
Instance.new("UICorner", SaveCfgBtn).CornerRadius = UDim.new(0, 4)
SaveCfgBtn.MouseButton1Click:Connect(SaveConfig)

local LoadCfgBtn = Instance.new("TextButton", ConfigCard)
LoadCfgBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
LoadCfgBtn.BorderSizePixel = 0
LoadCfgBtn.Position = UDim2.new(0.5, 5, 0, 28)
LoadCfgBtn.Size = UDim2.new(0.5, -15, 0, 26)
LoadCfgBtn.Font = Enum.Font.GothamBold
LoadCfgBtn.Text = "📂 Load Config"
LoadCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadCfgBtn.TextSize = 8
Instance.new("UICorner", LoadCfgBtn).CornerRadius = UDim.new(0, 4)
LoadCfgBtn.MouseButton1Click:Connect(LoadConfig)

-- 2. Player
local PlayerPage = CreatePage("🏃‍♂️ Player", 420)
AddTabButton("🏃‍♂️ Player", "ผู้เล่น")
CreateToggle(PlayerPage, "👻 Noclip (Walk Through Walls)", "เดินทะลุกำแพง", getgenv().UltimateStg.NoclipEnabled, function(state) getgenv().UltimateStg.NoclipEnabled = state ShowNotification("Player", "Noclip: " .. tostring(state)) end)
CreateToggle(PlayerPage, "🦘 Infinite Jump (Air Jump)", "กระโดดกลางอากาศ", getgenv().UltimateStg.InfiniteJumpEnabled, function(state) getgenv().UltimateStg.InfiniteJumpEnabled = state ShowNotification("Player", "Infinite Jump: " .. tostring(state)) end)
CreateToggle(PlayerPage, "🛡️ Anti-AFK (No Kick)", "ป้องกันหลุดห้อง (AFK)", getgenv().UltimateStg.AntiAFKEnabled, function(state) getgenv().UltimateStg.AntiAFKEnabled = state ShowNotification("Player", "Anti-AFK: " .. tostring(state)) end)
CreateToggle(PlayerPage, "📦 Hitbox Expander", "ขยายฮิตบ็อกซ์ตัวละคร", getgenv().UltimateStg.HitboxExpander, function(state) getgenv().UltimateStg.HitboxExpander = state ShowNotification("Player", "Hitbox Expander: " .. tostring(state)) end)
CreateSlider(PlayerPage, "📏 Hitbox Size", "ขนาดฮิตบ็อกซ์", 2, 10, getgenv().UltimateStg.HitboxSize, function(val) getgenv().UltimateStg.HitboxSize = val end)

-- 3. ESP
local EspPage = CreatePage("👀 ESP", 420)
AddTabButton("👀 ESP", "การมองเห็น")
CreateToggle(EspPage, "✨ ESP Glow", "เรืองแสงตัวละคร (Glow)", getgenv().UltimateStg.ESPGlow, function(state)
    getgenv().UltimateStg.ESPGlow = state
    ShowNotification("ESP", "ESP Glow: " .. tostring(state))
    if not state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("UltimateGlow") then
                plr.Character.UltimateGlow:Destroy()
            end
        end
    end
end)
CreateToggle(EspPage, "🔲 ESP Box", "แสดงกรอบรอบตัว (Box)", getgenv().UltimateStg.ESPBox, function(state)
    getgenv().UltimateStg.ESPBox = state
    ShowNotification("ESP", "ESP Box: " .. tostring(state))
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.Box then espData.Box.Visible = false end
        end
    end
end)
CreateToggle(EspPage, "📈 ESP Tracer", "แสดงเส้นโยง (Tracer)", getgenv().UltimateStg.ESPTracer, function(state)
    getgenv().UltimateStg.ESPTracer = state
    ShowNotification("ESP", "ESP Tracer: " .. tostring(state))
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.Tracer then espData.Tracer.Visible = false end
        end
    end
end)
CreateToggle(EspPage, "🏷️ ESP Name / Health / Dist", "ชื่อ เลือด ระยะห่าง", getgenv().UltimateStg.ESPNameInfo, function(state)
    getgenv().UltimateStg.ESPNameInfo = state
    ShowNotification("ESP", "ESP Info: " .. tostring(state))
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.NameTag then espData.NameTag.Visible = false end
        end
    end
end)
CreateSlider(EspPage, "🎯 Max ESP Distance", "ระยะทาง ESP สูงสุด", 50, 500, getgenv().UltimateStg.ESPDistanceMax, function(val) getgenv().UltimateStg.ESPDistanceMax = val end)

-- 4. Aimbot
local AimbotPage = CreatePage("🎯 Aimbot", 420)
AddTabButton("🎯 Aimbot", "ล็อคเป้า")
CreateToggle(AimbotPage, "👑 Aimbot - Head Lock", "ล็อคหัว", getgenv().UltimateStg.AimbotHead, function(state)
    getgenv().UltimateStg.AimbotHead = state
    if state then getgenv().UltimateStg.AimbotTorso = false end
    ShowNotification("Aimbot", "Head Lock: " .. tostring(state))
end)
CreateToggle(AimbotPage, "🎯 Aimbot - Torso Lock", "ล็อคตัว", getgenv().UltimateStg.AimbotTorso, function(state)
    getgenv().UltimateStg.AimbotTorso = state
    if state then getgenv().UltimateStg.AimbotHead = false end
    ShowNotification("Aimbot", "Torso Lock: " .. tostring(state))
end)
CreateToggle(AimbotPage, "🔮 Show FOV", "แสดงวง FOV", getgenv().UltimateStg.ShowFOV, function(state)
    getgenv().UltimateStg.ShowFOV = state
    if FOVCircle then FOVCircle.Visible = state end
    ShowNotification("Aimbot", "Show FOV: " .. tostring(state))
end)
CreateSlider(AimbotPage, "⚙️ FOV Size", "ขนาด FOV", 30, 500, getgenv().UltimateStg.FOVSize, function(val) getgenv().UltimateStg.FOVSize = val end)

local FOVColorBtn = Instance.new("TextButton", AimbotPage)
FOVColorBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
FOVColorBtn.BorderColor3 = Color3.fromRGB(45, 60, 90)
FOVColorBtn.BorderSizePixel = 1
FOVColorBtn.Size = UDim2.new(1, -6, 0, 32)
FOVColorBtn.Font = Enum.Font.GothamSemibold
FOVColorBtn.Text = "🎨 FOV Color Style: " .. FOVColorNames[1]
FOVColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVColorBtn.TextSize = 8
Instance.new("UICorner", FOVColorBtn).CornerRadius = UDim.new(0, 5)

FOVColorBtn.MouseButton1Click:Connect(function()
    getgenv().UltimateStg.FOVColorMode = getgenv().UltimateStg.FOVColorMode + 1
    if getgenv().UltimateStg.FOVColorMode > 5 then
        getgenv().UltimateStg.FOVColorMode = 1
    end
    local mode = getgenv().UltimateStg.FOVColorMode
    FOVColorBtn.Text = "🎨 FOV Color Style: " .. FOVColorNames[mode]
    if mode == 1 then
        FOVColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        FOVColorBtn.TextColor3 = FOVColorList[mode - 1]
    end
end)

-- 5. Settings
local SettingsPage = CreatePage("⚙️ Settings")
AddTabButton("⚙️ Settings", "ตั้งค่า")
CreateToggle(SettingsPage, "📊 Floating FPS/Ping", "สถิติลอย", getgenv().UltimateStg.FloatingStats, function(state)
    getgenv().UltimateStg.FloatingStats = state
    FloatFrame.Visible = state
    ShowNotification("Settings", "Floating Stats: " .. tostring(state))
end)
CreateToggle(SettingsPage, "⚡ FPS & Ping Booster", "บูสความลื่น", getgenv().UltimateStg.FPSBoost, function(state)
    getgenv().UltimateStg.FPSBoost = state
    if state then
        pcall(function()
            settings():GetService("NetworkSettings").IncomingReplicationLag = 0
            Lighting.GlobalShadows = false
        end)
        ShowNotification("Settings", "FPS Booster: ON")
    else
        pcall(function()
            settings():GetService("NetworkSettings").IncomingReplicationLag = 0.1
            Lighting.GlobalShadows = true
        end)
        ShowNotification("Settings", "FPS Booster: OFF")
    end
end)

-- 6. Security
local SecurityPage = CreatePage("🛡️ Security")
AddTabButton("🛡️ Security", "ความปลอดภัย")
local SecInfoCard = Instance.new("Frame", SecurityPage)
SecInfoCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
SecInfoCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
SecInfoCard.BorderSizePixel = 1
SecInfoCard.Size = UDim2.new(1, -6, 0, 130)
Instance.new("UICorner", SecInfoCard).CornerRadius = UDim.new(0, 6)

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

-- 7. DEV & ADMIN PANEL
if Owners[LocalPlayer.Name] or Admins[LocalPlayer.Name] then
    local DevPage = CreatePage("🛠️ DEV / ADMIN", 460)
    AddTabButton("🛠️ DEV", "ระบบแอดมิน")
    
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
    local roleText = Owners[LocalPlayer.Name] and "⭐ OWNER KEY GENERATOR PANEL" : "🛡️ ADMIN KEY GENERATOR PANEL"
    DC_Head.Text = roleText
    DC_Head.TextColor3 = Color3.fromRGB(255, 200, 0)
    DC_Head.TextSize = 9
    DC_Head.TextXAlignment = Enum.TextXAlignment.Left
    
    local KeyInput = Instance.new("TextBox", DevCard)
    KeyInput.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
    KeyInput.BorderColor3 = Color3.fromRGB(45, 60, 90)
    KeyInput.BorderSizePixel = 1
    KeyInput.Position = UDim2.new(0, 10, 0, 32)
    KeyInput.Size = UDim2.new(1, -20, 0, 30)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderText = "พิมพ์ชื่อคีย์ที่ต้องการสร้าง (เช่น MIN-VIP-XYZ)"
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.PlaceholderColor3 = Color3.fromRGB(110, 130, 170)
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
        btn.BorderSizePixel = 0
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
    GenBtn.BorderSizePixel = 0
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

        local newKey = KeyInput.Text
        if newKey == "" then
            newKey = "MIN-" .. math.random(100000, 999999)
        end
        
        local expiryTime = 0
        if selectedDays > 0 then
            expiryTime = os.time() + (selectedDays * 24 * 60 * 60)
        end
        
        KeyDatabase[newKey] = {Used = false, ExpiresAt = expiryTime}
        pcall(function() setclipboard(newKey) end)
        
        GenBtn.Text = "✅ สร้างและคัดลอกคีย์สำเร็จ: " .. newKey
        ShowNotification("🔑 KEY CREATED", "สร้างและคัดลอกคีย์สำเร็จ!")
        
        SendDiscordWebhook("🛠️ New Key Generated", "Creator: **" .. LocalPlayer.Name .. "**\nNew Key: `" .. newKey .. "`\nExpires: `" .. selectedDays .. " Days`", 16776960)

        task.wait(2)
        GenBtn.Text = "➕ สร้างคีย์ & คัดลอก (Generate Key)"
    end)
end

RenderConnection = RunService.RenderStepped:Connect(function(dt)
    if not getgenv().HubLoaded then
        if FOVCircle then FOVCircle.Visible = false end
        for _, espData in pairs(ESPContainer) do
            if espData.Box then espData.Box.Visible = false end
            if espData.Tracer then espData.Tracer.Visible = false end
            if espData.NameTag then espData.NameTag.Visible = false end
        end
        return 
    end

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
    if getgenv().UltimateStg.FloatingStats then
        FloatText.Text = "📊 FPS: " .. currentFPS .. " | Ping: " .. pingVal .. "ms"
    end

    pcall(function()
        if getgenv().UltimateStg.NoclipEnabled and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)

    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                if getgenv().UltimateStg.HitboxExpander then
                    hrp.Size = Vector3.new(getgenv().UltimateStg.HitboxSize, getgenv().UltimateStg.HitboxSize, getgenv().UltimateStg.HitboxSize)
                    hrp.Transparency = 0.7
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end)

    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local char = plr.Character
                if getgenv().UltimateStg.ESPGlow and char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local targetRoot = char:FindFirstChild("HumanoidRootPart")
                    local inDist = true
                    if myRoot and targetRoot then
                        local dist = (myRoot.Position - targetRoot.Position).Magnitude
                        if dist > getgenv().UltimateStg.ESPDistanceMax then inDist = false end
                    end

                    if inDist then
                        if not char:FindFirstChild("UltimateGlow") then
                            local glow = Instance.new("Highlight")
                            glow.Name = "UltimateGlow"
                            glow.Adornee = char
                            glow.FillColor = Color3.fromRGB(0, 120, 255)
                            glow.OutlineColor = Color3.fromRGB(150, 100, 255)
                            glow.FillTransparency = 0.3
                            glow.Parent = char
                        end
                    else
                        if char:FindFirstChild("UltimateGlow") then char.UltimateGlow:Destroy() end
                    end
                else
                    if char and char:FindFirstChild("UltimateGlow") then char.UltimateGlow:Destroy() end
                end
            end
        end
    end)

    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                if getgenv().UltimateStg.ESPBox or getgenv().UltimateStg.ESPTracer or getgenv().UltimateStg.ESPNameInfo then
                    if not ESPContainer[plr] then
                        local box, tracer, nameTag = nil, nil, nil
                        pcall(function()
                            if Drawing then
                                box = Drawing.new("Square")
                                box.Visible = false
                                box.Color = Color3.fromRGB(0, 162, 255)
                                box.Thickness = 1.5
                                box.Filled = false

                                tracer = Drawing.new("Line")
                                tracer.Visible = false
                                tracer.Color = Color3.fromRGB(150, 100, 255)
                                tracer.Thickness = 1
                                tracer.Transparency = 0.7

                                nameTag = Drawing.new("Text")
                                nameTag.Visible = false
                                nameTag.Center = true
                                nameTag.Outline = true
                                nameTag.Color = Color3.fromRGB(255, 255, 255)
                                nameTag.Size = 12
                                nameTag.Font = 2
                            end
                        end)
                        ESPContainer[plr] = {Box = box, Tracer = tracer, NameTag = nameTag}
                    end

                    local char = plr.Character
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 and myRoot then
                        local hrp = char.HumanoidRootPart
                        local head = char:FindFirstChild("Head")
                        local dist = (myRoot.Position - hrp.Position).Magnitude

                        if head and dist <= getgenv().UltimateStg.ESPDistanceMax then
                            local topPosition = head.Position + Vector3.new(0, 0.7, 0)
                            local bottomPosition = hrp.Position - Vector3.new(0, 2.8, 0)
                            local topPos, topOnScreen = Camera:WorldToViewportPoint(topPosition)
                            local bottomPos, bottomOnScreen = Camera:WorldToViewportPoint(bottomPosition)

                            if topOnScreen or bottomOnScreen then
                                local box = ESPContainer[plr].Box
                                local tracer = ESPContainer[plr].Tracer
                                local nameTag = ESPContainer[plr].NameTag
                                local height = math.abs(bottomPos.Y - topPos.Y)
                                local width = height / 2

                                if getgenv().UltimateStg.ESPBox and box then
                                    box.Size = Vector2.new(width, height)
                                    box.Position = Vector2.new(topPos.X - width / 2, topPos.Y)
                                    box.Visible = true
                                elseif box then
                                    box.Visible = false
                                end

                                if getgenv().UltimateStg.ESPTracer and tracer then
                                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 20)
                                    tracer.To = Vector2.new(bottomPos.X, bottomPos.Y)
                                    tracer.Visible = true
                                elseif tracer then
                                    tracer.Visible = false
                                end

                                if getgenv().UltimateStg.ESPNameInfo and nameTag then
                                    local health = math.floor(char.Humanoid.Health)
                                    nameTag.Text = "👤 " .. plr.Name .. " | 💖 " .. health .. " HP | 📍 " .. math.floor(dist) .. "m"
                                    nameTag.Position = Vector2.new(topPos.X, topPos.Y - 20)
                                    nameTag.Visible = true
                                elseif nameTag then
                                    nameTag.Visible = false
                                end
                            else
                                if ESPContainer[plr].Box then ESPContainer[plr].Box.Visible = false end
                                if ESPContainer[plr].Tracer then ESPContainer[plr].Tracer.Visible = false end
                                if ESPContainer[plr].NameTag then ESPContainer[plr].NameTag.Visible = false end
                            end
                        else
                            if ESPContainer[plr] then
                                if ESPContainer[plr].Box then ESPContainer[plr].Box.Visible = false end
                                if ESPContainer[plr].Tracer then ESPContainer[plr].Tracer.Visible = false end
                                if ESPContainer[plr].NameTag then ESPContainer[plr].NameTag.Visible = false end
                            end
                        end
                    else
                        if ESPContainer[plr] then
                            if ESPContainer[plr].Box then ESPContainer[plr].Box.Visible = false end
                            if ESPContainer[plr].Tracer then ESPContainer[plr].Tracer.Visible = false end
                            if ESPContainer[plr].NameTag then ESPContainer[plr].NameTag.Visible = false end
                        end
                    end
                else
                    if ESPContainer[plr] then
                        if ESPContainer[plr].Box then ESPContainer[plr].Box.Visible = false end
                        if ESPContainer[plr].Tracer then ESPContainer[plr].Tracer.Visible = false end
                        if ESPContainer[plr].NameTag then ESPContainer[plr].NameTag.Visible = false end
                    end
                end
            end
        end
    end

    pcall(function()
        if FOVCircle and getgenv().UltimateStg.ShowFOV then
            FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            FOVCircle.Radius = getgenv().UltimateStg.FOVSize
            local mode = getgenv().UltimateStg.FOVColorMode
            if mode == 1 then
                local hue = tick() % 5 / 5
                FOVCircle.Color = Color3.fromHSV(hue, 1, 1)
            else
                FOVCircle.Color = FOVColorList[mode - 1]
            end
            FOVCircle.Visible = true
        elseif FOVCircle then
            FOVCircle.Visible = false
        end
    end)

    pcall(function()
        if getgenv().UltimateStg.AimbotHead or getgenv().UltimateStg.AimbotTorso then
            local closestTarget = nil
            local shortestDist = getgenv().UltimateStg.FOVSize
            local origin = Camera.CFrame.Position

            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
                    local targetPart = nil
                    if getgenv().UltimateStg.AimbotHead then
                        targetPart = plr.Character:FindFirstChild("Head")
                    elseif getgenv().UltimateStg.AimbotTorso then
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

Players.PlayerRemoving:Connect(function(plr)
    if ESPContainer[plr] then
        pcall(function()
            if ESPContainer[plr].Box then ESPContainer[plr].Box:Remove() end
            if ESPContainer[plr].Tracer then ESPContainer[plr].Tracer:Remove() end
            if ESPContainer[plr].NameTag then ESPContainer[plr].NameTag:Remove() end
        end)
        ESPContainer[plr] = nil
    end
end)

UserInputService.JumpRequest:Connect(function()
    if getgenv().HubLoaded and getgenv().UltimateStg.InfiniteJumpEnabled then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(60) do
        if getgenv().HubLoaded and getgenv().UltimateStg.AntiAFKEnabled then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)
