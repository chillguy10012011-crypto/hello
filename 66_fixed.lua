--[[
    NEW CONTROL PANEL - TEST BUILD
    Gộp từ các file chức năng cũ, sắp xếp lại thành GUI mới.
    Chưa tách loadstring/module ở bản này để dễ test toàn bộ trước.
]]

-- // TỐI ƯU HÀM BẢO MẬT CLONEREF
local function getService(serviceName)
    local rawService = game:GetService(serviceName)
    if cloneref then
        return cloneref(rawService)
    end
    return rawService
end

-- // KHAI BÁO SERVICES
local Players = getService("Players")
local RunService = getService("RunService")
local UserInputService = getService("UserInputService")
local Workspace = getService("Workspace")

local LocalPlayer = Players.LocalPlayer
local CoreGui = getService("CoreGui")

-- // HÀM KÉO THẢ (DRAGGABLE) DÙNG CHUNG
local function enableDragging(frame, dragHandle)
    dragHandle = dragHandle or frame
    local dragging, dragInput, dragStart, startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- // TẠO GUI CHÍNH
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomControlGUI"
ScreenGui.ResetOnSpawn = false

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- // NÚT BẬT/TẮT HÌNH TRÒN (FLOATING BUTTON)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
ToggleBtn.BorderSizePixel = 2
ToggleBtn.Text = "GUI"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

enableDragging(ToggleBtn)

-- // KHUNG CHÍNH (MAIN FRAME)
local baseWidth, baseHeight = 275, 175
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, baseWidth * 2, 0, baseHeight * 2)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderColor3 = Color3.fromRGB(0, 170, 255)
TitleBar.BorderSizePixel = 1
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "CONTROL PANEL"
TitleText.TextColor3 = Color3.fromRGB(0, 170, 255)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

enableDragging(MainFrame, TitleBar)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TitleBar

-- // NÚT SETTINGS (BÁNH RĂNG)
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Name = "SettingsButton"
SettingsBtn.Size = UDim2.new(0, 30, 0, 30)
SettingsBtn.Position = UDim2.new(1, -60, 0, 0)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
SettingsBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
SettingsBtn.BorderSizePixel = 1
SettingsBtn.Text = "⚙"
SettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsBtn.Font = Enum.Font.SourceSansBold
SettingsBtn.TextSize = 18
SettingsBtn.Parent = TitleBar

local SettingsPanel = Instance.new("Frame")
SettingsPanel.Name = "SettingsPanel"
SettingsPanel.Size = UDim2.new(0.82, 0, 0.88, 0)
SettingsPanel.Position = UDim2.new(0.09, 0, 0.08, 0)
SettingsPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SettingsPanel.BorderColor3 = Color3.fromRGB(0, 170, 255)
SettingsPanel.BorderSizePixel = 2
SettingsPanel.Visible = false
SettingsPanel.ZIndex = 20
SettingsPanel.Parent = MainFrame

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, -45, 0, 30)
SettingsTitle.Position = UDim2.new(0, 10, 0, 0)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "SETTINGS"
SettingsTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
SettingsTitle.Font = Enum.Font.SourceSansBold
SettingsTitle.TextSize = 16
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.ZIndex = 21
SettingsTitle.Parent = SettingsPanel

local SettingsClose = Instance.new("TextButton")
SettingsClose.Size = UDim2.new(0, 30, 0, 30)
SettingsClose.Position = UDim2.new(1, -32, 0, 0)
SettingsClose.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
SettingsClose.Text = "X"
SettingsClose.TextColor3 = Color3.fromRGB(255,255,255)
SettingsClose.Font = Enum.Font.SourceSansBold
SettingsClose.TextSize = 14
SettingsClose.ZIndex = 21
SettingsClose.Parent = SettingsPanel

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- // THANH BÊN NÚT SLIDE VÀ HÀM HỖ TRỢ GIAO DIỆN
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0.35, 0, 1, -30)
Sidebar.Position = UDim2.new(0, 0, 0, 30)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.BorderColor3 = Color3.fromRGB(0, 170, 255)
Sidebar.BorderSizePixel = 1
Sidebar.ScrollBarThickness = 4
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 2)
SidebarLayout.Parent = Sidebar

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(0.65, 0, 1, -30)
ContentArea.Position = UDim2.new(0.35, 0, 0, 30)
ContentArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local slides = {}
local registeredBackgrounds = {MainFrame, ContentArea}
local registeredBorders = {MainFrame, TitleBar, Sidebar}
local registeredTexts = {TitleText}
local toggleButtonsRegistry = {} 
local resetCallbacks = {} 
local currentGuiStyle = "Default"
table.insert(registeredBackgrounds, SettingsPanel)
table.insert(registeredBorders, SettingsPanel)

local function applyTheme(bgColor, borderColor, textColor)
    if bgColor then
        for _, obj in pairs(registeredBackgrounds) do
            if obj:IsA("Frame") or obj:IsA("ScrollingFrame") then
                obj.BackgroundColor3 = bgColor
            end
        end
    end
    if borderColor then
        for _, obj in pairs(registeredBorders) do
            obj.BorderColor3 = borderColor
        end
    end
    if textColor then
        for _, obj in pairs(registeredTexts) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj.TextColor3 = textColor
            end
        end
    end
end

local function createSlide(name)
    local slideFrame = Instance.new("ScrollingFrame")
    slideFrame.Name = name
    slideFrame.Size = UDim2.new(1, 0, 1, 0)
    slideFrame.BackgroundTransparency = 1
    slideFrame.BorderSizePixel = 0
    slideFrame.ScrollBarThickness = 6
    slideFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    slideFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    slideFrame.Visible = false
    slideFrame.Parent = ContentArea

    local navButton = Instance.new("TextButton")
    navButton.Size = UDim2.new(1, 0, 0, 35)
    navButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    navButton.BorderColor3 = Color3.fromRGB(0, 170, 255)
    navButton.BorderSizePixel = 1
    navButton.Text = name
    navButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    navButton.Font = Enum.Font.SourceSans
    navButton.TextSize = 14
    navButton.Parent = Sidebar

    table.insert(registeredBorders, navButton)
    table.insert(registeredTexts, navButton)

    navButton.MouseButton1Click:Connect(function()
        for _, s in pairs(slides) do s.Visible = false end
        slideFrame.Visible = true
    end)

    slides[name] = slideFrame
    return slideFrame
end

local function createStyledButton(parent, text, pos, size)
    local btn = Instance.new("TextButton")
    btn.Size = size or UDim2.new(0.95, 0, 0, 30)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderColor3 = Color3.fromRGB(0, 170, 255)
    btn.BorderSizePixel = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = parent

    table.insert(registeredBorders, btn)
    table.insert(registeredTexts, btn)
    return btn
end

local function createStyledTextBox(parent, placeholder, pos, size)
    local box = Instance.new("TextBox")
    box.Size = size or UDim2.new(0.95, 0, 0, 30)
    box.Position = pos
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    box.BorderColor3 = Color3.fromRGB(0, 170, 255)
    box.BorderSizePixel = 1
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 14
    box.Parent = parent

    table.insert(registeredBorders, box)
    table.insert(registeredTexts, box)
    return box
end

local ParameterPopup
local ParameterPopupBody
local ParameterPopupTitle

local function closeParameterPopup()
    if ParameterPopup then ParameterPopup.Visible = false end
end

