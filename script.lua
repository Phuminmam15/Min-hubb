-- =====================================================================
-- Min Hub - Maintenance & Update Notice UI
-- =====================================================================

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ลบ UI เก่าทิ้งก่อนกันซ้อนทับ
if CoreGui:FindFirstChild("MinHubMaintenance") then
    CoreGui.MinHubMaintenance:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MinHubMaintenance"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- กรอบแจ้งเตือนหลัก (Maintenance Frame)
local NoticeFrame = Instance.new("Frame", ScreenGui)
NoticeFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
NoticeFrame.BorderColor3 = Color3.fromRGB(0, 255, 128)
NoticeFrame.BorderSizePixel = 1
NoticeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
NoticeFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
NoticeFrame.Size = UDim2.new(0, 420, 0, 260)
NoticeFrame.Active = true
NoticeFrame.Draggable = true

-- ไอคอนหรือหัวข้อสถานะ
local IconLabel = Instance.new("TextLabel", NoticeFrame)
IconLabel.BackgroundTransparency = 1
IconLabel.Position = UDim2.new(0, 20, 0, 20)
IconLabel.Size = UDim2.new(1, -40, 0, 30)
IconLabel.Font = Enum.Font.GothamBold
IconLabel.Text = "⚠️️ SCRIPT UNDER MAINTENANCE"
IconLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
IconLabel.TextSize = 15
IconLabel.TextXAlignment = Enum.TextXAlignment.Center

local SubTitle = Instance.new("TextLabel", NoticeFrame)
IconLabel.BackgroundTransparency = 1
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 20, 0, 50)
SubTitle.Size = UDim2.new(1, -40, 0, 20)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "ระบบกำลังปิดปรับปรุง / อัปเดตชั่วคราว"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
SubTitle.TextSize = 11
SubTitle.TextXAlignment = Enum.TextXAlignment.Center

-- กล่องข้อความรายละเอียด (Notice Details)
local DescBox = Instance.new("Frame", NoticeFrame)
DescBox.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
DescBox.BorderColor3 = Color3.fromRGB(40, 40, 55)
DescBox.Position = UDim2.new(0, 25, 0, 85)
DescBox.Size = UDim2.new(1, -50, 0, 95)

local DescText = Instance.new("TextLabel", DescBox)
DescText.BackgroundTransparency = 1
DescText.Position = UDim2.new(0, 15, 0, 10)
DescText.Size = UDim2.new(1, -30, 1, -20)
DescText.Font = Enum.Font.Gotham
DescText.Text = "ขณะนี้สคริปต์อยู่ในระหว่างปรับปรุงระบบเพื่อเพิ่มฟังก์ชันใหม่และป้องกันการตรวจจับจากระบบกันโปร (Anti-Cheat) กรุณารอสักครู่จนกว่าจะอัปเดตเสร็จสิ้น\n\n• สถานะ: กำลังพัฒนา / ปรับปรุง\n• ติดตามการอัปเดตได้ที่ Discord"
DescText.TextColor3 = Color3.fromRGB(200, 200, 210)
DescText.TextSize = 10
DescText.TextWrapped = true
DescText.TextXAlignment = Enum.TextXAlignment.Left
DescText.TextYAlignment = Enum.TextYAlignment.Top

-- ปุ่มปิด / คัดลอกลิงก์ Discord แจ้งข่าวสาร
local CloseNoticeBtn = Instance.new("TextButton", NoticeFrame)
CloseNoticeBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
CloseNoticeBtn.BorderSizePixel = 0
CloseNoticeBtn.Position = UDim2.new(0, 25, 0, 195)
CloseNoticeBtn.Size = UDim2.new(1, -50, 0, 35)
CloseNoticeBtn.Font = Enum.Font.GothamBold
CloseNoticeBtn.Text = "CLOSE / ปิดหน้าต่างนี้"
CloseNoticeBtn.TextColor3 = Color3.fromRGB(12, 12, 16)
CloseNoticeBtn.TextSize = 11

CloseNoticeBtn.MouseButton1Click:Connect(function()
    -- เอฟเฟกต์ย่อหน้าจอก่อนปิด
    local tweenOut = TweenService:Create(NoticeFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tweenOut:Play()
    tweenOut.Completed:Wait()
    ScreenGui:Destroy()
end)
