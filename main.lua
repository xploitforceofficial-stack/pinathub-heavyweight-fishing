-- =======================================================
-- PINATHUB - FISHING SIMULATOR SCRIPT
-- =======================================================

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- Variables
local player = Players.LocalPlayer
local UIS = UserInputService
local lp = player
local RS = ReplicatedStorage

-- Wait for MainGui
local MainGui = lp:WaitForChild("PlayerGui"):WaitForChild("MainGui")

-- Environment Variables
getgenv().NWKZ_Anchor = false
getgenv().NWKZ_AutoCast = false
getgenv().WalkOnWater = false
getgenv().InfJump = false
getgenv().Noclip = false
getgenv().RGBBody = false
getgenv().WaterParts = {}
getgenv().AllCharacterParts = {}

-- Anti Afk
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- =======================================================
-- CUSTOM NOTIFICATION SYSTEM (ELEGAN, PREMIUM, MINI)
-- =======================================================
local NotificationService = {}

-- Create notification holder
local notifHolder = Instance.new("ScreenGui")
notifHolder.Name = "PinatHubNotifications"
notifHolder.ResetOnSpawn = false
notifHolder.Parent = player:WaitForChild("PlayerGui")

local notifFrame = Instance.new("Frame")
notifFrame.Name = "NotificationHolder"
notifFrame.Size = UDim2.new(0, 350, 1, -20)
notifFrame.Position = UDim2.new(1, -370, 0, 10)
notifFrame.BackgroundTransparency = 1
notifFrame.Parent = notifHolder

local notifList = Instance.new("UIListLayout")
notifList.Name = "NotifList"
notifList.Padding = UDim.new(0, 8)
notifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
notifList.VerticalAlignment = Enum.VerticalAlignment.Top
notifList.SortOrder = Enum.SortOrder.LayoutOrder
notifList.Parent = notifFrame

-- Function to create a notification
local function ShowNotification(title, message, duration)
    duration = duration or 3
    
    -- Create notification frame
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 330, 0, 70)
    notif.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    notif.BackgroundTransparency = 1
    notif.BorderSizePixel = 0
    notif.ClipsDescendants = true
    notif.Parent = notifFrame
    
    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notif
    
    -- Stroke (border tipis)
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 90)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = notif
    
    -- Shadow
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 10, 10)
    shadow.Parent = notif
    
    -- Accent line (warna ungu)
    local accent = Instance.new("Frame")
    accent.Name = "Accent"
    accent.Size = UDim2.new(0, 4, 1, 0)
    accent.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    accent.BorderSizePixel = 0
    accent.Parent = notif
    
    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 4)
    accentCorner.Parent = accent
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.Position = UDim2.new(0, 14, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = notif
    
    -- Message
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -20, 0, 18)
    messageLabel.Position = UDim2.new(0, 14, 0, 32)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 14
    messageLabel.Parent = notif
    
    -- Progress bar
    local progressBg = Instance.new("Frame")
    progressBg.Name = "ProgressBg"
    progressBg.Size = UDim2.new(1, -20, 0, 3)
    progressBg.Position = UDim2.new(0, 10, 1, -8)
    progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    progressBg.BorderSizePixel = 0
    progressBg.Parent = notif
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progressBg
    
    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Size = UDim2.new(1, 0, 1, 0)
    progress.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    progress.BorderSizePixel = 0
    progress.Parent = progressBg
    
    local progressCorner2 = Instance.new("UICorner")
    progressCorner2.CornerRadius = UDim.new(1, 0)
    progressCorner2.Parent = progress
    
    -- Animation
    notif.Position = UDim2.new(1, 50, 0, 0)
    
    -- Tween animations
    local fadeIn = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -340, 0, 0),
        BackgroundTransparency = 0
    })
    
    local fadeOut = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 50, 0, 0),
        BackgroundTransparency = 1
    })
    
    -- Progress bar animation
    local progressTween = TweenService:Create(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 1, 0)
    })
    
    fadeIn:Play()
    progressTween:Play()
    
    -- Auto destroy
    task.delay(duration, function()
        if notif and notif.Parent then
            fadeOut:Play()
            task.wait(0.3)
            notif:Destroy()
        end
    end)
    
    return notif
