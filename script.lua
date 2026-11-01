--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local CoreGui = game:GetService("CoreGui");
local Stats = game:GetService("Stats");
local Lighting = game:GetService("Lighting");
local Workspace = game:GetService("Workspace");
local UserInputService = game:GetService("UserInputService");
local Camera = Workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local DevUsername = "Terx_83";
for _, v in pairs(CoreGui:GetChildren()) do
	if (v.Name == "NongminUltimateHub") then
		v:Destroy();
	end
end
pcall(function()
	local FlatIdent_2584C = 0;
	local mt;
	local oldNamecall;
	while true do
		if (FlatIdent_2584C == 1) then
			oldNamecall = mt.__namecall;
			mt.__namecall = newcclosure(function(self, ...)
				local FlatIdent_7126A = 0;
				local method;
				local args;
				while true do
					if (FlatIdent_7126A == 1) then
						if ((method == "Kick") and (self == LocalPlayer)) then
							return nil;
						end
						if ((method == "Teleport") or (method == "TeleportToNotInServer")) then
							return nil;
						end
						FlatIdent_7126A = 2;
					end
					if (FlatIdent_7126A == 2) then
						if ((method == "ReportAbuse") or (method == "PostAsync") or (method == "GetAsync") or (method == "JSONEncode")) then
							if (type(args[1]) == "string") then
								local FlatIdent_30B1F = 0;
								local str;
								while true do
									if (FlatIdent_30B1F == 0) then
										str = string.lower(args[1]);
										if (string.match(str, "ban") or string.match(str, "detect") or string.match(str, "telemetry") or string.match(str, "exploit")) then
											return nil;
										end
										break;
									end
								end
							end
						end
						return oldNamecall(self, ...);
					end
					if (FlatIdent_7126A == 0) then
						method = getnamecallmethod();
						args = {...};
						FlatIdent_7126A = 1;
					end
				end
			end);
			FlatIdent_2584C = 2;
		end
		if (FlatIdent_2584C == 0) then
			mt = getrawmetatable(game);
			setreadonly(mt, false);
			FlatIdent_2584C = 1;
		end
		if (FlatIdent_2584C == 2) then
			setreadonly(mt, true);
			break;
		end
	end
end);
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "NongminUltimateHub";
ScreenGui.Parent = CoreGui;
ScreenGui.ResetOnSpawn = false;
local MinimalRGBStrokes = {};
local RenderConnection = nil;
local ESPContainer = {};
local FOVCircle = Drawing.new("Circle");
FOVCircle.Visible = false;
FOVCircle.Thickness = 2;
FOVCircle.NumSides = 64;
FOVCircle.Filled = false;
FOVCircle.Transparency = 0.9;
local function AddRGBStroke(parent, thickness)
	local FlatIdent_8CB90 = 0;
	local stroke;
	while true do
		if (FlatIdent_8CB90 == 1) then
			stroke.Color = Color3.fromRGB(0, 162, 255);
			stroke.Parent = parent;
			FlatIdent_8CB90 = 2;
		end
		if (FlatIdent_8CB90 == 0) then
			stroke = Instance.new("UIStroke");
			stroke.Thickness = thickness or 1.5;
			FlatIdent_8CB90 = 1;
		end
		if (FlatIdent_8CB90 == 2) then
			table.insert(MinimalRGBStrokes, stroke);
			return stroke;
		end
	end
