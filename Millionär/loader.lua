local License = getgenv().Key

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local LuaName = "Millionär whitelist"

loadstring(game:HttpGet("https://raw.githubusercontent.com/Firoxus/i-love-you-cheese/main/Millionär/AntiAntiCheat.lua"))()

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = "Intializing Authentication...",
	Duration = 5
})

local initialized = false
local sessionid = ""


Name = "MILLIONÄR" --* Application Name
Ownerid = "57F8I2y2Sl" --* OwnerID
APPVersion = "1.0" --* Application Version

local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=init&ver=' .. APPVersion)

if req == "KeyAuth_Invalid" then 
   print(" Error: Application not found.")

   StarterGui:SetCore("SendNotification", {
	   Title = LuaName,
	   Text = " Error: Application not found.",
	   Duration = 3
   })

   return false
end

local data = HttpService:JSONDecode(req)

if data.success == true then
   initialized = true
   sessionid = data.sessionid
   --print(req)
elseif (data.message == "invalidver") then
   print(" Error: Wrong application version..")

   StarterGui:SetCore("SendNotification", {
	   Title = LuaName,
	   Text = " Error: Wrong application version..",
	   Duration = 3
   })

   return false
else
   print(" Error: " .. data.message)
   return false
end

print("\n\n Licensing... \n")
local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=license&key=' .. License ..'&ver=' .. APPVersion .. '&sessionid=' .. sessionid)
local data = HttpService:JSONDecode(req)


if data.success == false then 
    StarterGui:SetCore("SendNotification", {
	    Title = LuaName,
	    Text = " Error: " .. data.message,
	    Duration = 5
    })

    return false
end

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = "Whitelisted! Enjoy Millionär.",
	Duration = 5
})

function CheckStatus(param)
    if param == "visualc0de" or "dhscripts1" or "l4ost" then
        return "Special"
    end
    return "Whitelisted"
end

function GetSubPrefix(str)
    local str = tostring(str):gsub(" ","")
    local var = ""
    --
    if #str == 2 then
        local sec = string.sub(str,#str,#str+1)
        var = sec == "1" and "st" or sec == "2" and "nd" or sec == "3" and "rd" or "th"
    end
    --
    return var
end

local title_string = "Millionär | ".. game.Players.LocalPlayer.DisplayName .." | %A, %B"
local day = os.date(" %d", os.time())
local second_string = ", %Y."
title_string = os.date(title_string, os.time())..day..GetSubPrefix(day)..os.date(second_string, os.time())

local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInput = game:GetService("UserInputService")



_G.FakeAnim1 = game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId
_G.FakeAnim2 = game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId
_G.FakeAnim3 = game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId


getgenv().taffy_esp = {
    box = {
        enabled1 = true,
        enabled = false,
        outline = false,
        healthbar = false,
        color1 = Color3.fromRGB(255, 255, 255),
        color2 = Color3.fromRGB(0, 0, 0),
        healthbarcolor = Color3.fromRGB(4, 0, 255)
    },
    tracer = {
        enabled = false,
        unlocktracers = false,
        color = Color3.fromRGB(255, 255, 255)
    },
    name = {
        enabled = false,
        outline = false,
        size = 13,
        font = 2,
        color = Color3.fromRGB(255, 255, 255)
    },
    misc = {
        teamcheck = false,
        useteamcolors = false,
        visibleonly = true
    },
    Toolsshow = {
        enable = false,
        outline = false,
        size = 8,
        font = 3,
        color = Color3.fromRGB(147, 39, 161)
    }
}

function esp(v)
    -- box --
    local BLOCKOUTLINE = Drawing.new("Square")
    BLOCKOUTLINE.Visible = false
    BLOCKOUTLINE.Color = Color3.new(0,0,0)
    BLOCKOUTLINE.Thickness = 3
    BLOCKOUTLINE.Transparency = 1
    BLOCKOUTLINE.Filled = false

    local BOXPLAYER = Drawing.new("Square")
    BOXPLAYER.Visible = false
    BOXPLAYER.Color = taffy_esp.box.color1
    BOXPLAYER.Thickness = 1
    BOXPLAYER.Transparency = 1
    BOXPLAYER.Filled = false

    local HealthBarOUTLINE = Drawing.new("Square")
    HealthBarOUTLINE.Thickness = 3
    HealthBarOUTLINE.Filled = false
    HealthBarOUTLINE.Color = Color3.new(0,0,0)
    HealthBarOUTLINE.Transparency = 1
    HealthBarOUTLINE.Visible = false

    local HealthBarITSELF = Drawing.new("Square")
    HealthBarITSELF.Thickness = 1
    HealthBarITSELF.Filled = false
    HealthBarITSELF.Transparency = 1
    HealthBarITSELF.Visible = false
    
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1,1,1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1

    local Name = Drawing.new("Text")
    Name.Transparency = 1
    Name.Visible = false
    Name.Color = taffy_esp.name.color
    Name.Size = 16
    Name.Center = true
    Name.Outline = false
    Name.Font = 2
    Name.Text = "name [100/100]"

    local toolshow = Drawing.new("Text")
    toolshow.Transparency = 1
    toolshow.Visible = false
    toolshow.Color = getgenv().taffy_esp.Toolsshow.color
    toolshow.Size = 16
    toolshow.Center = true
    toolshow.Outline = false
    toolshow.Font = 2
    toolshow.Text = ""
game:GetService("RunService").RenderStepped:Connect(function()
        if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health  > 0 and (not taffy_esp.misc.teamcheck or v.TeamColor == lplr.TeamColor) then
            local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local Distance = (CurrentCamera.CFrame.p - v.Character.HumanoidRootPart.Position).Magnitude
            local RootPart = v.Character.HumanoidRootPart
            local Head = v.Character.Head
            local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
            local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + Vector3.new(0,0.5,0))
            local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - Vector3.new(0,3,0))
            if (not taffy_esp.misc.visibleonly or onScreen) then
                if taffy_esp.box.enabled1 then
                    BLOCKOUTLINE.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BLOCKOUTLINE.Position = Vector2.new(RootPosition.X - BLOCKOUTLINE.Size.X / 2, RootPosition.Y - BLOCKOUTLINE.Size.Y / 2)
                    BLOCKOUTLINE.Visible = taffy_esp.box.outline
                    BLOCKOUTLINE.Color = taffy_esp.box.color2
    
                    BOXPLAYER.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BOXPLAYER.Position = Vector2.new(RootPosition.X - BOXPLAYER.Size.X / 2, RootPosition.Y - BOXPLAYER.Size.Y / 2)
                    BOXPLAYER.Visible = taffy_esp.box.enabled
                    if not taffy_esp.misc.useteamcolors then
                        local color = v.TeamColor
                        BOXPLAYER.Color = taffy_esp.box.color1
                    else
                        BOXPLAYER.Color = taffy_esp.box.color1
                    end
                        
                    HealthBarOUTLINE.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                    HealthBarOUTLINE.Position = HealthBarOUTLINE.Position - Vector2.new(6,0)
                    HealthBarOUTLINE.Visible = taffy_esp.box.outline
    
                    HealthBarITSELF.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (v.Character.Humanoid.MaxHealth / math.clamp(v.Character.Humanoid.Health, 0,v.Character.Humanoid.MaxHealth)))
                    HealthBarITSELF.Position = Vector2.new(BOXPLAYER.Position.X - 5, BOXPLAYER.Position.Y + (1 / HealthBarITSELF.Size.Y))
                    HealthBarITSELF.Color = taffy_esp.box.healthbarcolor
                    HealthBarITSELF.Visible = taffy_esp.box.healthbar
                    
                    
                    
                    
                else
                    BLOCKOUTLINE.Visible = false
                    BOXPLAYER.Visible = false
                    HealthBarOUTLINE.Visible = false
                    HealthBarITSELF.Visible = false
                end
                if taffy_esp.tracer.enabled then
                    if taffy_esp.tracer.unlocktracers then
                        Tracer.From = Vector2.new(mouse.X, mouse.Y + 36)
                    else
                        Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    end
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
                    Tracer.Visible = taffy_esp.tracer.enabled
                    if not taffy_esp.misc.useteamcolors then
                        local color = v.TeamColor
                        Tracer.Color = taffy_esp.tracer.color
                    else
                        Tracer.Color = taffy_esp.tracer.color
                    end
                else
                    Tracer.Visible = false
                end

                if taffy_esp.Toolsshow.enable then
                      local Equipped = v.Character:FindFirstChildOfClass("Tool") and v.Character:FindFirstChildOfClass("Tool").Name or "None"
                    toolshow.Text = Equipped
                    toolshow.Position = Vector2.new(workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).X, workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).Y + 30)
                    toolshow.Color = getgenv().taffy_esp.Toolsshow.color
                    toolshow.Font = 3
                    Name.Size = taffy_esp.Toolsshow.size
                    toolshow.Visible = true
                    else
                        toolshow.Visible = false
                end


                if taffy_esp.name.enabled then
                    Name.Text = tostring(v.Character.Humanoid.DisplayName).. " [" .. tostring(math.floor(v.Character.Humanoid.Health + 0.5)) .. "/" .. tostring(v.Character.Humanoid.MaxHealth) .. "]"
                    Name.Position = Vector2.new(workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).X, workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).Y - 30)
                    Name.Visible = true
                    Name.Size = taffy_esp.name.size
                    if not taffy_esp.misc.useteamcolors then
                        local color = v.TeamColor
                        Name.Color = taffy_esp.name.color
                    else
                        Name.Color = taffy_esp.name.color
                    end
                    Name.Outline = taffy_esp.name.outline
                else
                    Name.Visible = false
                end
            else
                BLOCKOUTLINE.Visible = false
                BOXPLAYER.Visible = false
                toolshow.Visible=false
                HealthBarOUTLINE.Visible = false
                HealthBarITSELF.Visible = false
                Tracer.Visible = false
                Name.Visible = false
            end
        else
            toolshow.Visible=false
            BLOCKOUTLINE.Visible = false
            BOXPLAYER.Visible = false
            HealthBarOUTLINE.Visible = false
            HealthBarITSELF.Visible = false
            Tracer.Visible = false
            Name.Visible = false
        end
    end)
end

for i,v in pairs(game.Players:GetChildren()) do
    esp(v)
end

game.Players.PlayerAdded:Connect(function(v)
    esp(v)
end)

local azure = {
    UISettings = {
        Rainbow = nil
    },
    Aiming = {
        Aimbot = {
            Enabled = nil,
            Prediction = nil,
            Hitbox = nil,
            Smoothing = {
                Enabled = nil,
                Value = nil
            },
            VelocityResolver = nil,
            ReverseResolver = nil,
            Alerts = nil
        },
        Target = {
            Enabled = nil,
            Prediction = nil,
            Hitbox = nil,
            Alerts = nil,
            Tracer = {
                Enabled = nil,
                Color = nil,
                From = nil,
            },
            PingBased = nil,
            Highlight = {
                Enabled = nil,
                FillColor = nil,
                OutlineColor = nil
            },
            LookAt = nil,
            ViewAt = nil,
            FakeHitbox = {
                Enabled = nil,
                Color = nil,
                Size = nil,
                Material = nil
            },
            Offset = {
                Y = nil
            },
            Dot = {
                Enabled = nil,Color = nil
            }
        },
        WristPos = {
            Enabled = nil,
            Distance = nil
        },
        TargetStrafe = {
            Enabled = nil,
            Speed = nil,
            Distance = nil,
            Height = nil,
            Visualize = {
                Enabled = nil,
                Color = nil
            }
        }
    },
    Blatant = {
        CFrame = {
            Enabled = nil,
            Value = nil
        },
        Exploits = {
            AutoStomp = nil,
            AntiBag = nil,
            NoSlow = nil,
            JumpCooldown = nil
        },
        AntiStomp = {
            Enabled = nil,
            Type = nil
        },
        FakeLag = {
            Enabled = nil,
            Duration = nil
        },
        AntiAim = {
            SemiLegit = nil,
            VelocityUnderGround = nil,
            VelocityUnderGroundAmount = nil,
            RotVelocity = {
                Enabled = nil,Value = nil
            }
        },
        GunMod = {
            AutoReload = nil
        },
        ToolReach = nil
    },
    Visuals = {
        Local = {
            Chams = nil,
            Highlight = {
                Enabled = nil,
                FillColor = nil,
                OutlineColor = nil,
            },
            CloneChams = {
                Enabled = nil,
                Duration = nil,
                Color = nil,
                Material = nil
            }
        },
    }
}
   

local LocalPlayer = game.Players.LocalPlayer

local LocalPlayerObjs = {
    Mouse = LocalPlayer:GetMouse()
}