local function openParameterPopup(mainFrame, title, fields)
    if not ParameterPopup then
        ParameterPopup = Instance.new("Frame")
        ParameterPopup.Size = UDim2.new(0, 290, 0, 120)
        ParameterPopup.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ParameterPopup.BorderColor3 = Color3.fromRGB(0, 170, 255)
        ParameterPopup.BorderSizePixel = 1
        ParameterPopup.ZIndex = 500
        ParameterPopup.Visible = false
        ParameterPopup.Parent = ScreenGui
        ParameterPopupTitle = Instance.new("TextLabel")
        ParameterPopupTitle.Size = UDim2.new(1, -42, 0, 32)
        ParameterPopupTitle.Position = UDim2.new(0, 10, 0, 0)
        ParameterPopupTitle.BackgroundTransparency = 1
        ParameterPopupTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
        ParameterPopupTitle.Font = Enum.Font.SourceSansBold
        ParameterPopupTitle.TextSize = 14
        ParameterPopupTitle.TextXAlignment = Enum.TextXAlignment.Left
        ParameterPopupTitle.ZIndex = 501
        ParameterPopupTitle.Parent = ParameterPopup
        local close = Instance.new("TextButton")
        close.Size = UDim2.new(0, 28, 0, 26)
        close.Position = UDim2.new(1, -32, 0, 3)
        close.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        close.BorderColor3 = Color3.fromRGB(0, 170, 255)
        close.Text = "X"
        close.TextColor3 = Color3.fromRGB(255, 255, 255)
        close.Font = Enum.Font.SourceSansBold
        close.TextSize = 12
        close.ZIndex = 501
        close.Parent = ParameterPopup
        close.MouseButton1Click:Connect(closeParameterPopup)
        ParameterPopupBody = Instance.new("Frame")
        ParameterPopupBody.Size = UDim2.new(1, -20, 1, -38)
        ParameterPopupBody.Position = UDim2.new(0, 10, 0, 36)
        ParameterPopupBody.BackgroundTransparency = 1
        ParameterPopupBody.ZIndex = 501
        ParameterPopupBody.Parent = ParameterPopup
    end
    for _, child in ipairs(ParameterPopupBody:GetChildren()) do child:Destroy() end
    ParameterPopupTitle.Text = title
    local y = 0
    for _, field in ipairs(fields) do
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.58, -4, 0, 28)
        label.Position = UDim2.new(0, 0, 0, y)
        label.BackgroundTransparency = 1
        label.Text = field.name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.SourceSans
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.ZIndex = 502
        label.Parent = ParameterPopupBody
        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0.42, 0, 0, 26)
        box.Position = UDim2.new(0.58, 4, 0, y)
        box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        box.BorderColor3 = Color3.fromRGB(0, 170, 255)
        box.BorderSizePixel = 1
        box.Text = tostring(field.get())
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Font = Enum.Font.SourceSans
        box.TextSize = 13
        box.ClearTextOnFocus = false
        box.ZIndex = 502
        box.Parent = ParameterPopupBody
        box.FocusLost:Connect(function()
            local value = tonumber(box.Text)
            if value then
                if field.min then value = math.max(field.min, value) end
                if field.max then value = math.min(field.max, value) end
                field.set(value)
            end
            box.Text = tostring(field.get())
        end)
        y = y + 32
    end
    local popupHeight = 44 + y
    ParameterPopup.Size = UDim2.new(0, 290, 0, popupHeight)
    local abs = mainFrame.AbsolutePosition
    local size = mainFrame.AbsoluteSize
    local camera = Workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(800, 600)
    local x = math.clamp(abs.X + size.X - 290, 4, viewport.X - 294)
    local py = abs.Y + size.Y + 5
    if py + popupHeight > viewport.Y - 4 then py = math.max(4, abs.Y - popupHeight - 5) end
    ParameterPopup.Position = UDim2.fromOffset(x, py)
    ParameterPopup.Visible = true
end

local function addParameterButton(mainFrame, title, fields)
    local more = Instance.new("TextButton")
    more.Name = "ParameterButton"
    more.Size = UDim2.new(0, 28, 1, 0)
    more.Position = UDim2.new(1, -68, 0, 0)
    more.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    more.BorderColor3 = Color3.fromRGB(0, 170, 255)
    more.BorderSizePixel = 1
    more.Text = "..."
    more.TextColor3 = Color3.fromRGB(255, 255, 255)
    more.Font = Enum.Font.SourceSansBold
    more.TextSize = 14
    more.ZIndex = 10
    more.Parent = mainFrame
    table.insert(registeredBorders, more)
    more.MouseButton1Click:Connect(function() openParameterPopup(mainFrame, title, fields) end)
end

local function createKeybindButton(parent, defaultText, pos, size, defaultKey, onToggleCallback)
    size = size or UDim2.new(0.95, 0, 0, 30)
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = size
    mainFrame.Position = pos
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = parent

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(1, -70, 1, 0)
    toggleBtn.Position = UDim2.new(0, 0, 0, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
    toggleBtn.BorderSizePixel = 1
    toggleBtn.Text = defaultText .. " (OFF)"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.SourceSans
    toggleBtn.TextSize = 13
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Center
    toggleBtn.Parent = mainFrame

    local checkBox = Instance.new("TextButton")
    checkBox.Size = UDim2.new(0, 24, 0, 24)
    checkBox.Position = UDim2.new(1, -98, 0.5, -12)
    checkBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    checkBox.BorderColor3 = Color3.fromRGB(0, 170, 255)
    checkBox.BorderSizePixel = 1
    checkBox.Text = ""
    checkBox.TextColor3 = Color3.fromRGB(0, 255, 120)
    checkBox.Font = Enum.Font.SourceSansBold
    checkBox.TextSize = 16
    checkBox.Visible = false
    checkBox.Parent = mainFrame

    local keybindBox = Instance.new("TextButton")
    keybindBox.Size = UDim2.new(0, 38, 1, 0)
    keybindBox.Position = UDim2.new(1, -38, 0, 0)
    keybindBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    keybindBox.BorderColor3 = Color3.fromRGB(0, 170, 255)
    keybindBox.BorderSizePixel = 1
    keybindBox.Text = defaultKey and defaultKey.Name or "None"
    keybindBox.TextColor3 = Color3.fromRGB(0, 170, 255)
    keybindBox.Font = Enum.Font.SourceSansBold
    keybindBox.TextSize = 12
    keybindBox.Parent = mainFrame

    table.insert(registeredBorders, toggleBtn)
    table.insert(registeredBorders, keybindBox)
    table.insert(registeredBorders, checkBox)
    table.insert(registeredTexts, toggleBtn)

    local isToggled = false
    local currentKey = defaultKey
    local isBinding = false

    local function updateVisuals()
        if currentGuiStyle == "GUI1" then
            toggleBtn.BackgroundTransparency = 1
            toggleBtn.BorderSizePixel = 0
            toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            toggleBtn.Text = defaultText
            checkBox.Visible = true
            checkBox.Text = isToggled and "✓" or ""
        else
            toggleBtn.BackgroundTransparency = 0
            toggleBtn.BorderSizePixel = 1
            toggleBtn.TextXAlignment = Enum.TextXAlignment.Center
            toggleBtn.Text = defaultText .. " (" .. (isToggled and "ON" or "OFF") .. ")"
            toggleBtn.BackgroundColor3 = isToggled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
            checkBox.Visible = false
        end
    end

    local function executeToggle()
        isToggled = not isToggled
        updateVisuals()
        if onToggleCallback then
            onToggleCallback(isToggled)
        end
    end

    local function forceResetOff()
        if isToggled then
            isToggled = false
            updateVisuals()
            if onToggleCallback then
                onToggleCallback(false)
            end
        end
    end
    table.insert(resetCallbacks, forceResetOff)

    toggleBtn.MouseButton1Click:Connect(executeToggle)
    checkBox.MouseButton1Click:Connect(executeToggle)

    keybindBox.MouseButton1Click:Connect(function()
        isBinding = true
        keybindBox.Text = "..."
        keybindBox.TextColor3 = Color3.fromRGB(255, 255, 0)
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if isBinding then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Delete then
                    currentKey = nil
                    keybindBox.Text = "None"
                else
                    currentKey = input.KeyCode
                    keybindBox.Text = currentKey.Name
                end
                keybindBox.TextColor3 = Color3.fromRGB(0, 170, 255)
                isBinding = false
            end
        elseif not gameProcessed and currentKey and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
            executeToggle()
        end
    end)

    table.insert(toggleButtonsRegistry, updateVisuals)

    return toggleBtn, keybindBox, mainFrame
end

local function setGuiStyle(styleName)
    currentGuiStyle = styleName
    if styleName == "GUI1" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 24, 30)
        MainFrame.BorderColor3 = Color3.fromRGB(0, 230, 255)
        TitleBar.BackgroundColor3 = Color3.fromRGB(12, 15, 20)
        TitleBar.BorderColor3 = Color3.fromRGB(0, 230, 255)
        Sidebar.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
        Sidebar.BorderColor3 = Color3.fromRGB(0, 230, 255)
        ContentArea.BackgroundColor3 = Color3.fromRGB(20, 24, 30)
    else
        MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
        TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TitleBar.BorderColor3 = Color3.fromRGB(0, 170, 255)
        Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Sidebar.BorderColor3 = Color3.fromRGB(0, 170, 255)
        ContentArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end

    for _, updateFunc in ipairs(toggleButtonsRegistry) do
        updateFunc()
    end
