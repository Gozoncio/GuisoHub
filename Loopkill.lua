game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Gui By Guiso",
    Text = "Loading...",
    Icon = "rbxassetid://105175546096"
})

local h = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local e = h.CreateLib("Guiso's Gui", "DarkTheme")
local p = e:NewTab("Main")
local eh = p:NewSection("Looking/AntiRagdoll/AntiFling")
eh:NewButton("Activate", "Toggles Looking", function()
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "Looking Enabled",
        Color = Color3.fromRGB(227, 27, 27),
        Font = Enum.Font.GothamBold,
        FontSize = Enum.FontSize.Size18
    })

    local r = '/'
    repeat wait() until game.Loaded
    local s = game:GetService('Players')
    local ma = s.LocalPlayer
    local d = false
    local t = {}
    local o = {}

    local function a(m)
        if game:GetService('Players'):FindFirstChild(m) then
            return game:GetService('Players'):FindFirstChild(m)
        else
            if m ~= nil and m ~= "" and m ~= " " and m then
                local g = m
                local j = false
                for _,v in pairs(game:GetService('Players'):GetPlayers()) do
                    if not j and (v.Name:lower():sub(1,#g) == g:lower() or v.DisplayName:lower():sub(1,#g) == g:lower()) then
                        g = v
                        j = true
                    end
                end
                if g ~= nil and g ~= m then
                    return g
                end
            end
        end
    end

    ma.Chatted:Connect(function(n)
        n = n:lower():split(' ')
        if n[1] == '/e' then
            for i,v in next,n do
                n[i] = n[i+1]
            end
        end
        if n[1] == r..'lka' or (n[1] == r..'loop' and n[2] == 'all') then
            d = true
        elseif n[1] == r..'kill' and a(n[2]) and not table.find(o,a(n[2]).Name) then
            table.insert(o,a(n[2]).Name)
        elseif n[1] == r..'wl' and a(n[2]) and not table.find(t,a(n[2]).Name) then
            table.insert(t,a(n[2]).Name)
        elseif n[1] == r..'bl' and a(n[2]) and table.find(t,a(n[2]).Name) then
            table.remove(t,a(n[2]).Name)
        elseif n[1] == r..'resurrect' then
            table.clear(o)
            d = false
            pcall(function()
                ma.Character.PuttingDown:FireServer()
            end)
        end
    end)

    spawn(function()
        while true do
            wait()
            pcall(function()
                if ma.Character.Ragdoll.Value then
                    ma.Character.GetUpEvent:FireServer()
                end
            end)
            pcall(function()
                for _,_2 in next,ma.Character:GetChildren() do
                    pcall(function()
                        if _2:IsA('Accessory') and _2.Name ~= 'FakeAccessory' and _2:FindFirstChild('Handle') and _2.Handle:FindFirstChildOfClass('Weld') then
                            local c = _2:Clone()
                            _2:Destroy()
                            c.Name = 'FakeAccessory'
                            c.Parent = ma.Character
                        end
                    end)
                    pcall(function()
                        if _2.Name == 'VelocityDamage' or _2.Name == 'GetPicked' then
                            _2:Destroy()
                        end
                    end)
                end
            end)
        end
    end)

    while true do
        wait(0.1)
        if d then
            for _,v in next,s:GetPlayers() do
                if v ~= ma and not table.find(t,v.Name) then
                    pcall(function()
                        ma.Character.Picking:FireServer(v.Character.HumanoidRootPart,Vector3.new(math.huge,-math.huge,math.huge))
                        wait(0.05)
                        ma.Character.PuttingDown:FireServer()
                    end)
                end
            end
        end
        if #o ~= 0 then
            for _,v in next,s:GetPlayers() do
                if table.find(o,v.Name) then
                    pcall(function()
                        local _ = v.Character:FindFirstChildOfClass('Accessory')
                        if _ then
                            if _:FindFirstChild('Handle') then
                                ma.Character.Picking:FireServer(_.Handle,Vector3.new(math.huge,-math.huge,math.huge))
                            elseif _:IsA('BasePart') then
                                ma.Character.Picking:FireServer(_,Vector3.new(math.huge,-math.huge,math.huge))
                            end
                        else
                            ma.Character.Picking:FireServer(v.Character.HumanoidRootPart,Vector3.new(math.huge,-math.huge,math.huge))
                            wait(0.1)
                            ma.Character.PuttingDown:FireServer()
                        end
                    end)
                end
            end
        end
    end
end)

eh:NewTextBox("Player Name", "Kill Command", function(f)
    game.Players:Chat('/kill '..f)
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "Killing",
        Color = Color3.fromRGB(227, 27, 27),
        Font = Enum.Font.GothamBold,
        FontSize = Enum.FontSize.Size18
    })