local RunService = game:GetService("RunService")

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Millionär | ' .. game.Players.LocalPlayer.DisplayName,
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    Aiming = Window:AddTab('Aiming'), 
    Blatant = Window:AddTab('Blatant'),
    Visuals = Window:AddTab('Visuals'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('Settings'),
}


local AimbotTab = Tabs.Aiming:AddLeftGroupbox('Aimbot')
local TargetTab = Tabs.Aiming:AddRightGroupbox('Target Aim')
local WristPosXOther = Tabs.Aiming:AddLeftTabbox()
local WristPositionTab = WristPosXOther:AddTab('Wrist Position')
local StrafeTab = WristPosXOther:AddTab('Strafe')

local ExploitsTab = Tabs.Blatant:AddLeftGroupbox('Exploits')
local FlyTab = Tabs.Blatant:AddRightGroupbox('Fly')
local CFrameTab = Tabs.Blatant:AddRightGroupbox('CFrame')
local AntiStompTab = Tabs.Blatant:AddLeftGroupbox('Anti-Stomp')
local GunModTab = Tabs.Blatant:AddLeftGroupbox('Gun Modification')
local FakeLagTab = Tabs.Blatant:AddRightGroupbox('Fake Lag')
local AntiAimTab = Tabs.Blatant:AddRightGroupbox('Anti Aim')
local SpinbotTab = Tabs.Blatant:AddLeftGroupbox('Spinbot')
local fakeanimTab = Tabs.Blatant:AddLeftGroupbox('FakeAnimations (AA)')
local removehitboxTab = Tabs.Blatant:AddRightGroupbox('Remove Hitbox')


local LocalTab = Tabs.Visuals:AddRightGroupbox('Character')
local FOVTag = Tabs.Visuals:AddRightGroupbox('FOV')
local CrosshairTab = Tabs.Visuals:AddRightGroupbox('Crosshair')
local ESPTab = Tabs.Visuals:AddLeftGroupbox('ESP')
local WorldTab = Tabs.Visuals:AddLeftGroupbox('World')
local SkyboxTab = Tabs.Visuals:AddRightGroupbox('Sky box')

local AnimationsTab = Tabs.Misc:AddLeftGroupbox('Animations')

AnimationsTab:AddLabel("Don't change animations while moving")
local TeleportTab = Tabs.Misc:AddRightGroupbox('Teleports')

local OtherGroupbox = Tabs["UI Settings"]:AddRightGroupbox('Other')

AimbotTab:AddToggle('AimbotEnabledTggle', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Enable Aimbot',
})

Toggles.AimbotEnabledTggle:OnChanged(function()
    azure.Aiming.Aimbot.Enabled = Toggles.AimbotEnabledTggle.Value
end)

Toggles.AimbotEnabledTggle:AddKeyPicker('AimbotKeyPickerXD', {
    Default = 'None', 
    SyncToggleState = false, 

    Mode = 'Toggle',

    Text = 'Aimbot', 
    NoUI = false,
})

Options.AimbotKeyPickerXD:OnClick(function()
    if azure.Aiming.Aimbot.Enabled then
        AimbotBindEnabled = not AimbotBindEnabled
        if AimbotBindEnabled then
            AimbotTarget = AimbotGetTarget()
            if azure.Aiming.Aimbot.Alerts then
                Library:Notify("Aiming : "..tostring(AimbotTarget.Character.Humanoid.DisplayName))
            end
        elseif not AimbotBindEnabled then
            if azure.Aiming.Aimbot.Alerts then
                Library:Notify("Unaiming : "..tostring(AimbotTarget.Character.Humanoid.DisplayName))
            end
        end
    end
end)

AimbotTab:AddInput('AimbotPredictionTextbox', {
    Default = '',
    Numeric = false,
    Finished = false,

    Text = 'Prediction',
    Tooltip = 'Aimbot Prediction',

    Placeholder = 'Example = 7', 
})

Options.AimbotPredictionTextbox:OnChanged(function()
    azure.Aiming.Aimbot.Prediction = Options.AimbotPredictionTextbox.Value
end)

AimbotTab:AddToggle('AimbotDrawFOVTggle', {
    Text = 'Draw FOV',
    Default = false, 
    Tooltip = 'Enable Aimbot FOV', 
})

Toggles.AimbotDrawFOVTggle:OnChanged(function()
    AimbotDrawFOV = Toggles.AimbotDrawFOVTggle.Value
end)

Toggles.AimbotDrawFOVTggle:AddColorPicker('LocalHighlxxxxxxxxxxightFillColorColorPicker', {
    Default = Color3.fromRGB(255,0,0),
    Title = 'Aimbot FOV Color'
})

Options.LocalHighlxxxxxxxxxxightFillColorColorPicker:OnChanged(function()
    AimbotFOVClr = Options.LocalHighlxxxxxxxxxxightFillColorColorPicker.Value
end)

AimbotTab:AddSlider('AimbotFOVSizex', {
    Text = 'Aimbot FOV',

    Default = 5,
    Min = 1,
    Max = 5,
    Rounding = 2,

    Compact = false,
})

Options.AimbotFOVSizex:OnChanged(function()
    AimbotFOVSize = Options.AimbotFOVSizex.Value*100
end)

AimbotTab:AddDropdown('AimbotHitboxDropdownn', {
    Values = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 2,
    Multi = false,

    Text = 'Hitbox',
    Tooltip = 'Aimbot Hitbox',
})

Options.AimbotHitboxDropdownn:OnChanged(function()
    azure.Aiming.Aimbot.Hitbox = Options.AimbotHitboxDropdownn.Value
end)

AimbotTab:AddToggle('AimbotAlertsTggl', {
    Text = 'Alerts',
    Default = false,
    Tooltip = 'Enable Aimbot Alerts',
})

Toggles.AimbotAlertsTggl:OnChanged(function()
    azure.Aiming.Aimbot.Alerts = Toggles.AimbotAlertsTggl.Value
end)

AimbotTab:AddToggle('AimbotVelocityResolverToggle', {
    Text = 'Velocity Resolver',
    Default = false,
    Tooltip = 'Enable Aimbot Velocity Resolver',
})

Toggles.AimbotVelocityResolverToggle:OnChanged(function()
    azure.Aiming.Aimbot.VelocityResolver = Toggles.AimbotVelocityResolverToggle.Value
end)

AimbotTab:AddToggle('ReverseResolverAimbotTggle', {
    Text = 'Reverse Resolver',
    Default = false,
    Tooltip = 'Enable Aimbot Reverse Resolver',
})

Toggles.ReverseResolverAimbotTggle:OnChanged(function()
    azure.Aiming.Aimbot.ReverseResolver = Toggles.ReverseResolverAimbotTggle.Value
end)

AimbotTab:AddToggle('AimbotSmoothingTggle', {
    Text = 'Enable Smoothing',
    Default = false,
    Tooltip = 'Enable Aimbot Smoothing',
})

Toggles.AimbotSmoothingTggle:OnChanged(function()
    azure.Aiming.Aimbot.Smoothing.Enabled = Toggles.AimbotSmoothingTggle.Value
end)

AimbotTab:AddInput('AimbotSmoothingTextBox', {
    Default = '',
    Numeric = false,
    Finished = false,

    Text = 'Smoothing Value',
    Tooltip = 'Smoothing Value',

    Placeholder = 'Example = 0.01', 
})

Options.AimbotSmoothingTextBox:OnChanged(function()
    azure.Aiming.Aimbot.Smoothing.Value = Options.AimbotSmoothingTextBox.Value
end)

--// target
TargetTab:AddToggle('TargetEnabledToggle', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Enable Target',
})

Toggles.TargetEnabledToggle:OnChanged(function()
    azure.Aiming.Target.Enabled = Toggles.TargetEnabledToggle.Value
end)

Toggles.TargetEnabledToggle:AddKeyPicker('TargetKeyPickerXD', {
    Default = 'None', 
    SyncToggleState = false, 

    Mode = 'Toggle',

    Text = 'Target Aim', 
    NoUI = false,
})

Options.TargetKeyPickerXD:OnClick(function()
    if azure.Aiming.Target.Enabled then
        TargetBindEnabled = not TargetBindEnabled
        if TargetBindEnabled then
            TargetTarget = TargetGetTarget()
            if azure.Aiming.Target.Alerts then
                Library:Notify("Targeting : "..tostring(TargetTarget.Character.Humanoid.DisplayName))
            end
        elseif not TargetBindEnabled then
            if azure.Aiming.Target.Alerts then
                Library:Notify("Untargeting : "..tostring(TargetTarget.Character.Humanoid.DisplayName))
            end
        end
    end
end)

TargetTab:AddInput('TargetPredictionTextbox', {
    Default = '',
    Numeric = false,
    Finished = false,

    Text = 'Prediction',
    Tooltip = 'Target Prediction',

    Placeholder = 'Example = 0.165', 
})

Options.TargetPredictionTextbox:OnChanged(function()
    azure.Aiming.Target.Prediction = Options.TargetPredictionTextbox.Value
end)

TargetTab:AddToggle('TargetTabFovTggle', {
    Text = 'Draw FOV',
    Default = false, 
    Tooltip = 'Enable Target FOV', 
})

Toggles.TargetTabFovTggle:OnChanged(function()
    TargetFOvEnabled = Toggles.TargetTabFovTggle.Value
end)

Toggles.TargetTabFovTggle:AddColorPicker('LocalHighxlxxxxxxxxxxightFillColorColorPicker', {
    Default = Color3.fromRGB(255,0,0),
    Title = 'Target FOV Color'
})

Options.LocalHighxlxxxxxxxxxxightFillColorColorPicker:OnChanged(function()
    TargetFovClr = Options.LocalHighxlxxxxxxxxxxightFillColorColorPicker.Value
end)

TargetTab:AddSlider('AimbotFOVSxizex', {
    Text = 'Target FOV',

    Default = 5,
    Min = 1,
    Max = 5,
    Rounding = 2,

    Compact = false,
})

Options.AimbotFOVSxizex:OnChanged(function()
    TargetFOVSize = Options.AimbotFOVSxizex.Value*100
end)

TargetTab:AddDropdown('TargetHitboxDropdown', {
    Values = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' },
    Default = 2,
    Multi = false,

    Text = 'Hitbox',
    Tooltip = 'Target Hitbox',
})

Options.TargetHitboxDropdown:OnChanged(function()
    azure.Aiming.Target.Hitbox = Options.TargetHitboxDropdown.Value
end)

TargetTab:AddToggle('TargetAlertsTggl', {
    Text = 'Alerts',
    Default = false,
    Tooltip = 'Enable Target Alerts',
})

Toggles.TargetAlertsTggl:OnChanged(function()
    azure.Aiming.Target.Alerts = Toggles.TargetAlertsTggl.Value
end)

TargetTab:AddToggle('TargetLookAtTggle', {
    Text = 'Look At',
    Default = false,
    Tooltip = 'Enable Look At',
})

Toggles.TargetLookAtTggle:OnChanged(function()
    azure.Aiming.Target.LookAt = Toggles.TargetLookAtTggle.Value
end)

TargetTab:AddToggle('TargetViewAtTggle', {
    Text = 'View At',
    Default = false,
    Tooltip = 'Enable View At',
})

Toggles.TargetViewAtTggle:OnChanged(function()
    azure.Aiming.Target.ViewAt = Toggles.TargetViewAtTggle.Value
end)

TargetTab:AddToggle('PingbasedTggle', {
    Text = 'Ping Based',
    Default = false, 
    Tooltip = 'recommended on 100 ping', 
})

Toggles.PingbasedTggle:OnChanged(function()
    azure.Aiming.Target.PingBased = Toggles.PingbasedTggle.Value
end)

TargetTab:AddToggle('TracerEnabledTracerTarget', {
    Text = 'Tracers',
    Default = false, 
    Tooltip = 'Tracers Enabled', 
})

Toggles.TracerEnabledTracerTarget:OnChanged(function()
    azure.Aiming.Target.Tracer.Enabled = Toggles.TracerEnabledTracerTarget.Value
end)

Toggles.TracerEnabledTracerTarget:AddColorPicker('AddColorPickerForTracerTargetThingy', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Target Tracer Color'
})

Options.AddColorPickerForTracerTargetThingy:OnChanged(function()
    azure.Aiming.Target.Tracer.Color = Options.AddColorPickerForTracerTargetThingy.Value
end)

TargetTab:AddDropdown('TargetTracerFrom', {
    Values = { 'Mouse', 'Head', 'UpperTorso', 'LowerTorso','Gun' },
    Default = 5,
    Multi = false, 

    Text = 'Tracer From:',
    Tooltip = 'Tracer From',
})

Options.TargetTracerFrom:OnChanged(function()
    azure.Aiming.Target.Tracer.From = Options.TargetTracerFrom.Value
end)

TargetTab:AddToggle('HighlightEnabledTggle', {
    Text = 'Highlight',
    Default = false, 
    Tooltip = 'Highlight Enabled', 
})