end

local Slide1 = createSlide("Player")
Slide1.Visible = true

local selectedPlayerName = ""
local modeOption = 1
local targetDistance = 4

local SelectedLbl = Instance.new("TextLabel")
SelectedLbl.Size = UDim2.new(0.95, 0, 0, 25)
SelectedLbl.Position = UDim2.new(0.025, 0, 0, 10)
SelectedLbl.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SelectedLbl.BorderColor3 = Color3.fromRGB(0, 170, 255)
SelectedLbl.BorderSizePixel = 1
SelectedLbl.Text = "Người chơi: [Chưa chọn]"
SelectedLbl.TextColor3 = Color3.fromRGB(0, 255, 150)
SelectedLbl.Font = Enum.Font.SourceSans
SelectedLbl.TextSize = 13
SelectedLbl.Parent = Slide1

table.insert(registeredBorders, SelectedLbl)

-- // DANH SÁCH NGƯỜI CHƠI
local PlayerListOpen = true
local PlayerListRowHeight = 34

local PlayerListToggle = Instance.new("TextButton")
PlayerListToggle.Size = UDim2.new(0.95, 0, 0, 28)
PlayerListToggle.Position = UDim2.new(0.025, 0, 0, 40)
PlayerListToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PlayerListToggle.BorderColor3 = Color3.fromRGB(0, 170, 255)
PlayerListToggle.BorderSizePixel = 1
PlayerListToggle.Text = "▼  Người chơi trong server"
PlayerListToggle.TextColor3 = Color3.fromRGB(0, 255, 150)
PlayerListToggle.Font = Enum.Font.SourceSansBold
PlayerListToggle.TextSize = 13
PlayerListToggle.TextXAlignment = Enum.TextXAlignment.Left
PlayerListToggle.Parent = Slide1

table.insert(registeredBorders, PlayerListToggle)
table.insert(registeredTexts, PlayerListToggle)

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(0.95, 0, 0, 0)
PlayerList.Position = UDim2.new(0.025, 0, 0, 70)
PlayerList.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
PlayerList.BorderColor3 = Color3.fromRGB(0, 170, 255)
PlayerList.BorderSizePixel = 1
PlayerList.ScrollBarThickness = 0
PlayerList.ScrollingEnabled = false
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = Slide1

table.insert(registeredBorders, PlayerList)

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 2)
UIList.Parent = PlayerList

-- Lưu vị trí gốc của các thành phần nằm bên dưới bảng người chơi.
-- Khi bảng mở rộng/thu nhỏ, các thành phần này sẽ tự động dời xuống/lên.
local originalPlayerListPositions = nil

local function getPlayerCount()
    local count = 0
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            count = count + 1
        end
    end
    return count
end

local function getPlayerListHeight()
    local count = getPlayerCount()
    if count <= 0 then
        return 0
    end

    -- Mỗi người chơi chiếm 32px + 2px khoảng cách.
    return (count * PlayerListRowHeight) - 2
end

local function updatePlayerListLayout()
    if not originalPlayerListPositions then
        originalPlayerListPositions = {}

        for _, child in pairs(Slide1:GetChildren()) do
            if child ~= SelectedLbl
                and child ~= PlayerListToggle
                and child ~= PlayerList
                and child:IsA("GuiObject")
                and child.Position.Y.Scale == 0
                and child.Position.Y.Offset >= 100 then

                originalPlayerListPositions[child] = child.Position.Y.Offset
            end
        end
    end

    local listHeight = PlayerListOpen and getPlayerListHeight() or 0

    PlayerList.Size = UDim2.new(0.95, 0, 0, listHeight)
    PlayerList.Visible = PlayerListOpen

    -- InputNameBox1 cũ bắt đầu ở Y=130.
    -- Vị trí mới: ngay sau bảng người chơi + 5px.
    local newInputY = 75 + listHeight
    local offset = newInputY - 130

    for object, originalY in pairs(originalPlayerListPositions) do
        if object and object.Parent then
            object.Position = UDim2.new(
                object.Position.X.Scale,
                object.Position.X.Offset,
                object.Position.Y.Scale,
                originalY + offset
            )
        end
    end
end

local function updatePlayerList()
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -8, 0, 32)
            pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            pBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
            pBtn.BorderSizePixel = 1
            pBtn.Text = ""
            pBtn.AutoButtonColor = true
            pBtn.Parent = PlayerList

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, -42, 1, 0)
            nameLabel.Position = UDim2.new(0, 6, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.Font = Enum.Font.SourceSans
            nameLabel.TextSize = 13
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Parent = pBtn

            local avatar = Instance.new("ImageLabel")
            avatar.Size = UDim2.new(0, 26, 0, 26)
            avatar.Position = UDim2.new(1, -31, 0.5, -13)
            avatar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            avatar.BorderSizePixel = 0
            avatar.Parent = pBtn

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(1, 0)
            corner.Parent = avatar

            local success, content = pcall(function()
                return Players:GetUserThumbnailAsync(
                    p.UserId,
                    Enum.ThumbnailType.HeadShot,
                    Enum.ThumbnailSize.Size48x48
                )
            end)

            if success and content then
                avatar.Image = content
            end

            table.insert(registeredBorders, pBtn)
            table.insert(registeredTexts, nameLabel)

            pBtn.MouseButton1Click:Connect(function()
                selectedPlayerName = p.Name
                SelectedLbl.Text = "Người chơi: " .. selectedPlayerName
            end)
        end
    end

    local listHeight = getPlayerListHeight()
    PlayerList.Size = UDim2.new(0.95, 0, 0, PlayerListOpen and listHeight or 0)
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, listHeight)
end

PlayerListToggle.MouseButton1Click:Connect(function()
    PlayerListOpen = not PlayerListOpen

    if PlayerListOpen then
        PlayerListToggle.Text = "▼  Người chơi trong server"
    else
        PlayerListToggle.Text = "▶  Người chơi trong server"
    end

    updatePlayerListLayout()
end)

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local listHeight = getPlayerListHeight()
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, listHeight)
end)

updatePlayerList()
Players.PlayerAdded:Connect(function()
    updatePlayerList()
    updatePlayerListLayout()
end)

Players.PlayerRemoving:Connect(function()
    task.defer(function()
        updatePlayerList()
        updatePlayerListLayout()
    end)
end)

local InputNameBox1 = createStyledTextBox(Slide1, "Nhập Username...", UDim2.new(0.025, 0, 0, 130), UDim2.new(0.95, 0, 0, 28))

local ModeFrame = Instance.new("Frame")
ModeFrame.Size = UDim2.new(0.95, 0, 0, 30)
ModeFrame.Position = UDim2.new(0.025, 0, 0, 163)
ModeFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ModeFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
ModeFrame.BorderSizePixel = 1
ModeFrame.Parent = Slide1

table.insert(registeredBorders, ModeFrame)

local Mode1Btn = createStyledButton(ModeFrame, "Chế độ 1", UDim2.new(0.01, 0, 0.08, 0), UDim2.new(0.48, 0, 0.84, 0))
local Mode2Btn = createStyledButton(ModeFrame, "Chế độ 2", UDim2.new(0.51, 0, 0.08, 0), UDim2.new(0.48, 0, 0.84, 0))
Mode1Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)