end
local KeyDatabase = {["TERX-VIP-1111"]={Used=false,ExpiresAt=0},["TERX-VIP-7DAYS"]={Used=false,ExpiresAt=(os.time() + (7 * 24 * 60 * 60))}};
local KeyScreen = Instance.new("Frame", ScreenGui);
KeyScreen.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
KeyScreen.BorderSizePixel = 0;
KeyScreen.AnchorPoint = Vector2.new(0.5, 0.5);
KeyScreen.Position = UDim2.new(0.5, 0, 0.5, 0);
KeyScreen.Size = UDim2.new(0, 340, 0, 220);
KeyScreen.Active = true;
KeyScreen.Draggable = true;
AddRGBStroke(KeyScreen, 2);
local KeyCorner = Instance.new("UICorner", KeyScreen);
KeyCorner.CornerRadius = UDim.new(0, 8);
local KeyTitle = Instance.new("TextLabel", KeyScreen);
KeyTitle.BackgroundTransparency = 1;
KeyTitle.Position = UDim2.new(0, 15, 0, 15);
KeyTitle.Size = UDim2.new(1, -30, 0, 25);
KeyTitle.Font = Enum.Font.GothamBold;
KeyTitle.Text = "🔑 ENTER KEY SYSTEM 🔑";
KeyTitle.TextColor3 = Color3.fromRGB(0, 180, 255);
KeyTitle.TextSize = 12;
KeyTitle.TextXAlignment = Enum.TextXAlignment.Center;
local KeySub = Instance.new("TextLabel", KeyScreen);
KeySub.BackgroundTransparency = 1;
KeySub.Position = UDim2.new(0, 15, 0, 42);
KeySub.Size = UDim2.new(1, -30, 0, 20);
KeySub.Font = Enum.Font.Gotham;
KeySub.Text = "1 Key / 1 Person with Expiry System";
KeySub.TextColor3 = Color3.fromRGB(160, 180, 210);
KeySub.TextSize = 8;
KeySub.TextXAlignment = Enum.TextXAlignment.Center;
local KeyBox = Instance.new("TextBox", KeyScreen);
KeyBox.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
KeyBox.BorderColor3 = Color3.fromRGB(45, 60, 90);
KeyBox.BorderSizePixel = 1;
KeyBox.Position = UDim2.new(0, 25, 0, 75);
KeyBox.Size = UDim2.new(1, -50, 0, 35);
KeyBox.Font = Enum.Font.GothamSemibold;
KeyBox.PlaceholderText = "Enter your key here...";
KeyBox.Text = "";
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255);
KeyBox.PlaceholderColor3 = Color3.fromRGB(110, 130, 170);
KeyBox.TextSize = 10;
local BoxCorner = Instance.new("UICorner", KeyBox);
BoxCorner.CornerRadius = UDim.new(0, 6);
local SubmitKeyBtn = Instance.new("TextButton", KeyScreen);
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255);
SubmitKeyBtn.BorderSizePixel = 0;
SubmitKeyBtn.Position = UDim2.new(0, 25, 0, 122);
SubmitKeyBtn.Size = UDim2.new(1, -50, 0, 32);
SubmitKeyBtn.Font = Enum.Font.GothamBold;
SubmitKeyBtn.Text = "✨ VERIFY KEY / ยืนยันคีย์";
SubmitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
SubmitKeyBtn.TextSize = 9;
local SubmitCorner = Instance.new("UICorner", SubmitKeyBtn);
SubmitCorner.CornerRadius = UDim.new(0, 6);
local CancelKeyBtn = Instance.new("TextButton", KeyScreen);
CancelKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50);
CancelKeyBtn.BorderColor3 = Color3.fromRGB(50, 60, 85);
CancelKeyBtn.Position = UDim2.new(0, 25, 0, 162);
CancelKeyBtn.Size = UDim2.new(1, -50, 0, 28);
CancelKeyBtn.Font = Enum.Font.GothamBold;
CancelKeyBtn.Text = "❌ CANCEL / ยกเลิก";
CancelKeyBtn.TextColor3 = Color3.fromRGB(255, 100, 100);
CancelKeyBtn.TextSize = 9;
local CancelCorner = Instance.new("UICorner", CancelKeyBtn);
CancelCorner.CornerRadius = UDim.new(0, 6);
CancelKeyBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy();
end);
local LoadingFrame = Instance.new("Frame", ScreenGui);
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
LoadingFrame.BorderSizePixel = 0;
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5);
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
LoadingFrame.Size = UDim2.new(0, 340, 0, 210);
LoadingFrame.Visible = false;
AddRGBStroke(LoadingFrame, 2);
local LoadCorner = Instance.new("UICorner", LoadingFrame);
LoadCorner.CornerRadius = UDim.new(0, 8);
local LoadTitle = Instance.new("TextLabel", LoadingFrame);
LoadTitle.BackgroundTransparency = 1;
LoadTitle.Position = UDim2.new(0, 15, 0, 35);
LoadTitle.Size = UDim2.new(1, -30, 0, 20);
LoadTitle.Font = Enum.Font.GothamBold;
LoadTitle.Text = "Key Verified! Loading Hub...";
LoadTitle.TextColor3 = Color3.fromRGB(0, 180, 255);
LoadTitle.TextSize = 11;
LoadTitle.TextXAlignment = Enum.TextXAlignment.Center;
local LoadPercent = Instance.new("TextLabel", LoadingFrame);
LoadPercent.BackgroundTransparency = 1;
LoadPercent.Position = UDim2.new(0, 15, 0, 65);
LoadPercent.Size = UDim2.new(1, -30, 0, 30);
LoadPercent.Font = Enum.Font.GothamBold;
LoadPercent.Text = "0%";
LoadPercent.TextColor3 = Color3.fromRGB(255, 255, 255);
LoadPercent.TextSize = 16;
LoadPercent.TextXAlignment = Enum.TextXAlignment.Center;
local BarBg = Instance.new("Frame", LoadingFrame);
BarBg.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
BarBg.BorderSizePixel = 0;
BarBg.Position = UDim2.new(0, 25, 0, 115);
BarBg.Size = UDim2.new(1, -50, 0, 10);
local BarBgCorner = Instance.new("UICorner", BarBg);
BarBgCorner.CornerRadius = UDim.new(1, 0);
local BarFill = Instance.new("Frame", BarBg);
BarFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255);
BarFill.BorderSizePixel = 0;
BarFill.Size = UDim2.new(0, 0, 1, 0);
local BarFillCorner = Instance.new("UICorner", BarFill);
BarFillCorner.CornerRadius = UDim.new(1, 0);
local MainFrame = Instance.new("Frame", ScreenGui);
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
MainFrame.BorderSizePixel = 0;
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5);
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0);
MainFrame.Size = UDim2.new(0, 460, 0, 280);
MainFrame.Active = true;
MainFrame.Visible = false;
MainFrame.ClipsDescendants = true;
AddRGBStroke(MainFrame, 2.5);
local MainCorner = Instance.new("UICorner", MainFrame);
MainCorner.CornerRadius = UDim.new(0, 8);
local ToggleButton = Instance.new("ImageButton", ScreenGui);
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
ToggleButton.BorderSizePixel = 0;
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30);
ToggleButton.Size = UDim2.new(0, 50, 0, 50);
ToggleButton.Image = "rbxassetid://579271238";
ToggleButton.ScaleType = Enum.ScaleType.Crop;
ToggleButton.Visible = false;
AddRGBStroke(ToggleButton, 2);
local ToggleCorner = Instance.new("UICorner", ToggleButton);
ToggleCorner.CornerRadius = UDim.new(0, 10);
local ToggleLabel = Instance.new("TextLabel", ToggleButton);
ToggleLabel.BackgroundTransparency = 1;
ToggleLabel.Size = UDim2.new(1, 0, 1, 0);
ToggleLabel.Font = Enum.Font.GothamBold;
ToggleLabel.Text = "[H]";
ToggleLabel.TextColor3 = Color3.fromRGB(0, 180, 255);
ToggleLabel.TextSize = 14;
SubmitKeyBtn.MouseButton1Click:Connect(function()
	local FlatIdent_1743D = 0;
	local userKey;
	local keyData;
	while true do
		if (2 == FlatIdent_1743D) then
			LoadingFrame.Visible = true;
			for i = 1, 100 do
				local FlatIdent_61B23 = 0;
				while true do
					if (FlatIdent_61B23 == 0) then
						LoadPercent.Text = i .. "%";
						BarFill.Size = UDim2.new(i / 100, 0, 1, 0);
						FlatIdent_61B23 = 1;
					end
					if (FlatIdent_61B23 == 1) then
						task.wait(0.015);
						break;
					end
				end
			end
			FlatIdent_1743D = 3;
		end
		if (FlatIdent_1743D == 0) then
			userKey = KeyBox.Text;
			keyData = KeyDatabase[userKey];
			FlatIdent_1743D = 1;
		end
		if (FlatIdent_1743D == 1) then
			if (LocalPlayer.Name == DevUsername) then
			elseif keyData then
				if (keyData.Used == true) then
					local FlatIdent_974E = 0;
					while true do
						if (FlatIdent_974E == 0) then
							KeyBox.Text = "";
							KeyBox.PlaceholderText = "❌ Key already used!";
							FlatIdent_974E = 1;
						end
						if (FlatIdent_974E == 1) then
							return;
						end
					end
				elseif ((keyData.ExpiresAt > 0) and (os.time() > keyData.ExpiresAt)) then
					local FlatIdent_129E6 = 0;
					while true do
						if (0 == FlatIdent_129E6) then
							KeyBox.Text = "";
							KeyBox.PlaceholderText = "❌ Key expired!";
							FlatIdent_129E6 = 1;
						end
						if (FlatIdent_129E6 == 1) then
							return;
						end
					end
				else
					keyData.Used = true;
				end
			else
				local FlatIdent_31905 = 0;
				while true do
					if (FlatIdent_31905 == 1) then
						return;
					end
					if (0 == FlatIdent_31905) then
						KeyBox.Text = "";
						KeyBox.PlaceholderText = "❌ Invalid Key!";
						FlatIdent_31905 = 1;
					end
				end
			end
			KeyScreen.Visible = false;
			FlatIdent_1743D = 2;
		end
		if (FlatIdent_1743D == 3) then
			LoadingFrame.Visible = false;
			MainFrame.Visible = true;
			FlatIdent_1743D = 4;
		end
		if (4 == FlatIdent_1743D) then
			ToggleButton.Visible = true;
			break;
		end
	end
end);
local dragging, dragStart, startPos;
MainFrame.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_946F = 0;
		while true do
			if (FlatIdent_946F == 0) then
				dragging = true;
				dragStart = input.Position;
				FlatIdent_946F = 1;
			end
			if (FlatIdent_946F == 1) then
				startPos = MainFrame.Position;
				break;
			end
		end
	end
end);
UserInputService.InputChanged:Connect(function(input)
	if (dragging and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		local FlatIdent_49AED = 0;
		local delta;
		while true do
			if (FlatIdent_49AED == 0) then
				delta = input.Position - dragStart;
				MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
				break;
			end
		end
	end
end);
UserInputService.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		dragging = false;
	end
end);
local tDragging, tDragStart, tStartPos;
ToggleButton.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_99389 = 0;
		while true do
			if (FlatIdent_99389 == 1) then
				tStartPos = ToggleButton.Position;
				break;
			end
			if (FlatIdent_99389 == 0) then
				tDragging = true;
				tDragStart = input.Position;
				FlatIdent_99389 = 1;
			end
		end
	end
end);
UserInputService.InputChanged:Connect(function(input)
	if (tDragging and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		local FlatIdent_7A75F = 0;
		local delta;
		while true do
			if (FlatIdent_7A75F == 0) then
				delta = input.Position - tDragStart;
				ToggleButton.Position = UDim2.new(tStartPos.X.Scale, tStartPos.X.Offset + delta.X, tStartPos.Y.Scale, tStartPos.Y.Offset + delta.Y);
				break;
			end
		end
	end
end);
UserInputService.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		tDragging = false;
	end
end);
local function ToggleMenu()
	MainFrame.Visible = not MainFrame.Visible;