Toggles.HighlightEnabledTggle:OnChanged(function()
    azure.Aiming.Target.Highlight.Enabled = Toggles.HighlightEnabledTggle.Value
end)

Toggles.HighlightEnabledTggle:AddColorPicker('HighlightFillColorColorPicker', {
    Default = Color3.fromRGB(255,0,0),
    Title = 'Highlight Fill Color'
})

Options.HighlightFillColorColorPicker:OnChanged(function()
    azure.Aiming.Target.Highlight.FillColor = Options.HighlightFillColorColorPicker.Value
end)

Toggles.HighlightEnabledTggle:AddColorPicker('HighlightOutLineColor', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Highlight Outline Color'
})

Options.HighlightOutLineColor:OnChanged(function()
    azure.Aiming.Target.Highlight.OutlineColor = Options.HighlightOutLineColor.Value
end)

TargetTab:AddToggle('FakeHitboxTggle', {
    Text = 'Fake Hitbox',
    Default = false, 
    Tooltip = 'Fake Hitbox Enabled', 
})

Toggles.FakeHitboxTggle:OnChanged(function()
    azure.Aiming.Target.FakeHitbox.Enabled = Toggles.FakeHitboxTggle.Value
end)

Toggles.FakeHitboxTggle:AddColorPicker('FakeHitboxColor', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Fake Hitbox Color'
})

Options.FakeHitboxColor:OnChanged(function()
    azure.Aiming.Target.FakeHitbox.Color = Options.FakeHitboxColor.Value
end)

TargetTab:AddDropdown('TargetFakeHitboxMaterial', {
    Values = { 'Neon', 'ForceField', 'Plastic' },
    Default = 1,
    Multi = false, 

    Text = 'Fake Hitbox Material',
    Tooltip = 'Fake Hitbox Material',
})

Options.TargetFakeHitboxMaterial:OnChanged(function()
    azure.Aiming.Target.FakeHitbox.Material = Options.TargetFakeHitboxMaterial.Value
end)

TargetTab:AddSlider('TarggeetFakeHitboxSize', {
    Text = 'Fake Hitbox Size',

    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 2,

    Compact = false,
})

Options.TarggeetFakeHitboxSize:OnChanged(function()
    azure.Aiming.Target.FakeHitbox.Size = Options.TarggeetFakeHitboxSize.Value
end)

TargetTab:AddToggle('DotPARENTEnabedx', {
    Text = 'Dot',
    Default = false, 
    Tooltip = 'Dot Enabled', 
})

Toggles.DotPARENTEnabedx:OnChanged(function()
    azure.Aiming.Target.Dot.Enabled = Toggles.DotPARENTEnabedx.Value
end)

Toggles.DotPARENTEnabedx:AddColorPicker('DotParentForColorxXD', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Dot Color'
})

Options.DotParentForColorxXD:OnChanged(function()
    azure.Aiming.Target.Dot.Color = Options.DotParentForColorxXD.Value
end)

TargetTab:AddSlider('TargetOffsetYSlider', {
    Text = 'Target Offset (Y)',

    Default = 0,
    Min = -0.5,
    Max = 0.5,
    Rounding = 2,

    Compact = false,
})

Options.TargetOffsetYSlider:OnChanged(function()
    azure.Aiming.Target.Offset.Y = Options.TargetOffsetYSlider.Value
end)

WristPositionTab:AddToggle('WristPosEnabledTggle', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Enable Wrist Position',
})

Toggles.WristPosEnabledTggle:OnChanged(function()
    azure.Aiming.WristPos.Enabled = Toggles.WristPosEnabledTggle.Value
end)

Toggles.WristPosEnabledTggle:AddKeyPicker('WristPosBindEnabled', {
    Default = 'None', 
    SyncToggleState = false, 

    Mode = 'Toggle',

    Text = 'Wrist Position', 
    NoUI = false,
})

Options.WristPosBindEnabled:OnClick(function()
    if azure.Aiming.WristPos.Enabled then
        WristPosBind = not WristPosBind
        WristPosTarget = GetTarget()
    end
end)

WristPositionTab:AddSlider('WristPosOffsetSlider', {
    Text = 'Offset (Y)',

    Default = 1,
    Min = 1,
    Max = 25,
    Rounding = 2,

    Compact = false,
})

Options.WristPosOffsetSlider:OnChanged(function()
    azure.Aiming.WristPos.Distance = Options.WristPosOffsetSlider.Value
end)

WristPositionTab:AddLabel("Drops FPS (could be buggy)")

StrafeTab:AddToggle('TargetStrafeEnabled', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Enable Target Strafe Enabled',
})

Toggles.TargetStrafeEnabled:OnChanged(function()
    azure.Aiming.TargetStrafe.Enabled = Toggles.TargetStrafeEnabled.Value
end)

Toggles.TargetStrafeEnabled:AddKeyPicker('StrafeKeyPickerXD', {
    Default = 'None', 
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Strafe (Target)', 
    NoUI = false,
})

StrafeTab:AddToggle('TargetStrafeVisualizatiONcOLR', {
    Text = 'Visualize Rotation',
    Default = false, 
    Tooltip = 'Visualize Rotation Enabled', 
})

Toggles.TargetStrafeVisualizatiONcOLR:OnChanged(function()
    azure.Aiming.TargetStrafe.Visualize.Enabled = Toggles.TargetStrafeVisualizatiONcOLR.Value
end)

Toggles.TargetStrafeVisualizatiONcOLR:AddColorPicker('TargetStrafeVisualizatiONcOLRXX', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Visualize Rotation Color'
})

Options.TargetStrafeVisualizatiONcOLRXX:OnChanged(function()
    azure.Aiming.TargetStrafe.Visualize.Color = Options.TargetStrafeVisualizatiONcOLRXX.Value
end)

StrafeTab:AddSlider('TargetStrafeSpeedLSid', {
    Text = 'Speed',

    Default = 5,
    Min = 1,
    Max = 5,
    Rounding = 0,

    Compact = false,
})

Options.TargetStrafeSpeedLSid:OnChanged(function()
    if Options.TargetStrafeSpeedLSid.Value == 5 then
        azure.Aiming.TargetStrafe.Speed = 0.5
    elseif Options.TargetStrafeSpeedLSid.Value == 4 then
        azure.Aiming.TargetStrafe.Speed = 0.6
    elseif Options.TargetStrafeSpeedLSid.Value == 3 then
        azure.Aiming.TargetStrafe.Speed = 0.7
    elseif Options.TargetStrafeSpeedLSid.Value == 2 then
        azure.Aiming.TargetStrafe.Speed = 0.8
    elseif Options.TargetStrafeSpeedLSid.Value == 1 then
        azure.Aiming.TargetStrafe.Speed = 0.9
    end
end)

StrafeTab:AddSlider('TargetStrafeDistanceSlid', {
    Text = 'Distance',

    Default = 0,
    Min = 0,
    Max = 20,
    Rounding = 2,

    Compact = false,
})

Options.TargetStrafeDistanceSlid:OnChanged(function()
    azure.Aiming.TargetStrafe.Distance = Options.TargetStrafeDistanceSlid.Value
end)

StrafeTab:AddSlider('TargetStrafeHeightSlid', {
    Text = 'Height',

    Default = 0,
    Min = 0,
    Max = 20,
    Rounding = 2,

    Compact = false,
})

Options.TargetStrafeHeightSlid:OnChanged(function()
    azure.Aiming.TargetStrafe.Height = Options.TargetStrafeHeightSlid.Value
end)

StrafeTab:AddLabel("FPS Based")

ExploitsTab:AddToggle('JumpCooldownTggle', {
    Text = 'No Jump Cooldown',
    Default = false, 
    Tooltip = 'Removes Jump Cooldown', 
})

Toggles.JumpCooldownTggle:OnChanged(function()
    azure.Blatant.Exploits.JumpCooldown = Toggles.JumpCooldownTggle.Value
end)

ExploitsTab:AddToggle('NoSlowdownTgle', {
    Text = 'No Slowdown',
    Default = false, 
    Tooltip = 'Enable No Slowdown', 
})

Toggles.NoSlowdownTgle:OnChanged(function()
    azure.Blatant.Exploits.NoSlow = Toggles.NoSlowdownTgle.Value
end)

ExploitsTab:AddToggle('AutoStompTggle', {
    Text = 'Auto Stomp',
    Default = false, 
    Tooltip = 'Enable Auto Stomp', 
})

Toggles.AutoStompTggle:OnChanged(function()
    azure.Blatant.Exploits.AutoStomp = Toggles.AutoStompTggle.Value
end)

ExploitsTab:AddToggle('AntiFlingEnabled', {
    Text = 'Anti-Fling',
    Default = false, 
    Tooltip = 'Enable Anti-Fling', 
})

Toggles.AntiFlingEnabled:OnChanged(function()
    LocalPlayer.Character.HumanoidRootPart.Anchored = Toggles.AntiFlingEnabled.Value
end)

ExploitsTab:AddToggle('AntiBagEnabledx', {
    Text = 'Anti-Bag',
    Default = false, 
    Tooltip = 'Enable Anti-Bag ( do not use when antilocking )', 
})

Toggles.AntiBagEnabledx:OnChanged(function()
    azure.Blatant.Exploits.AntiBag = Toggles.AntiBagEnabledx.Value
end)

ExploitsTab:AddToggle('NoclipEnabled', {
    Text = 'Noclip',
    Default = false, 
    Tooltip = 'Enable Noclip', 
})

Toggles.NoclipEnabled:OnChanged(function()
    if Toggles.NoclipEnabled.Value then
        NoclipLoop = game:GetService("RunService").Stepped:Connect(function()
            for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") and v.CanCollide == true then
                    v.CanCollide = false
                end
            end
        end)
    elseif Toggles.NoclipEnabled.Value == false and NoclipLoop then
        NoclipLoop:Disconnect()
    end
end)

Toggles.NoclipEnabled:AddKeyPicker('NoclipBind', {
    Default = 'None', 
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Noclip', 
    NoUI = false,
})


AntiStompTab:AddToggle('aNTIStompTggle', {
    Text = 'Enable',
    Default = false, 
    Tooltip = 'Enable AntiStomp', 
})

Toggles.aNTIStompTggle:OnChanged(function()
    azure.Blatant.AntiStomp.Enabled = Toggles.aNTIStompTggle.Value
end)

AntiStompTab:AddDropdown('AntiStompDropdown', {
    Values = { 'Remove Character', 'Remove Humanoid' },
    Default = 1,
    Multi = false, 

    Text = 'Anti Stomp Type',
    Tooltip = 'Anti Stomp Type',
})

Options.AntiStompDropdown:OnChanged(function()
    azure.Blatant.AntiStomp.Type = Options.AntiStompDropdown.Value
end)

CFrameTab:AddToggle('CFrameSpeedTggle', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Enable CFrame',
})

Toggles.CFrameSpeedTggle:OnChanged(function()
    azure.Blatant.CFrame.Enabled = Toggles.CFrameSpeedTggle.Value
end)

Toggles.CFrameSpeedTggle:AddKeyPicker('CFrameSpeedBind', {
    Default = 'None', 
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'CFrame', 
    NoUI = false,
})

CFrameTab:AddSlider('CFrameSpeedAmountXD', {
    Text = 'CFrame Speed Amount',

    Default = 1,
    Min = 1,
    Max = 5,
    Rounding = 2,

    Compact = false,
})

Options.CFrameSpeedAmountXD:OnChanged(function()
    azure.Blatant.CFrame.Value = Options.CFrameSpeedAmountXD.Value
end)

FakeLagTab:AddToggle('FakeLagEnabledTggle', {
    Text = 'Enable',
    Default = false, 
    Tooltip = 'Enable Fake Lag', 
})

Toggles.FakeLagEnabledTggle:OnChanged(function()
    azure.Blatant.FakeLag.Enabled = Toggles.FakeLagEnabledTggle.Value
end)

FakeLagTab:AddSlider('FakeLagEnabledSlider', {
    Text = 'Duration',

    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 2,

    Compact = false,
})

Options.FakeLagEnabledSlider:OnChanged(function()
    azure.Blatant.FakeLag.Duration = Options.FakeLagEnabledSlider.Value
end)

local PredictorPart = Instance.new("Part",game.Workspace)

local newBillboardx = Instance.new("BillboardGui", PredictorPart)

local newFramex = Instance.new("Frame", newBillboardx)
local newUiCornorx = Instance.new("UICorner", newFramex)