Mode1Btn.MouseButton1Click:Connect(function()
    modeOption = 1
    Mode1Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    Mode2Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

Mode2Btn.MouseButton1Click:Connect(function()
    modeOption = 2
    Mode2Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    Mode1Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

local LockAimToggle = false
createKeybindButton(Slide1, "Nhìn người gần nhất", UDim2.new(0.025, 0, 0, 198), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    LockAimToggle = state
end)

local StandBehindToggle = false
local StandBehindButton, _, StandBehindFrame = createKeybindButton(Slide1, "Đứng sau target", UDim2.new(0.025, 0, 0, 231), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    StandBehindToggle = state
end)

-- // CHỐNG GIẢM TỐC
local AntiSlowToggle = false
local antiSlowConnection = nil
local antiSlowDefaultSpeed = 16

createKeybindButton(Slide1, "Chống giảm tốc", UDim2.new(0.025, 0, 0, 264), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    AntiSlowToggle = state

    if AntiSlowToggle then
        if not antiSlowConnection then
            antiSlowConnection = RunService.RenderStepped:Connect(function()
                local character = LocalPlayer.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.WalkSpeed < antiSlowDefaultSpeed then
                    humanoid.WalkSpeed = antiSlowDefaultSpeed
                end
            end)
        end
    else
        if antiSlowConnection then
            antiSlowConnection:Disconnect()
            antiSlowConnection = nil
        end
    end
end)
local DistBox = createStyledTextBox(Slide1, "4", UDim2.new(0.025, 0, 0, 297), UDim2.new(0.95, 0, 0, 22))
DistBox.Text = "Khoảng cách: 4 studs (Nhấn để chỉnh)"
DistBox.TextColor3 = Color3.fromRGB(0, 170, 255)

local SliderFrame = Instance.new("Frame")
SliderFrame.Size = UDim2.new(0.95, 0, 0, 15)
SliderFrame.Position = UDim2.new(0.025, 0, 0, 324)
SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SliderFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
SliderFrame.BorderSizePixel = 1
SliderFrame.Parent = Slide1

table.insert(registeredBorders, SliderFrame)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new((4 - 1) / (20 - 1), 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderFrame

local isDraggingSlider = false

local function updateSliderFromValue(val)
    val = math.clamp(val, 1, 20)
    targetDistance = math.floor(val * 10 + 0.5) / 10
    SliderFill.Size = UDim2.new((targetDistance - 1) / 19, 0, 1, 0)
    DistBox.Text = "Khoảng cách: " .. tostring(targetDistance) .. " studs (Nhấn để chỉnh)"
end

local function updateSliderFromInput(input)
    local relativeX = input.Position.X - SliderFrame.AbsolutePosition.X
    local pct = math.clamp(relativeX / SliderFrame.AbsoluteSize.X, 0, 1)
    local val = 1 + (pct * 19)
    updateSliderFromValue(val)
end

SliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSlider = true
        updateSliderFromInput(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSliderFromInput(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSlider = false
    end
end)

DistBox.FocusLost:Connect(function()
    local num = tonumber(DistBox.Text:match("%d+%.?%d*"))
    if num then
        updateSliderFromValue(num)
    else
        DistBox.Text = "Khoảng cách: " .. tostring(targetDistance) .. " studs (Nhấn để chỉnh)"
    end
end)

DistBox.Visible = false
SliderFrame.Visible = false
addParameterButton(StandBehindFrame, "Thông số • Đứng sau target", {{name="Khoảng cách", min=1, max=20, get=function() return targetDistance end, set=function(v) updateSliderFromValue(v) end}})

local function getTargetPlayer()
    local name = (modeOption == 1) and selectedPlayerName or InputNameBox1.Text
    if name ~= "" then
        return Players:FindFirstChild(name)
    end
    return nil
end

RunService.RenderStepped:Connect(function()
    if LockAimToggle and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myHrp = LocalPlayer.Character.HumanoidRootPart
        local closestChar = nil
        local shortestDist = math.huge

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (p.Character.HumanoidRootPart.Position - myHrp.Position).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    closestChar = p.Character.HumanoidRootPart
                end
            end
        end

        if closestChar then
            Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, closestChar.Position)
        end
    end

    if StandBehindToggle and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getTargetPlayer()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetHrp = target.Character.HumanoidRootPart
            local myHrp = LocalPlayer.Character.HumanoidRootPart
            myHrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, targetDistance)
        end
    end
end)

local SlideMovement = createSlide("Movement")


-- 1. NÚT FLY (BAY TỰ DO TRÊN MOBILE VÀ PC)
local flyToggle = false
local flySpeed = 50
local flyConnection = nil

local FlyButton, _, FlyFrame = createKeybindButton(SlideMovement, "Fly (Bay tự do)", UDim2.new(0.025, 0, 0, 20), UDim2.new(0.95, 0, 0, 35), nil, function(state)
    flyToggle = state
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")

    if flyToggle and hrp and humanoid then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = Vector3.zero
        bv.Parent = hrp

        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bg.P = 9e4
        bg.CFrame = hrp.CFrame
        bg.Parent = hrp

        humanoid.PlatformStand = true

        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyToggle or not hrp or not hrp.Parent then
                if flyConnection then flyConnection:Disconnect() flyConnection = nil end
                return
            end

            local camera = Workspace.CurrentCamera
            local moveVector = humanoid.MoveDirection

            bg.CFrame = camera.CFrame

            if moveVector.Magnitude > 0 then
                local cameraCFrame = camera.CFrame
                local forwardVector = cameraCFrame.LookVector
                local rightVector = cameraCFrame.RightVector

                local dotForward = moveVector:Dot(cameraCFrame.LookVector)
                local dotRight = moveVector:Dot(cameraCFrame.RightVector)

                local flyDirection = (forwardVector * dotForward) + (rightVector * dotRight)
                if flyDirection.Magnitude > 0 then
                    flyDirection = flyDirection.Unit
                end

                bv.Velocity = flyDirection * flySpeed
            else
                bv.Velocity = Vector3.zero
            end
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if hrp then
            local oldBv = hrp:FindFirstChild("FlyVelocity")
            local oldBg = hrp:FindFirstChild("FlyGyro")
            if oldBv then oldBv:Destroy() end
            if oldBg then oldBg:Destroy() end
        end
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end)

addParameterButton(FlyFrame, "Thông số • Fly", {{name="Tốc độ bay", min=1, max=200, get=function() return flySpeed end, set=function(v) flySpeed = v end}})

-- 2. NÚT NOCLIP + SÀN GIẢ TÀNG HÌNH
local noClipToggle = false
local noClipConnection = nil
local fakeFloor = nil
local fixedY = nil

createKeybindButton(SlideMovement, "NoClip (Xuyên tường + Sàn giả)", UDim2.new(0.025, 0, 0, 65), UDim2.new(0.95, 0, 0, 35), nil, function(state)
    noClipToggle = state
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if noClipToggle then
        if hrp then
            fixedY = hrp.Position.Y - 3.2
        end

        if not fakeFloor or not fakeFloor.Parent then
            fakeFloor = Instance.new("Part")
            fakeFloor.Name = "CustomInvisibleFloor"
            fakeFloor.Size = Vector3.new(8, 1, 8)
            fakeFloor.Transparency = 1
            fakeFloor.Anchored = true
            fakeFloor.CanCollide = true
            fakeFloor.Parent = Workspace
        end

        noClipConnection = RunService.Stepped:Connect(function()
            local currentChar = LocalPlayer.Character
            local currentHrp = currentChar and currentChar:FindFirstChild("HumanoidRootPart")
            local humanoid = currentChar and currentChar:FindFirstChildOfClass("Humanoid")

            if currentChar and noClipToggle then
                for _, part in pairs(currentChar:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "CustomInvisibleFloor" then
                        part.CanCollide = false
                    end
                end

                if currentHrp and fakeFloor then
                    if humanoid and humanoid.Jump then
                        fixedY = currentHrp.Position.Y - 1.5
                    end
                    fakeFloor.CFrame = CFrame.new(currentHrp.Position.X, fixedY, currentHrp.Position.Z)
                end
            end
        end)
    else
        if noClipConnection then
            noClipConnection:Disconnect()
            noClipConnection = nil
        end
        if fakeFloor then
            fakeFloor:Destroy()
            fakeFloor = nil
        end
        fixedY = nil
    end
end)

-- 3. NÚT ANTIFLING
local antiFlingToggle = false
local antiFlingConnection = nil

createKeybindButton(SlideMovement, "AntiFling (Chống văng chuẩn)", UDim2.new(0.025, 0, 0, 110), UDim2.new(0.95, 0, 0, 35), nil, function(state)
    antiFlingToggle = state

    if antiFlingToggle then
        if not antiFlingConnection then
            antiFlingConnection = RunService.Heartbeat:Connect(function()
                if not antiFlingToggle then return end
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local hrp = char.HumanoidRootPart
                    if hrp.RotVelocity.Magnitude > 75 or hrp.Velocity.Magnitude > 500 then
                        hrp.RotVelocity = Vector3.new(0, 0, 0)
                        hrp.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    else
        if antiFlingConnection then
            antiFlingConnection:Disconnect()
            antiFlingConnection = nil
        end
    end
end)

-- 4. NÚT AIR WALK
local airWalkToggle = false
local airWalkSpeed = 50
local airWalkConnection = nil
local airWalkBv = nil

local AirWalkButton, _, AirWalkFrame = createKeybindButton(SlideMovement, "Đi trên không (Air Walk)", UDim2.new(0.025, 0, 0, 155), UDim2.new(0.95, 0, 0, 35), nil, function(state)
    airWalkToggle = state
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if airWalkToggle and hrp then
        airWalkBv = Instance.new("BodyVelocity")
        airWalkBv.Name = "AirWalkVelocity"
        airWalkBv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        airWalkBv.Velocity = Vector3.zero
        airWalkBv.Parent = hrp

        airWalkConnection = RunService.RenderStepped:Connect(function()
            if hrp and airWalkBv then
                local cam = Workspace.CurrentCamera
                local moveDir = Vector3.zero

                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

                airWalkBv.Velocity = moveDir * airWalkSpeed
            end
        end)
    else
        if airWalkConnection then airWalkConnection:Disconnect() airWalkConnection = nil end
        if airWalkBv then airWalkBv:Destroy() airWalkBv = nil end
    end
end)

addParameterButton(AirWalkFrame, "Thông số • Air Walk", {{name="Tốc độ", min=1, max=200, get=function() return airWalkSpeed end, set=function(v) airWalkSpeed = v end}})

-- 5. NÚT TỐC BIẾN (PHÍM R)
local flashStepToggle = false
local flashStepDistance = 100

local function getMouseTargetPosition()
    local mousePos = UserInputService:GetMouseLocation()
    local ray = Workspace.CurrentCamera:ScreenPointToRay(mousePos.X, mousePos.Y)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    if LocalPlayer.Character then
        raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    end

    local result = Workspace:Raycast(ray.Origin, ray.Direction * flashStepDistance, raycastParams)
    if result then
        return result.Position
    else
        return ray.Origin + (ray.Direction * flashStepDistance)
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if flashStepToggle and input.KeyCode == Enum.KeyCode.R then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp then
            local targetPos = getMouseTargetPosition()
            hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 2.5, 0), targetPos)
        end
    end
end)

local FlashStepButton, _, FlashStepFrame = createKeybindButton(SlideMovement, "Tốc biến [Phím R]", UDim2.new(0.025, 0, 0, 200), UDim2.new(0.95, 0, 0, 35), Enum.KeyCode.R, function(state)
    flashStepToggle = state
end)

addParameterButton(FlashStepFrame, "Thông số • Flash Step", {{name="Khoảng cách", min=1, max=500, get=function() return flashStepDistance end, set=function(v) flashStepDistance = v end}})

-- // TỐC ĐỘ CHẠY
local SpeedToggle = false
local speedValue = 32
local speedMin, speedMax = 16, 200
local speedDefault = 16
local speedConnection = nil

local SpeedBox = createStyledTextBox(SlideMovement, "32", UDim2.new(0.025, 0, 0, 790), UDim2.new(0.95, 0, 0, 22))
SpeedBox.Text = "Tốc độ: 32 (Nhấn để chỉnh)"
SpeedBox.TextColor3 = Color3.fromRGB(0, 170, 255)

local SpeedSliderFrame = Instance.new("Frame")
SpeedSliderFrame.Size = UDim2.new(0.95, 0, 0, 15)
SpeedSliderFrame.Position = UDim2.new(0.025, 0, 0, 817)
SpeedSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpeedSliderFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
SpeedSliderFrame.BorderSizePixel = 1
SpeedSliderFrame.Parent = SlideMovement

table.insert(registeredBorders, SpeedSliderFrame)

local SpeedSliderFill = Instance.new("Frame")
SpeedSliderFill.Size = UDim2.new((speedValue - speedMin) / (speedMax - speedMin), 0, 1, 0)
SpeedSliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SpeedSliderFill.BorderSizePixel = 0
SpeedSliderFill.Parent = SpeedSliderFrame

local isDraggingSpeedSlider = false

local function updateSpeedFromValue(val)
    val = math.clamp(val, speedMin, speedMax)
    speedValue = math.floor(val + 0.5)
    SpeedSliderFill.Size = UDim2.new((speedValue - speedMin) / (speedMax - speedMin), 0, 1, 0)
    SpeedBox.Text = "Tốc độ: " .. tostring(speedValue) .. " (Nhấn để chỉnh)"
end

local function updateSpeedFromInput(input)
    local relativeX = input.Position.X - SpeedSliderFrame.AbsolutePosition.X
    local pct = math.clamp(relativeX / SpeedSliderFrame.AbsoluteSize.X, 0, 1)
    updateSpeedFromValue(speedMin + pct * (speedMax - speedMin))
end

SpeedSliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSpeedSlider = true
        updateSpeedFromInput(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingSpeedSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSpeedFromInput(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSpeedSlider = false
    end
end)

SpeedBox.FocusLost:Connect(function()
    local num = tonumber(SpeedBox.Text:match("%d+%.?%d*"))
    if num then
        updateSpeedFromValue(num)
    else
        SpeedBox.Text = "Tốc độ: " .. tostring(speedValue) .. " (Nhấn để chỉnh)"
    end
end)

local SpeedButton, _, SpeedFrame = createKeybindButton(SlideMovement, "Tăng tốc độ", UDim2.new(0.025, 0, 0, 245), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    SpeedToggle = state

    if SpeedToggle then
        if not speedConnection then
            speedConnection = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.WalkSpeed ~= speedValue then
                    humanoid.WalkSpeed = speedValue
                end
            end)
        end
    else
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speedDefault
        end
    end
end)

SpeedBox.Visible = false
SpeedSliderFrame.Visible = false
addParameterButton(SpeedFrame, "Thông số • Tốc độ", {{name="Tốc độ", min=16, max=200, get=function() return speedValue end, set=function(v) updateSpeedFromValue(v) end}})

-- // DASH
-- Dash client-side: Q để kích hoạt, có cooldown và hiệu ứng FOV/trail.
local DashToggle = false
local dashCooldown = 0.75
local dashDistance = 42
local dashDuration = 0.16
local dashReady = true
local dashKey = Enum.KeyCode.Q

local DashButton, _, DashFrame = createKeybindButton(
    SlideMovement,
    "Dash (Q)",
    UDim2.new(0.025, 0, 0, 278),
    UDim2.new(0.95, 0, 0, 28),
    nil,
    function(state)
        DashToggle = state
    end
)

addParameterButton(DashFrame, "Thông số • Dash", {{name="Khoảng cách", min=1, max=200, get=function() return dashDistance end, set=function(v) dashDistance = v end}, {name="Cooldown", min=0, max=10, get=function() return dashCooldown end, set=function(v) dashCooldown = v end}, {name="Thời gian", min=0.03, max=2, get=function() return dashDuration end, set=function(v) dashDuration = v end}})

local function getDashDirection()
    local character = LocalPlayer.Character
    if not character then return nil end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root then return nil end

    local moveDirection = humanoid.MoveDirection
    if moveDirection.Magnitude > 0.05 then
        return moveDirection.Unit
    end

    local camera = Workspace.CurrentCamera
    if camera then
        local look = camera.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z)
        if flatLook.Magnitude > 0.05 then
            return flatLook.Unit
        end
    end

    local look = root.CFrame.LookVector
    local flatLook = Vector3.new(look.X, 0, look.Z)
    if flatLook.Magnitude > 0.05 then
        return flatLook.Unit
    end

    return nil