end
ToggleButton.MouseButton1Click:Connect(ToggleMenu);
UserInputService.InputBegan:Connect(function(input, gp)
	if (not gp and (input.KeyCode == Enum.KeyCode.H)) then
		ToggleMenu();
	end
end);
local TopBarHolder = Instance.new("ScrollingFrame", MainFrame);
TopBarHolder.BackgroundColor3 = Color3.fromRGB(10, 12, 20);
TopBarHolder.BorderSizePixel = 0;
TopBarHolder.Size = UDim2.new(1, -35, 0, 36);
TopBarHolder.CanvasSize = UDim2.new(0, 520, 0, 0);
TopBarHolder.ScrollBarThickness = 0;
TopBarHolder.ScrollingDirection = Enum.ScrollingDirection.X;
local TopBarList = Instance.new("UIListLayout", TopBarHolder);
TopBarList.FillDirection = Enum.FillDirection.Horizontal;
TopBarList.SortOrder = Enum.SortOrder.LayoutOrder;
TopBarList.Padding = UDim.new(0, 2);
local ConfirmDialog = Instance.new("Frame", ScreenGui);
ConfirmDialog.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
ConfirmDialog.BorderSizePixel = 0;
ConfirmDialog.AnchorPoint = Vector2.new(0.5, 0.5);
ConfirmDialog.Position = UDim2.new(0.5, 0, 0.5, 0);
ConfirmDialog.Size = UDim2.new(0, 320, 0, 160);
ConfirmDialog.Visible = false;
ConfirmDialog.ZIndex = 100;
AddRGBStroke(ConfirmDialog, 2);
local CDCorner = Instance.new("UICorner", ConfirmDialog);
CDCorner.CornerRadius = UDim.new(0, 8);
local CDTitle = Instance.new("TextLabel", ConfirmDialog);
CDTitle.BackgroundTransparency = 1;
CDTitle.Position = UDim2.new(0, 15, 0, 15);
CDTitle.Size = UDim2.new(1, -30, 0, 20);
CDTitle.Font = Enum.Font.GothamBold;
CDTitle.Text = "⚠️ ยืนยันการปิดใช้งาน (Confirm Exit)";
CDTitle.TextColor3 = Color3.fromRGB(255, 90, 90);
CDTitle.TextSize = 11;
CDTitle.ZIndex = 101;
local CDDesc = Instance.new("TextLabel", ConfirmDialog);
CDDesc.BackgroundTransparency = 1;
CDDesc.Position = UDim2.new(0, 15, 0, 42);
CDDesc.Size = UDim2.new(1, -30, 0, 40);
CDDesc.Font = Enum.Font.Gotham;
CDDesc.Text = "คุณแน่ใจหรือไม่ว่าต้องการปิดสคริปต์?\nฟังก์ชันทั้งหมดจะหยุดทำงานและปิดลงทันที";
CDDesc.TextColor3 = Color3.fromRGB(180, 190, 210);
CDDesc.TextSize = 8;
CDDesc.TextWrapped = true;
CDDesc.ZIndex = 101;
local ConfirmYesBtn = Instance.new("TextButton", ConfirmDialog);
ConfirmYesBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40);
ConfirmYesBtn.BorderSizePixel = 0;
ConfirmYesBtn.Position = UDim2.new(0, 20, 0, 105);
ConfirmYesBtn.Size = UDim2.new(0, 130, 0, 32);
ConfirmYesBtn.Font = Enum.Font.GothamBold;
ConfirmYesBtn.Text = "✓ ยืนยัน (Confirm)";
ConfirmYesBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
ConfirmYesBtn.TextSize = 9;
ConfirmYesBtn.ZIndex = 101;
local CYCorner = Instance.new("UICorner", ConfirmYesBtn);
CYCorner.CornerRadius = UDim.new(0, 6);
local ConfirmNoBtn = Instance.new("TextButton", ConfirmDialog);
ConfirmNoBtn.BackgroundColor3 = Color3.fromRGB(35, 45, 65);
ConfirmNoBtn.BorderSizePixel = 0;
ConfirmNoBtn.Position = UDim2.new(1, -150, 0, 105);
ConfirmNoBtn.Size = UDim2.new(0, 130, 0, 32);
ConfirmNoBtn.Font = Enum.Font.GothamBold;
ConfirmNoBtn.Text = "✕ ยกเลิก (Cancel)";
ConfirmNoBtn.TextColor3 = Color3.fromRGB(200, 220, 255);
ConfirmNoBtn.TextSize = 9;
ConfirmNoBtn.ZIndex = 101;
local CNCorner = Instance.new("UICorner", ConfirmNoBtn);
CNCorner.CornerRadius = UDim.new(0, 6);
local CloseBtn = Instance.new("TextButton", MainFrame);
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40);
CloseBtn.BorderSizePixel = 0;
CloseBtn.Position = UDim2.new(1, -30, 0, 7);
CloseBtn.Size = UDim2.new(0, 22, 0, 22);
CloseBtn.Font = Enum.Font.GothamBold;
CloseBtn.Text = "X";
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
CloseBtn.TextSize = 9;
local CloseCorner = Instance.new("UICorner", CloseBtn);
CloseCorner.CornerRadius = UDim.new(0, 4);
CloseBtn.ZIndex = 5;
local function UnloadAllScript()
	local FlatIdent_59521 = 0;
	while true do
		if (FlatIdent_59521 == 1) then
			pcall(function()
				for _, plr in pairs(Players:GetPlayers()) do
					if plr.Character then
						for _, obj in pairs(plr.Character:GetChildren()) do
							if (obj.Name == "UltimateGlow") then
								obj:Destroy();
							end
						end
					end
				end
			end);
			for _, espData in pairs(ESPContainer) do
				local FlatIdent_1B1BA = 0;
				while true do
					if (FlatIdent_1B1BA == 0) then
						if espData.Box then
							pcall(function()
								espData.Box:Remove();
							end);
						end
						if espData.Tracer then
							pcall(function()
								espData.Tracer:Remove();
							end);
						end
						break;
					end
				end
			end
			FlatIdent_59521 = 2;
		end
		if (FlatIdent_59521 == 3) then
			ScreenGui:Destroy();
			break;
		end
		if (FlatIdent_59521 == 2) then
			ESPContainer = {};
			pcall(function()
				FOVCircle:Remove();
			end);
			FlatIdent_59521 = 3;
		end
		if (FlatIdent_59521 == 0) then
			if RenderConnection then
				RenderConnection:Disconnect();
				RenderConnection = nil;
			end
			pcall(function()
				if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
					LocalPlayer.Character.Humanoid.WalkSpeed = 16;
				end
			end);
			FlatIdent_59521 = 1;
		end
	end
end
CloseBtn.MouseButton1Click:Connect(function()
	ConfirmDialog.Visible = true;
end);
ConfirmNoBtn.MouseButton1Click:Connect(function()
	ConfirmDialog.Visible = false;
end);
ConfirmYesBtn.MouseButton1Click:Connect(function()
	UnloadAllScript();
end);
local ResizeBtn = Instance.new("TextButton", MainFrame);
ResizeBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
ResizeBtn.BorderSizePixel = 0;
ResizeBtn.Position = UDim2.new(1, -22, 1, -22);
ResizeBtn.Size = UDim2.new(0, 18, 0, 18);
ResizeBtn.Text = "◢";
ResizeBtn.TextColor3 = Color3.fromRGB(0, 180, 255);
ResizeBtn.TextSize = 10;
ResizeBtn.ZIndex = 10;
AddRGBStroke(ResizeBtn, 1.5);
local ResizeCorner = Instance.new("UICorner", ResizeBtn);
ResizeCorner.CornerRadius = UDim.new(0, 4);
local resizing = false;
local resizeStart, startSize;
ResizeBtn.InputBegan:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		local FlatIdent_380E8 = 0;
		while true do
			if (FlatIdent_380E8 == 0) then
				resizing = true;
				resizeStart = input.Position;
				FlatIdent_380E8 = 1;
			end
			if (FlatIdent_380E8 == 1) then
				startSize = MainFrame.AbsoluteSize;
				break;
			end
		end
	end
end);
UserInputService.InputChanged:Connect(function(input)
	if (resizing and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
		local FlatIdent_39EBF = 0;
		local delta;
		local newWidth;
		local newHeight;
		while true do
			if (FlatIdent_39EBF == 0) then
				delta = input.Position - resizeStart;
				newWidth = math.clamp(startSize.X + delta.X, 380, 750);
				FlatIdent_39EBF = 1;
			end
			if (1 == FlatIdent_39EBF) then
				newHeight = math.clamp(startSize.Y + delta.Y, 240, 520);
				MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight);
				break;
			end
		end
	end
end);
UserInputService.InputEnded:Connect(function(input)
	if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
		resizing = false;
	end
end);
local PagesHolder = Instance.new("Frame", MainFrame);
PagesHolder.BackgroundTransparency = 1;
PagesHolder.Position = UDim2.new(0, 10, 0, 45);
PagesHolder.Size = UDim2.new(1, -20, 1, -52);
local Pages = {};
local MenuButtons = {};
local function CreatePage(name, customHeight)
	local FlatIdent_494DF = 0;
	local page;
	local layout;
	while true do
		if (FlatIdent_494DF == 1) then
			page.ScrollBarThickness = 2;
			page.Visible = false;
			layout = Instance.new("UIListLayout", page);
			layout.SortOrder = Enum.SortOrder.LayoutOrder;
			FlatIdent_494DF = 2;
		end
		if (FlatIdent_494DF == 0) then
			page = Instance.new("ScrollingFrame", PagesHolder);
			page.BackgroundTransparency = 1;
			page.Size = UDim2.new(1, 0, 1, 0);
			page.CanvasSize = UDim2.new(0, 0, 0, customHeight or 380);
			FlatIdent_494DF = 1;
		end
		if (FlatIdent_494DF == 2) then
			layout.Padding = UDim.new(0, 6);
			Pages[name] = page;
			return page;
		end
	end