task.spawn(function ()
    PredictorPart.Anchored = true
    PredictorPart.CanCollide = false
    PredictorPart.CFrame = CFrame.new(0,9999,0)
    PredictorPart.Transparency = 1
    newBillboardx.Name = "azure_billboardpredictor"
    newBillboardx.Adornee = PredictorPart
    newBillboardx.Size = UDim2.new(1, 0, 1, 0)
    newBillboardx.AlwaysOnTop = true
    newFramex.Size = UDim2.new(1, 0, 1, 0)
    newFramex.BackgroundTransparency = 0
    newUiCornorx.CornerRadius = UDim.new(50, 50)
end)

AntiAimTab:AddToggle('PredictiorRoblox', {
    Text = 'Predictor',
    Default = false, 
    Tooltip = 'Predictor Enabled', 
})

Toggles.PredictiorRoblox:OnChanged(function()
    if Toggles.PredictiorRoblox.Value then
        PredictorHook = game:GetService("RunService").Stepped:Connect(function ()
            PredictorPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position+(LocalPlayer.Character.HumanoidRootPart.Velocity*0.11))
            spawn(function ()
                newFramex.BackgroundColor3 = PredictorColoxr
            end)
        end)
    elseif Toggles.PredictiorRoblox.Value == false and PredictorHook then
        PredictorHook:Disconnect()
        PredictorPart.CFrame = CFrame.new(0,5000,0)
    end
end)

Toggles.PredictiorRoblox:AddColorPicker('AddColorPickerForTxxxxxxxxxxracerTargetThingy', {
    Default = Color3.fromRGB(255,255,255),
})

Options.AddColorPickerForTxxxxxxxxxxracerTargetThingy:OnChanged(function()
    PredictorColoxr = Options.AddColorPickerForTxxxxxxxxxxracerTargetThingy.Value
end)

AntiAimTab:AddToggle('VelUnderGroundToggle', {
    Text = 'Velocity Underground',
    Default = false, 
    Tooltip = 'Velocity Underground Enabled', 
})

Toggles.VelUnderGroundToggle:OnChanged(function()
    azure.Blatant.AntiAim.VelocityUnderGround = Toggles.VelUnderGroundToggle.Value
end)

Toggles.VelUnderGroundToggle:AddKeyPicker('NoclipBind', {
    Default = 'None', 
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'V-Underground', 
    NoUI = false,
})

AntiAimTab:AddSlider('VelocityUndergroundSLider', {
    Text = 'V-Underground Velocity',

    Default = 1,
    Min = 1,
    Max = 500,
    Rounding = 2,

    Compact = false,
})

Options.VelocityUndergroundSLider:OnChanged(function()
    azure.Blatant.AntiAim.VelocityUnderGroundAmount = Options.VelocityUndergroundSLider.Value
end)

AntiAimTab:AddSlider('VelocityHipheightUnderground', {
    Text = 'HipHeight',

    Default = 2,
    Min = 2,
    Max = 11,
    Rounding = 2,

    Compact = false,
})

Options.VelocityHipheightUnderground:OnChanged(function()
    VelocityUndergroundHipheight = Options.VelocityHipheightUnderground.Value
end)


AntiAimTab:AddToggle('VFallTggle', {
    Text = 'Velocity Fall',
    Default = false, 
    Tooltip = 'Velocity Fall Enabled', 
})

Toggles.VFallTggle:OnChanged(function()
    if Toggles.VFallTggle.Value then
        VFallHook = RunService.Stepped:Connect(function ()
            LocalPlayer.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
                if new == Enum.HumanoidStateType.Freefall == true and Toggles.VFallTggle.Value == true then
                    wait(0.28)
                    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, -V_FallVelocity, 0)
                end
            end)
        end)
    elseif Toggles.VFallTggle.Value == false and VFallHook then
        VFallHook:Disconnect()
    end
end)

AntiAimTab:AddSlider('VFallVel', {
    Text = 'V-Fall Velocity',

    Default = 1,
    Min = 1,
    Max = 50,
    Rounding = 2,

    Compact = false,
})

Options.VFallVel:OnChanged(function()
    V_FallVelocity = Options.VFallVel.Value
end)

GunModTab:AddToggle('AutoReloadTggle', {
    Text = 'Auto Reload',
    Default = false, 
    Tooltip = 'Enable Auto Reload', 
})

Toggles.AutoReloadTggle:OnChanged(function()
    azure.Blatant.GunMod.AutoReload = Toggles.AutoReloadTggle.Value
end)

SpinbotTab:AddToggle('RotVelocitySpinbot', {
    Text = 'Enable',
    Default = false, 
    Tooltip = 'Spinbot Enabled', 
})

Toggles.RotVelocitySpinbot:OnChanged(function()
    if Toggles.RotVelocitySpinbot.Value then
        RotVelHook = RunService.Stepped:Connect(function ()
            LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(Spinbot_X,Spinbot_Y,Spinbot_Z)
        end)
    elseif Toggles.RotVelocitySpinbot.Value == false and RotVelHook then
        RotVelHook:Disconnect()
    end
end)

SpinbotTab:AddSlider('SpinbotY', {
    Text = 'Speed',

    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 2,

    Compact = false,
})

Options.SpinbotY:OnChanged(function()
    Spinbot_Y = Options.SpinbotY.Value
end)



fakeanimTab:AddToggle('MoonWalk', {
    Text = 'MoonWalk ( 1 )',
    Default = false, 
    Tooltip = 'Prediction can be weird', 
})

Toggles.MoonWalk:OnChanged(function()
        if Toggles.MoonWalk.Value then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                "rbxassetid://696096087"
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                "rbxassetid://696096087"
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                "rbxassetid://696096087"
        elseif Toggles.MoonWalk.Value == false then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
        end
end)

fakeanimTab:AddToggle('MoonWalk1', {
    Text = 'MoonWalk ( 2 )',
    Default = false, 
    Tooltip = 'Prediction can be weird', 
})

Toggles.MoonWalk1:OnChanged(function()
        if Toggles.MoonWalk1.Value then
 game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                ""
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                ""
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                ""
        elseif Toggles.MoonWalk1.Value == false then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
        end
end)

           
fakeanimTab:AddToggle('NonHeadshotWalk', {
    Text = 'HeadshotWalk',
    Default = false, 
    Tooltip = 'Enemie cant 2 tap', 
})

Toggles.NonHeadshotWalk:OnChanged(function()
        if Toggles.NonHeadshotWalk.Value then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                "http://www.roblox.com/asset/?id=1083222527"
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                "http://www.roblox.com/asset/?id=1083222527"
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                "http://www.roblox.com/asset/?id=1083222527"
        elseif Toggles.NonHeadshotWalk.Value == false then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
        end
end)

fakeanimTab:AddToggle('ArmSwingWalk', {
    Text = 'Arm Spread',
    Default = false, 
    Tooltip = 'Prediction can be weird', 
})

Toggles.ArmSwingWalk:OnChanged(function()
        if Toggles.ArmSwingWalk.Value then
             game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                "rbxassetid://754656200"
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                "rbxassetid://754656200"
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                "rbxassetid://754656200"
        elseif Toggles.ArmSwingWalk.Value == false then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
        end
end)

fakeanimTab:AddToggle('FlossWalk', {
    Text = 'FlossWalk',
    Default = false, 
    Tooltip = 'Prediction can be weird', 
})

Toggles.FlossWalk:OnChanged(function()
        if Toggles.FlossWalk.Value then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId =
                "http://www.roblox.com/asset/?id=5917459365"
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId =
                "http://www.roblox.com/asset/?id=5917459365"
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId =
                "http://www.roblox.com/asset/?id=5917459365"
        elseif Toggles.FlossWalk.Value == false then
            game.Players.LocalPlayer.Character.Animate.idle.Animation1.AnimationId = _G.FakeAnim1
            game.Players.LocalPlayer.Character.Animate.run.RunAnim.AnimationId = _G.FakeAnim2
            game.Players.LocalPlayer.Character.Animate.walk.WalkAnim.AnimationId = _G.FakeAnim3
        end
end)


removehitboxTab:AddDropdown('RemovalDropdown', {
    Values = { 'None','RightLeg', 'LeftLeg',"LeftArm" },
    Default = 1,
    Multi = false, 

    Text = 'RemovalDropdown',
    Tooltip = 'RemoveHitboxes',
})

Options.RemovalDropdown:OnChanged(function()
    if Options.RemovalDropdown.Value == "None" then
    elseif Options.RemovalDropdown.Value == "RightLeg" then
        game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
    elseif Options.RemovalDropdown.Value == "LeftLeg" then
        game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()
        elseif Options.RemovalDropdown.Value == "LeftArm" then
        game.Players.LocalPlayer.Character.LeftUpperArm:Destroy()
end
end)

LocalTab:AddToggle('ChamsEnabledTggle', {
    Text = 'Enable Chams',
    Default = false,
    Tooltip = 'Enable Chams',
})

Toggles.ChamsEnabledTggle:OnChanged(function()
    azure.Visuals.Local.Chams = Toggles.ChamsEnabledTggle.Value
end)

task.spawn(function ()
    while true do
        wait()
        if azure.Visuals.Local.Chams then
            for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = "ForceField"
                end
            end
        else
            for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = "Plastic"
                end
            end
        end
    end
end)
--[[
LocalTab:AddToggle('GunChamsTggle', {
    Text = 'Enable Gun Chams',
    Default = false, 
    Tooltip = 'Gun Chams Enabled', 
})

Toggles.GunChamsTggle:OnChanged(function()
    azure.Visuals.Local.GunChams.Enabled = Toggles.GunChamsTggle.Value
end)

Toggles.GunChamsTggle:AddColorPicker('GunChamsColr', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Gun Chams Color'
})

Options.GunChamsColr:OnChanged(function()
    azure.Visuals.Local.GunChams.Color = Options.GunChamsColr.Value
end)

task.spawn(function ()
    while true do
        wait()
        if azure.Visuals.Local.GunChams.Enabled then
            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Material = "ForceField"
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Color = azure.Visuals.Local.GunChams.Color
            end
        else
            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Default.Material = "Plastic"
            end
        end
    end
end)
]]

local LocalHL = Instance.new("Highlight")

LocalTab:AddToggle('LocalHighlight', {
    Text = 'Highlight',
    Default = false, 
    Tooltip = 'Highlight Enabled', 
})

Toggles.LocalHighlight:OnChanged(function()
    azure.Visuals.Local.Highlight.Enabled = Toggles.LocalHighlight.Value
end)

task.spawn(function ()
    while true do
        wait()
        if azure.Visuals.Local.Highlight.Enabled then
            LocalHL.Parent = LocalPlayer.Character
            LocalHL.FillColor = azure.Visuals.Local.Highlight.FillColor
            LocalHL.OutlineColor = azure.Visuals.Local.Highlight.OutlineColor
        else
            LocalHL.Parent = game.CoreGui
        end
    end
end)

Toggles.LocalHighlight:AddColorPicker('LocalHighlightFillColorColorPicker', {
    Default = Color3.fromRGB(255,0,0),
    Title = 'Highlight Fill Color'
})

Options.LocalHighlightFillColorColorPicker:OnChanged(function()
    azure.Visuals.Local.Highlight.FillColor = Options.LocalHighlightFillColorColorPicker.Value
end)

Toggles.LocalHighlight:AddColorPicker('LocalHighlightOutLineColor', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Highlight Outline Color'
})

Options.LocalHighlightOutLineColor:OnChanged(function()
    azure.Visuals.Local.Highlight.OutlineColor = Options.LocalHighlightOutLineColor.Value
end)

LocalTab:AddToggle('CloneChamsEnabled', {
    Text = 'Clone Chams',
    Default = false, 
    Tooltip = 'Clone Chams Enabled', 
})

Toggles.CloneChamsEnabled:OnChanged(function()
    azure.Visuals.Local.CloneChams.Enabled = Toggles.CloneChamsEnabled.Value
end)

Toggles.CloneChamsEnabled:AddColorPicker('CloneChamsColor', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Clone Chams Color'
})

Options.CloneChamsColor:OnChanged(function()
    azure.Visuals.Local.CloneChams.Color = Options.CloneChamsColor.Value
end)

task.spawn(function ()
    while true do
        wait()
        if azure.Visuals.Local.CloneChams.Enabled then
            repeat
                game.Players.LocalPlayer.Character.Archivable = true
                local Clone = game.Players.LocalPlayer.Character:Clone()
                for _,Obj in next, Clone:GetDescendants() do
                if Obj.Name == "HumanoidRootPart" or Obj:IsA("Humanoid") or Obj:IsA("LocalScript") or Obj:IsA("Script") or Obj:IsA("Decal") then
                    Obj:Destroy()
                elseif Obj:IsA("BasePart") or Obj:IsA("Meshpart") or Obj:IsA("Part") then
                    if Obj.Transparency == 1 then
                    Obj:Destroy()
                    else
                    Obj.CanCollide = false
                    Obj.Anchored = true
                    Obj.Material = azure.Visuals.Local.CloneChams.Material
                    Obj.Color = azure.Visuals.Local.CloneChams.Color
                    Obj.Transparency = 0
                    Obj.Size = Obj.Size + Vector3.new(0.03, 0.03, 0.03)   
                end
            end
                pcall(function()
                    Obj.CanCollide = false
                end)
            end
            Clone.Parent = game.Workspace
            wait(azure.Visuals.Local.CloneChams.Duration)
            Clone:Destroy()  
            until azure.Visuals.Local.CloneChams.Enabled == false
        end
    end
end)