end

local function playDashEffect(character, root)
    -- Trail ngắn tạo cảm giác chuyển động nhanh.
    local attachment0 = Instance.new("Attachment")
    attachment0.Name = "DashAttachment0"
    attachment0.Position = Vector3.new(0, 1, 0)
    attachment0.Parent = root

    local attachment1 = Instance.new("Attachment")
    attachment1.Name = "DashAttachment1"
    attachment1.Position = Vector3.new(0, -1, 0)
    attachment1.Parent = root

    local trail = Instance.new("Trail")
    trail.Name = "DashTrail"
    trail.Attachment0 = attachment0
    trail.Attachment1 = attachment1
    trail.Lifetime = 0.12
    trail.MinLength = 0.05
    trail.FaceCamera = true
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.15),
        NumberSequenceKeypoint.new(1, 1)
    })
    trail.Parent = root

    -- Hiệu ứng FOV giống dash nhanh.
    local camera = Workspace.CurrentCamera
    local oldFov = camera and camera.FieldOfView or 70
    if camera then
        camera.FieldOfView = math.clamp(oldFov + 12, 1, 120)
    end

    task.delay(dashDuration, function()
        if camera and camera.Parent then
            camera.FieldOfView = oldFov
        end
        if trail then trail:Destroy() end
        if attachment0 then attachment0:Destroy() end
        if attachment1 then attachment1:Destroy() end
    end)