end

-- =======================================================
-- LOGO LAUNCHER
-- =======================================================
local logoGui = Instance.new("ScreenGui")
logoGui.Name = "PinatHubLogo"
logoGui.ResetOnSpawn = false
logoGui.Parent = player:WaitForChild("PlayerGui", 5)

local logoButton = Instance.new("ImageButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 60, 0, 60)
logoButton.Position = UDim2.new(0.5, -30, 0.5, -30)
logoButton.BackgroundTransparency = 1
logoButton.Image = "rbxassetid://108939127221214"
logoButton.ImageColor3 = Color3.fromRGB(180, 0, 255)
logoButton.ScaleType = Enum.ScaleType.Fit
logoButton.Parent = logoGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = logoButton

-- Animasi kecil
local hoverTween = TweenService:Create(logoButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 70)})
local unhoverTween = TweenService:Create(logoButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)})

logoButton.MouseEnter:Connect(function()
    hoverTween:Play()
end)

logoButton.MouseLeave:Connect(function()
    unhoverTween:Play()
end)

-- Fitur drag
local dragging = false
local dragInput, dragStart, startPos

logoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = logoButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

logoButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        logoButton.Position = newPos
    end
end)

-- Load WindUI Library
local WindUI = (function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua", true))()
    end)
    return success and result or nil
end)()

if not WindUI then 
    ShowNotification("Error", "Failed to load WindUI Library", 5)
    return 
end

-- =======================================================
-- CREATE CUSTOM WINDOW
-- =======================================================
local Window = WindUI:CreateWindow({
    Title = "PinatHub",
    Author = "ZeOrbit",
    Folder = "PinatHub",
    NewElements = true,
    OpenButton = {
        Enabled = false
    },
    Topbar = { Height = 44, ButtonsType = "Default" }
})

Window:Tag({ Title = "v1.0", Icon = "star", Color = Color3.fromHex("#BA00FF"), Border = true })

-- Fungsi untuk buka/tutup via logo
local guiVisible = true
logoButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    if Window then
        if guiVisible then
            Window:Open()
        else
            Window:Minimize()
        end
    end
end)

-- =======================================================
-- CREATE PING DISPLAY
-- =======================================================
local pingGui = Instance.new("ScreenGui")
pingGui.Name = "PingDisplay"
pingGui.ResetOnSpawn = false
pingGui.Parent = player:WaitForChild("PlayerGui")

local pingFrame = Instance.new("Frame")
pingFrame.Name = "PingFrame"
pingFrame.Size = UDim2.new(0, 120, 0, 40)
pingFrame.Position = UDim2.new(0, 10, 0, 50)
pingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
pingFrame.BackgroundTransparency = 0.3
pingFrame.BorderSizePixel = 0
pingFrame.Parent = pingGui
pingFrame.Active = true
pingFrame.Draggable = true

local pingCorner = Instance.new("UICorner")
pingCorner.CornerRadius = UDim.new(0, 8)
pingCorner.Parent = pingFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "PingLabel"
pingLabel.Size = UDim2.new(1, 0, 1, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "PING: 0ms"
pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
pingLabel.TextScaled = true
pingLabel.Font = Enum.Font.GothamBold
pingLabel.Parent = pingFrame

-- Update Ping
spawn(function()
    while task.wait(1) do
        pcall(function()
            local pingValue = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
            local ping = tonumber(pingValue:match("%d+")) or 0
            pingLabel.Text = "PING: " .. ping .. "ms"
            
            if ping < 100 then
                pingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            elseif ping < 200 then
                pingLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            else
                pingLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end)
    end
end)

-- =======================================================
-- CREATE TABS
-- =======================================================
local MainTab = Window:Tab({ Title = "Main", Icon = "settings", IconColor = Color3.fromHex("#00FFFF"), Border = true })
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "map-pin", IconColor = Color3.fromHex("#FF305D"), Border = true })
local PlayerTab = Window:Tab({ Title = "Local Players", Icon = "users", IconColor = Color3.fromHex("#30FF6A"), Border = true })
local CommunityTab = Window:Tab({ Title = "Community", Icon = "message-circle", IconColor = Color3.fromHex("#9B59B6"), Border = true })