end
local function AddTabButton(name, thaiName)
	local FlatIdent_31791 = 0;
	local btn;
	while true do
		if (FlatIdent_31791 == 2) then
			btn.Font = Enum.Font.GothamSemibold;
			btn.Text = name;
			FlatIdent_31791 = 3;
		end
		if (4 == FlatIdent_31791) then
			table.insert(MenuButtons, {Button=btn,Name=name});
			btn.MouseButton1Click:Connect(function()
				local FlatIdent_1784A = 0;
				while true do
					if (FlatIdent_1784A == 0) then
						for _, p in pairs(Pages) do
							p.Visible = false;
						end
						for _, mb in ipairs(MenuButtons) do
							local FlatIdent_2A862 = 0;
							while true do
								if (FlatIdent_2A862 == 0) then
									mb.Button.BackgroundColor3 = Color3.fromRGB(10, 12, 20);
									mb.Button.TextColor3 = Color3.fromRGB(160, 180, 210);
									break;
								end
							end
						end
						FlatIdent_1784A = 1;
					end
					if (FlatIdent_1784A == 1) then
						if Pages[name] then
							local FlatIdent_75B50 = 0;
							while true do
								if (FlatIdent_75B50 == 1) then
									btn.TextColor3 = Color3.fromRGB(255, 255, 255);
									break;
								end
								if (FlatIdent_75B50 == 0) then
									Pages[name].Visible = true;
									btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255);
									FlatIdent_75B50 = 1;
								end
							end
						end
						break;
					end
				end
			end);
			break;
		end
		if (1 == FlatIdent_31791) then
			btn.BorderSizePixel = 0;
			btn.Size = UDim2.new(0, 68, 1, 0);
			FlatIdent_31791 = 2;
		end
		if (FlatIdent_31791 == 3) then
			btn.TextColor3 = Color3.fromRGB(160, 180, 210);
			btn.TextSize = 8;
			FlatIdent_31791 = 4;
		end
		if (FlatIdent_31791 == 0) then
			btn = Instance.new("TextButton", TopBarHolder);
			btn.BackgroundColor3 = Color3.fromRGB(10, 12, 20);
			FlatIdent_31791 = 1;
		end
	end
end
local function CreateToggle(parent, title, thaiTitle, callback)
	local FlatIdent_2EAC6 = 0;
	local toggleBtn;
	local c;
	local statusLbl;
	local enabled;
	while true do
		if (1 == FlatIdent_2EAC6) then
			toggleBtn.BorderSizePixel = 1;
			toggleBtn.Size = UDim2.new(1, -6, 0, 30);
			toggleBtn.Font = Enum.Font.GothamSemibold;
			FlatIdent_2EAC6 = 2;
		end
		if (6 == FlatIdent_2EAC6) then
			statusLbl.TextColor3 = Color3.fromRGB(255, 90, 90);
			statusLbl.TextSize = 9;
			enabled = false;
			FlatIdent_2EAC6 = 7;
		end
		if (FlatIdent_2EAC6 == 5) then
			statusLbl.Size = UDim2.new(0, 45, 1, 0);
			statusLbl.Font = Enum.Font.GothamBold;
			statusLbl.Text = "[ OFF ]";
			FlatIdent_2EAC6 = 6;
		end
		if (FlatIdent_2EAC6 == 0) then
			toggleBtn = Instance.new("TextButton", parent);
			toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
			toggleBtn.BorderColor3 = Color3.fromRGB(45, 60, 90);
			FlatIdent_2EAC6 = 1;
		end
		if (FlatIdent_2EAC6 == 7) then
			toggleBtn.MouseButton1Click:Connect(function()
				local FlatIdent_20FB0 = 0;
				while true do
					if (0 == FlatIdent_20FB0) then
						enabled = not enabled;
						if enabled then
							local FlatIdent_89237 = 0;
							while true do
								if (FlatIdent_89237 == 0) then
									statusLbl.Text = "[ ON ]";
									statusLbl.TextColor3 = Color3.fromRGB(50, 255, 150);
									FlatIdent_89237 = 1;
								end
								if (FlatIdent_89237 == 1) then
									toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 40, 70);
									break;
								end
							end
						else
							local FlatIdent_5B2CE = 0;
							while true do
								if (FlatIdent_5B2CE == 1) then
									toggleBtn.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
									break;
								end
								if (FlatIdent_5B2CE == 0) then
									statusLbl.Text = "[ OFF ]";
									statusLbl.TextColor3 = Color3.fromRGB(255, 90, 90);
									FlatIdent_5B2CE = 1;
								end
							end
						end
						FlatIdent_20FB0 = 1;
					end
					if (FlatIdent_20FB0 == 1) then
						pcall(function()
							callback(enabled);
						end);
						break;
					end
				end
			end);
			return toggleBtn;
		end
		if (FlatIdent_2EAC6 == 4) then
			statusLbl = Instance.new("TextLabel", toggleBtn);
			statusLbl.BackgroundTransparency = 1;
			statusLbl.Position = UDim2.new(1, -55, 0, 0);
			FlatIdent_2EAC6 = 5;
		end
		if (2 == FlatIdent_2EAC6) then
			toggleBtn.Text = "  " .. title .. " / " .. thaiTitle;
			toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 230);
			toggleBtn.TextSize = 8;
			FlatIdent_2EAC6 = 3;
		end
		if (FlatIdent_2EAC6 == 3) then
			toggleBtn.TextXAlignment = Enum.TextXAlignment.Left;
			c = Instance.new("UICorner", toggleBtn);
			c.CornerRadius = UDim.new(0, 5);
			FlatIdent_2EAC6 = 4;
		end
	end
end
local function CreateSlider(parent, title, thaiTitle, min, max, default, callback)
	local FlatIdent_2388 = 0;
	local sliderFrame;
	local c;
	local titleLbl;
	local bar;
	local bc;
	local fill;
	local fc;
	local draggingSlider;
	while true do
		if (FlatIdent_2388 == 7) then
			fc = Instance.new("UICorner", fill);
			fc.CornerRadius = UDim.new(1, 0);
			draggingSlider = false;
			bar.InputBegan:Connect(function(input)
				if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
					draggingSlider = true;
				end
			end);
			FlatIdent_2388 = 8;
		end
		if (FlatIdent_2388 == 8) then
			UserInputService.InputEnded:Connect(function(input)
				if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
					draggingSlider = false;
				end
			end);
			UserInputService.InputChanged:Connect(function(input)
				if (draggingSlider and ((input.UserInputType == Enum.UserInputType.MouseMovement) or (input.UserInputType == Enum.UserInputType.Touch))) then
					local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1);
					fill.Size = UDim2.new(pos, 0, 1, 0);
					local val = math.floor(min + ((max - min) * pos));
					titleLbl.Text = title .. " / " .. thaiTitle .. " (" .. val .. ")";
					pcall(function()
						callback(val);
					end);
				end
			end);
			break;
		end
		if (FlatIdent_2388 == 1) then
			sliderFrame.Size = UDim2.new(1, -6, 0, 42);
			c = Instance.new("UICorner", sliderFrame);
			c.CornerRadius = UDim.new(0, 5);
			titleLbl = Instance.new("TextLabel", sliderFrame);
			FlatIdent_2388 = 2;
		end
		if (FlatIdent_2388 == 6) then
			fill = Instance.new("Frame", bar);
			fill.BackgroundColor3 = Color3.fromRGB(0, 162, 255);
			fill.BorderSizePixel = 0;
			fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0);
			FlatIdent_2388 = 7;
		end
		if (4 == FlatIdent_2388) then
			bar = Instance.new("TextButton", sliderFrame);
			bar.BackgroundColor3 = Color3.fromRGB(35, 45, 75);
			bar.BorderSizePixel = 0;
			bar.Position = UDim2.new(0, 8, 0, 25);
			FlatIdent_2388 = 5;
		end
		if (3 == FlatIdent_2388) then
			titleLbl.Text = title .. " / " .. thaiTitle .. " (" .. default .. ")";
			titleLbl.TextColor3 = Color3.fromRGB(230, 230, 230);
			titleLbl.TextSize = 8;
			titleLbl.TextXAlignment = Enum.TextXAlignment.Left;
			FlatIdent_2388 = 4;
		end
		if (FlatIdent_2388 == 2) then
			titleLbl.BackgroundTransparency = 1;
			titleLbl.Position = UDim2.new(0, 8, 0, 4);
			titleLbl.Size = UDim2.new(1, -16, 0, 18);
			titleLbl.Font = Enum.Font.GothamSemibold;
			FlatIdent_2388 = 3;
		end
		if (FlatIdent_2388 == 5) then
			bar.Size = UDim2.new(1, -16, 0, 6);
			bar.Text = "";
			bc = Instance.new("UICorner", bar);
			bc.CornerRadius = UDim.new(1, 0);
			FlatIdent_2388 = 6;
		end
		if (FlatIdent_2388 == 0) then
			sliderFrame = Instance.new("Frame", parent);
			sliderFrame.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
			sliderFrame.BorderColor3 = Color3.fromRGB(45, 60, 90);
			sliderFrame.BorderSizePixel = 1;
			FlatIdent_2388 = 1;
		end
	end