end

local function dash()
    if not DashToggle or not dashReady then return end

    local character = LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not root or humanoid.Health <= 0 then return end

    local direction = getDashDirection()
    if not direction then return end

    dashReady = false
    playDashEffect(character, root)

    -- Giữ vận tốc ngang để dash mượt và không ép nhân vật bay lên.
    local oldY = root.AssemblyLinearVelocity.Y
    local startTime = os.clock()

    while os.clock() - startTime < dashDuration do
        if not root.Parent or humanoid.Health <= 0 then break end
        root.AssemblyLinearVelocity = Vector3.new(
            direction.X * (dashDistance / dashDuration),
            oldY,
            direction.Z * (dashDistance / dashDuration)
        )
        RunService.RenderStepped:Wait()
    end

    if root.Parent then
        local current = root.AssemblyLinearVelocity
        root.AssemblyLinearVelocity = Vector3.new(current.X * 0.15, current.Y, current.Z * 0.15)
    end

    task.delay(dashCooldown, function()
        dashReady = true
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == dashKey then
        dash()
    end
end)

-- // Cập nhật kích thước bảng người chơi lần đầu sau khi toàn bộ giao diện đã tạo xong
updatePlayerListLayout()

local VisualSlide = createSlide("Visual")
local EspToggle = false
local function updateESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local highlight = p.Character:FindFirstChild("CustomESPHighlight")
            if EspToggle then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "CustomESPHighlight"
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = p.Character
                end
                if p == LocalPlayer then
                    highlight.FillColor = Color3.fromRGB(0, 170, 255)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                else
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end

createKeybindButton(VisualSlide, "Esp", UDim2.new(0.025, 0, 0, 297), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    EspToggle = state
    updateESP()
end)

local TracerToggle = false
local tracerDrawings = {}

local function clearTracers()
    for _, drawGroup in pairs(tracerDrawings) do
        if drawGroup.Line then drawGroup.Line:Remove() end
        if drawGroup.Box then drawGroup.Box:Remove() end
    end
    tracerDrawings = {}
end

createKeybindButton(VisualSlide, "Tracer", UDim2.new(0.025, 0, 0, 330), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    TracerToggle = state
    if not TracerToggle then clearTracers() end
end)

RunService.RenderStepped:Connect(function()
    if not TracerToggle then return end

    local Camera = Workspace.CurrentCamera
    local viewportSize = Camera.ViewportSize
    local shiftLockPos = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if not tracerDrawings[p] then
                local line = Drawing.new("Line")
                line.Color = Color3.fromRGB(255, 0, 0)
                line.Thickness = 1.5
                line.Transparency = 1

                local box = Drawing.new("Square")
                box.Color = Color3.fromRGB(255, 0, 0)
                box.Thickness = 1.5
                box.Filled = false
                box.Transparency = 1

                tracerDrawings[p] = {Line = line, Box = box}
            end

            local drawGroup = tracerDrawings[p]
            local char = p.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if hrp and char:FindFirstChildOfClass("Humanoid") and char.Humanoid.Health > 0 then
                local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                if onScreen then
                    drawGroup.Line.From = shiftLockPos
                    drawGroup.Line.To = Vector2.new(hrpPos.X, hrpPos.Y)
                    drawGroup.Line.Visible = true

                    local head = char:FindFirstChild("Head")
                    local headPos = head and Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)) or hrpPos
                    local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))

                    local boxHeight = math.abs(headPos.Y - legPos.Y)
                    local boxWidth = boxHeight * 0.65

                    drawGroup.Box.Size = Vector2.new(boxWidth, boxHeight)
                    drawGroup.Box.Position = Vector2.new(hrpPos.X - boxWidth / 2, hrpPos.Y - boxHeight / 2)
                    drawGroup.Box.Visible = true
                else
                    drawGroup.Line.Visible = false
                    drawGroup.Box.Visible = false
                end
            else
                drawGroup.Line.Visible = false
                drawGroup.Box.Visible = false
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if tracerDrawings[p] then
        if tracerDrawings[p].Line then tracerDrawings[p].Line:Remove() end
        if tracerDrawings[p].Box then tracerDrawings[p].Box:Remove() end
        tracerDrawings[p] = nil
    end
end)

local ShowNameToggle = false
local function updateNames()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild("Head")
            if head then
                local billboard = head:FindFirstChild("CustomNameBillboard")
                if ShowNameToggle then
                    if not billboard then
                        billboard = Instance.new("BillboardGui")
                        billboard.Name = "CustomNameBillboard"
                        billboard.Size = UDim2.new(0, 200, 0, 30)
                        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = head

                        local nameLabel = Instance.new("TextLabel")
                        nameLabel.Size = UDim2.new(1, 0, 1, 0)
                        nameLabel.BackgroundTransparency = 1
                        nameLabel.Text = p.DisplayName .. " (@" .. p.Name .. ")"
                        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        nameLabel.TextStrokeTransparency = 0
                        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        nameLabel.Font = Enum.Font.SourceSansBold
                        nameLabel.TextSize = 14
                        nameLabel.Parent = billboard
                    end
                else
                    if billboard then billboard:Destroy() end
                end
            end
        end
    end
end

createKeybindButton(VisualSlide, "Show Name", UDim2.new(0.025, 0, 0, 363), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    ShowNameToggle = state
    updateNames()
end)

local xrayTransparencyPct = 50
local XrayToggle = false
local originalTranspMap = {}
local xrayDescendantConnection = nil

local TranspBox = createStyledTextBox(VisualSlide, "50", UDim2.new(0.025, 0, 0, 396), UDim2.new(0.95, 0, 0, 22))
TranspBox.Text = "Độ mờ X-Ray: 50% (Nhấn để chỉnh)"
TranspBox.TextColor3 = Color3.fromRGB(0, 170, 255)

local TranspSliderFrame = Instance.new("Frame")
TranspSliderFrame.Size = UDim2.new(0.95, 0, 0, 15)
TranspSliderFrame.Position = UDim2.new(0.025, 0, 0, 423)
TranspSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TranspSliderFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
TranspSliderFrame.BorderSizePixel = 1
TranspSliderFrame.Parent = VisualSlide

table.insert(registeredBorders, TranspSliderFrame)

local TranspSliderFill = Instance.new("Frame")
TranspSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
TranspSliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
TranspSliderFill.BorderSizePixel = 0
TranspSliderFill.Parent = TranspSliderFrame

local isDraggingTranspSlider = false