end)

eh:NewButton("Loopkill All", "Toggles Loopkill All", function()
    game.Players:Chat("/lka")
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "Killing All",
        Color = Color3.fromRGB(227, 27, 27),
        Font = Enum.Font.GothamBold,
        FontSize = Enum.FontSize.Size18
    })
end)

local eh = p:NewSection("Instant Respawn")
eh:NewButton("Activate", "Respawn Top Left", function()
    local ma = game.Players.LocalPlayer
    local nm = ma:GetMouse()
    local b = game:GetService('RunService')
    local k = game:GetService('VirtualInputManager')
    pcall(function()
        local hf = ma.PlayerGui.DeathMenu.Frame.Button.TextButton
        hf.Parent = ma.PlayerGui.DeathMenu
        hf.Size = UDim2.new(0.1,0,0.05,0)
        hf.Position = UDim2.new(0.1,0,0,0)
        hf.TextScaled = true
    end)
    ma.CharacterAdded:Connect(function()
        repeat
            b.RenderStepped:wait()
        until ma:FindFirstChild('PlayerGui') and ma.PlayerGui:FindFirstChild('DeathMenu') and ma.PlayerGui.DeathMenu:FindFirstChild('Frame') and ma.PlayerGui.DeathMenu.Frame:FindFirstChild('Button') and ma.PlayerGui.DeathMenu.Frame.Button:FindFirstChild('TextButton')
        local hf = ma.PlayerGui.DeathMenu.Frame.Button.TextButton
        hf.Parent = ma.PlayerGui.DeathMenu
        hf.Size = UDim2.new(0.1,0,0.05,0)
        hf.Position = UDim2.new(0.1,0,0,0)
        hf.TextScaled = true
    end)
end)

local eh = p:NewSection("Whitelist/Blacklist")
eh:NewTextBox("Whitelist", "Prevents lka of player", function(f)
    game.Players:Chat('/wl '..f)
end)

eh:NewTextBox("Blacklist", "Undo whitelist", function(f)
    game.Players:Chat('/bl '..f)
end)

local pe = e:NewTab("Secondary")
local sr = pe:NewSection("Infinite Yield")
sr:NewButton("Activate", "Executes Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

local sr = pe:NewSection("Rejoin")
sr:NewButton("Activate", "Rejoins Current Server", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/1gtVMUz3"))()
end)

local sr = pe:NewSection("Player Movement")
sr:NewButton("Remove Animations", "Removes Animations", function()
    local dq = game.Players.LocalPlayer
    pcall(function()
        dq.Character.Animate.Disabled = true
    end)
end)

sr:NewButton("Disable Body Follow Mouse", "Locks Body in place", function()
    local dq = game.Players.LocalPlayer
    pcall(function()
        dq.Character.BodyFollowMouse.Disabled = true
    end)
end)

local td = e:NewTab("Key Binds")
local ot = td:NewSection("Key Binds")
ot:NewKeybind("Close/Open Gui Bind", "Keybind to close/open Gui", Enum.KeyCode.E, function()
    h:ToggleUI()
end)

ot:NewKeybind("UI Toggle", "Keybind to Toggle UI", Enum.KeyCode.T, function()
    h:ToggleUI()
end)

ot:NewKeybind("Loopkill All", "Toggles Loopkill All", Enum.KeyCode.L, function()
    game.Players:Chat("/lka")
end)

ot:NewKeybind("Rejoin Server", "Rejoins Current Server", Enum.KeyCode.Backquote, function()
    loadstring(game:HttpGet("https://pastebin.com/raw/1gtVMUz3"))()
end)

local ms = td:NewSection("Misc Keybinds")
ms:NewKeybind("Remove Animations", "Removes Animations", Enum.KeyCode.F, function()
    local dq = game.Players.LocalPlayer
    pcall(function()
        dq.Character.Animate.Disabled = true
    end)
end)

ms:NewKeybind("Disable Body Follow Mouse", "Locks Body in place", Enum.KeyCode.B, function()
    local dq = game.Players.LocalPlayer
    pcall(function()
        dq.Character.BodyFollowMouse.Disabled = true
    end)
end)

local ms = td:NewSection("Credits")
ms:NewButton("Copy Script", "Copies the Script", function()
    game.Players:Chat("/lka")
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "Killing All",
        Color = Color3.fromRGB(227, 27, 27),
        Font = Enum.Font.GothamBold,
        FontSize = Enum.FontSize.Size18
    })
end)