end
getgenv().UltimateStg = {SpeedEnabled=false,WalkSpeedValue=16,ESPGlow=false,ESPBoxTracer=false,AimbotHead=false,AimbotTorso=false,ShowFOV=false,FOVSize=100,FOVColorIndex=1,FPSBoost=false,FloatingStats=false};
local FOVColors = {Color3.fromRGB(0, 162, 255),Color3.fromRGB(255, 60, 60),Color3.fromRGB(50, 255, 120),Color3.fromRGB(255, 220, 0)};
local FOVColorNames = {"[ Blue / ฟ้า ]","[ Red / แดง ]","[ Green / เขียว ]","[ Yellow / เหลือง ]"};
local FloatFrame = Instance.new("Frame", ScreenGui);
FloatFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
FloatFrame.BorderSizePixel = 0;
FloatFrame.Position = UDim2.new(0.05, 0, 0.05, 0);
FloatFrame.Size = UDim2.new(0, 140, 0, 36);
FloatFrame.Visible = false;
FloatFrame.Active = true;
FloatFrame.Draggable = true;
AddRGBStroke(FloatFrame, 1);
local FloatCorner = Instance.new("UICorner", FloatFrame);
FloatCorner.CornerRadius = UDim.new(0, 6);
local FloatText = Instance.new("TextLabel", FloatFrame);
FloatText.BackgroundTransparency = 1;
FloatText.Size = UDim2.new(1, 0, 1, 0);
FloatText.Font = Enum.Font.GothamBold;
FloatText.Text = "FPS: 60 | Ping: 0ms";
FloatText.TextColor3 = Color3.fromRGB(0, 180, 255);
FloatText.TextSize = 9;
local HomePage = CreatePage("Home", 420);
HomePage.Visible = true;
AddTabButton("Home", "หน้าหลัก");
MenuButtons[1].Button.BackgroundColor3 = Color3.fromRGB(0, 120, 255);
MenuButtons[1].Button.TextColor3 = Color3.fromRGB(255, 255, 255);
local ExecuterCard = Instance.new("Frame", HomePage);
ExecuterCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
ExecuterCard.BorderColor3 = Color3.fromRGB(45, 60, 90);
ExecuterCard.BorderSizePixel = 1;
ExecuterCard.Size = UDim2.new(1, -6, 0, 175);
local EC_Corner = Instance.new("UICorner", ExecuterCard);
EC_Corner.CornerRadius = UDim.new(0, 6);
local EC_Title = Instance.new("TextLabel", ExecuterCard);
EC_Title.BackgroundTransparency = 1;
EC_Title.Position = UDim2.new(0, 10, 0, 6);
EC_Title.Size = UDim2.new(1, -20, 0, 16);
EC_Title.Font = Enum.Font.GothamBold;
EC_Title.Text = "📝 Script Loadstring Input & Guide:";
EC_Title.TextColor3 = Color3.fromRGB(0, 180, 255);
EC_Title.TextSize = 8;
EC_Title.TextXAlignment = Enum.TextXAlignment.Left;
local EC_Desc = Instance.new("TextLabel", ExecuterCard);
EC_Desc.BackgroundTransparency = 1;
EC_Desc.Position = UDim2.new(0, 10, 0, 22);
EC_Desc.Size = UDim2.new(1, -20, 0, 22);
EC_Desc.Font = Enum.Font.Gotham;
EC_Desc.Text = "วางลิงก์โค้ด loadstring ของสคริปต์ แล้วกดรันหรือเคลียร์ข้อความได้ทันที";
EC_Desc.TextColor3 = Color3.fromRGB(160, 180, 210);
EC_Desc.TextSize = 7;
EC_Desc.TextWrapped = true;
EC_Desc.TextXAlignment = Enum.TextXAlignment.Left;
local ScriptBox = Instance.new("TextBox", ExecuterCard);
ScriptBox.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
ScriptBox.BorderColor3 = Color3.fromRGB(45, 60, 90);
ScriptBox.BorderSizePixel = 1;
ScriptBox.Position = UDim2.new(0, 10, 0, 46);
ScriptBox.Size = UDim2.new(1, -20, 0, 65);
ScriptBox.Font = Enum.Font.Gotham;
ScriptBox.MultiLine = true;
ScriptBox.ClearTextOnFocus = false;
ScriptBox.PlaceholderText = 'loadstring(game:HttpGet("https://..."))()';
ScriptBox.Text = "";
ScriptBox.TextColor3 = Color3.fromRGB(255, 255, 255);
ScriptBox.PlaceholderColor3 = Color3.fromRGB(110, 130, 170);
ScriptBox.TextSize = 8;
ScriptBox.TextXAlignment = Enum.TextXAlignment.Left;
ScriptBox.TextYAlignment = Enum.TextYAlignment.Top;
local SB_Corner = Instance.new("UICorner", ScriptBox);
SB_Corner.CornerRadius = UDim.new(0, 4);
local RunScriptBtn = Instance.new("TextButton", ExecuterCard);
RunScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255);
RunScriptBtn.BorderSizePixel = 0;
RunScriptBtn.Position = UDim2.new(0, 10, 0, 118);
RunScriptBtn.Size = UDim2.new(0.68, -5, 0, 28);
RunScriptBtn.Font = Enum.Font.GothamBold;
RunScriptBtn.Text = "▶ EXECUTE / รันสคริปต์";
RunScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
RunScriptBtn.TextSize = 8;
local RS_Corner = Instance.new("UICorner", RunScriptBtn);
RS_Corner.CornerRadius = UDim.new(0, 4);
local ClearScriptBtn = Instance.new("TextButton", ExecuterCard);
ClearScriptBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60);
ClearScriptBtn.BorderSizePixel = 0;
ClearScriptBtn.Position = UDim2.new(0.68, 5, 0, 118);
ClearScriptBtn.Size = UDim2.new(0.32, -15, 0, 28);
ClearScriptBtn.Font = Enum.Font.GothamBold;
ClearScriptBtn.Text = "🗑️ CLEAR / ล้าง";
ClearScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
ClearScriptBtn.TextSize = 8;
local CS_Corner = Instance.new("UICorner", ClearScriptBtn);
CS_Corner.CornerRadius = UDim.new(0, 4);
ClearScriptBtn.MouseButton1Click:Connect(function()
	local FlatIdent_21DDC = 0;
	while true do
		if (FlatIdent_21DDC == 1) then
			task.wait(1);
			ClearScriptBtn.Text = "🗑️ CLEAR / ล้าง";
			break;
		end
		if (FlatIdent_21DDC == 0) then
			ScriptBox.Text = "";
			ClearScriptBtn.Text = "✅ CLEARED!";
			FlatIdent_21DDC = 1;
		end
	end
end);
RunScriptBtn.MouseButton1Click:Connect(function()
	local FlatIdent_67691 = 0;
	local code;
	while true do
		if (FlatIdent_67691 == 0) then
			code = ScriptBox.Text;
			if (code and (code ~= "")) then
				local FlatIdent_1CA5D = 0;
				local success;
				while true do
					if (FlatIdent_1CA5D == 0) then
						success = pcall(function()
							local FlatIdent_272FB = 0;
							local func;
							local compileErr;
							while true do
								if (FlatIdent_272FB == 0) then
									func, compileErr = loadstring(code);
									if not func then
										error(compileErr);
									end
									FlatIdent_272FB = 1;
								end
								if (1 == FlatIdent_272FB) then
									func();
									break;
								end
							end
						end);
						if success then
							local FlatIdent_628E3 = 0;
							while true do
								if (FlatIdent_628E3 == 0) then
									RunScriptBtn.Text = "✅ SUCCESS!";
									task.wait(1.5);
									FlatIdent_628E3 = 1;
								end
								if (FlatIdent_628E3 == 1) then
									RunScriptBtn.Text = "▶ EXECUTE / รันสคริปต์";
									break;
								end
							end
						else
							local FlatIdent_8A1DB = 0;
							while true do
								if (0 == FlatIdent_8A1DB) then
									RunScriptBtn.Text = "❌ ERROR!";
									task.wait(1.5);
									FlatIdent_8A1DB = 1;
								end
								if (FlatIdent_8A1DB == 1) then
									RunScriptBtn.Text = "▶ EXECUTE / รันสคริปต์";
									break;
								end
							end
						end
						break;
					end
				end
			end
			break;
		end
	end
end);
local DiscordCard = Instance.new("Frame", HomePage);
DiscordCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
DiscordCard.BorderColor3 = Color3.fromRGB(45, 60, 90);
DiscordCard.BorderSizePixel = 1;
DiscordCard.Size = UDim2.new(1, -6, 0, 65);
local DC_Corner = Instance.new("UICorner", DiscordCard);
DC_Corner.CornerRadius = UDim.new(0, 6);
local DC_Title = Instance.new("TextLabel", DiscordCard);
DC_Title.BackgroundTransparency = 1;
DC_Title.Position = UDim2.new(0, 10, 0, 6);
DC_Title.Size = UDim2.new(1, -20, 0, 16);
DC_Title.Font = Enum.Font.GothamBold;
DC_Title.Text = "💬 ช่องทางติดต่อพูดคุย (Discord)";
DC_Title.TextColor3 = Color3.fromRGB(0, 180, 255);
DC_Title.TextSize = 8;
DC_Title.TextXAlignment = Enum.TextXAlignment.Left;
local CopyDiscordBtn = Instance.new("TextButton", DiscordCard);
CopyDiscordBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255);
CopyDiscordBtn.BorderSizePixel = 0;
CopyDiscordBtn.Position = UDim2.new(0, 10, 0, 28);
CopyDiscordBtn.Size = UDim2.new(1, -20, 0, 26);
CopyDiscordBtn.Font = Enum.Font.GothamBold;
CopyDiscordBtn.Text = "📋 คัดลอกลิงก์ Discord: discord.gg/FuC9cme7ht";
CopyDiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
CopyDiscordBtn.TextSize = 8;
local CopyCorner = Instance.new("UICorner", CopyDiscordBtn);
CopyCorner.CornerRadius = UDim.new(0, 4);
CopyDiscordBtn.MouseButton1Click:Connect(function()
	local FlatIdent_634AF = 0;
	while true do
		if (0 == FlatIdent_634AF) then
			pcall(function()
				setclipboard("https://discord.gg/FuC9cme7ht");
			end);
			CopyDiscordBtn.Text = "✅ คัดลอกลิงก์ Discord สำเร็จ!";
			FlatIdent_634AF = 1;
		end
		if (FlatIdent_634AF == 1) then
			task.wait(1.5);
			CopyDiscordBtn.Text = "📋 คัดลอกลิงก์ Discord: discord.gg/FuC9cme7ht";
			break;
		end
	end
end);
AddTabButton("Player", "ผู้เล่น");
local PlayerPage = CreatePage("Player");
CreateToggle(PlayerPage, "Speed Hack (Safe)", "เปิดเดินเร็ว", function(state)
	local FlatIdent_21297 = 0;
	while true do
		if (FlatIdent_21297 == 0) then
			getgenv().UltimateStg.SpeedEnabled = state;
			if not state then
				pcall(function()
					if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
						LocalPlayer.Character.Humanoid.WalkSpeed = 16;
					end
				end);
			end
			break;
		end
	end
end);
CreateSlider(PlayerPage, "WalkSpeed Value", "ระดับความเร็ว", 16, 150, 16, function(val)
	getgenv().UltimateStg.WalkSpeedValue = val;
end);
AddTabButton("ESP", "การมองเห็น");
local EspPage = CreatePage("ESP");
CreateToggle(EspPage, "ESP Glow", "เรืองแสง (Glow)", function(state)
	local FlatIdent_91608 = 0;
	while true do
		if (FlatIdent_91608 == 0) then
			getgenv().UltimateStg.ESPGlow = state;
			if not state then
				for _, plr in pairs(Players:GetPlayers()) do
					if (plr.Character and plr.Character:FindFirstChild("UltimateGlow")) then
						plr.Character.UltimateGlow:Destroy();
					end
				end
			end
			break;
		end
	end
end);
CreateToggle(EspPage, "ESP Box + Tracer", "กรอบ + เส้นโยง", function(state)
	local FlatIdent_44265 = 0;
	while true do
		if (0 == FlatIdent_44265) then
			getgenv().UltimateStg.ESPBoxTracer = state;
			if not state then
				for _, espData in pairs(ESPContainer) do
					local FlatIdent_15A17 = 0;
					while true do
						if (FlatIdent_15A17 == 0) then
							if espData.Box then
								espData.Box.Visible = false;
							end
							if espData.Tracer then
								espData.Tracer.Visible = false;
							end
							break;
						end
					end
				end
			end
			break;
		end
	end
end);
AddTabButton("Aimbot", "ล็อคเป้า");
local AimbotPage = CreatePage("Aimbot", 420);
CreateToggle(AimbotPage, "Aimbot - Head Lock", "ล็อคหัว", function(state)
	local FlatIdent_912A7 = 0;
	while true do
		if (FlatIdent_912A7 == 0) then
			getgenv().UltimateStg.AimbotHead = state;
			if state then
				getgenv().UltimateStg.AimbotTorso = false;
			end
			break;
		end
	end
end);
CreateToggle(AimbotPage, "Aimbot - Torso Lock", "ล็อคตัว", function(state)
	local FlatIdent_69C4C = 0;
	while true do
		if (FlatIdent_69C4C == 0) then
			getgenv().UltimateStg.AimbotTorso = state;
			if state then
				getgenv().UltimateStg.AimbotHead = false;
			end
			break;
		end
	end
end);
CreateToggle(AimbotPage, "Show FOV", "แสดงวง FOV", function(state)
	local FlatIdent_8B272 = 0;
	while true do
		if (0 == FlatIdent_8B272) then
			getgenv().UltimateStg.ShowFOV = state;
			FOVCircle.Visible = state;
			break;
		end
	end
end);
CreateSlider(AimbotPage, "FOV Size", "ขนาด FOV", 30, 300, 100, function(val)
	getgenv().UltimateStg.FOVSize = val;
end);
AddTabButton("Settings", "ตั้งค่า");
local SettingsPage = CreatePage("Settings");
CreateToggle(SettingsPage, "Floating FPS/Ping", "สถิติลอย", function(state)
	local FlatIdent_3F7F4 = 0;
	while true do
		if (0 == FlatIdent_3F7F4) then
			getgenv().UltimateStg.FloatingStats = state;
			FloatFrame.Visible = state;
			break;
		end
	end
end);
CreateToggle(SettingsPage, "FPS & Ping Booster", "บูสความลื่น", function(state)
	local FlatIdent_734D3 = 0;
	while true do
		if (FlatIdent_734D3 == 0) then
			getgenv().UltimateStg.FPSBoost = state;
			if state then
				pcall(function()
					local FlatIdent_43626 = 0;
					while true do
						if (0 == FlatIdent_43626) then
							settings():GetService("NetworkSettings").IncomingReplicationLag = 0;
							Lighting.GlobalShadows = false;
							break;
						end
					end
				end);
			else
				pcall(function()
					local FlatIdent_4185D = 0;
					while true do
						if (FlatIdent_4185D == 0) then
							settings():GetService("NetworkSettings").IncomingReplicationLag = 0.1;
							Lighting.GlobalShadows = true;
							break;
						end
					end
				end);
			end
			break;
		end
	end
end);
AddTabButton("Security", "ความปลอดภัย");
local SecurityPage = CreatePage("Security");
local SecInfoCard = Instance.new("Frame", SecurityPage);
SecInfoCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
SecInfoCard.BorderColor3 = Color3.fromRGB(45, 60, 90);
SecInfoCard.BorderSizePixel = 1;
SecInfoCard.Size = UDim2.new(1, -6, 0, 130);
local secic = Instance.new("UICorner", SecInfoCard);
secic.CornerRadius = UDim.new(0, 6);
local SI_Title = Instance.new("TextLabel", SecInfoCard);
SI_Title.BackgroundTransparency = 1;
SI_Title.Position = UDim2.new(0, 10, 0, 8);
SI_Title.Size = UDim2.new(1, -20, 0, 16);
SI_Title.Font = Enum.Font.GothamBold;
SI_Title.Text = "🛡️ Shield Protection Active";
SI_Title.TextColor3 = Color3.fromRGB(0, 180, 255);
SI_Title.TextSize = 9;
SI_Title.TextXAlignment = Enum.TextXAlignment.Left;
local SI_Desc = Instance.new("TextLabel", SecInfoCard);
SI_Desc.BackgroundTransparency = 1;
SI_Desc.Position = UDim2.new(0, 10, 0, 28);
SI_Desc.Size = UDim2.new(1, -20, 0, 95);
SI_Desc.Font = Enum.Font.Gotham;
SI_Desc.Text = "• Anti-Ban & Telemetry: ป้องกันแบน\n• Anti-Report: บล็อกการรีพอร์ต\n• Anti-Kick: ป้องกันเตะ/ดึงตัว\n• Clean Cache: ล้างแรมอัตโนมัติ";
SI_Desc.TextColor3 = Color3.fromRGB(160, 180, 210);
SI_Desc.TextSize = 8;
SI_Desc.TextXAlignment = Enum.TextXAlignment.Left;
if (LocalPlayer.Name == DevUsername) then
	AddTabButton("DEV", "ระบบ DEV");
	local DevPage = CreatePage("DEV", 450);
	local DevCard = Instance.new("Frame", DevPage);
	DevCard.BackgroundColor3 = Color3.fromRGB(22, 26, 40);
	DevCard.BorderColor3 = Color3.fromRGB(45, 60, 90);
	DevCard.BorderSizePixel = 1;
	DevCard.Size = UDim2.new(1, -6, 0, 210);
	local dc_c = Instance.new("UICorner", DevCard);
	dc_c.CornerRadius = UDim.new(0, 6);
	local DC_Head = Instance.new("TextLabel", DevCard);
	DC_Head.BackgroundTransparency = 1;
	DC_Head.Position = UDim2.new(0, 10, 0, 8);
	DC_Head.Size = UDim2.new(1, -20, 0, 16);
	DC_Head.Font = Enum.Font.GothamBold;
	DC_Head.Text = "🛠️ DEV KEY GENERATOR PANEL";
	DC_Head.TextColor3 = Color3.fromRGB(255, 200, 0);
	DC_Head.TextSize = 9;
	DC_Head.TextXAlignment = Enum.TextXAlignment.Left;
	local KeyInput = Instance.new("TextBox", DevCard);
	KeyInput.BackgroundColor3 = Color3.fromRGB(15, 17, 26);
	KeyInput.BorderColor3 = Color3.fromRGB(45, 60, 90);
	KeyInput.BorderSizePixel = 1;
	KeyInput.Position = UDim2.new(0, 10, 0, 32);
	KeyInput.Size = UDim2.new(1, -20, 0, 30);
	KeyInput.Font = Enum.Font.Gotham;
	KeyInput.PlaceholderText = "พิมพ์ชื่อคีย์ที่ต้องการสร้าง (เช่น TERX-VIP-XYZ)";
	KeyInput.Text = "";
	KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255);
	KeyInput.PlaceholderColor3 = Color3.fromRGB(110, 130, 170);
	KeyInput.TextSize = 8;
	local ki_c = Instance.new("UICorner", KeyInput);
	ki_c.CornerRadius = UDim.new(0, 4);
	local selectedDays = 1;
	local DaysLabel = Instance.new("TextLabel", DevCard);
	DaysLabel.BackgroundTransparency = 1;
	DaysLabel.Position = UDim2.new(0, 10, 0, 68);
	DaysLabel.Size = UDim2.new(1, -20, 0, 16);
	DaysLabel.Font = Enum.Font.GothamBold;
	DaysLabel.Text = "⏱️ เลือกอายุของคีย์: [ 1 วัน ]";
	DaysLabel.TextColor3 = Color3.fromRGB(0, 180, 255);
	DaysLabel.TextSize = 8;
	DaysLabel.TextXAlignment = Enum.TextXAlignment.Left;
	local function CreateDayBtn(posX, text, daysVal)
		local FlatIdent_4E551 = 0;
		local btn;
		local bc;
		while true do
			if (FlatIdent_4E551 == 0) then
				btn = Instance.new("TextButton", DevCard);
				btn.BackgroundColor3 = Color3.fromRGB(30, 40, 65);
				btn.BorderSizePixel = 0;
				btn.Position = UDim2.new(posX, 0, 0, 90);
				FlatIdent_4E551 = 1;
			end
			if (FlatIdent_4E551 == 1) then
				btn.Size = UDim2.new(0.15, -4, 0, 24);
				btn.Font = Enum.Font.GothamBold;
				btn.Text = text;
				btn.TextColor3 = Color3.fromRGB(255, 255, 255);
				FlatIdent_4E551 = 2;
			end
			if (FlatIdent_4E551 == 2) then
				btn.TextSize = 8;
				bc = Instance.new("UICorner", btn);
				bc.CornerRadius = UDim.new(0, 4);
				btn.MouseButton1Click:Connect(function()
					selectedDays = daysVal;
					DaysLabel.Text = "⏱️ เลือกอายุของคีย์: [ " .. text .. " ]";
				end);
				break;
			end
		end
	end
	CreateDayBtn(0, "1 วัน", 1);
	CreateDayBtn(0.16, "3 วัน", 3);
	CreateDayBtn(0.32, "7 วัน", 7);
	CreateDayBtn(0.48, "15 วัน", 15);
	CreateDayBtn(0.64, "30 วัน", 30);
	CreateDayBtn(0.8, "ถาวร", 0);
	local GenBtn = Instance.new("TextButton", DevCard);
	GenBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100);
	GenBtn.BorderSizePixel = 0;
	GenBtn.Position = UDim2.new(0, 10, 0, 124);
	GenBtn.Size = UDim2.new(1, -20, 0, 32);
	GenBtn.Font = Enum.Font.GothamBold;
	GenBtn.Text = "➕ สร้างคีย์ & คัดลอก (Generate Key)";
	GenBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
	GenBtn.TextSize = 9;
	local gb_c = Instance.new("UICorner", GenBtn);
	gb_c.CornerRadius = UDim.new(0, 4);
	GenBtn.MouseButton1Click:Connect(function()
		local FlatIdent_580B8 = 0;
		local newKey;
		local expiryTime;
		while true do
			if (3 == FlatIdent_580B8) then
				GenBtn.Text = "✅ สร้างและคัดลอกคีย์สำเร็จ: " .. newKey;
				task.wait(2);
				FlatIdent_580B8 = 4;
			end
			if (2 == FlatIdent_580B8) then
				KeyDatabase[newKey] = {Used=false,ExpiresAt=expiryTime};
				pcall(function()
					setclipboard(newKey);
				end);
				FlatIdent_580B8 = 3;
			end
			if (FlatIdent_580B8 == 1) then
				expiryTime = 0;
				if (selectedDays > 0) then
					expiryTime = os.time() + (selectedDays * 24 * 60 * 60);
				end
				FlatIdent_580B8 = 2;
			end
			if (FlatIdent_580B8 == 0) then
				newKey = KeyInput.Text;
				if (newKey == "") then
					newKey = "TERX-" .. math.random(100000, 999999);
				end
				FlatIdent_580B8 = 1;
			end
			if (FlatIdent_580B8 == 4) then
				GenBtn.Text = "➕ สร้างคีย์ & คัดลอก (Generate Key)";
				break;
			end
		end
	end);