local function isPlayerPart(part)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and part:IsDescendantOf(p.Character) then
            return true
        end
    end
    return false
end

local function applyXrayToPart(part)
    if part:IsA("BasePart") and not isPlayerPart(part) then
        if not originalTranspMap[part] then
            originalTranspMap[part] = part.Transparency
        end
        part.Transparency = xrayTransparencyPct / 100
    end
end

local function updateXrayState()
    if XrayToggle then
        for _, obj in pairs(Workspace:GetDescendants()) do
            applyXrayToPart(obj)
        end
    else
        for part, origTrans in pairs(originalTranspMap) do
            if part and part.Parent then
                part.Transparency = origTrans
            end
        end
        originalTranspMap = {}
    end
end

local function updateTranspFromValue(val)
    val = math.clamp(val, 0, 100)
    xrayTransparencyPct = math.floor(val + 0.5)
    TranspSliderFill.Size = UDim2.new(xrayTransparencyPct / 100, 0, 1, 0)
    TranspBox.Text = "Độ mờ X-Ray: " .. tostring(xrayTransparencyPct) .. "% (Nhấn để chỉnh)"
    if XrayToggle then
        updateXrayState()
    end
end

local function updateTranspFromInput(input)
    local relativeX = input.Position.X - TranspSliderFrame.AbsolutePosition.X
    local pct = math.clamp(relativeX / TranspSliderFrame.AbsoluteSize.X, 0, 1)
    updateTranspFromValue(pct * 100)
end

TranspSliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingTranspSlider = true
        updateTranspFromInput(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingTranspSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateTranspFromInput(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingTranspSlider = false
    end
end)

TranspBox.FocusLost:Connect(function()
    local num = tonumber(TranspBox.Text:match("%d+"))
    if num then
        updateTranspFromValue(num)
    else
        TranspBox.Text = "Độ mờ X-Ray: " .. tostring(xrayTransparencyPct) .. "% (Nhấn để chỉnh)"
    end
end)

local XrayButton, _, XrayFrame = createKeybindButton(VisualSlide, "X-ray", UDim2.new(0.025, 0, 0, 396), UDim2.new(0.95, 0, 0, 28), nil, function(state)
    XrayToggle = state
    updateXrayState()

    if XrayToggle then
        if not xrayDescendantConnection then
            xrayDescendantConnection = Workspace.DescendantAdded:Connect(function(descendant)
                if XrayToggle then
                    task.wait(0.1)
                    applyXrayToPart(descendant)
                end
            end)
        end
    else
        if xrayDescendantConnection then
            xrayDescendantConnection:Disconnect()
            xrayDescendantConnection = nil
        end
    end
end)

local SlideSpawn = createSlide("Spawn")

local SpawnBox = createStyledTextBox(SlideSpawn, "Nhập tên Model...", UDim2.new(0.025, 0, 0, 20), UDim2.new(0.95, 0, 0, 30))

local SpawnUnanchoredBtn = createStyledButton(SlideSpawn, "Triệu hồi (Có tác động lực)", UDim2.new(0.025, 0, 0, 60), UDim2.new(0.95, 0, 0, 30))
local SpawnAnchoredBtn = createStyledButton(SlideSpawn, "Triệu hồi (Không tác động lực)", UDim2.new(0.025, 0, 0, 100), UDim2.new(0.95, 0, 0, 30))
local DeleteModelBtn = createStyledButton(SlideSpawn, "Xóa toàn bộ Model theo tên", UDim2.new(0.025, 0, 0, 140), UDim2.new(0.95, 0, 0, 30))

local function spawnModelLogic(isAnchored)
    local name = SpawnBox.Text
    if name == "" then return end
    
    local char = LocalPlayer.Character
    local spawnPos = char and char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5) or CFrame.new(0, 10, 0)

    local newModel = Instance.new("Model")
    newModel.Name = name

    local part = Instance.new("Part")
    part.Name = "MainPart"
    part.Size = Vector3.new(4, 4, 4)
    part.CFrame = spawnPos
    part.Anchored = isAnchored
    part.CanCollide = true
    part.Material = Enum.Material.SmoothPlastic
    part.Color = Color3.fromRGB(0, 170, 255)
    part.Parent = newModel

    newModel.PrimaryPart = part
    newModel.Parent = Workspace
end

SpawnUnanchoredBtn.MouseButton1Click:Connect(function()
    spawnModelLogic(false)
end)

SpawnAnchoredBtn.MouseButton1Click:Connect(function()
    spawnModelLogic(true)
end)

DeleteModelBtn.MouseButton1Click:Connect(function()
    local name = SpawnBox.Text
    if name == "" then return end
    
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Model") and obj.Name == name then
            obj:Destroy()
        end
    end
end)

local FixLagBtn = createStyledButton(SlideFix, "Chạy Code Fix Lag", UDim2.new(0.025, 0, 0, 20), UDim2.new(0.95, 0, 0, 35))

FixLagBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/chillguy10012011-crypto/Nh-n-j/refs/heads/main/Fix%20lag"))()
    end)
end)



local LT2Btn = createStyledButton(SlideFix, "Chạy Script Kron Hub", UDim2.new(0.025, 0, 0, 65), UDim2.new(0.95, 0, 0, 35))
LT2Btn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0'))()
    end)
end)

local IYBtn = createStyledButton(SlideFix, "Chạy Script Infinite Yield", UDim2.new(0.025, 0, 0, 110), UDim2.new(0.95, 0, 0, 35))
IYBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end)
end)


local SlideUtility = createSlide("Utility")

local ResetAllBtn = createStyledButton(SlideUtility, "Reset all / Stop all", UDim2.new(0.025, 0, 0, 20), UDim2.new(0.95, 0, 0, 40))
ResetAllBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)

ResetAllBtn.MouseButton1Click:Connect(function()
    for _, resetFunc in ipairs(resetCallbacks) do
        pcall(resetFunc)
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local hl = p.Character:FindFirstChild("CustomESPHighlight")
            if hl then hl:Destroy() end
            local head = p.Character:FindFirstChild("Head")
            if head then
                local billboard = head:FindFirstChild("CustomNameBillboard")
                if billboard then billboard:Destroy() end
            end
        end
    end

    if clearTracers then pcall(clearTracers) end
    local char = LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if hrp then
            for _, name in ipairs({"FlyVelocity", "FlyGyro", "AirWalkVelocity"}) do
                local obj = hrp:FindFirstChild(name)
                if obj then obj:Destroy() end
            end
        end
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.WalkSpeed = 16
            pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true) end)
            pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true) end)
            pcall(function() humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, true) end)
        end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
    local floor = Workspace:FindFirstChild("CustomInvisibleFloor")
    if floor then floor:Destroy() end
    if updateXrayState then pcall(updateXrayState) end
end)

local Info = createStyledButton(SlideUtility, "Test GUI mới • Reset All để tắt các toggle", UDim2.new(0.025, 0, 0, 75), UDim2.new(0.95, 0, 0, 35))
Info.Active = false


TranspBox.Visible = false
TranspSliderFrame.Visible = false
addParameterButton(XrayFrame, "Thông số • X-Ray", {{name="Độ mờ (%)", min=0, max=100, get=function() return xrayTransparencyPct end, set=function(v) updateTranspFromValue(v) end}})

-- // SETTINGS WINDOW ĐỘC LẬP
-- Cửa sổ này tách hoàn toàn khỏi MainFrame, có thể kéo thả riêng.
local SettingsGui = Instance.new("ScreenGui")
SettingsGui.Name = "ControlPanelSettings"
SettingsGui.ResetOnSpawn = false
SettingsGui.DisplayOrder = 999
pcall(function() SettingsGui.Parent = CoreGui end)
if not SettingsGui.Parent then SettingsGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local SettingsWindow = Instance.new("Frame")
SettingsWindow.Name = "SettingsWindow"
SettingsWindow.Size = UDim2.new(0, 330, 0, 355)
SettingsWindow.Position = UDim2.new(0.5, -165, 0.5, -177)
SettingsWindow.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SettingsWindow.BorderColor3 = Color3.fromRGB(0, 170, 255)
SettingsWindow.BorderSizePixel = 2
SettingsWindow.Visible = false
SettingsWindow.Parent = SettingsGui