-- =======================================================
-- AUTO FISHING LOGIC
-- =======================================================
task.spawn(function()
    while task.wait(1) do
        if getgenv().NWKZ_AutoCast then
            pcall(function()
                local char = lp.Character
                if char and not char:GetAttribute("Fishing") and not MainGui.Fishing.Visible then
                    RS.Events.Fishing:FireServer()
                end
            end)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if getgenv().NWKZ_Anchor then
        pcall(function()
            local fishingUI = MainGui.Fishing
            if fishingUI.Visible then
                local bar = fishingUI.BarFrame.Bar
                bar.Position = UDim2.new(0.5, 0, bar.Position.Y.Scale, 0)
                RS.Fishing:FireServer("1")
            end
        end)
    end
end)

-- =======================================================
-- MAIN TAB
-- =======================================================
local FishingSection = MainTab:Section({ Title = "Auto Fishing" })

FishingSection:Toggle({
    Title = "Auto Cast",
    Desc = "Automatically cast fishing rod",
    Value = false,
    Callback = function(value)
        getgenv().NWKZ_AutoCast = value
        ShowNotification("Auto Fishing", value and "Auto Cast enabled" or "Auto Cast disabled", 2)
    end
})

FishingSection:Space()

FishingSection:Toggle({
    Title = "Auto Anchor",
    Desc = "Automatically anchor when fishing",
    Value = false,
    Callback = function(value)
        getgenv().NWKZ_Anchor = value
        ShowNotification("Auto Fishing", value and "Auto Anchor enabled" or "Auto Anchor disabled", 2)
    end
})

MainTab:Space()

local InventorySection = MainTab:Section({ Title = "Inventory" })

InventorySection:Button({
    Title = "Sell All Fish",
    Desc = "Sell all fish in inventory",
    Callback = function()
        RS.Events.SellFish:FireServer("All")
        ShowNotification("Success", "Successfully sold all fish!", 3)
    end
})

-- =======================================================
-- TELEPORT TAB - ISLANDS
-- =======================================================
local IslandsSection = TeleportTab:Section({ Title = "Islands Teleport" })

-- Teleport function
local function TeleportToLocation(locationName, findFunction)
    pcall(function()
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            ShowNotification("Error", "Character not found!", 2)
            return
        end
        
        local root = character.HumanoidRootPart
        local mapFolder = Workspace:FindFirstChild("Map")
        
        if not mapFolder then
            ShowNotification("Error", "Map folder not found!", 2)
            return
        end
        
        local targetPart = findFunction(mapFolder)
        
        if targetPart then
            root.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0)
            ShowNotification("Teleported", "Teleported to " .. locationName, 2)
        else
            ShowNotification("Error", locationName .. " not found!", 2)
        end
    end)
end