LocalTab:AddSlider('DurationSliderWHAT', {
    Text = 'Duration',

    Default = 0.1,
    Min = 0.1,
    Max = 3,
    Rounding = 2,

    Compact = false,
})

Options.DurationSliderWHAT:OnChanged(function()
    azure.Visuals.Local.CloneChams.Duration = Options.DurationSliderWHAT.Value
end)

LocalTab:AddDropdown('CloneChamsMaterial', {
    Values = { 'Neon', 'ForceField', 'Plastic' },
    Default = 2,
    Multi = false, 

    Text = 'Clone Chams Material',
    Tooltip = 'Clone Chams Material',
})

Options.CloneChamsMaterial:OnChanged(function()
    azure.Visuals.Local.CloneChams.Material = Options.CloneChamsMaterial.Value
end)

FOVTag:AddSlider('FOVSLlider', {
    Text = 'Amount',

    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 2,

    Compact = false,
})

Options.FOVSLlider:OnChanged(function()
    workspace.CurrentCamera.FieldOfView = Options.FOVSLlider.Value
end)

ESPTab:AddToggle('BoxESPEnabled', {
    Text = 'Box',
    Default = false, 
    Tooltip = 'Box ESP Enabled', 
})

Toggles.BoxESPEnabled:OnChanged(function()
    getgenv().taffy_esp.box.enabled = Toggles.BoxESPEnabled.Value
end)

Toggles.BoxESPEnabled:AddColorPicker('BoxESPColor', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Box ESP Color'
})

Options.BoxESPColor:OnChanged(function()
    getgenv().taffy_esp.box.color1 = Options.BoxESPColor.Value
end)

ESPTab:AddToggle('HealthESPEnabled', {
    Text = 'Health',
    Default = false, 
    Tooltip = 'Health ESP Enabled', 
})

Toggles.HealthESPEnabled:OnChanged(function()
    getgenv().taffy_esp.box.healthbar = Toggles.HealthESPEnabled.Value
end)

Toggles.HealthESPEnabled:AddColorPicker('HealthESPColor', {
    Default = Color3.fromRGB(0,255,0),
    Title = 'Health ESP Color'
})

Options.HealthESPColor:OnChanged(function()
    getgenv().taffy_esp.box.healthbarcolor = Options.HealthESPColor.Value
end)
task.spawn(function ()
    while true do
        wait()
        if getgenv().taffy_esp.box.healthbar or getgenv().taffy_esp.box.enabled then
            getgenv().taffy_esp.box.outline = true
        elseif getgenv().taffy_esp.box.healthbar == false or getgenv().taffy_esp.box.enabled == false then
            getgenv().taffy_esp.box.outline = false
        end
        if getgenv().taffy_esp.box.healthbar == true and getgenv().taffy_esp.box.enabled == false then
            getgenv().taffy_esp.box.outline = false
        end
    end
end)

ESPTab:AddToggle('TracerESPEnabled', {
    Text = 'Tracer',
    Default = false, 
    Tooltip = 'Tracer ESP Enabled', 
})

Toggles.TracerESPEnabled:OnChanged(function()
    getgenv().taffy_esp.tracer.enabled = Toggles.TracerESPEnabled.Value
end)

Toggles.TracerESPEnabled:AddColorPicker('TracerESPColor', {
    Default = Color3.fromRGB(0,255,0),
    Title = 'Tracer ESP Color'
})

Options.TracerESPColor:OnChanged(function()
    getgenv().taffy_esp.tracer.color = Options.TracerESPColor.Value
end)

ESPTab:AddToggle('UnlockedTracerEnabled', {
    Text = 'Unlock Tracer',
    Default = false, 
    Tooltip = 'Unlock Tracer Enabled', 
})

Toggles.UnlockedTracerEnabled:OnChanged(function()
    getgenv().taffy_esp.tracer.unlocktracers = Toggles.UnlockedTracerEnabled.Value
end)

ESPTab:AddToggle('NameESPEnabled', {
    Text = 'Name',
    Default = false, 
    Tooltip = 'Name ESP Enabled', 
})

Toggles.NameESPEnabled:OnChanged(function()
    getgenv().taffy_esp.name.enabled = Toggles.NameESPEnabled.Value
end)

Toggles.NameESPEnabled:AddColorPicker('NameESPColor', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Name ESP Color'
})

Options.NameESPColor:OnChanged(function()
    getgenv().taffy_esp.name.color = Options.NameESPColor.Value
end)

ESPTab:AddToggle('ToolESPEnabled', {
    Text = 'Held Tool',
    Default = false, 
    Tooltip = 'Held Tool ESP Enabled', 
})

Toggles.ToolESPEnabled:OnChanged(function()
    getgenv().taffy_esp.Toolsshow.enable = Toggles.ToolESPEnabled.Value
end)

Toggles.ToolESPEnabled:AddColorPicker('ToolESPColor', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Held Tool ESP Color'
})

Options.ToolESPColor:OnChanged(function()
    getgenv().taffy_esp.Toolsshow.color = Options.ToolESPColor.Value
end)

WorldTab:AddLabel('Ambient'):AddColorPicker('AmbientColorPicker', {
    Default = Color3.fromRGB(0,0,0),
    Title = 'Ambient', 
})

Options.AmbientColorPicker:OnChanged(function()
    
    if AmbientRainbowMode == true then

    else
        game.Lighting.Ambient = Options.AmbientColorPicker.Value
    end
end)

WorldTab:AddToggle('RainbowAmbient', {
    Text = 'Rainbow Ambient',
    Default = false, 
    Tooltip = 'Rainbow Ambient Enabled', 
})