end
RenderConnection = RunService.RenderStepped:Connect(function(dt)
	local tickVal = tick() * 0.4;
	local rgbColor = Color3.fromHSV(tickVal % 1, 1, 1);
	for _, stroke in pairs(MinimalRGBStrokes) do
		if (stroke and stroke.Parent) then
			stroke.Color = rgbColor;
		end
	end
	local currentFPS = math.floor(1 / math.max(dt, 0.001));
	local pingVal = 0;
	pcall(function()
		pingVal = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue());
	end);
	if getgenv().UltimateStg.FloatingStats then
		FloatText.Text = "FPS: " .. currentFPS .. " | Ping: " .. pingVal .. "ms";
	end
	pcall(function()
		local FlatIdent_6C967 = 0;
		local char;
		while true do
			if (FlatIdent_6C967 == 0) then
				char = LocalPlayer.Character;
				if (char and char:FindFirstChild("Humanoid") and getgenv().UltimateStg.SpeedEnabled) then
					char.Humanoid.WalkSpeed = getgenv().UltimateStg.WalkSpeedValue;
				end
				break;
			end
		end
	end);
	pcall(function()
		for _, plr in pairs(Players:GetPlayers()) do
			if (plr ~= LocalPlayer) then
				local FlatIdent_23B4 = 0;
				local char;
				while true do
					if (FlatIdent_23B4 == 0) then
						char = plr.Character;
						if (getgenv().UltimateStg.ESPGlow and char and char:FindFirstChild("Humanoid") and (char.Humanoid.Health > 0)) then
							if not char:FindFirstChild("UltimateGlow") then
								local FlatIdent_2FBBD = 0;
								local glow;
								while true do
									if (FlatIdent_2FBBD == 1) then
										glow.Adornee = char;
										glow.FillColor = Color3.fromRGB(0, 120, 255);
										FlatIdent_2FBBD = 2;
									end
									if (0 == FlatIdent_2FBBD) then
										glow = Instance.new("Highlight");
										glow.Name = "UltimateGlow";
										FlatIdent_2FBBD = 1;
									end
									if (FlatIdent_2FBBD == 3) then
										glow.Parent = char;
										break;
									end
									if (FlatIdent_2FBBD == 2) then
										glow.OutlineColor = Color3.fromRGB(150, 100, 255);
										glow.FillTransparency = 0.3;
										FlatIdent_2FBBD = 3;
									end
								end
							end
						elseif (char and char:FindFirstChild("UltimateGlow")) then
							char.UltimateGlow:Destroy();
						end
						break;
					end
				end
			end
		end
	end);
	for _, plr in pairs(Players:GetPlayers()) do
		if (plr ~= LocalPlayer) then
			if getgenv().UltimateStg.ESPBoxTracer then
				local FlatIdent_5AA23 = 0;
				local char;
				while true do
					if (FlatIdent_5AA23 == 0) then
						if not ESPContainer[plr] then
							local FlatIdent_3F15E = 0;
							local box;
							local tracer;
							while true do
								if (FlatIdent_3F15E == 2) then
									box.Filled = false;
									tracer = Drawing.new("Line");
									FlatIdent_3F15E = 3;
								end
								if (FlatIdent_3F15E == 1) then
									box.Color = Color3.fromRGB(0, 162, 255);
									box.Thickness = 1.5;
									FlatIdent_3F15E = 2;
								end
								if (FlatIdent_3F15E == 0) then
									box = Drawing.new("Square");
									box.Visible = false;
									FlatIdent_3F15E = 1;
								end
								if (FlatIdent_3F15E == 4) then
									tracer.Thickness = 1;
									ESPContainer[plr] = {Box=box,Tracer=tracer};
									break;
								end
								if (3 == FlatIdent_3F15E) then
									tracer.Visible = false;
									tracer.Color = Color3.fromRGB(150, 100, 255);
									FlatIdent_3F15E = 4;
								end
							end
						end
						char = plr.Character;
						FlatIdent_5AA23 = 1;
					end
					if (FlatIdent_5AA23 == 1) then
						if (char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and (char.Humanoid.Health > 0)) then
							local hrp = char.HumanoidRootPart;
							local head = char:FindFirstChild("Head");
							if head then
								local FlatIdent_1BB5D = 0;
								local topPosition;
								local bottomPosition;
								local topPos;
								local topOnScreen;
								local bottomPos;
								local bottomOnScreen;
								while true do
									if (FlatIdent_1BB5D == 2) then
										if (topOnScreen or bottomOnScreen) then
											local FlatIdent_9448C = 0;
											local box;
											local tracer;
											local height;
											local width;
											while true do
												if (FlatIdent_9448C == 4) then
													tracer.To = Vector2.new(bottomPos.X, bottomPos.Y);
													tracer.Visible = true;
													break;
												end
												if (3 == FlatIdent_9448C) then
													box.Visible = true;
													tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y);
													FlatIdent_9448C = 4;
												end
												if (FlatIdent_9448C == 2) then
													box.Size = Vector2.new(width, height);
													box.Position = Vector2.new(topPos.X - (width / 2), topPos.Y);
													FlatIdent_9448C = 3;
												end
												if (FlatIdent_9448C == 1) then
													height = math.abs(bottomPos.Y - topPos.Y);
													width = height / 2;
													FlatIdent_9448C = 2;
												end
												if (FlatIdent_9448C == 0) then
													box = ESPContainer[plr].Box;
													tracer = ESPContainer[plr].Tracer;
													FlatIdent_9448C = 1;
												end
											end
										else
											local FlatIdent_53D9 = 0;
											while true do
												if (FlatIdent_53D9 == 0) then
													ESPContainer[plr].Box.Visible = false;
													ESPContainer[plr].Tracer.Visible = false;
													break;
												end
											end
										end
										break;
									end
									if (FlatIdent_1BB5D == 1) then
										topPos, topOnScreen = Camera:WorldToViewportPoint(topPosition);
										bottomPos, bottomOnScreen = Camera:WorldToViewportPoint(bottomPosition);
										FlatIdent_1BB5D = 2;
									end
									if (FlatIdent_1BB5D == 0) then
										topPosition = head.Position + Vector3.new(0, 0.7, 0);
										bottomPosition = hrp.Position - Vector3.new(0, 2.8, 0);
										FlatIdent_1BB5D = 1;
									end
								end
							end
						elseif ESPContainer[plr] then
							local FlatIdent_506A5 = 0;
							while true do
								if (FlatIdent_506A5 == 0) then
									ESPContainer[plr].Box.Visible = false;
									ESPContainer[plr].Tracer.Visible = false;
									break;
								end
							end
						end
						break;
					end
				end
			elseif ESPContainer[plr] then
				local FlatIdent_14124 = 0;
				while true do
					if (FlatIdent_14124 == 1) then
						ESPContainer[plr] = nil;
						break;
					end
					if (0 == FlatIdent_14124) then
						if ESPContainer[plr].Box then
							ESPContainer[plr].Box:Remove();
						end
						if ESPContainer[plr].Tracer then
							ESPContainer[plr].Tracer:Remove();
						end
						FlatIdent_14124 = 1;
					end
				end
			end
		end
	end
	pcall(function()
		if getgenv().UltimateStg.ShowFOV then
			local FlatIdent_8E29D = 0;
			while true do
				if (1 == FlatIdent_8E29D) then
					FOVCircle.Visible = true;
					break;
				end
				if (FlatIdent_8E29D == 0) then
					FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2);
					FOVCircle.Radius = getgenv().UltimateStg.FOVSize;
					FlatIdent_8E29D = 1;
				end
			end
		else
			FOVCircle.Visible = false;
		end
	end);
	pcall(function()
		if (getgenv().UltimateStg.AimbotHead or getgenv().UltimateStg.AimbotTorso) then
			local closestTarget = nil;
			local shortestDist = getgenv().UltimateStg.FOVSize;
			local origin = Camera.CFrame.Position;
			for _, plr in pairs(Players:GetPlayers()) do
				if ((plr ~= LocalPlayer) and plr.Character and plr.Character:FindFirstChild("Humanoid") and (plr.Character.Humanoid.Health > 0)) then
					local FlatIdent_84478 = 0;
					local targetPart;
					while true do
						if (FlatIdent_84478 == 0) then
							targetPart = nil;
							if getgenv().UltimateStg.AimbotHead then
								targetPart = plr.Character:FindFirstChild("Head");
							elseif getgenv().UltimateStg.AimbotTorso then
								targetPart = plr.Character:FindFirstChild("UpperTorso") or plr.Character:FindFirstChild("Torso");
							end
							FlatIdent_84478 = 1;
						end
						if (FlatIdent_84478 == 1) then
							if targetPart then
								local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position);
								if onScreen then
									local FlatIdent_15F29 = 0;
									local mouseDist;
									while true do
										if (FlatIdent_15F29 == 0) then
											mouseDist = (Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude;
											if (mouseDist < shortestDist) then
												local FlatIdent_2CC55 = 0;
												local direction;
												local raycastParams;
												local raycastResult;
												while true do
													if (FlatIdent_2CC55 == 1) then
														raycastParams.FilterType = Enum.RaycastFilterType.Exclude;
														raycastParams.FilterDescendantsInstances = {LocalPlayer.Character,plr.Character};
														FlatIdent_2CC55 = 2;
													end
													if (FlatIdent_2CC55 == 2) then
														raycastResult = Workspace:Raycast(origin, direction, raycastParams);
														if not raycastResult then
															local FlatIdent_2C980 = 0;
															while true do
																if (FlatIdent_2C980 == 0) then
																	shortestDist = mouseDist;
																	closestTarget = targetPart;
																	break;
																end
															end
														end
														break;
													end
													if (FlatIdent_2CC55 == 0) then
														direction = targetPart.Position - origin;
														raycastParams = RaycastParams.new();
														FlatIdent_2CC55 = 1;
													end
												end
											end
											break;
										end
									end
								end
							end
							break;
						end
					end
				end
			end
			if closestTarget then
				Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestTarget.Position);
			end
		end
	end);
end);