-- Function to get random part from folder
local function getRandomPartFromFolder(folder)
    if not folder then return nil end
    
    local parts = {}
    for _, child in ipairs(folder:GetDescendants()) do
        if child:IsA("BasePart") then
            table.insert(parts, child)
        end
    end
    
    if #parts > 0 then
        return parts[math.random(1, #parts)]
    end
    return nil
end

-- Map 1 - Beginning Isle (Leaf VFX)
IslandsSection:Button({
    Title = "Beginning Isle",
    Desc = "Teleport to Beginning Isle",
    Callback = function()
        TeleportToLocation("Beginning Isle", function(mapFolder)
            local map1 = mapFolder:FindFirstChild("Map 1")
            if map1 then
                for _, child in ipairs(map1:GetDescendants()) do
                    if child:IsA("BasePart") and child.Name == "Leaf VFX" then
                        return child
                    end
                end
            end
            return nil
        end)
    end
})

-- Map 2 - Bamboo Isle (Leaf VFX)
IslandsSection:Button({
    Title = "Bamboo Isle",
    Desc = "Teleport to Bamboo Isle",
    Callback = function()
        TeleportToLocation("Bamboo Isle", function(mapFolder)
            local map2 = mapFolder:FindFirstChild("Map 2")
            if map2 then
                for _, child in ipairs(map2:GetDescendants()) do
                    if child:IsA("BasePart") and (child.Name == "Leaf VFX" or child.Name == "VFX" or child.Name:find("VFX")) then
                        return child
                    end
                end
                return getRandomPartFromFolder(map2)
            end
            return nil
        end)
    end
})

-- Map 3 - Fallout Isle (Leaf VFX)
IslandsSection:Button({
    Title = "Fallout Isle",
    Desc = "Teleport to Fallout Isle",
    Callback = function()
        TeleportToLocation("Fallout Isle", function(mapFolder)
            local map3 = mapFolder:FindFirstChild("Map 3")
            if map3 then
                for _, child in ipairs(map3:GetDescendants()) do
                    if child:IsA("BasePart") and child.Name == "Leaf VFX" then
                        return child
                    end
                end
            end
            return nil
        end)
    end
})

-- Map 4 - Sovereign Isle (Leaf VFX)
IslandsSection:Button({
    Title = "Sovereign Isle",
    Desc = "Teleport to Sovereign Isle",
    Callback = function()
        TeleportToLocation("Sovereign Isle", function(mapFolder)
            local map4 = mapFolder:FindFirstChild("Map 4")
            if map4 then
                for _, child in ipairs(map4:GetDescendants()) do
                    if child:IsA("BasePart") and child.Name == "Leaf VFX" then
                        return child
                    end
                end
            end
            return nil
        end)
    end
})

-- Map 5 - Perch Isle (waterbucket)
IslandsSection:Button({
    Title = "Perch Isle",
    Desc = "Teleport to Perch Isle",
    Callback = function()
        TeleportToLocation("Perch Isle", function(mapFolder)
            local map5 = mapFolder:FindFirstChild("Map 5")
            if map5 then
                for _, child in ipairs(map5:GetDescendants()) do
                    if child:IsA("BasePart") and child.Name == "waterbucket" then
                        return child
                    end
                end
            end
            return nil
        end)
    end
})

-- Map 6 - Frost Isle (random part)
IslandsSection:Button({
    Title = "Frost Isle",
    Desc = "Teleport to Frost Isle (Random)",
    Callback = function()
        TeleportToLocation("Frost Isle", function(mapFolder)
            local map6 = mapFolder:FindFirstChild("Map 6")
            if map6 then
                return getRandomPartFromFolder(map6)
            end
            return nil
        end)
    end
})

-- Map 7 - Coconut Isle (random part)
IslandsSection:Button({
    Title = "Coconut Isle",
    Desc = "Teleport to Coconut Isle (Random)",
    Callback = function()
        TeleportToLocation("Coconut Isle", function(mapFolder)
            local map7 = mapFolder:FindFirstChild("Map 7")
            if map7 then
                return getRandomPartFromFolder(map7)
            end
            return nil
        end)
    end
})

-- Map 8 - Amber Isle (random part)
IslandsSection:Button({
    Title = "Amber Isle",
    Desc = "Teleport to Amber Isle (Random)",
    Callback = function()
        TeleportToLocation("Amber Isle", function(mapFolder)
            local map8 = mapFolder:FindFirstChild("Map 8")
            if map8 then
                return getRandomPartFromFolder(map8)
            end
            return nil
        end)
    end
})

TeleportTab:Space()

-- =======================================================
-- TELEPORT TAB - SECRET RODS
-- =======================================================
local SecretRodsSection = TeleportTab:Section({ Title = "Secret Rod Locations" })

-- Function to teleport to secret rod
local function TeleportToSecretRod(rodName)
    pcall(function()
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            ShowNotification("Error", "Character not found!", 2)
            return
        end
        
        local root = character.HumanoidRootPart
        local secretRodFolder = Workspace:FindFirstChild("SecretRod")
        
        if not secretRodFolder then
            ShowNotification("Error", "SecretRod folder not found!", 2)
            return
        end
        
        local rodModel = secretRodFolder:FindFirstChild(rodName)
        
        if rodModel and rodModel:IsA("Model") then
            local primaryPart = rodModel.PrimaryPart or rodModel:FindFirstChildWhichIsA("BasePart")
            if primaryPart then
                root.CFrame = primaryPart.CFrame + Vector3.new(0, 5, 0)
                ShowNotification("Teleported", "Teleported to " .. rodName, 2)
            else
                ShowNotification("Error", "No part found in rod model!", 2)
            end
        else
            ShowNotification("Error", rodName .. " not found!", 2)
        end
    end)
end

-- Secret Rod buttons
local rods = {
    "Anchorbound Rod",
    "Ascendant Bamboo Rod",
    "Blazeshark Rod",
    "Demonic Rod",
    "Kraken Rod",
    "Lifebloom Rod"
}

for _, rodName in ipairs(rods) do
    SecretRodsSection:Button({
        Title = rodName,
        Desc = "Teleport to " .. rodName,
        Callback = function()
            TeleportToSecretRod(rodName)
        end
    })
end

-- =======================================================
-- PLAYER TAB
-- =======================================================
local PlayerOptionsSection = PlayerTab:Section({ Title = "Player Options" })

-- Walk on Water
PlayerOptionsSection:Toggle({
    Title = "Walk On Water",
    Desc = "Walk on water surfaces",
    Value = false,
    Callback = function(value)
        getgenv().WalkOnWater = value
        ShowNotification("Walk On Water", value and "Enabled" or "Disabled", 2)
        
        if value then
            local ocean = Workspace:FindFirstChild("Ocean")
            if ocean then
                for _, child in ipairs(ocean:GetChildren()) do
                    if child:IsA("Part") and child.Name == "Water" then
                        table.insert(getgenv().WaterParts, child)
                    end
                end
            end
        end
    end
})

-- Walk on water logic
RunService.RenderStepped:Connect(function()
    if getgenv().WalkOnWater then
        pcall(function()
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            
            local root = character.HumanoidRootPart
            
            for _, waterPart in ipairs(getgenv().WaterParts) do
                if waterPart and waterPart.Parent then
                    local dist = (root.Position - waterPart.Position).Magnitude
                    if dist < 50 and root.Position.Y < waterPart.Position.Y + 5 then
                        root.Velocity = Vector3.new(root.Velocity.X, math.max(root.Velocity.Y, 0), root.Velocity.Z)
                        break
                    end
                end
            end
        end)
    end
end)

PlayerOptionsSection:Space()

-- Infinite Jump
PlayerOptionsSection:Toggle({
    Title = "Infinite Jump",
    Desc = "Jump infinitely",
    Value = false,
    Callback = function(value)
        getgenv().InfJump = value
        ShowNotification("Infinite Jump", value and "Enabled" or "Disabled", 2)
    end
})

UserInputService.JumpRequest:Connect(function()
    if getgenv().InfJump then
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid:ChangeState("Jumping")
        end
    end
end)

PlayerOptionsSection:Space()

-- Noclip
PlayerOptionsSection:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls",
    Value = false,
    Callback = function(value)
        getgenv().Noclip = value
        ShowNotification("Noclip", value and "Enabled" or "Disabled", 2)
    end
})