Toggles.RainbowAmbient:OnChanged(function()
    AmbientRainbowMode = Toggles.RainbowAmbient.Value
    if Toggles.RainbowAmbient.Value then
        while Toggles.RainbowAmbient.Value do
            wait()
            game:GetService("Lighting").Ambient  = Color3.new(255/255,0/255,0/255)
            for i = 0,255,10 do
             wait()
             game:GetService("Lighting").Ambient = Color3.new(255/255,i/255,0/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").Ambient = Color3.new(i/255,255/255,0/255)
            end
            for i = 0,255,10 do
               wait()
               game:GetService("Lighting").Ambient = Color3.new(0/255,255/255,i/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").Ambient = Color3.new(0/255,i/255,255/255)
            end
            for i = 0,255,10 do
                wait()
                game:GetService("Lighting").Ambient = Color3.new(i/255,0/255,255/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").Ambient = Color3.new(255/255,0/255,i/255)
            end
            if Toggles.RainbowAmbient.Value == false then break end
        end
    end
end)

local AmbientReset = WorldTab:AddButton('Reset to Default', function()
    Options.AmbientColorPicker:SetValueRGB(Color3.fromRGB(0,0,0))
end)

WorldTab:AddLabel('Outdoor Ambient'):AddColorPicker('OutdoorAmbientColor', {
    Default = Color3.fromRGB(152, 152, 146),
    Title = 'Outdoor Ambient', 
})

Options.OutdoorAmbientColor:OnChanged(function()
    if OutdoorAmbientRainbowMode then
    else
        game.Lighting.OutdoorAmbient = Options.OutdoorAmbientColor.Value
    end
end)

WorldTab:AddToggle('RainbowOutdoorAmbient', {
    Text = 'Rainbow Outdoor',
    Default = false, 
    Tooltip = 'Rainbow Outdoor Ambient Enabled', 
})

Toggles.RainbowOutdoorAmbient:OnChanged(function()
    OutdoorAmbientRainbowMode = Toggles.RainbowOutdoorAmbient.Value
    if Toggles.RainbowOutdoorAmbient.Value then
        while Toggles.RainbowOutdoorAmbient.Value do
            wait()
            game:GetService("Lighting").OutdoorAmbient  = Color3.new(255/255,0/255,0/255)
            for i = 0,255,10 do
             wait()
             game:GetService("Lighting").OutdoorAmbient = Color3.new(255/255,i/255,0/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").OutdoorAmbient = Color3.new(i/255,255/255,0/255)
            end
            for i = 0,255,10 do
               wait()
               game:GetService("Lighting").OutdoorAmbient = Color3.new(0/255,255/255,i/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").OutdoorAmbient = Color3.new(0/255,i/255,255/255)
            end
            for i = 0,255,10 do
                wait()
                game:GetService("Lighting").OutdoorAmbient = Color3.new(i/255,0/255,255/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").OutdoorAmbient = Color3.new(255/255,0/255,i/255)
            end
            if Toggles.RainbowOutdoorAmbient.Value == false then break end
        end
    end
end)

local OutdoorAmbientReset = WorldTab:AddButton('Reset to Default', function()
    Options.OutdoorAmbientColor:SetValueRGB(Color3.fromRGB(152, 152, 146))
end)

WorldTab:AddSlider('FogEndSlider', {
    Text = 'Fog End',

    Default = 500,
    Min = 1,
    Max = 500,
    Rounding = 1,

    Compact = false,
})

Options.FogEndSlider:OnChanged(function()
    game.Lighting.FogEnd = Options.FogEndSlider.Value
end)

WorldTab:AddLabel('Fog Color'):AddColorPicker('FogColorColorPicker', {
    Default = Color3.fromRGB(100, 87, 72),
    Title = 'Fog Color', 
})

Options.FogColorColorPicker:OnChanged(function()
    if FogRainbowMode then
    else
        game.Lighting.FogColor = Options.FogColorColorPicker.Value
    end
end)

WorldTab:AddToggle('RainbowFogColor', {
    Text = 'Rainbow Outdoor',
    Default = false, 
    Tooltip = 'Rainbow Outdoor Ambient Enabled', 
})

Toggles.RainbowFogColor:OnChanged(function()
    FogRainbowMode = Toggles.RainbowFogColor.Value
    if Toggles.RainbowFogColor.Value then
        while Toggles.RainbowFogColor.Value do
            wait()
            game:GetService("Lighting").FogColor  = Color3.new(255/255,0/255,0/255)
            for i = 0,255,10 do
             wait()
             game:GetService("Lighting").FogColor = Color3.new(255/255,i/255,0/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").FogColor = Color3.new(i/255,255/255,0/255)
            end
            for i = 0,255,10 do
               wait()
               game:GetService("Lighting").FogColor = Color3.new(0/255,255/255,i/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").FogColor = Color3.new(0/255,i/255,255/255)
            end
            for i = 0,255,10 do
                wait()
                game:GetService("Lighting").FogColor = Color3.new(i/255,0/255,255/255)
            end
            for i = 255,0,-10 do
                wait()
                game:GetService("Lighting").FogColor = Color3.new(255/255,0/255,i/255)
            end
            if Toggles.RainbowFogColor.Value == false then break end
        end
    end
end)

local ResetFogEnd = WorldTab:AddButton('Reset to Default', function()
    Options.FogEndSlider:SetValue(500)
    Options.FogColorColorPicker:SetValueRGB(Color3.fromRGB(100, 87, 72))
end)

WorldTab:AddToggle('GlobalShadowsEnabled', {
    Text = 'Global Shadows',
    Default = true, 
    Tooltip = 'Global Shadows Enabled', 
})

Toggles.GlobalShadowsEnabled:OnChanged(function()
    game.Lighting.GlobalShadows = Toggles.GlobalShadowsEnabled.Value
end)
WorldTab:AddSlider('Saturation', {
    Text = 'Saturation',

    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 1,

    Compact = false,
})

Options.Saturation:OnChanged(function()
                        local ColorCorrection = game.Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect")
ColorCorrection.Saturation = Options.Saturation.Value
end)
WorldTab:AddSlider('Contrast', {
    Text = 'Contrast',

    Default = 0.1,
    Min = 0,
    Max = 10,
    Rounding = 1,

    Compact = false,
})

Options.Contrast:OnChanged(function()
    local ColorCorrection = game.Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect")
ColorCorrection.Contrast = Options.Contrast.Value
end)




CrosshairTab:AddToggle('CrosshairEnabledTop', {
    Text = 'Top',
    Default = true, 
    Tooltip = 'Top Enabled', 
})

Toggles.CrosshairEnabledTop:OnChanged(function()
    LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.Visible = Toggles.CrosshairEnabledTop.Value
end)

Toggles.CrosshairEnabledTop:AddColorPicker('CrosshairTopColor', {
    Default = Color3.fromRGB(255,255,255),
})

Options.CrosshairTopColor:OnChanged(function()
    
    if RainbowCrossHairMode then
    else
        LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = Options.CrosshairTopColor.Value
    end
end)

CrosshairTab:AddToggle('CrosshairEnabledDown', {
    Text = 'Bottom',
    Default = true, 
    Tooltip = 'Bottom Enabled', 
})

Toggles.CrosshairEnabledDown:OnChanged(function()
    LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.Visible = Toggles.CrosshairEnabledDown.Value
end)

Toggles.CrosshairEnabledDown:AddColorPicker('CrosshairBottomXd', {
    Default = Color3.fromRGB(255,255,255),
})

Options.CrosshairBottomXd:OnChanged(function()
   
    if RainbowCrossHairMode then
    else
        LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = Options.CrosshairBottomXd.Value
    end
end)

CrosshairTab:AddToggle('CrosshairEnabledLeft', {
    Text = 'Left',
    Default = true, 
    Tooltip = 'Left Enabled', 
})

Toggles.CrosshairEnabledLeft:OnChanged(function()
    LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.Visible = Toggles.CrosshairEnabledLeft.Value
end)

Toggles.CrosshairEnabledLeft:AddColorPicker('CrosshairLeftColor', {
    Default = Color3.fromRGB(255,255,255),
})

Options.CrosshairLeftColor:OnChanged(function()
    if RainbowCrossHairMode then
    else
        LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 = Options.CrosshairLeftColor.Value
    end
end)

CrosshairTab:AddToggle('CrosshairEnabledRight', {
    Text = 'Right',
    Default = true, 
    Tooltip = 'Right Enabled', 
})

Toggles.CrosshairEnabledRight:OnChanged(function()
    LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.Visible = Toggles.CrosshairEnabledRight.Value
end)

Toggles.CrosshairEnabledRight:AddColorPicker('CrosshairRightColor', {
    Default = Color3.fromRGB(255,255,255),
})

Options.CrosshairRightColor:OnChanged(function()
    if RainbowCrossHairMode then
    else
        LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = Options.CrosshairRightColor.Value
    end
end)

CrosshairTab:AddLabel('Middle'):AddColorPicker('CrosshairMiddle', {
    Default = Color3.fromRGB(255,255,255),
    Title = 'Middle', 
})

Options.CrosshairMiddle:OnChanged(function()
    
    if RainbowCrossHairMode then
    else
        LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = Options.CrosshairMiddle.Value
    end
end)

CrosshairTab:AddToggle('RainbowCrosshair', {
    Text = 'Rainbow Crosshair',
    Default = false, 
    Tooltip = 'Rainbow Crosshair Enabled', 
})

Toggles.RainbowCrosshair:OnChanged(function()
    RainbowCrossHairMode = Toggles.RainbowCrosshair.Value
    if Toggles.RainbowCrosshair.Value then
        while Toggles.RainbowCrosshair.Value do
            wait()
            for i = 0,255,10 do
             wait()
                 game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = Color3.new(255/255,i/255,0/255)
                game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = Color3.new(255/255,i/255,0/255)
                game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = Color3.new(255/255,i/255,0/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = Color3.new(255/255,i/255,0/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 = Color3.new(255/255,i/255,0/255)
            end
            for i = 255,0,-10 do
                wait()
                    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = Color3.new(i/255,255/255,0/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = Color3.new(i/255,255/255,0/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = Color3.new(i/255,255/255,0/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 =  Color3.new(i/255,255/255,0/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 = Color3.new(i/255,255/255,0/255)
            end
            for i = 0,255,10 do
               wait()
                   game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = Color3.new(0/255,255/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = Color3.new(0/255,255/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = Color3.new(0/255,255/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = Color3.new(0/255,255/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 =  Color3.new(0/255,255/255,i/255)
            end
            for i = 255,0,-10 do
                wait()
                    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = Color3.new(0/255,i/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = Color3.new(0/255,i/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = Color3.new(0/255,i/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = Color3.new(0/255,i/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 =  Color3.new(0/255,i/255,255/255)
            end
            for i = 0,255,10 do
                wait()
                    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = Color3.new(i/255,0/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = Color3.new(i/255,0/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = Color3.new(i/255,0/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = Color3.new(i/255,0/255,255/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 =  Color3.new(i/255,0/255,255/255)
            end
            for i = 255,0,-10 do
                wait()
                    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = Color3.new(255/255,0/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = Color3.new(255/255,0/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = Color3.new(255/255,0/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = Color3.new(255/255,0/255,i/255)
    game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 =  Color3.new(255/255,0/255,i/255)
            end
            if Toggles.RainbowCrosshair.Value == false then break end
        end
    end
end)

TeleportTab:AddDropdown('SchoolDropdown', {
    Values = { 'None','Food', 'Roof', 'Secret Room' },
    Default = 1,
    Multi = false, 

    Text = 'School',
    Tooltip = 'School Tps',
})

Options.SchoolDropdown:OnChanged(function()
    if Options.SchoolDropdown.Value == "None" then
    elseif Options.SchoolDropdown.Value == "Food" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-613.674194, 21.8749924, 289.857483, 0.00497477828, 2.20831442e-08, -0.999987602, -3.01110035e-08, 1, 2.19336211e-08, 0.999987602, 3.00015159e-08, 0.00497477828)
    elseif Options.SchoolDropdown.Value == "Secret Room" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-503.606995, 21.8749924, 361.749969, 0.999836385, -4.32269722e-08, -0.0180903766, 4.39084253e-08, 1, 3.72720521e-08, 0.0180903766, -3.80602749e-08, 0.999836385)
    elseif Options.SchoolDropdown.Value == "Roof" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-606.53656, 68.6249771, 325.997162, 0.99997282, 3.51442764e-10, 0.00737056695, -3.13645859e-10, 1, -5.12924192e-09, -0.00737056695, 5.12679055e-09, 0.99997282)
    end
end)

TeleportTab:AddDropdown('BankDropdown', {
    Values = { 'None','Food', 'Roof', 'Vault' },
    Default = 1,
    Multi = false, 

    Text = 'Bank',
    Tooltip = 'Bank Tps',
})

Options.BankDropdown:OnChanged(function()
    if Options.BankDropdown.Value == "None" then
    elseif Options.BankDropdown.Value == "Food" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-334.105621, 23.6826458, -297.371765, 0.0062069688, 8.89299017e-08, -0.999980748, 1.73607013e-08, 1, 8.9039375e-08, 0.999980748, -1.79130311e-08, 0.0062069688)
    elseif Options.BankDropdown.Value == "Vault" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-508.115051, 23.169693, -284.901337, -0.0288586095, -4.23028865e-08, -0.999583483, -4.83239475e-08, 1, -4.0925368e-08, 0.999583483, 4.71227715e-08, -0.0288586095)
    elseif Options.BankDropdown.Value == "Roof" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-459.32785, 39.0389023, -285.086548, 0.0124173071, 5.90856395e-08, -0.999922931, 3.85150489e-09, 1, 5.91380243e-08, 0.999922931, -4.58554306e-09, 0.0124173071)
    end
end)

TeleportTab:AddDropdown('UphillTps', {
    Values = { 'None','Food', 'Guns', 'Uphill Building 1','Uphill Building 2','Armor' },
    Default = 1,
    Multi = false, 

    Text = 'Uphill',
    Tooltip = 'Uphill Tps',
})

Options.UphillTps:OnChanged(function()
    if Options.UphillTps.Value == "None" then
    elseif Options.UphillTps.Value == "Food" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(299.117859, 49.2826538, -613.93158, 0.999884248, -2.11976445e-08, -0.015215965, 2.13970885e-08, 1, 1.29448381e-08, 0.015215965, -1.32689166e-08, 0.999884248)
    elseif Options.UphillTps.Value == "Guns" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(481.662781, 48.0704918, -622.017944, -0.999999166, 8.56621298e-08, 0.00129488122, 8.56506901e-08, 1, -8.88794016e-09, -0.00129488122, -8.77702444e-09, -0.999999166)
    elseif Options.UphillTps.Value == "Uphill Building 1" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(435.492004, 106.683769, -627.779114, -0.999886215, 4.09484855e-08, -0.0150852418, 4.09440126e-08, 1, 6.05427153e-10, 0.0150852418, -1.22920268e-11, -0.999886215)
    elseif Options.UphillTps.Value == "Uphill Building 2" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(300.213928, 106.03389, -620.259521, -0.999988019, 1.25798518e-08, -0.00488910545, 1.23825759e-08, 1, 4.03804208e-08, 0.00488910545, 4.03193994e-08, -0.999988019)
    elseif Options.UphillTps.Value == "Armor" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(533.781738, 50.3253212, -637.361084, 0.0147596924, -1.06152655e-07, 0.999891043, -2.64739004e-08, 1, 1.06555007e-07, -0.999891043, -2.80437362e-08, 0.0147596924)
    end
end)

TeleportTab:AddDropdown('DownhillTps', {
    Values = { 'None','Guns','Armor','Admin Base' },
    Default = 1,
    Multi = false, 

    Text = 'Downhill',
    Tooltip = 'Downhill Tps',
})

Options.DownhillTps:OnChanged(function()
    if Options.DownhillTps.Value == "None" then
    elseif Options.DownhillTps.Value == "Guns" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-581.334473, 8.31477833, -736.237427, -0.00332057965, -4.02167544e-08, -0.999994516, -5.74397596e-08, 1, -4.00262437e-08, 0.999994516, 5.73065329e-08, -0.00332057965)
    elseif Options.DownhillTps.Value == "Armor" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-604.672913, 10.3496885, -788.588745, -0.0184768867, -9.57051682e-09, 0.999829292, -3.11832942e-08, 1, 8.99588226e-09, -0.999829292, -3.10117549e-08, -0.0184768867)
    elseif Options.DownhillTps.Value == "Admin Base" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-797.611328, -39.6492157, -886.291382, 0.0349296406, -6.03186034e-09, 0.999389768, -1.15090231e-08, 1, 6.43779474e-09, -0.999389768, -1.17268701e-08, 0.0349296406)
    end
end)

TeleportTab:AddDropdown('CasinoTps', {
    Values = { 'None','Popcorn','DB','Casino' },
    Default = 1,
    Multi = false, 

    Text = 'Casino',
    Tooltip = 'Casino Tps',
})

Options.CasinoTps:OnChanged(function()
    if Options.CasinoTps.Value == "None" then
    elseif Options.CasinoTps.Value == "Popcorn" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-989.919678, 24.600008, -152.482224, 0.99982506, 1.5004666e-08, 0.0187029168, -1.51050052e-08, 1, 5.22361621e-09, -0.0187029168, -5.50521007e-09, 0.99982506)
    elseif Options.CasinoTps.Value == "DB" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1039.74451, 21.7499943, -260.811493, -0.999998271, 3.43565993e-08, 0.0018673077, 3.42738211e-08, 1, -4.4362519e-08, -0.0018673077, -4.42984422e-08, -0.999998271)
    elseif Options.CasinoTps.Value == "Casino" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-866.869263, 21.7499943, -116.072456, -0.99939853, -1.97582839e-09, 0.0346787088, 1.85263072e-09, 1, 1.10365839e-07, -0.0346787088, 1.103637e-07, -0.99939853)
    end
end)

FlyTab:AddToggle('FlyTggle', {
    Text = 'Enable',
    Default = false,
    Tooltip = 'Enable Fly',
})

Toggles.FlyTggle:OnChanged(function()
    if Toggles.FlyTggle.Value == true then
        FlyLoop = game:GetService("RunService").Stepped:Connect(function()
            spawn(function()
                pcall(function()
                    local speed = FlySpeed
                    local velocity = Vector3.new(0, 1, 0)
                    local UserInputService = game:GetService("UserInputService")

                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.lookVector * speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.rightVector * -speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.lookVector * -speed)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.rightVector * speed)
                    end
                    
                    LocalPlayer.Character.HumanoidRootPart.Velocity = velocity
                    LocalPlayer.Character.Humanoid:ChangeState("Freefall")
                end)
            end)
        end)
    elseif Toggles.FlyTggle.Value == false and FlyLoop then
        FlyLoop:Disconnect()
        LocalPlayer.Character.Humanoid:ChangeState("Landing")
    end
end)

Toggles.FlyTggle:AddKeyPicker('FlyBind', {
    Default = 'None', 
    SyncToggleState = true, 

    Mode = 'Toggle',

    Text = 'Fly', 
    NoUI = false,
})

FlyTab:AddSlider('FlySepedSlider', {
    Text = 'Speed',

    Default = 1,
    Min = 1,
    Max = 5,
    Rounding = 2,

    Compact = false,
})

Options.FlySepedSlider:OnChanged(function()
    FlySpeed = Options.FlySepedSlider.Value*50
end)

AnimationsTab:AddDropdown('RunAnimations', {
    Values = { 'None','Rthro','Werewolf','Zombie','Ninja','Toy','Superhero','OldSchool','Cartoony','Stylish','Vampire' },
    Default = 1,
    Multi = false, 

    Text = 'Run',
})

Options.RunAnimations:OnChanged(function()
    ChangeAnimHook = game:GetService("RunService").Stepped:Connect(function ()
        if Options.RunAnimations.Value == "None" then
        elseif Options.RunAnimations.Value == "Rthro" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=2510198475"
        elseif Options.RunAnimations.Value == "Werewolf" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
        elseif Options.RunAnimations.Value == "Zombie" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
        elseif Options.RunAnimations.Value == "Ninja" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
        elseif Options.RunAnimations.Value == "Toy" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
        elseif Options.RunAnimations.Value == "Superhero" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
        elseif Options.RunAnimations.Value == "OldSchool" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=5319844329"
        elseif Options.RunAnimations.Value == "Cartoony" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
        elseif Options.RunAnimations.Value == "Stylish" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
        elseif Options.RunAnimations.Value == "Vampire" then
            LocalPlayer.Character.Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
        end
    end)
end)

AnimationsTab:AddDropdown('JumpAnimations', {
    Values = { 'None','Rthro','Werewolf','Zombie','Ninja','Toy','Superhero','OldSchool','Cartoony','Stylish','Vampire' },
    Default = 1,
    Multi = false, 

    Text = 'Jump',
})

Options.JumpAnimations:OnChanged(function()
    ChangeJumpAnimHook = game:GetService("RunService").Stepped:Connect(function ()
        if Options.JumpAnimations.Value == "None" then
        elseif Options.JumpAnimations.Value == "Rthro" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=2510197830"
        elseif Options.JumpAnimations.Value == "Werewolf" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
        elseif Options.JumpAnimations.Value == "Zombie" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
        elseif Options.JumpAnimations.Value == "Ninja" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
        elseif Options.JumpAnimations.Value == "Toy" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
        elseif Options.JumpAnimations.Value == "Superhero" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
        elseif Options.JumpAnimations.Value == "OldSchool" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=5319841935"
        elseif Options.JumpAnimations.Value == "Cartoony" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
        elseif Options.JumpAnimations.Value == "Stylish" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
        elseif Options.JumpAnimations.Value == "Vampire" then
            LocalPlayer.Character.Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
        end
    end)
end)

AnimationsTab:AddDropdown('FallAnimations', {
    Values = { 'None','Rthro','Werewolf','Zombie','Ninja','Toy','Superhero','OldSchool','Cartoony','Stylish','Vampire' },
    Default = 1,
    Multi = false, 

    Text = 'Fall',
})

Options.FallAnimations:OnChanged(function()
    ChangeFallAnimHook = game:GetService("RunService").Stepped:Connect(function ()
        if Options.FallAnimations.Value == "None" then
        elseif Options.FallAnimations.Value == "Rthro" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=2510195892"
        elseif Options.FallAnimations.Value == "Werewolf" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
        elseif Options.FallAnimations.Value == "Zombie" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
        elseif Options.FallAnimations.Value == "Ninja" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
        elseif Options.FallAnimations.Value == "Toy" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
        elseif Options.FallAnimations.Value == "Superhero" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
        elseif Options.FallAnimations.Value == "OldSchool" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=5319839762"
        elseif Options.FallAnimations.Value == "Cartoony" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
        elseif Options.FallAnimations.Value == "Stylish" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
        elseif Options.FallAnimations.Value == "Vampire" then
            LocalPlayer.Character.Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
        end
    end)
end)

targetstraferangepart = Instance.new("MeshPart")

local TracerLine = Drawing.new("Line")
local HLTarget = Instance.new("Highlight")
local FakeHitboxPart = Instance.new("Part",game.Workspace)
local DotParent = Instance.new("Part",game.Workspace)

local newBillboard = Instance.new("BillboardGui", DotParent)

local newFrame = Instance.new("Frame", newBillboard)
local newUiCornor = Instance.new("UICorner", newFrame)


task.spawn(function ()
    newBillboard.Name = "azure_billboarddot"
    newBillboard.Adornee = DotParent
    newBillboard.Size = UDim2.new(1, 0, 1, 0)
    newBillboard.AlwaysOnTop = true
    newFrame.Size = UDim2.new(1, 0, 1, 0)
    newFrame.BackgroundTransparency = 0
    newUiCornor.CornerRadius = UDim.new(50, 50)
    DotParent.CanCollide = false
    DotParent.Anchored = true
    DotParent.CFrame = CFrame.new(0,2000,0)
    DotParent.Transparency = 1
    targetstraferangepart.MeshId = "rbxassetid://3726303797"
    targetstraferangepart.CanCollide = false
    targetstraferangepart.Anchored = true
    targetstraferangepart.Material = Enum.Material.Neon
    targetstraferangepart.Parent = game.Workspace
end)


RunService.Stepped:Connect(function ()
    if azure.Aiming.Target.Enabled and TargetBindEnabled and TargetTarget.Character then
        if azure.Aiming.Target.Dot.Enabled then
            DotParent.CFrame = CFrame.new(TargetTarget.Character[azure.Aiming.Target.Hitbox].Position+Vector3.new(0,azure.Aiming.Target.Offset.Y,0)+(TargetTarget.Character[azure.Aiming.Target.Hitbox].Velocity*azure.Aiming.Target.Prediction))
            task.spawn(function ()
                newFrame.BackgroundColor3 = azure.Aiming.Target.Dot.Color
            end)
            spawn(function ()
                if azure.Aiming.Target.Dot.Enabled == false then
                    DotParent.CFrame = CFrame.new(0,2000,0)
                end
            end)
        end
        if azure.Aiming.Target.FakeHitbox.Enabled then
            FakeHitboxPart.CFrame = CFrame.new(TargetTarget.Character.HumanoidRootPart.Position+Vector3.new(0,azure.Aiming.Target.Offset.Y,0)+(TargetTarget.Character.HumanoidRootPart.Velocity*azure.Aiming.Target.Prediction))
            spawn(function ()
                if azure.Aiming.Target.FakeHitbox.Enabled == false then
                    FakeHitboxPart.CFrame = CFrame.new(0,9999,0)
                end
            end)
            task.spawn(function ()
                FakeHitboxPart.CanCollide = false
                FakeHitboxPart.Anchored = true
                FakeHitboxPart.Color = azure.Aiming.Target.FakeHitbox.Color
                FakeHitboxPart.Size = Vector3.new(1*azure.Aiming.Target.FakeHitbox.Size,1*azure.Aiming.Target.FakeHitbox.Size,1*azure.Aiming.Target.FakeHitbox.Size)
                if azure.Aiming.Target.FakeHitbox.Material == "Neon" then
                    FakeHitboxPart.Transparency = 0
                    FakeHitboxPart.Material = "Neon"
                end
                if azure.Aiming.Target.FakeHitbox.Material == "ForceField" then
                    FakeHitboxPart.Transparency = 0
                    FakeHitboxPart.Material = "ForceField"
                end
                if azure.Aiming.Target.FakeHitbox.Material == "Plastic" then
                    FakeHitboxPart.Transparency = 0.75
                    FakeHitboxPart.Material = "Plastic"
                end
            end)
        end
        if azure.Aiming.Target.ViewAt then
            workspace.CurrentCamera.CameraSubject = TargetTarget.Character.Humanoid
            spawn(function ()
                if azure.Aiming.Target.ViewAt == false then
                    workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
                end
            end)
        end
        if azure.Aiming.Target.Tracer.Enabled then
            local LineVec = workspace.CurrentCamera:WorldToViewportPoint(TargetTarget.Character[azure.Aiming.Target.Hitbox].Position+Vector3.new(0,azure.Aiming.Target.Offset.Y,0)+(TargetTarget.Character[azure.Aiming.Target.Hitbox].Velocity*azure.Aiming.Target.Prediction))
            local humanoidt = workspace.CurrentCamera:WorldToViewportPoint(game.Players.LocalPlayer.Character.UpperTorso.Position)
            local headt = workspace.CurrentCamera:WorldToViewportPoint(game.Players.LocalPlayer.Character.Head.Position)
            local lowert = workspace.CurrentCamera:WorldToViewportPoint(game.Players.LocalPlayer.Character.LowerTorso.Position)
            local gunt = workspace.CurrentCamera:WorldToViewportPoint(game.Players.LocalPlayer.Character.RightHand.Position)
            
            TracerLine.Color = azure.Aiming.Target.Tracer.Color
            TracerLine.Transparency = 1
            TracerLine.Thickness = 2
            TracerLine.To = Vector2.new(LineVec.X, LineVec.Y)
            TracerLine.Visible = true
            if azure.Aiming.Target.Tracer.From == "Mouse" then
                TracerLine.From = Vector2.new(LocalPlayerObjs.Mouse.X, LocalPlayerObjs.Mouse.Y + game:GetService("GuiService"):GetGuiInset().Y)
            end
            if azure.Aiming.Target.Tracer.From == "Head" then
                TracerLine.From = Vector2.new(headt.X, headt.Y)
            end
            if azure.Aiming.Target.Tracer.From == "UpperTorso" then
                TracerLine.From = Vector2.new(humanoidt.X, humanoidt.Y)
            end
            if azure.Aiming.Target.Tracer.From == "LowerTorso" then
                TracerLine.From = Vector2.new(lowert.X, lowert.Y)
            end
            if azure.Aiming.Target.Tracer.From == "Gun" then
                TracerLine.From = Vector2.new(gunt.X, gunt.Y)
            end

            spawn(function ()
                if azure.Aiming.Target.Tracer.Enabled == false or azure.Aiming.Target.Enabled == false then
                    TracerLine.Visible = false
                end
            end)
        end
        if azure.Aiming.Target.Highlight.Enabled then
            HLTarget.Parent = TargetTarget.Character
            HLTarget.FillColor = azure.Aiming.Target.Highlight.FillColor
            HLTarget.OutlineColor = azure.Aiming.Target.Highlight.OutlineColor
            spawn(function ()
                if azure.Aiming.Target.Highlight.Enabled == false then
                    HLTarget.Parent = game.CoreGui
                end
            end)
        end

        if azure.Aiming.TargetStrafe.Visualize.Enabled and azure.Aiming.TargetStrafe.Enabled then
            targetstraferangepart.CFrame = TargetTarget.Character.HumanoidRootPart.CFrame
            spawn(function ()
                targetstraferangepart.Size = Vector3.new(azure.Aiming.TargetStrafe.Distance * 0.7, 0.01, azure.Aiming.TargetStrafe.Distance * 0.7)
                targetstraferangepart.Color = azure.Aiming.TargetStrafe.Visualize.Color
            end)
            spawn(function ()
                if azure.Aiming.TargetStrafe.Visualize.Enabled == false or azure.Aiming.TargetStrafe.Enabled == false then
                    targetstraferangepart.CFrame = CFrame.new(0,9999,0)
                end
            end)
        end
    else
        TracerLine.Visible = false
        HLTarget.Parent = game.CoreGui
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        FakeHitboxPart.CFrame = CFrame.new(0,999,0)
        DotParent.CFrame = CFrame.new(0,2000,0)
        targetstraferangepart.CFrame = CFrame.new(0,9999,0)
    end
    
    if azure.Aiming.Target.PingBased == true then
        pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        split = string.split(pingvalue,'(')
        ping = tonumber(split[1])
        if ping < 360 then
            azure.Aiming.Target.Prediction = 0.16537
        elseif ping < 270 then
            azure.Aiming.Target.Prediction = 0.195566
        elseif ping < 260 then
            azure.Aiming.Target.Prediction = 0.175566
        elseif ping < 250 then
            azure.Aiming.Target.Prediction = 0.1651
        elseif ping < 240 then
            azure.Aiming.Target.Prediction = 0.16780
        elseif ping < 230 then
            azure.Aiming.Target.Prediction = 0.15692
        elseif ping < 220 then
            azure.Aiming.Target.Prediction = 0.165566
        elseif ping < 210 then
            azure.Aiming.Target.Prediction = 0.16780
        elseif ping < 200 then
            azure.Aiming.Target.Prediction = 0.165566
        elseif ping < 190 then
            azure.Aiming.Target.Prediction = 0.166547
        elseif ping < 180 then
            azure.Aiming.Target.Prediction = 0.19284
        elseif ping < 170 then
            azure.Aiming.Target.Prediction = 0.1923111 
        elseif ping < 160 then
            azure.Aiming.Target.Prediction = 0.16
        elseif ping < 150 then
            azure.Aiming.Target.Prediction = 0.15
        elseif ping < 140 then
            azure.Aiming.Target.Prediction = 0.1223333
        elseif ping < 130 then
            azure.Aiming.Target.Prediction = 0.156692
        elseif ping < 120 then
            azure.Aiming.Target.Prediction = 0.143765
        elseif ping < 110 then
            azure.Aiming.Target.Prediction = 0.1455
        elseif ping < 100 then
            azure.Aiming.Target.Prediction = 0.130340
        elseif ping < 90 then
            azure.Aiming.Target.Prediction = 0.136
        elseif ping < 80 then
            azure.Aiming.Target.Prediction = 0.1347
        elseif ping < 70 then
            azure.Aiming.Target.Prediction = 0.119
        elseif ping < 60 then
            azure.Aiming.Target.Prediction = 0.12731
        elseif ping < 50 then
            azure.Aiming.Target.Prediction = 0.127668
        elseif ping < 40 then
            azure.Aiming.Target.Prediction = 0.125
        elseif ping < 30 then
            azure.Aiming.Target.Prediction = 0.11
        elseif ping < 20 then
            azure.Aiming.Target.Prediction = 0.12588
        elseif ping < 10 then
            azure.Aiming.Target.Prediction = 0.9
        end
    end
    if WristPosBind and azure.Aiming.WristPos.Enabled and WristPosTarget.Character and WristPosTarget.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character.RightHand:FindFirstChild("RightWrist") then
            LocalPlayer.Character.RightHand.RightWrist:Destroy()
        end
        repeat
            task.wait()
            LocalPlayer.Character.RightHand.CFrame = CFrame.new(WristPosTarget.Character.HumanoidRootPart.Position) * CFrame.new(0,azure.Aiming.WristPos.Distance,0)
            LocalPlayer.Character.RightHand.Transparency = 1
        until WristPosBind == false or azure.Aiming.WristPos.Enabled == false
        if WristPosBind == false or azure.Aiming.WristPos.Enabled == false then
            LocalPlayer.Character.RightHand.CFrame = LocalPlayer.Character.RightUpperArm.CFrame
            LocalPlayer.Character.RightHand.Transparency = 0
        end
    end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if azure.Aiming.Target.Enabled and TargetBindEnabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = TargetTarget.Character[azure.Aiming.Target.Hitbox].Position+Vector3.new(0,azure.Aiming.Target.Offset.Y,0)+(TargetTarget.Character[azure.Aiming.Target.Hitbox].Velocity*azure.Aiming.Target.Prediction)
        return old(unpack(args))
    end
    return old(...)
end)

RunService.RenderStepped:Connect(function ()
    if azure.Aiming.Aimbot.VelocityResolver then
        pcall(function ()
            AimbotTargetVelocity = AimbotTarget.Character.HumanoidRootPart.Velocity
            AimbotTarget.Character.HumanoidRootPart.Velocity = Vector3.new(AimbotTargetVelocity.X, -0.000000000000000000000000000000001, AimbotTargetVelocity.Z)
        end)
    end
    if azure.Aiming.Aimbot.Enabled and AimbotBindEnabled and azure.Aiming.Aimbot.Smoothing.Enabled == false then
        if azure.Aiming.Aimbot.ReverseResolver == true then
            local zxc = CFrame.new(workspace.CurrentCamera.CFrame.p, AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Position - AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Velocity/azure.Aiming.Aimbot.Prediction)
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(zxc, 1, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
        end
        if azure.Aiming.Aimbot.ReverseResolver == false then
            local zxc = CFrame.new(workspace.CurrentCamera.CFrame.p, AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Position + AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Velocity/azure.Aiming.Aimbot.Prediction)
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(zxc, 1, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
        end
    elseif azure.Aiming.Aimbot.Enabled and AimbotBindEnabled and azure.Aiming.Aimbot.Smoothing.Enabled == true then
        if azure.Aiming.Aimbot.ReverseResolver == true then
            local zx = CFrame.new(workspace.CurrentCamera.CFrame.p, AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Position - AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Velocity/azure.Aiming.Aimbot.Prediction)
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(zx, azure.Aiming.Aimbot.Smoothing.Value, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
        end
        if azure.Aiming.Aimbot.ReverseResolver == false then
            local zx = CFrame.new(workspace.CurrentCamera.CFrame.p, AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Position + AimbotTarget.Character[azure.Aiming.Aimbot.Hitbox].Velocity/azure.Aiming.Aimbot.Prediction)
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(zx, azure.Aiming.Aimbot.Smoothing.Value, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
        end
    end
    if TargetBindEnabled and azure.Aiming.Target.Enabled and TargetTarget.Character and TargetTarget.Character:FindFirstChild("HumanoidRootPart") then
        if azure.Aiming.Target.LookAt then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(TargetTarget.Character.HumanoidRootPart.CFrame.X, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position.Y, TargetTarget.Character.HumanoidRootPart.CFrame.Z))
            LocalPlayer.Character.Humanoid.AutoRotate = false
            spawn(function ()
                if azure.Aiming.Target.LookAt == false then
                    LocalPlayer.Character.Humanoid.AutoRotate = true
                end
            end)
        end
    else
        LocalPlayer.Character.Humanoid.AutoRotate = true
    end
end)

angle_Y = 0

RunService.Stepped:Connect(function (param,FPS)
    if azure.Aiming.TargetStrafe.Enabled then
        if azure.Aiming.Target.Enabled and TargetBindEnabled then
            if Toggles.TargetLookAtTggle.Value == true then
                Toggles.TargetLookAtTggle:SetValue(false)
                wait()
                Toggles.TargetLookAtTggle:SetValue(true)
            end
            angle_Y = angle_Y + FPS / azure.Aiming.TargetStrafe.Speed % 1
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(TargetTarget.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 2 * math.pi * angle_Y, 0) * CFrame.new(0, azure.Aiming.TargetStrafe.Height, azure.Aiming.TargetStrafe.Distance)
        end
    end
end)

local circleinstance = Drawing.new("Circle")
local circleinstancex = Drawing.new("Circle")
RunService.Heartbeat:Connect(function ()
    if AimbotDrawFOV then
        circleinstance.Position = Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y + game:GetService("GuiService"):GetGuiInset().Y)
        circleinstance.Visible = true
        circleinstance.Thickness = 2
        circleinstance.Radius =	AimbotFOVSize
        circleinstance.NumSides = 60
        circleinstance.Color = AimbotFOVClr
    else
        circleinstance.Visible = false
    end
    if TargetFOvEnabled then
        circleinstancex.Position = Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y + game:GetService("GuiService"):GetGuiInset().Y)
        circleinstancex.Visible = true
        circleinstancex.Thickness = 2
        circleinstancex.Radius = TargetFOVSize
        circleinstancex.NumSides = 60
        circleinstancex.Color = TargetFovClr
    else
        circleinstancex.Visible = false
    end
    if azure.Blatant.CFrame.Enabled then
        if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
            for i = 1, azure.Blatant.CFrame.Value do
                LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection)
            end
        end
    end
    if azure.Blatant.Exploits.JumpCooldown then
        LocalPlayer.Character.Humanoid.UseJumpPower = false
    else 
        LocalPlayer.Character.Humanoid.UseJumpPower = true
    end
    if azure.Blatant.Exploits.NoSlow then
        wait()
        local bodyeffectsBounderies = LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoJumping') or LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('ReduceWalk') or LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoWalkSpeed')
        if bodyeffectsBounderies then
            bodyeffectsBounderies:Destroy()
        end
        if LocalPlayer.Character.BodyEffects.Reload.Value == true then
            LocalPlayer.Character.BodyEffects.Reload.Value = false
        end
    end
    if azure.Blatant.Exploits.AutoStomp then
        game.ReplicatedStorage.MainEvent:FireServer("Stomp")
    end
    if azure.Blatant.Exploits.AntiBag then
        if LocalPlayer.Character["Christmas_Sock"] then
            LocalPlayer.Character["Christmas_Sock"]:Destroy()
        end
    end
    if azure.Blatant.AntiStomp.Enabled then
        if LocalPlayer.Character.Humanoid.Health <= 1 then
            if azure.Blatant.AntiStomp.Type == "Remove Character" then
                for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v:Destroy()
                    end
                end
            elseif azure.Blatant.AntiStomp.Type == "Remove Humanoid" then
                LocalPlayer.Character.Humanoid:Destroy()
            end
        end
    end
    if azure.Blatant.FakeLag.Enabled then
        repeat
            wait()
            Toggles.AntiFlingEnabled:SetValue(true)
            wait(azure.Blatant.FakeLag.Duration/4)
            Toggles.AntiFlingEnabled:SetValue(false)
        until azure.Blatant.FakeLag.Enabled == false
    end
    if azure.Blatant.AntiAim.VelocityUnderGround then
        VelocityUnderGroundAA()
    else
        LocalPlayer.Character.Humanoid.HipHeight = 2
    end
    if azure.Blatant.AntiAim.RotVelocity.Enabled then
        RotVelocityAA()
    end
    if azure.Blatant.GunMod.AutoReload then
        if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
            if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo") then
                if game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("Ammo").Value <= 0 then
                    game:GetService("ReplicatedStorage").MainEvent:FireServer("Reload", game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA("Tool")) 
                end
            end
        end
    end
end)

OtherGroupbox:AddToggle('RainbowModeXD', {
    Text = 'Rainbow Theme',
    Default = false,
    Tooltip = 'Enable Rainbow Mode',
})

Toggles.RainbowModeXD:OnChanged(function()
    azure.UISettings.Rainbow = Toggles.RainbowModeXD.Value
end)

OtherGroupbox:AddToggle('WatermarkEnabled', {
    Text = 'Watermark',
    Default = true,
    Tooltip = 'Watermark Enabled',
})

Toggles.WatermarkEnabled:OnChanged(function()
    Library:SetWatermarkVisibility(Toggles.WatermarkEnabled.Value)
end)

OtherGroupbox:AddToggle('KeybindFrameEnabled', {
    Text = 'Keybind Frame',
    Default = true,
    Tooltip = 'Keybind Frame Enabled',
})

Toggles.KeybindFrameEnabled:OnChanged(function()
    Library.KeybindFrame.Visible = Toggles.KeybindFrameEnabled.Value
end)


Library:SetWatermark(title_string)



Library:OnUnload(function()
    Library.Unloaded = true
end)

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload Cheat', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' }) 

Library.ToggleKeybind = Options.MenuKeybind 
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings() 
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
ThemeManager:SetFolder('Millionär')
SaveManager:SetFolder('Millionär/dahood')
SaveManager:BuildConfigSection(Tabs['UI Settings']) 
ThemeManager:ApplyToTab(Tabs['UI Settings'])

function AimbotGetTarget()
    local distance = AimbotFOVSize
    local zclosest

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = workspace.CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)).magnitude
            if magnitude < distance then
                zclosest = v
                distance = magnitude
            end
        end
    end
    return zclosest
end

function TargetGetTarget()
    local distance = TargetFOVSize
    local zclosest

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = workspace.CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)).magnitude
            if magnitude < distance then
                zclosest = v
                distance = magnitude
            end
        end
    end
    return zclosest
end

function GetTarget()
    local distance = math.huge
    local zclosest

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = workspace.CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalPlayer:GetMouse().X, LocalPlayer:GetMouse().Y)).magnitude
            if magnitude < distance then
                zclosest = v
                distance = magnitude
            end
        end
    end
    return zclosest
end

function VelocityUnderGroundAA()
    local oldVelocity = LocalPlayer.Character.HumanoidRootPart.Velocity
    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -azure.Blatant.AntiAim.VelocityUnderGroundAmount, oldVelocity.Z)
    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, -azure.Blatant.AntiAim.VelocityUnderGroundAmount, oldVelocity.Z)
    LocalPlayer.Character.Humanoid.HipHeight = VelocityUndergroundHipheight
end

function RotVelocityAA()
    LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, azure.Blatant.AntiAim.RotVelocity.Value, 0)
end

task.spawn(function()
    while game:GetService("RunService").RenderStepped:Wait() do
        if azure.UISettings.Rainbow then
            local Registry = Window.Holder.Visible and Library.Registry or Library.HudRegistry

            for Idx, Object in next, Registry do
                for Property, ColorIdx in next, Object.Properties do
                    if ColorIdx == "AccentColor" or ColorIdx == "AccentColorDark" then
                        local Instance = Object.Instance
                        local yPos = Instance.AbsolutePosition.Y

                        local Mapped = Library:MapValue(yPos, 0, 1080, 0, 0.5) * 0.69
                        local Color = Color3.fromHSV((Library.CurrentRainbowHue - Mapped) % 1, 0.43, 1)

                        if ColorIdx == "AccentColorDark" then
                            Color = Library:GetDarkerColor(Color)
                        end

                        Instance[Property] = Color
                    end
                end
            end
        end
    end
end)
