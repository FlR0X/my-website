if getgenv().b7b09d85e600f432269def391385162e09e8255bd5a2848c15056fa596c7e124 == true then
local realfenv
realfenv = hookfunction(getgenv().getfenv,function(a)
    local num = tonumber(a)
    if num then
        if num > 10 or num < 1 then
            error("Bypassing the error XD")
        else
            return realfenv()
        end
    else
        return realfenv()
    end
end)
 
local maxSim = 1000
getgenv().setsimulationradius = newcclosure(function(i,v)
    local plr = game.Players.LocalPlayer
    sethiddenproperty(plr,"MaxSimulationRadius",maxSim)
    sethiddenproperty(plr,"SimulationRadius",maxSim)
end)
 
local sethidden
sethidden = hookfunction(getgenv().sethiddenproperty,function(i,p,v)
    local plr = game.Players.LocalPlayer
    if i == plr then
        if (p == "MaxSimulationRadius" or p == "SimulationRadius") then
            if v == maxSim then
                sethidden(i,p,v)
            end
        else
            sethidden(i,p,v)
        end
    else
        sethidden(i,p,v)
    end
end)

for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
game:GetService("RunService").Heartbeat:connect(function()
v.Velocity = Vector3.new(-30,0,0)
end)
end
end
end
            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character
            local R = {
                one = Character:WaitForChild("FireMohawk"),
                two = Character:WaitForChild("Vets Day Cap"),
                three = Character:WaitForChild("Robloxclassicred"),
                four = Character:WaitForChild("Kate Hair"),
                five = Character:WaitForChild("Pink Hair"),
                six = Character:WaitForChild("LavanderHair"),
                seven = Character:WaitForChild("Pal Hair"),
                eight = Character:WaitForChild("Hat1"),
                nine = Character:WaitForChild("BlockheadBaseballCap"),
                ten = Character:WaitForChild("Necklace")
            }
            for T, v in next, R do
                v.Handle.AccessoryWeld:Remove()
                for U, V in next, v:GetDescendants() do
                    if V:IsA("Mesh") or V:IsA("SpecialMesh") then
                        V:Remove()
                    end
                end
            end
            local function W(T, v)
                local X = Instance.new("Attachment", T)
                X.Position = Vector3.new(0, 0, 0)
                local Y = Instance.new("Attachment", v)
                Y.Position = Vector3.new(0, 0, 0)
                local Z = Instance.new("AlignPosition", T)
                Z.Attachment0 = X
                Z.Attachment1 = Y
                Z.RigidityEnabled = false
                Z.ReactionForceEnabled = false
                Z.ApplyAtCenterOfMass = true
                Z.MaxForce = 9999999
                Z.MaxVelocity = math.huge
                Z.Responsiveness = 2500
                local _ = Instance.new("AlignOrientation", T)
                _.Attachment0 = X
                _.Attachment1 = Y
                _.ReactionTorqueEnabled = true
                _.PrimaryAxisOnly = false
                _.MaxTorque = 9999999
                _.MaxAngularVelocity = math.huge
                _.Responsiveness = 2500
            end
            local rj = {}
            local sv = {}
            local j7 = 1
            local sw = 0
            local sx = Player:GetMouse()
            cum = 2
            piss = 5
            shit = 0.6
            local sy = BrickColor.new("Black")
            for T = 1, 10 do
                local p = Instance.new("Part", game.Players.LocalPlayer.Character.Torso)
                p.Size = Vector3.new(0.2, 0.2, 0.2)
                p.Anchored = true
                p.CanCollide = false
                p.Transparency = 1
                p.Material = "Neon"
                p.Position = game.Players.LocalPlayer.Character.Torso.Position
                table.insert(rj, p)
            end
            for T = 1, 10 do
                local p = Instance.new("Part", game.Players.LocalPlayer.Character.Torso)
                p.Size = Vector3.new(0.2, 0.2, 0.2)
                p.Anchored = true
                p.CanCollide = false
                p.Transparency = 1
                p.Material = "Neon"
                p.Position = game.Players.LocalPlayer.Character.Torso.Position
                table.insert(sv, p)
            end
            local sound = Instance.new("Sound", game.Players.LocalPlayer.Character.Torso)
            sound.SoundId = "rbxassetid://0"
            sound.Volume = 0
            sound:Play()
            spawn(
                function()
                    local sz = 0
                    while true do
                        if j7 == 1 then
                            if sz < #rj then
                                sz = sz + j7
                            else
                                j7 = -1
                                sy = BrickColor.Random()
                            end
                        elseif j7 == -1 then
                            if sz > 1 then
                                sz = sz + j7
                            else
                                j7 = 1
                                sy = BrickColor.Random()
                            end
                        end
                        local sA = rj[sz]
                        local sB = sv[sz]
                        sA.BrickColor = BrickColor.Random()
                        sB.BrickColor = BrickColor.Random()
                        sw = sound.PlaybackLoudness / 500
                        sA.Size = Vector3.new(sw, sw, 0.2)
                        sB.Size = Vector3.new(sw, sw, 0.2)
                        wait()
                        sA.BrickColor = sy
                        sB.BrickColor = sy
                    end
                end
            )
            game:GetService("RunService").RenderStepped:connect(
                function()
                    for T = 1, #rj do
                        if T == 1 then
                            rj[T].CFrame = rj[T].CFrame:lerp(game.Players.LocalPlayer.Character.Torso.CFrame, 0.5)
                        else
                            rj[T].CFrame =
                                rj[T].CFrame:lerp(
                                rj[T - 1].CFrame * CFrame.Angles(-sw / piss, math.sin(-sw / cum), 0) *
                                    CFrame.new(0, 0, 2),
                                shit
                            )
                        end
                    end
                    for T = 1, #sv do
                        if T == 1 then
                            sv[T].CFrame = sv[T].CFrame:lerp(game.Players.LocalPlayer.Character.Torso.CFrame, 0.9)
                        else
                            sv[T].CFrame =
                                sv[T].CFrame:lerp(
                                sv[T - 1].CFrame * CFrame.Angles(-sw / 20, math.sin(sw / 50), 0) *
                                    CFrame.new(0, 0, 0.15),
                                0.8
                            )
                        end
                    end
                end
            )
            sx.KeyDown:connect(
                function(dr)
                    if dr == "t" then
                        cum = -2
                        piss = 5
                    end
                    if dr == "r" then
                        cum = 50000
                        piss = 2
                    end
                    if dr == "e" then
                        cum = 2
                        piss = 5
                    end
                    if dr == "z" then
                        shit = shit + 0.05
                    end
                    if dr == "x" then
                        shit = shit - 0.05
                    end
                    if dr == "c" then
                        cum = cum + 0.5
                    end
                    if dr == "v" then
                        cum = cum - 0.5
                    end
                end
            )
            local sC = Instance.new("ScreenGui")
            local jI = Instance.new("Frame")
            local sD = Instance.new("TextBox")
            local sE = Instance.new("TextButton")
            local sF = Instance.new("TextBox")
            local sG = Instance.new("TextBox")
            local sH = Instance.new("TextButton")
            local sI = Instance.new("TextButton")
            local sJ = Instance.new("TextLabel")
            local sK = Instance.new("TextButton")
            local sL = Instance.new("TextButton")
            local sM = Instance.new("TextButton")
            local sN = Instance.new("TextButton")
            sC.Name = "visualizergui"
            sC.Parent = game.Players.LocalPlayer.PlayerGui
            jI.Parent = sC
            jI.BackgroundColor3 = Color3.new(0.701961, 0.952941, 1)
            jI.BackgroundTransparency = 0.20000000298023
            jI.BorderColor3 = Color3.new(0.211765, 0.329412, 0.415686)
            jI.BorderSizePixel = 8
            jI.Position = UDim2.new(0, 51, 0, 213)
            jI.Size = UDim2.new(0, 418, 0, 213)
            jI.Active = true
            jI.Draggable = true
            jI.Visible = false
            sD.Name = "idvalue"
            sD.Parent = jI
            sD.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sD.BackgroundTransparency = 0.5
            sD.Size = UDim2.new(0, 418, 0, 50)
            sD.Font = Enum.Font.Fantasy
            sD.FontSize = Enum.FontSize.Size24
            sD.Text = "Put ID plz"
            sD.TextSize = 24
            sE.Name = "play"
            sE.Parent = jI
            sE.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sE.BackgroundTransparency = 0.44999998807907
            sE.BorderColor3 = Color3.new(0.207843, 0.0901961, 0.0705882)
            sE.BorderSizePixel = 3
            sE.Position = UDim2.new(0, 9, 0, 82)
            sE.Size = UDim2.new(0, 117, 0, 50)
            sE.Font = Enum.Font.SourceSans
            sE.FontSize = Enum.FontSize.Size28
            sE.Text = "Play"
            sE.TextSize = 28
            sF.Name = "volume"
            sF.Parent = jI
            sF.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sF.BackgroundTransparency = 0.44999998807907
            sF.BorderColor3 = Color3.new(0.207843, 0.0901961, 0.0705882)
            sF.BorderSizePixel = 3
            sF.Position = UDim2.new(0, 151, 0, 82)
            sF.Size = UDim2.new(0, 117, 0, 50)
            sF.Font = Enum.Font.SourceSans
            sF.FontSize = Enum.FontSize.Size28
            sF.Text = "Volume"
            sF.TextSize = 28
            sG.Name = "pitch"
            sG.Parent = jI
            sG.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sG.BackgroundTransparency = 0.44999998807907
            sG.BorderColor3 = Color3.new(0.207843, 0.0901961, 0.0705882)
            sG.BorderSizePixel = 3
            sG.Position = UDim2.new(0, 291, 0, 82)
            sG.Size = UDim2.new(0, 117, 0, 50)
            sG.Font = Enum.Font.SourceSans
            sG.FontSize = Enum.FontSize.Size28
            sG.Text = "Pitch"
            sG.TextSize = 28
            sH.Name = "close"
            sH.Parent = jI
            sH.BackgroundColor3 = Color3.new(1, 0, 0.0156863)
            sH.BackgroundTransparency = 0.40000000596046
            sH.Position = UDim2.new(0, 393, 0, 190)
            sH.Size = UDim2.new(0, 25, 0, 23)
            sH.Font = Enum.Font.SourceSans
            sH.FontSize = Enum.FontSize.Size28
            sH.Text = "X"
            sH.TextSize = 28
            sI.Name = "min"
            sI.Parent = jI
            sI.BackgroundColor3 = Color3.new(0.286275, 0.286275, 1)
            sI.BackgroundTransparency = 0.40000000596046
            sI.Position = UDim2.new(0, 357, 0, 190)
            sI.Size = UDim2.new(0, 25, 0, 23)
            sI.Font = Enum.Font.SourceSans
            sI.FontSize = Enum.FontSize.Size36
            sI.Text = "-"
            sI.TextSize = 36
            sJ.Name = "credits"
            sJ.Parent = jI
            sJ.BackgroundColor3 = Color3.new(1, 1, 1)
            sJ.BackgroundTransparency = 1
            sJ.Position = UDim2.new(0, 0, 0, 161)
            sJ.Size = UDim2.new(0, 200, 0, 52)
            sJ.Font = Enum.Font.SourceSans
            sJ.FontSize = Enum.FontSize.Size14
            sJ.Text = "credits to mr steal yo bork for gui"
            sJ.TextSize = 14
            sJ.TextWrapped = true
            sK.Name = "open"
            sK.Parent = sC
            sK.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sK.BackgroundTransparency = 0.44999998807907
            sK.BorderColor3 = Color3.new(0.207843, 0.0901961, 0.0705882)
            sK.BorderSizePixel = 3
            sK.Position = UDim2.new(0, 0, 0, 400)
            sK.Size = UDim2.new(0, 59, 0, 50)
            sK.Font = Enum.Font.SourceSans
            sK.FontSize = Enum.FontSize.Size28
            sK.Text = "Open"
            sK.TextSize = 28
            sK.Visible = false
            sL.Name = "set2"
            sL.Parent = jI
            sL.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sL.BackgroundTransparency = 0.44999998807907
            sL.BorderColor3 = Color3.new(0.207843, 0.0901961, 0.0705882)
            sL.BorderSizePixel = 3
            sL.Position = UDim2.new(0, 325, 0, 136)
            sL.Size = UDim2.new(0, 55, 0, 25)
            sL.Font = Enum.Font.SourceSans
            sL.FontSize = Enum.FontSize.Size24
            sL.Text = "Set"
            sL.TextSize = 24
            sL.TextWrapped = true
            sM.Name = "set1"
            sM.Parent = jI
            sM.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sM.BackgroundTransparency = 0.44999998807907
            sM.BorderColor3 = Color3.new(0.207843, 0.0901961, 0.0705882)
            sM.BorderSizePixel = 3
            sM.Position = UDim2.new(0, 181, 0, 136)
            sM.Size = UDim2.new(0, 55, 0, 25)
            sM.Font = Enum.Font.SourceSans
            sM.FontSize = Enum.FontSize.Size24
            sM.Text = "Set"
            sM.TextSize = 24
            sM.TextWrapped = true
            sN.Name = "loop"
            sN.Parent = jI
            sN.BackgroundColor3 = Color3.new(0.666667, 1, 1)
            sN.BackgroundTransparency = 0.44999998807907
            sN.BorderColor3 = Color3.new(0.207843, 0.0901961, 0.0705882)
            sN.BorderSizePixel = 3
            sN.Position = UDim2.new(0, 241, 0, 188)
            sN.Size = UDim2.new(0, 84, 0, 25)
            sN.Font = Enum.Font.SourceSans
            sN.FontSize = Enum.FontSize.Size18
            sN.Text = "Loop : OFF"
            sN.TextSize = 18
            sN.TextWrapped = true
            function start()
                wait(0.5)
                jI.Position = UDim2.new(0, -500, 0, 400)
                jI.Visible = true
                jI:TweenPosition(UDim2.new(0, 0, 0, 400), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 1)
            end
            if game.Players.LocalPlayer.Character then
                start()
            else
                print "character not found plz try again XD"
            end
            function minimize()
                jI:TweenPosition(UDim2.new(0, 0, 0, 400), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 1)
                sJ.Text = ""
                sI.Text = ""
                sH.Text = ""
                sE.Text = ""
                sG.Text = ""
                sF.Text = ""
                sD.Text = ""
                sM.Text = ""
                sL.Text = ""
                sN.Text = ""
                jI:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sJ:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sI:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sH:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sD:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sF:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sE:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sG:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sN:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sM:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sL:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                jI:TweenPosition(UDim2.new(0, 0, 0, 400), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                wait(0.5)
                jI.Visible = false
                sK.Visible = true
            end
            function show()
                sK.Visible = false
                jI.Position = UDim2.new(0, -500, 0, 400)
                jI.Visible = true
                sJ.Text = "credits to me for gui, i didn't make the visualizer credits to whoever leaked it or made it."
                sI.Text = "-"
                sH.Text = "X"
                sE.Text = "Play"
                sG.Text = "Pitch"
                sF.Text = "Volume"
                sD.Text = "Put ID plz"
                sM.Text = "Set"
                sL.Text = "Set"
                sN.Text = "Loop : OFF"
                jI:TweenSize(UDim2.new(0, 418, 0, 213), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sJ:TweenSize(UDim2.new(0, 200, 0, 52), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sI:TweenSize(UDim2.new(0, 25, 0, 23), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sH:TweenSize(UDim2.new(0, 25, 0, 23), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sD:TweenSize(UDim2.new(0, 418, 0, 50), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sF:TweenSize(UDim2.new(0, 117, 0, 50), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sE:TweenSize(UDim2.new(0, 117, 0, 50), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sG:TweenSize(UDim2.new(0, 117, 0, 50), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sM:TweenSize(UDim2.new(0, 55, 0, 25), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sN:TweenSize(UDim2.new(0, 84, 0, 25), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sL:TweenSize(UDim2.new(0, 55, 0, 25), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                jI:TweenPosition(UDim2.new(0, 0, 0, 400), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
            end
            function exitdatshit()
                jI:TweenPosition(UDim2.new(0, 0, 0, 400), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 1)
                sJ.Text = ""
                sI.Text = ""
                sH.Text = ""
                sE.Text = ""
                sG.Text = ""
                sF.Text = ""
                sD.Text = ""
                jI:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sJ:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sI:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sH:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sD:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sF:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sE:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sG:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sM:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sL:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                sN:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                jI:TweenPosition(UDim2.new(0, 0, 0, 400), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.5)
                wait(0.5)
                sC:Destroy()
            end
            wait(1)
            sI.MouseButton1Down:connect(
                function()
                    minimize()
                end
            )
            sK.MouseButton1Down:connect(
                function()
                    show()
                end
            )
            sH.MouseButton1Down:connect(
                function()
                    exitdatshit()
                end
            )
            sM.MouseButton1Down:connect(
                function()
                    sound.Volume = sF.Text
                end
            )
            sL.MouseButton1Down:connect(
                function()
                    sound.Pitch = sG.Text
                end
            )
            sE.MouseButton1Down:connect(
                function()
                    sound.TimePosition = 0
                    sound.SoundId = "rbxassetid://" .. sD.Text
                    game.Players.LocalPlayer.Character.SuperFlyGoldBoombox.Remote:FireServer("PlaySong", sD.text)
                end
            )
            sN.MouseButton1Down:connect(
                function()
                    if sN.Text == "Loop : OFF" then
                        sound.Looped = true
                        sN.Text = "Loop : ON"
                    else
                        sound.Looped = false
                        sN.Text = "Loop : OFF"
                    end
                end
            )
            Character["Torso"].Part.Name = "Part"
            Character["Torso"].Part.Name = "Part1"
            Character["Torso"].Part.Name = "Part2"
            Character["Torso"].Part.Name = "Part3"
            Character["Torso"].Part.Name = "Part4"
            Character["Torso"].Part.Name = "Part5"
            Character["Torso"].Part.Name = "Part6"
            Character["Torso"].Part.Name = "Part7"
            Character["Torso"].Part.Name = "Part8"
            Character["Torso"].Part.Name = "Part9"
            W(R.one.Handle, Character["Torso"].Part)
            W(R.two.Handle, Character["Torso"].Part1)
            W(R.three.Handle, Character["Torso"].Part2)
            W(R.four.Handle, Character["Torso"].Part3)
            W(R.five.Handle, Character["Torso"].Part4)
            W(R.six.Handle, Character["Torso"].Part5)
            W(R.seven.Handle, Character["Torso"].Part6)
            W(R.eight.Handle, Character["Torso"].Part7)
            W(R.nine.Handle, Character["Torso"].Part8)
            W(R.ten.Handle, Character["Torso"].Part9)
            R.one.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            R.two.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.three.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.four.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.five.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.six.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.seven.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.eight.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.nine.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.ten.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            Character:WaitForChild("Torso").Part:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part1:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part2:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part3:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part4:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part5:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part6:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part7:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part8:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part9:FindFirstChild("Attachment").Name = "Attachment1"
            Character:WaitForChild("Torso").Part.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part1.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part2.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part3.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part4.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part5.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part6.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part7.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part8.Attachment1.Position = Vector3.new(0, 0, 0.75)
            Character:WaitForChild("Torso").Part9.Attachment1.Position = Vector3.new(0, 0, 0.75)
        