RunService.Stepped:Connect(function()
    if getgenv().Noclip then
        pcall(function()
            local character = player.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

PlayerOptionsSection:Space()

-- RGB Body (SUPER SMOOTH & CEPAT - RGB MEWAH)
PlayerOptionsSection:Toggle({
    Title = "RGB Body",
    Desc = "Rainbow RGB in your ava",
    Value = false,
    Callback = function(value)
        getgenv().RGBBody = value
        ShowNotification("RGB Body", value and "Enabled" or "Disabled", 2)
        
        if value then
            -- Kumpulkan SEMUA bagian
            getgenv().AllCharacterParts = {}
            local character = player.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("PartOperation") then
                        table.insert(getgenv().AllCharacterParts, part)
                    end
                end
                
                for _, accessory in ipairs(character:GetChildren()) do
                    if accessory:IsA("Accessory") then
                        local handle = accessory:FindFirstChild("Handle")
                        if handle and handle:IsA("BasePart") and not table.find(getgenv().AllCharacterParts, handle) then
                            table.insert(getgenv().AllCharacterParts, handle)
                        end
                    end
                end
            end
        end
    end
})

-- RGB Body logic (SUPER SMOOTH & CEPAT)
spawn(function()
    local hue = 0
    local connection
    
    while true do
        task.wait(0.016) -- 60fps update untuk smoothness maksimal
        if getgenv().RGBBody then
            hue = (hue + 1.2) % 360 -- Lebih cepat tapi tetap smooth (1.2 derajat per frame)
            local color = Color3.fromHSV(hue/360, 1, 1)
            
            pcall(function()
                for _, part in ipairs(getgenv().AllCharacterParts) do
                    if part and part.Parent then
                        part.Color = color
                        part.BrickColor = BrickColor.new(color)
                        
                        -- Update semua texture/decal
                        for _, child in ipairs(part:GetChildren()) do
                            if child:IsA("Texture") or child:IsA("Decal") then
                                child.Color3 = color
                            end
                        end
                    end
                end
                
                -- Update shirt/pants
                local character = player.Character
                if character then
                    for _, child in ipairs(character:GetChildren()) do
                        if child:IsA("Shirt") or child:IsA("Pants") then
                            child.Color3 = color
                        end
                    end
                end
            end)
        end
    end
end)

-- Character added event
player.CharacterAdded:Connect(function(character)
    task.wait(1)
    
    if getgenv().RGBBody then
        getgenv().AllCharacterParts = {}
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("PartOperation") then
                table.insert(getgenv().AllCharacterParts, part)
            end
        end
        
        for _, accessory in ipairs(character:GetChildren()) do
            if accessory:IsA("Accessory") then
                local handle = accessory:FindFirstChild("Handle")
                if handle and handle:IsA("BasePart") and not table.find(getgenv().AllCharacterParts, handle) then
                    table.insert(getgenv().AllCharacterParts, handle)
                end
            end
        end
    end
    
    if getgenv().WalkOnWater then
        getgenv().WaterParts = {}
        local ocean = Workspace:FindFirstChild("Ocean")
        if ocean then
            for _, child in ipairs(ocean:GetChildren()) do
                if child:IsA("Part") and child.Name == "Water" then
                    table.insert(getgenv().WaterParts, child)
                end
            end
        end
    end
end)

-- Water parts update
spawn(function()
    while task.wait(5) do
        if getgenv().WalkOnWater then
            getgenv().WaterParts = {}
            local ocean = Workspace:FindFirstChild("Ocean")
            if ocean then
                for _, child in ipairs(ocean:GetChildren()) do
                    if child:IsA("Part") and child.Name == "Water" then
                        table.insert(getgenv().WaterParts, child)
                    end
                end
            end
        end
    end
end)

-- =======================================================
-- COMMUNITY TAB (HANYA WHATSAPP & DISCORD)
-- =======================================================
local WhatsAppSection = CommunityTab:Section({ Title = "WhatsApp Group" })

WhatsAppSection:Button({
    Title = "Join WhatsApp Group",
    Desc = "Click to copy WhatsApp group link",
    Callback = function()
        if setclipboard then
            setclipboard("https://chat.whatsapp.com/I8hG44FLgrRAwQcS3lvEft")
            ShowNotification("Success", "WhatsApp link copied to clipboard!", 3)
        end
    end
})

CommunityTab:Space()

local DiscordSection = CommunityTab:Section({ Title = "Discord Server" })

DiscordSection:Button({
    Title = "Join Discord Server",
    Desc = "Click to copy Discord server link",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/eDbaHKEf7G")
            ShowNotification("Success", "Discord link copied to clipboard!", 3)
        end
    end
})

-- =======================================================
-- WINDOW CONTROLS
-- =======================================================
local ControlSection = Window:Section({ Title = "Window Controls" })
local ControlGroup = ControlSection:Group({})

ControlGroup:Button({
    Title = "Minimize",
    Callback = function() 
        Window:Minimize()
    end
})

ControlGroup:Space()

ControlGroup:Button({
    Title = "Close",
    Callback = function()
        Window:Destroy()
        if pingGui then pingGui:Destroy() end
        if logoGui then logoGui:Destroy() end
        if notifHolder then notifHolder:Destroy() end
    end
})

-- =======================================================
-- INITIAL NOTIFICATION
-- =======================================================
task.wait(1)
ShowNotification("PinatHub", "Script loaded successfully", 3)