local SettingsTop = Instance.new("Frame")
SettingsTop.Size = UDim2.new(1, 0, 0, 34)
SettingsTop.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SettingsTop.BorderColor3 = Color3.fromRGB(0, 170, 255)
SettingsTop.BorderSizePixel = 1
SettingsTop.Parent = SettingsWindow

enableDragging(SettingsWindow, SettingsTop)

local SettingsWindowTitle = Instance.new("TextLabel")
SettingsWindowTitle.Size = UDim2.new(1, -42, 1, 0)
SettingsWindowTitle.Position = UDim2.new(0, 10, 0, 0)
SettingsWindowTitle.BackgroundTransparency = 1
SettingsWindowTitle.Text = "⚙  GUI SETTINGS"
SettingsWindowTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
SettingsWindowTitle.Font = Enum.Font.SourceSansBold
SettingsWindowTitle.TextSize = 16
SettingsWindowTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsWindowTitle.Parent = SettingsTop

local SettingsWindowClose = Instance.new("TextButton")
SettingsWindowClose.Size = UDim2.new(0, 34, 0, 34)
SettingsWindowClose.Position = UDim2.new(1, -34, 0, 0)
SettingsWindowClose.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
SettingsWindowClose.Text = "X"
SettingsWindowClose.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsWindowClose.Font = Enum.Font.SourceSansBold
SettingsWindowClose.TextSize = 14
SettingsWindowClose.Parent = SettingsTop

local SettingsContent = Instance.new("ScrollingFrame")
SettingsContent.Size = UDim2.new(1, -12, 1, -46)
SettingsContent.Position = UDim2.new(0, 6, 0, 40)
SettingsContent.BackgroundTransparency = 1
SettingsContent.BorderSizePixel = 0
SettingsContent.ScrollBarThickness = 4
SettingsContent.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsContent.Parent = SettingsWindow

local SettingsLayout = Instance.new("UIListLayout")
SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
SettingsLayout.Padding = UDim.new(0, 7)
SettingsLayout.Parent = SettingsContent

local function settingsLabel(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -8, 0, 22)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(0, 170, 255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = SettingsContent
    return label
end

local function settingsButton(text)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderColor3 = Color3.fromRGB(0, 170, 255)
    btn.BorderSizePixel = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = SettingsContent
    return btn
end

-- STYLE
settingsLabel("Kiểu dáng GUI")
local StyleRow = Instance.new("Frame")
StyleRow.Size = UDim2.new(1, -8, 0, 34)
StyleRow.BackgroundTransparency = 1
StyleRow.Parent = SettingsContent

local DefaultStyleBtn = Instance.new("TextButton")
DefaultStyleBtn.Size = UDim2.new(0.49, -3, 1, 0)
DefaultStyleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
DefaultStyleBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
DefaultStyleBtn.Text = "Mặc định"
DefaultStyleBtn.TextColor3 = Color3.fromRGB(255,255,255)
DefaultStyleBtn.Font = Enum.Font.SourceSansBold
DefaultStyleBtn.TextSize = 14
DefaultStyleBtn.Parent = StyleRow

local Gui1StyleBtn = Instance.new("TextButton")
Gui1StyleBtn.Size = UDim2.new(0.49, -3, 1, 0)
Gui1StyleBtn.Position = UDim2.new(0.51, 0, 0, 0)
Gui1StyleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Gui1StyleBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
Gui1StyleBtn.Text = "GUI 1"
Gui1StyleBtn.TextColor3 = Color3.fromRGB(255,255,255)
Gui1StyleBtn.Font = Enum.Font.SourceSansBold
Gui1StyleBtn.TextSize = 14
Gui1StyleBtn.Parent = StyleRow

DefaultStyleBtn.MouseButton1Click:Connect(function()
    DefaultStyleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    Gui1StyleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    setGuiStyle("Default")
end)

Gui1StyleBtn.MouseButton1Click:Connect(function()
    Gui1StyleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    DefaultStyleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    setGuiStyle("GUI1")
end)

-- MÀU GUI
local colorList = {
    Color3.fromRGB(35, 35, 35), Color3.fromRGB(20, 20, 20), Color3.fromRGB(50, 50, 50),
    Color3.fromRGB(0, 170, 255), Color3.fromRGB(255, 85, 85), Color3.fromRGB(85, 255, 85),
    Color3.fromRGB(255, 255, 85), Color3.fromRGB(170, 85, 255), Color3.fromRGB(255, 170, 0),
    Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 105, 180)
}

local function createSettingsPalette(titleText, callback)
    settingsLabel(titleText)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -8, 0, 52)
    holder.BackgroundTransparency = 1
    holder.Parent = SettingsContent

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0, 25, 0, 20)
    grid.CellPadding = UDim2.new(0, 5, 0, 5)
    grid.Parent = holder

    for _, color in ipairs(colorList) do
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = color
        btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 1
        btn.Text = ""
        btn.Parent = holder
        btn.MouseButton1Click:Connect(function()
            callback(color)
        end)
    end
end

createSettingsPalette("Màu nền GUI", function(color)
    applyTheme(color, nil, nil)
    SettingsWindow.BackgroundColor3 = color
end)

createSettingsPalette("Màu viền GUI", function(color)
    applyTheme(nil, color, nil)
    SettingsWindow.BorderColor3 = color
    SettingsTop.BorderColor3 = color
end)

createSettingsPalette("Màu chữ GUI", function(color)
    applyTheme(nil, nil, color)
    SettingsWindowTitle.TextColor3 = color
end)

local ResetColorBtn = settingsButton("Khôi phục màu mặc định")
ResetColorBtn.MouseButton1Click:Connect(function()
    local bg = Color3.fromRGB(35, 35, 35)
    local border = Color3.fromRGB(0, 170, 255)
    local text = Color3.fromRGB(255, 255, 255)
    applyTheme(bg, border, text)
    SettingsWindow.BackgroundColor3 = bg
    SettingsWindow.BorderColor3 = border
    SettingsTop.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SettingsTop.BorderColor3 = border
    SettingsWindowTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
end)

SettingsBtn.MouseButton1Click:Connect(function()
    SettingsWindow.Visible = not SettingsWindow.Visible
end)

SettingsWindowClose.MouseButton1Click:Connect(function()
    SettingsWindow.Visible = false
end)

-- Dọn cửa sổ Settings cũ: không dùng nữa, chỉ giữ để tương thích với phần code theme cũ.
SettingsPanel.Visible = false

-- // COMPACT LAYOUT
local function compactContainer(container, topPadding, gap, skipHidden)
    topPadding = topPadding or 8
    gap = gap or 4
    local items = {}
    for _, child in ipairs(container:GetChildren()) do
        if child:IsA("GuiObject") and child.Position.Y.Scale == 0 then
            -- Bỏ qua phần tử đang ẩn để không chừa khoảng trống
            if not (skipHidden and not child.Visible) then
                table.insert(items, child)
            end
        end
    end
    table.sort(items, function(a, b)
        return a.Position.Y.Offset < b.Position.Y.Offset
    end)
    local y = topPadding
    for _, child in ipairs(items) do
        child.Position = UDim2.new(child.Position.X.Scale, child.Position.X.Offset, child.Position.Y.Scale, y)
        y = y + child.Size.Y.Offset + gap
    end
    if container:IsA("ScrollingFrame") then
        container.CanvasSize = UDim2.new(0, 0, 0, math.max(0, y + 8))
    end
end

compactContainer(SlideMovement, 8, 4, true)
compactContainer(VisualSlide, 8, 4, true)
compactContainer(SlideSpawn, 8, 4, true)
compactContainer(SlideFix, 8, 4, true)
compactContainer(SlideUtility, 8, 4, true)

-- // MẶC ĐỊNH MỞ PLAYER
for _, s in pairs(slides) do s.Visible = false end
if slides["Player"] then slides["Player"].Visible = true end
SettingsPanel.Visible = false
SettingsWindow.Visible = false

setGuiStyle("Default")
