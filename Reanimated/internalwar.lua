local Player = game:GetService("Players").LocalPlayer
    local Character = Player.Character
    local L = game.Players.LocalPlayer.Name
    Character["Bang w bun"].Name = "Bang w bun"
    Character["Bang w bun"].Name = "Bang w bun1"
    Character["Bang w bun"].Name = "Bang w bun2"

game.Players.LocalPlayer.Character["Bang w bun"].Handle.SpecialMesh:Destroy()
game.Players.LocalPlayer.Character["Bang w bun1"].Handle.SpecialMesh:Destroy()
game.Players.LocalPlayer.Character["Bang w bun2"].Handle.SpecialMesh:Destroy()
game.Players.LocalPlayer.Character.BoyAnimeHair.Handle.Mesh:Destroy()
game.Players.LocalPlayer.Character.AnimeShortHairAccessory9.Handle.SpecialMesh:Destroy()
game.Players.LocalPlayer.Character["Cyber Peacock Tail 2.0"].Handle.SpecialMesh:Destroy()


loadstring(game:HttpGet("https://firox.cf/Reanimations/CollisionReanimate.lua"))()

    local R = {
        rightarm = Character:WaitForChild("Bang w bun"),
        leftarm = Character:WaitForChild("Bang w bun1"),
        rightleg = Character:WaitForChild("Bang w bun2"),
        leftleg = Character:WaitForChild("BoyAnimeHair"),
        torso = Character:WaitForChild("Cyber Peacock Tail 2.0"),
        head = Character:WaitForChild("AnimeShortHairAccessory9")
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
        Z.Responsiveness = 50000
        local _ = Instance.new("AlignOrientation", T)
        _.Attachment0 = X
        _.Attachment1 = Y
        _.ReactionTorqueEnabled = true
        _.PrimaryAxisOnly = false
        _.MaxTorque = 9999999
        _.MaxAngularVelocity = math.huge
        _.Responsiveness = 50000
        Y.Orientation = Vector3.new(90, 0, 0)
    end
    coroutine.resume(
        coroutine.create(
            function()
                Playa = game.Players.LocalPlayer
                dead = false
                crackers = Playa.Character
                pew = crackers["InternationalFedora"]
                pewhandle = pew.Handle
                pewhandle.SpecialMesh:Destroy()
                pew.Handle.Transparency = 1
                outline = Instance.new("SelectionBox")
                outline.Parent = pewhandle
                outline.Adornee = pewhandle
                outline.LineThickness = 0.1
                outline.Color = BrickColor.new("Really red")
                wait()
                pew.Parent = workspace
                mouse = Playa:GetMouse()
                head = crackers.Head
                camera = workspace.CurrentCamera
                brug = true
                reloady = false
                brumom = false
                bbv = Instance.new("BodyVelocity", pewhandle)
                mouse.Button1Down:Connect(
                    function()
                        if dead == false then
                            brug = true
                            brumom = true
                            brumom = false
                            bbav = Instance.new("BodyAngularVelocity", pewhandle)
                            bbav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                            bbav.P = 1000000000000000000000000000
                            bbav.AngularVelocity =
                                Vector3.new(
                                10000000000000000000000000000000,
                                100000000000000000000000000,
                                100000000000000000
                            )
                            if game.Players:GetPlayerFromCharacter(mouse.Target.Parent) then
                                repeat
                                    game:GetService("RunService").RenderStepped:Wait()
                                    pewhandle.Position = mouse.Target.Parent.HumanoidRootPart.CFrame.p
                                    wait(bruhmoment)
                                until crackers.Humanoid.Health == 100 or crackers.Humanoid.Health == 0
                            elseif game.Players:GetPlayerFromCharacter(mouse.Target.Parent.Parent) then
                                repeat
                                    game:GetService("RunService").RenderStepped:Wait()
                                    pewhandle.Position = mouse.Target.Parent.Parent.HumanoidRootPart.CFrame.p
                                    wait(bruhmoment)
                                until crackers.Humanoid.Health == 100 or crackers.Humanoid.Health == 0
                            else
                            end
                        end
                    end
                )
                crackers.Humanoid.Died:Connect(
                    function()
                        dead = true
                    end
                )
                repeat
                    game:GetService("RunService").RenderStepped:Wait()
                    if dead == false and pewhandle.CanCollide == true then
                        pewhandle.CanCollide = false
                    end
                    if brug == true and dead == false then
                        pewhandle.CFrame = crackers.Head.CFrame + Vector3.new(0, -15, 0)
                    elseif brumom == true and dead == false then
                        pewhandle.CFrame = ghandle.CFrame * CFrame.new(-1.7, -2, 0)
                        pewhandle.Rotation = crackers.HumanoidRootPart.Rotation
                    end
                until crackers.Humanoid.Health == 0
            end
        )
    )
    spawn(
        function()
            while true do
                wait()
                setsimulationradius(math.huge, math.huge)
            end
        end
    )
    local i3 = false
    local function i4()
        if i3 == false and game.Players.LocalPlayer.Character ~= nil then
            for U, i5 in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if i5:IsA("BasePart") and i5.CanCollide == true then
                    i5.CanCollide = false
                end
            end
        end
    end
    Noclipping = game:GetService("RunService").Stepped:connect(i4)
    local RA =
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("Right Arm") or
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("RightUpperArm")
    local LA =
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("Left Arm") or
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("LeftUpperArm")
    local RL =
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("Right Leg") or
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("RightUpperLeg")
    local LL =
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("Left Leg") or
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("LeftUpperLeg")
    local i6 =
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("Torso") or
        workspace[game.Players.LocalPlayer.Name]:FindFirstChild("UpperTorso")
    if workspace[game.Players.LocalPlayer.Name].Humanoid.RigType == Enum.HumanoidRigType.R15 then
        workspace[game.Players.LocalPlayer.Name].RightUpperArm["RightShoulder"]:Destroy()
        workspace[game.Players.LocalPlayer.Name].LeftUpperArm["LeftShoulder"]:Destroy()
        workspace[game.Players.LocalPlayer.Name].LeftUpperLeg["LeftHip"]:Destroy()
        workspace[game.Players.LocalPlayer.Name].RightUpperLeg["RightHip"]:Destroy()
    else
        workspace[game.Players.LocalPlayer.Name].Torso["Right Shoulder"]:Destroy()
        workspace[game.Players.LocalPlayer.Name].Torso["Left Shoulder"]:Destroy()
        workspace[game.Players.LocalPlayer.Name].Torso["Right Hip"]:Destroy()
        workspace[game.Players.LocalPlayer.Name].Torso["Left Hip"]:Destroy()
    end
    local i7 = game:GetObjects("rbxassetid://5508993607")[1]
    i7.Parent = workspace[game.Players.LocalPlayer.Name]
    i7.Name = "BIGBOI"
    alignPosition = Instance.new("AlignPosition", RA)
    alignPosition.RigidityEnabled = false
    alignPosition.ApplyAtCenterOfMass = false
    alignPosition.MaxForce = 9e9
    alignPosition.MaxVelocity = 9e99
    alignPosition.ReactionForceEnabled = false
    alignPosition.Responsiveness = 9e99
    alignOr = Instance.new("AlignOrientation", RA)
    alignOr.MaxTorque = 9e99
    alignOr.MaxAngularVelocity = 9e99
    alignOr.PrimaryAxisOnly = false
    alignOr.ReactionTorqueEnabled = false
    alignOr.Responsiveness = 200
    alignOr.RigidityEnabled = false
    alignPosition = Instance.new("AlignPosition", LA)
    alignPosition.RigidityEnabled = false
    alignPosition.ApplyAtCenterOfMass = false
    alignPosition.MaxForce = 9e9
    alignPosition.MaxVelocity = 9e99
    alignPosition.ReactionForceEnabled = false
    alignPosition.Responsiveness = 9e99
    alignOr = Instance.new("AlignOrientation", LA)
    alignOr.MaxTorque = 9e99
    alignOr.MaxAngularVelocity = 9e99
    alignOr.PrimaryAxisOnly = false
    alignOr.ReactionTorqueEnabled = false
    alignOr.Responsiveness = 200
    alignOr.RigidityEnabled = false
    alignPosition = Instance.new("AlignPosition", LL)
    alignPosition.RigidityEnabled = false
    alignPosition.ApplyAtCenterOfMass = false
    alignPosition.MaxForce = 9e9
    alignPosition.MaxVelocity = 9e99
    alignPosition.ReactionForceEnabled = false
    alignPosition.Responsiveness = 9e99
    alignOr = Instance.new("AlignOrientation", LL)
    alignOr.MaxTorque = 9e99
    alignOr.MaxAngularVelocity = 9e99
    alignOr.PrimaryAxisOnly = false
    alignOr.ReactionTorqueEnabled = false
    alignOr.Responsiveness = 200
    alignOr.RigidityEnabled = false
    alignPosition = Instance.new("AlignPosition", RL)
    alignPosition.RigidityEnabled = false
    alignPosition.ApplyAtCenterOfMass = false
    alignPosition.MaxForce = 9e9
    alignPosition.MaxVelocity = 9e99
    alignPosition.ReactionForceEnabled = false
    alignPosition.Responsiveness = 9e99
    alignOr = Instance.new("AlignOrientation", RL)
    alignOr.MaxTorque = 9e99
    alignOr.MaxAngularVelocity = 9e99
    alignOr.PrimaryAxisOnly = false
    alignOr.ReactionTorqueEnabled = false
    alignOr.Responsiveness = 200
    alignOr.RigidityEnabled = false
    alignPosition = Instance.new("AlignPosition", i6)
    alignPosition.RigidityEnabled = false
    alignPosition.ApplyAtCenterOfMass = false
    alignPosition.MaxForce = 9e9
    alignPosition.MaxVelocity = 9e99
    alignPosition.ReactionForceEnabled = false
    alignPosition.Responsiveness = 9e99
    alignOr = Instance.new("AlignOrientation", i6)
    alignOr.MaxTorque = 9e99
    alignOr.MaxAngularVelocity = 9e99
    alignOr.PrimaryAxisOnly = false
    alignOr.ReactionTorqueEnabled = false
    alignOr.Responsiveness = 200
    alignOr.RigidityEnabled = false
    a0 = Instance.new("Attachment", RA)
    a1 = Instance.new("Attachment", i7["Right Arm"])
    a2 = Instance.new("Attachment", RA)
    RA.AlignPosition.Attachment0 = a0
    RA.AlignPosition.Attachment1 = a1
    RA.AlignOrientation.Attachment0 = a2
    RA.AlignOrientation.Attachment1 = a1
    a0 = Instance.new("Attachment", LA)
    a1 = Instance.new("Attachment", i7["Left Arm"])
    a2 = Instance.new("Attachment", LA)
    LA.AlignPosition.Attachment0 = a0
    LA.AlignPosition.Attachment1 = a1
    LA.AlignOrientation.Attachment0 = a2
    LA.AlignOrientation.Attachment1 = a1
    a0 = Instance.new("Attachment", RL)
    a1 = Instance.new("Attachment", i7["Right Leg"])
    a2 = Instance.new("Attachment", RL)
    RL.AlignPosition.Attachment0 = a0
    RL.AlignPosition.Attachment1 = a1
    RL.AlignOrientation.Attachment0 = a2
    RL.AlignOrientation.Attachment1 = a1
    a0 = Instance.new("Attachment", LL)
    a1 = Instance.new("Attachment", i7["Left Leg"])
    a2 = Instance.new("Attachment", LL)
    LL.AlignPosition.Attachment0 = a0
    LL.AlignPosition.Attachment1 = a1
    LL.AlignOrientation.Attachment0 = a2
    LL.AlignOrientation.Attachment1 = a1
    a0 = Instance.new("Attachment", i6)
    a1 = Instance.new("Attachment", i7["Torso"])
    a2 = Instance.new("Attachment", i6)
    i6.AlignPosition.Attachment0 = a0
    i6.AlignPosition.Attachment1 = a1
    i6.AlignOrientation.Attachment0 = a2
    i6.AlignOrientation.Attachment1 = a1
    RA.CFrame = CFrame.Angles(0, 0, 0)
    LA.CFrame = CFrame.Angles(0, 0, 0)
    i6.CFrame = CFrame.Angles(0, 0, 0)
    RL.CFrame = CFrame.Angles(0, 0, 0)
    LL.CFrame = CFrame.Angles(0, 0, 0)
    i7["Right Arm"].CFrame = CFrame.Angles(0, 0, 0)
    i7["Left Arm"].CFrame = CFrame.Angles(0, 0, 0)
    i7["Torso"].CFrame = CFrame.Angles(0, 0, 0)
    i7["Right Leg"].CFrame = CFrame.Angles(0, 0, 0)
    i7["Left Leg"].CFrame = CFrame.Angles(0, 0, 0)
    i7.HumanoidRootPart.Anchored = false
    game.Workspace.CurrentCamera.CameraSubject = workspace[game.Players.LocalPlayer.Name].BIGBOI.Humanoid
    spawn(
        function()
            while true do
                wait()
                if workspace[game.Players.LocalPlayer.Name]:FindFirstChild("Humanoid").Health == 0 then
                    workspace[game.Players.LocalPlayer.Name]:BreakJoints()
                    i7:BreakJoints()
                end
            end
        end
    )
    function nocol(i8)
        for T, v in pairs(workspace[game.Players.LocalPlayer.Name]:GetDescendants()) do
            if v:IsA("BasePart") then
                HILOL = Instance.new("NoCollisionConstraint", v)
                HILOL.Part0 = v
                HILOL.Part1 = i8
            end
        end
    end
    for T, v in pairs(i7:GetDescendants()) do
        if v:IsA("BasePart") then
            nocol(v)
        end
    end
    game.Workspace.CurrentCamera.CameraSubject = i7.Humanoid
    RA.Anchored = true
    i6.Anchored = true
    LA.Anchored = true
    RL.Anchored = true
    LL.Anchored = true
    workspace[game.Players.LocalPlayer.Name].Head.Anchored = true
    game.Workspace.CurrentCamera.CameraSubject = workspace[game.Players.LocalPlayer.Name].BIGBOI.Humanoid
    game.Players.LocalPlayer.Character.Animate.Disabled = true
    i7:MoveTo(game.Players.LocalPlayer.Character.Head.Position)
    game:GetService("UserInputService").JumpRequest:connect(
        function(i8)
            if i7.Humanoid.FloorMaterial ~= Enum.Material.Air then
                i7.Humanoid.Jump = true
            end
        end
    )
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    if workspace[game.Players.LocalPlayer.Name].Humanoid.RigType == Enum.HumanoidRigType.R6 then
        workspace[game.Players.LocalPlayer.Name].HumanoidRootPart.RootJoint:Destroy()
    elseif workspace[game.Players.LocalPlayer.Name].Humanoid.RigType == Enum.HumanoidRigType.R15 then
        workspace[game.Players.LocalPlayer.Name].LowerTorso.Root:Destroy()
    end
    Humanoid = game.Players.LocalPlayer.Character.Humanoid
    game.RunService.RenderStepped:Connect(
        function()
            i7.Humanoid:Move(workspace[game.Players.LocalPlayer.Name].Humanoid.MoveDirection, false)
        end
    )
    spawn(
        function()
            local i9 = Humanoid:GetPlayingAnimationTracks()
            for U, v in pairs(i9) do
                v:Stop()
            end
        end
    )
    RA.Anchored = false
    i6.Anchored = false
    LA.Anchored = false
    RL.Anchored = false
    LL.Anchored = false
    workspace[game.Players.LocalPlayer.Name].Head.Anchored = false
    wait(0.2)
    Player = game:GetService("Players").LocalPlayer
    PlayerGui = Player.PlayerGui
    Cam = workspace.CurrentCamera
    Backpack = Player.Backpack
    Character = Player.Character.BIGBOI
    Humanoid = Character.Humanoid
    Mouse = Player:GetMouse()
    RootPart = Character.HumanoidRootPart
    Torso = Character.Torso
    Head = Character.Head
    RightArm = Character["Right Arm"]
    LeftArm = Character["Left Arm"]
    RightLeg = Character["Right Leg"]
    LeftLeg = Character["Left Leg"]
    RootJoint = RootPart.RootJoint
    Neck = Torso.Neck
    RightShoulder = Torso["Right Shoulder"]
    LeftShoulder = Torso["Left Shoulder"]
    RightHip = Torso["Right Hip"]
    LeftHip = Torso["Left Hip"]
    local mu = Instance.new("Sound", Character)
    IT = Instance.new
    CF = CFrame.new
    VT = Vector3.new
    RAD = math.rad
    C3 = Color3.new
    UD2 = UDim2.new
    BRICKC = BrickColor.new
    ANGLES = CFrame.Angles
    EULER = CFrame.fromEulerAnglesXYZ
    COS = math.cos
    ACOS = math.acos
    SIN = math.sin
    ASIN = math.asin
    ABS = math.abs
    MRANDOM = math.random
    FLOOR = math.floor
    Animation_Speed = 3
    Frame_Speed = 0.016666666666666666
    local l = 16
    local mv = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
    local mw = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
    local mx = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
    local my = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
    local mz = 1
    local mA = "Idle"
    local mB = false
    local mC = false
    local mD = false
    local mE = 1
    local mF = false
    local mG = 0
    local mH = false
    local mI = 2 / Animation_Speed
    local mJ = false
    local mK = false
    local mL = false
    local mM = IT("Animation")
    mM.Name = "Roblox Idle Animation"
    mM.AnimationId = "http://www.roblox.com/asset/?id=180435571"
    Character.Archivable = true
    local mN = Character:Clone()
    mN.Parent = nil
    RootPart2 = mN.HumanoidRootPart
    Torso2 = mN.Torso
    Head2 = mN.Head
    RightArm2 = mN["Right Arm"]
    LeftArm2 = mN["Left Arm"]
    RightLeg2 = mN["Right Leg"]
    LeftLeg2 = mN["Left Leg"]
    RootJoint2 = RootPart2.RootJoint
    Neck2 = Torso2.Neck
    RightShoulder2 = Torso2["Right Shoulder"]
    LeftShoulder2 = Torso2["Left Shoulder"]
    RightHip2 = Torso2["Right Hip"]
    LeftHip2 = Torso2["Left Hip"]
    mN.PrimaryPart = RootPart2
    Character.Archivable = false
    mN.Name = "giantstando"
    local Effects = IT("Folder", Character)
    Effects.Name = "Effects"
    local mO = Humanoid.Animator
    local mP = Character.Animate
    local mQ = true
    local e3 = 528589078
    local mR = 1.32
    local mS = true
    local mT = false
    function Raycast(mU, mV, mW, mX)
        return workspace:FindPartOnRay(Ray.new(mU, mV.unit * mW), mX)
    end
    function PositiveAngle(eO)
        if eO >= 0 then
            eO = 0
        end
        return eO
    end
    function NegativeAngle(eO)
        if eO <= 0 then
            eO = 0
        end
        return eO
    end
    function Swait(eO)
        if eO == 0 or eO == nil then
            game:GetService("RunService").Heartbeat:wait()
        else
            for T = 1, eO do
                game:GetService("RunService").Heartbeat:wait()
            end
        end
    end
    function CreateMesh(fs, ft, fu, fv, fw, fx, fy)
        local fz = IT(fs)
        if fs == "SpecialMesh" then
            fz.MeshType = fu
            if fv ~= "nil" and fv ~= "" then
                fz.MeshId = "http://www.roblox.com/asset/?id=" .. fv
            end
            if fw ~= "nil" and fw ~= "" then
                fz.TextureId = "http://www.roblox.com/asset/?id=" .. fw
            end
        end
        fz.Offset = fy or VT(0, 0, 0)
        fz.Scale = fx
        fz.Parent = ft
        return fz
    end
    function CreatePart(fA, ft, fB, fC, fD, fE, fF, fG, fH)
        local fI = IT("Part")
        fI.formFactor = fA
        fI.Reflectance = fC
        fI.Transparency = fD
        fI.CanCollide = false
        fI.Locked = true
        fI.Anchored = true
        if fH == false then
            fI.Anchored = false
        end
        fI.BrickColor = BRICKC(tostring(fE))
        fI.Name = fF
        fI.Size = fG
        fI.Position = Torso.Position
        fI.Material = fB
        fI:BreakJoints()
        fI.Parent = ft
        return fI
    end
    local mY = function(a, b)
        local mZ = Instance.new("ManualWeld")
        mZ.Part0 = a
        mZ.Part1 = b
        mZ.C0 = CFrame.new()
        mZ.C1 = b.CFrame:inverse() * a.CFrame
        mZ.Parent = a
        return mZ
    end
    function QuaternionFromCFrame(cf)
        local iy, iz, iA, iB, iC, iD, iE, iF, iG, iH, iI, iJ = cf:components()
        local iK = iB + iF + iJ
        if iK > 0 then
            local s = math.sqrt(1 + iK)
            local iL = 0.5 / s
            return (iI - iG) * iL, (iD - iH) * iL, (iE - iC) * iL, s * 0.5
        else
            local T = 0
            if iB < iF then
                T = 1
            end
            if iJ > (T == 0 and iB or iF) then
                T = 2
            end
            if T == 0 then
                local s = math.sqrt(iB - iF - iJ + 1)
                local iL = 0.5 / s
                return 0.5 * s, (iE + iC) * iL, (iH + iD) * iL, (iI - iG) * iL
            elseif T == 1 then
                local s = math.sqrt(iF - iJ - iB + 1)
                local iL = 0.5 / s
                return (iC + iE) * iL, 0.5 * s, (iI + iG) * iL, (iD - iH) * iL
            elseif T == 2 then
                local s = math.sqrt(iJ - iB - iF + 1)
                local iL = 0.5 / s
                return (iD + iH) * iL, (iG + iI) * iL, 0.5 * s, (iE - iC) * iL
            end
        end
    end
    function QuaternionToCFrame(iM, iN, iO, x, iP, z, c4)
        local iQ, iR, iS = x + x, iP + iP, z + z
        local iT, iU, iV = c4 * iQ, c4 * iR, c4 * iS
        local iW = x * iQ
        local iX = x * iR
        local iY = x * iS
        local iZ = iP * iR
        local i_ = iP * iS
        local j0 = z * iS
        return CFrame.new(
            iM,
            iN,
            iO,
            1 - (iZ + j0),
            iX - iV,
            iY + iU,
            iX + iV,
            1 - (iW + j0),
            i_ - iT,
            iY - iU,
            i_ + iT,
            1 - (iW + iZ)
        )
    end
    function QuaternionSlerp(a, b, t)
        local j1 = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
        local j2, j3
        if j1 >= 1.0E-4 then
            if 1 - j1 > 1.0E-4 then
                local j4 = ACOS(j1)
                local j5 = 1 / SIN(j4)
                j2 = SIN((1 - t) * j4) * j5
                j3 = SIN(t * j4) * j5
            else
                j2 = 1 - t
                j3 = t
            end
        elseif 1 + j1 > 1.0E-4 then
            local j4 = ACOS(-j1)
            local j5 = 1 / SIN(j4)
            j2 = SIN((t - 1) * j4) * j5
            j3 = SIN(t * j4) * j5
        else
            j2 = t - 1
            j3 = t
        end
        return a[1] * j2 + b[1] * j3, a[2] * j2 + b[2] * j3, a[3] * j2 + b[3] * j3, a[4] * j2 + b[4] * j3
    end
    function Clerp(a, b, t)
        local io = {QuaternionFromCFrame(a)}
        local ip = {QuaternionFromCFrame(b)}
        local iq, ir, is = a.x, a.y, a.z
        local iu, iv, iw = b.x, b.y, b.z
        local ix = 1 - t
        return QuaternionToCFrame(ix * iq + t * iu, ix * ir + t * iv, ix * is + t * iw, QuaternionSlerp(io, ip, t))
    end
    function CreateFrame(ft, fD, m_, mU, fG, fX, n0, fF)
        local n1 = IT("Frame")
        n1.BackgroundTransparency = fD
        n1.BorderSizePixel = m_
        n1.Position = mU
        n1.Size = fG
        n1.BackgroundColor3 = fX
        n1.BorderColor3 = n0
        n1.Name = fF
        n1.Parent = ft
        return n1
    end
    function CreateLabel(ft, n3, n4, n5, n6, fD, m_, n7, fF)
        local n8 = IT("TextLabel")
        n8.BackgroundTransparency = 1
        n8.Size = UD2(1, 0, 1, 0)
        n8.Position = UD2(0, 0, 0, 0)
        n8.TextColor3 = n4
        n8.TextStrokeTransparency = n7
        n8.TextTransparency = fD
        n8.FontSize = n5
        n8.Font = n6
        n8.BorderSizePixel = m_
        n8.TextScaled = false
        n8.Text = n3
        n8.Name = fF
        n8.Parent = ft
        return n8
    end
    function NoOutlines(n9)
        n9.TopSurface, n9.BottomSurface, n9.LeftSurface, n9.RightSurface, n9.FrontSurface, n9.BackSurface =
            10,
            10,
            10,
            10,
            10,
            10
    end
    function CreateWeldOrSnapOrMotor(fP, ft, na, nb, eo, ep)
        local nc = IT(fP)
        nc.Part0 = na
        nc.Part1 = nb
        nc.C0 = eo
        nc.C1 = ep
        nc.Parent = ft
        return nc
    end
    local dA = IT("Sound")
    function CreateSound(fJ, ft, fK, fL, fM)
        local fN
        coroutine.resume(
            coroutine.create(
                function()
                    fN = dA:Clone()
                    fN.EmitterSize = fK * 5
                    fN.Parent = ft
                    fN.Volume = fK
                    fN.Pitch = fL
                    fN.SoundId = "http://www.roblox.com/asset/?id=" .. fJ
                    fN:play()
                    if fM == true then
                        fN.Looped = true
                    else
                        repeat
                            wait(1)
                        until fN.Playing == false
                        fN:remove()
                    end
                end
            )
        )
        return fN
    end
    function CFrameFromTopBack(nd, ne, nf)
        local ng = ne:Cross(nf)
        return CF(nd.x, nd.y, nd.z, ng.x, ne.x, nf.x, ng.y, ne.y, nf.y, ng.z, ne.z, nf.z)
    end
    function WACKYEFFECT(fO)
        local fP = fO.EffectType or "Sphere"
        local fG = fO.Size or VT(1, 1, 1)
        local fQ = fO.Size2 or VT(0, 0, 0)
        local fD = fO.Transparency or 0
        local fR = fO.Transparency2 or 1
        local fS = fO.CFrame or Torso.CFrame
        local fT = fO.MoveToPos or nil
        local fU = fO.RotationX or 0
        local fV = fO.RotationY or 0
        local fW = fO.RotationZ or 0
        local fB = fO.Material or "Neon"
        local fX = fO.Color or C3(1, 1, 1)
        local fY = fO.Time or 45
        local fZ = fO.SoundID or nil
        local f_ = fO.SoundPitch or nil
        local g0 = fO.SoundVolume or nil
        coroutine.resume(
            coroutine.create(
                function()
                    local g1 = false
                    local g2
                    local g3 = CreatePart(3, Effects, fB, 0, fD, BRICKC("Pearl"), "Effect", VT(1, 1, 1), true)
                    if fZ ~= nil and f_ ~= nil and g0 ~= nil then
                        g1 = true
                        g2 = CreateSound(fZ, g3, g0, f_, false)
                    end
                    g3.Color = fX
                    local g4
                    if fP == "Sphere" then
                        g4 = CreateMesh("SpecialMesh", g3, "Sphere", "", "", fG, VT(0, 0, 0))
                    elseif fP == "Block" or fP == "Box" then
                        g4 = IT("BlockMesh", g3)
                        g4.Scale = fG
                    elseif fP == "Wave" then
                        g4 = CreateMesh("SpecialMesh", g3, "FileMesh", "20329976", "", fG, VT(0, 0, -fG.X / 8))
                    elseif fP == "Ring" then
                        g4 =
                            CreateMesh("SpecialMesh", g3, "FileMesh", "559831844", "", VT(fG.X, fG.X, 0.1), VT(0, 0, 0))
                    elseif fP == "Slash" then
                        g4 =
                            CreateMesh(
                            "SpecialMesh",
                            g3,
                            "FileMesh",
                            "662586858",
                            "",
                            VT(fG.X / 10, 0, fG.X / 10),
                            VT(0, 0, 0)
                        )
                    elseif fP == "Round Slash" then
                        g4 =
                            CreateMesh(
                            "SpecialMesh",
                            g3,
                            "FileMesh",
                            "662585058",
                            "",
                            VT(fG.X / 10, 0, fG.X / 10),
                            VT(0, 0, 0)
                        )
                    elseif fP == "Swirl" then
                        g4 = CreateMesh("SpecialMesh", g3, "FileMesh", "1051557", "", fG, VT(0, 0, 0))
                    elseif fP == "Skull" then
                        g4 = CreateMesh("SpecialMesh", g3, "FileMesh", "4770583", "", fG, VT(0, 0, 0))
                    elseif fP == "Crystal" then
                        g4 = CreateMesh("SpecialMesh", g3, "FileMesh", "9756362", "", fG, VT(0, 0, 0))
                    end
                    if g4 ~= nil then
                        local g5
                        if fT ~= nil then
                            g5 = (fS.p - fT).Magnitude / fY
                        end
                        local g6 = fG - fQ
                        local g7 = fD - fR
                        if fP == "Block" then
                            g3.CFrame = fS * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
                        else
                            g3.CFrame = fS
                        end
                        for g9 = 1, fY + 1 do
                            Swait()
                            g4.Scale = g4.Scale - g6 / fY
                            if fP == "Wave" then
                                g4.Offset = VT(0, 0, -g4.Scale.X / 8)
                            end
                            g3.Transparency = 1
                            if fP == "Block" then
                                g3.CFrame =
                                    fS * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
                            else
                                g3.CFrame = g3.CFrame * ANGLES(RAD(fU), RAD(fV), RAD(fW))
                            end
                            if fT ~= nil then
                                local g8 = g3.Orientation
                                g3.CFrame = CF(g3.Position, fT) * CF(0, 0, -g5)
                                g3.Orientation = g8
                            end
                        end
                        if g1 == false then
                            g3:remove()
                        else
                            repeat
                                Swait()
                            until g2.Playing == false
                            g3:remove()
                        end
                    elseif g1 == false then
                        g3:remove()
                    else
                        repeat
                            Swait()
                        until g2.Playing == false
                        g3:remove()
                    end
                end
            )
        )
    end
    function MakeForm(n9, fP)
        if fP == "Cyl" then
            local g4 = IT("CylinderMesh", n9)
        elseif fP == "Ball" then
            local g4 = IT("SpecialMesh", n9)
            g4.MeshType = "Sphere"
        elseif fP == "Wedge" then
            local g4 = IT("SpecialMesh", n9)
            g4.MeshType = "Wedge"
        end
    end
    Debris = game:GetService("Debris")
    function CastProperRay(nh, ni, nj, eV)
        local mV = CF(nh, ni).lookVector
        return Raycast(nh, mV, nj, eV)
    end
    function GetRoot(nk, nl)
        if nl == true then
            return nk:FindFirstChild("HumanoidRootPart") or nk:FindFirstChild("Torso") or
                nk:FindFirstChild("UpperTorso")
        else
            return nk:FindFirstChild("Torso") or nk:FindFirstChild("UpperTorso")
        end
    end
    function FacialShadow()
        local nm = {}
        for T = 1, 16 do
            local nn =
                CreatePart(
                3,
                Effects,
                "Fabric",
                0,
                0 + (T - 1) / 16.2,
                "Dark stone grey",
                "FaceGradient",
                VT(1.01, 0.65, 1.01),
                false
            )
            nn.Color = C3(0, 0, 0)
            Head:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = nn
            CreateWeldOrSnapOrMotor("Weld", Head, Head, nn, CF(0, 0.45 - (T - 1) / 25, 0), CF(0, 0, 0))
            table.insert(nm, nn)
        end
        local function no()
            for T = 1, #nm do
                nm[T]:remove()
            end
        end
        return no
    end
    function CreateFlyingDebree(FLOOR, mU, np, nq, nr, ns)
        if FLOOR ~= nil then
            for T = 1, np do
                do
                    local nt =
                        CreatePart(
                        3,
                        Effects,
                        "Neon",
                        FLOOR.Reflectance,
                        FLOOR.Transparency,
                        "Peal",
                        "Debree",
                        nq,
                        false
                    )
                    nt.Material = FLOOR.Material
                    nt.Color = FLOOR.Color
                    nt.CFrame = mU * ANGLES(RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)))
                    nt.Velocity = VT(MRANDOM(-ns, ns), MRANDOM(-ns, ns), MRANDOM(-ns, ns))
                    coroutine.resume(
                        coroutine.create(
                            function()
                                Swait(15)
                                nt.Parent = workspace
                                nt.CanCollide = true
                                Debris:AddItem(nt, nr)
                            end
                        )
                    )
                end
            end
        end
    end
    local fG = 2
    RootPart2.Size = RootPart.Size * fG
    Torso2.Size = Torso.Size * fG
    RightArm2.Size = RightArm.Size * fG
    RightLeg2.Size = RightLeg.Size * fG
    LeftArm2.Size = LeftArm.Size * fG
    LeftLeg2.Size = LeftLeg.Size * fG
    RootJoint2.C0 = mv * CF(0 * fG, 0 * fG, 0 * fG) * ANGLES(RAD(0), RAD(0), RAD(0))
    RootJoint2.C1 = mv * CF(0 * fG, 0 * fG, 0 * fG) * ANGLES(RAD(0), RAD(0), RAD(0))
    Neck2.C0 = mw * CF(0 * fG, 0 * fG, 0 + 1 * fG - 1) * ANGLES(RAD(0), RAD(0), RAD(0))
    Neck2.C1 = CF(0 * fG, -0.5 * fG, 0 * fG) * ANGLES(RAD(-90), RAD(0), RAD(180))
    RightShoulder2.C1 = CF(0 * fG, 0.5 * fG, -0.35 * fG)
    LeftShoulder2.C1 = CF(0 * fG, 0.5 * fG, -0.35 * fG)
    RightHip2.C0 = CF(1 * fG, -1 * fG, 0 * fG) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
    LeftHip2.C0 = CF(-1 * fG, -1 * fG, 0 * fG) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
    RightHip2.C1 = CF(0.5 * fG, 1 * fG, 0 * fG) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
    LeftHip2.C1 = CF(-0.5 * fG, 1 * fG, 0 * fG) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
    Head2.Size = VT(1, 1, 1) * fG
    RootJoint2.Parent = RootPart
    Neck2.Parent = Torso
    RightShoulder2.Parent = Torso
    LeftShoulder2.Parent = Torso
    RightHip2.Parent = Torso
    LeftHip2.Parent = Torso
    local nu = C3(1, 1, 1)
    local nv = "Fantasy"
    local nw = 6
    local nx = {"Z-Tremor Punch", "E-Meteor Impact", "R-Uppercut"}
    local ny = {}
    function ApplyDamage(Humanoid, Damage)
        Damage = Damage * mz
        if Humanoid.Health < 2000 then
            if Humanoid.Health - Damage > 0 then
                Humanoid.Health = Humanoid.Health - Damage
            else
                Humanoid.Parent:BreakJoints()
            end
        else
            Humanoid.Parent:BreakJoints()
        end
    end
    function ApplyAoE(mU, mW, nz, nA, nB, nC)
        for nD, nE in pairs(workspace:GetDescendants()) do
            if nE.ClassName == "Model" and nE ~= Character then
                local nF = nE:FindFirstChildOfClass("Torso")
                if nF then
                    local nG = nE:FindFirstChild("Torso") or nE:FindFirstChild("UpperTorso")
                    if nG and mW >= (nG.Position - mU).Magnitude then
                        if nC == true then
                            nE:BreakJoints()
                        else
                            local nH = MRANDOM(nz, nA)
                            ApplyDamage(nF, nH)
                        end
                        if nB > 0 then
                            for U, c in pairs(nE:GetChildren()) do
                                if c:IsA("BasePart") then
                                    local bv = Instance.new("BodyVelocity")
                                    bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
                                    bv.velocity = CF(mU, nG.Position).lookVector * nB
                                    bv.Parent = c
                                    Debris:AddItem(bv, 0.05)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    function Intro()
        mC = true
        mB = true
        mF = true
        if mF == false then
            Disable_Jump = false
            Humanoid.WalkSpeed = l
        elseif mF == true then
            Disable_Jump = true
            Humanoid.WalkSpeed = 0
        end
        coroutine.resume(
            coroutine.create(
                function()
                    repeat
                        Swait()
                        RootPart2.Anchored = true
                        for U, c in pairs(mN:GetChildren()) do
                            if c:IsA("Part") then
                                c.Color = C3(1, 1, 1)
                                if c ~= RootPart2 then
                                    c.Transparency = 1
                                end
                                if c:FindFirstChildOfClass("Decal") then
                                    c:ClearAllChildren()
                                end
                                c.CanCollide = false
                                c.Material = "Neon"
                            else
                                c:remove()
                            end
                        end
                        RootJoint.C0 =
                            Clerp(
                            RootJoint.C0,
                            mv * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(-35)),
                            1 / Animation_Speed
                        )
                        Neck.C0 =
                            Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(35)), 1 / Animation_Speed)
                        RightShoulder.C0 =
                            Clerp(
                            RightShoulder.C0,
                            CF(1.5, 0.5, 0) * ANGLES(RAD(-1), RAD(0), RAD(3)) * mx,
                            1 / Animation_Speed
                        )
                        LeftShoulder.C0 =
                            Clerp(
                            LeftShoulder.C0,
                            CF(-1.5, 0.5, 0) * ANGLES(RAD(-1), RAD(0), RAD(-3)) * my,
                            1 / Animation_Speed
                        )
                        RightHip.C0 =
                            Clerp(
                            RightHip.C0,
                            CF(1, -1, -0.01) * ANGLES(RAD(-12), RAD(80), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                        LeftHip.C0 =
                            Clerp(
                            LeftHip.C0,
                            CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                    until mB == false
                end
            )
        )
        wait(1)
        mN.Parent = Character
        mN:SetPrimaryPartCFrame(RootPart.CFrame * CF(0, -20, 5))
        local nI, nJ =
            Raycast(
            RootPart.CFrame * CF(0, 0, 5).p,
            CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector,
            4,
            Character
        )
        for T = 1, 250 do
            Swait()
            mR = mR - 0.0032
            local nK = CF(nJ) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)) * CF(0, 0, MRANDOM(2, 18))
            local nL = MRANDOM(20, 80)
            WACKYEFFECT(
                {
                    Time = nL,
                    EffectType = "Sphere",
                    Size = VT(1, 1, 1),
                    Size2 = VT(0, 45, 0),
                    Transparency = 0,
                    Transparency2 = 0,
                    CFrame = nK,
                    MoveToPos = nK.p + VT(0, MRANDOM(35, 160), 0),
                    RotationX = 0,
                    RotationY = 0,
                    RotationZ = 0,
                    Material = "Neon",
                    Color = C3(1, 1, 1),
                    SoundID = nil,
                    SoundPitch = 0.8,
                    SoundVolume = 5
                }
            )
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.01)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-15), RAD(0), RAD(45)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-15), RAD(0), RAD(-45)) * my,
                1 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(-80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        for T = 0, 0.6, 0.1 / Animation_Speed do
            Swait()
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, -0.5 * fG) * ANGLES(RAD(140), RAD(0), RAD(-25)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, -0.5 * fG) * ANGLES(RAD(140), RAD(0), RAD(25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(25), RAD(80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(25), RAD(-80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        CreateSound(e3, Head2, 10, 1, false)
        for T = 0, 4, 0.1 / Animation_Speed do
            Swait()
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(-35), RAD(0), RAD(0)), 1 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-45), RAD(0), RAD(25)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-45), RAD(0), RAD(-25)) * my,
                1 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(-80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        mB = false
        mF = false
    end
    function Roar(nM)
        mB = true
        mF = true
        local mR = false
        coroutine.resume(
            coroutine.create(
                function()
                    repeat
                        Swait()
                        RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 8, 0), 0.1)
                        RootJoint.C0 =
                            Clerp(
                            RootJoint.C0,
                            mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)),
                            0.15 / Animation_Speed
                        )
                        Neck.C0 =
                            Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(35), RAD(0), RAD(0)), 0.15 / Animation_Speed)
                        RightShoulder.C0 =
                            Clerp(
                            RightShoulder.C0,
                            CF(1.45, 0.65, 0) * ANGLES(RAD(170), RAD(0), RAD(-22)) * mx,
                            1 / Animation_Speed
                        )
                        LeftShoulder.C0 =
                            Clerp(
                            LeftShoulder.C0,
                            CF(-1.45, 0.65, 0) * ANGLES(RAD(170), RAD(0), RAD(22)) * my,
                            1 / Animation_Speed
                        )
                        RightHip.C0 =
                            Clerp(
                            RightHip.C0,
                            CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                            0.15 / Animation_Speed
                        )
                        LeftHip.C0 =
                            Clerp(
                            LeftHip.C0,
                            CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                            0.15 / Animation_Speed
                        )
                    until mR == true
                end
            )
        )
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.15 * fG, 0.5 * fG, -0.5 * fG) * ANGLES(RAD(140), RAD(0), RAD(-45)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.15 * fG, 0.5 * fG, -0.5 * fG) * ANGLES(RAD(140), RAD(0), RAD(45)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(25), RAD(80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(25), RAD(-80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        CreateSound(e3, Effects, 4, 1, false)
        if nM then
            for mR = 1, #nM do
                if nM[mR]:FindFirstChildOfClass("Torso") then
                    local nl = GetRoot(nM[mR], true)
                    if nl then
                        ApplyDamage(nM[mR]:FindFirstChildOfClass("Torso"), MRANDOM(0, 50))
                        local bv = Instance.new("BodyVelocity")
                        bv.maxForce = Vector3.new(1000000000, 1000000000, 1000000000)
                        bv.velocity = CF(RootPart.Position, nl.Position).lookVector * 150
                        bv.Parent = nl
                        Debris:AddItem(bv, 0.05)
                    end
                end
            end
        end
        for T = 0, 6, 0.1 / Animation_Speed do
            Swait()
            local nN, nO =
                Raycast(
                RootPart2.Position,
                CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector,
                25,
                Character
            )
            if nN then
            end
            WACKYEFFECT(
                {
                    EffectType = "Wave",
                    Size = VT(20, 1, 20),
                    Size2 = VT(25 + MRANDOM(0, 8), 7, 25 + MRANDOM(0, 8)),
                    Transparency = 0.9,
                    Transparency2 = 1,
                    CFrame = CF(nO) * ANGLES(RAD(0), RAD(MRANDOM(0, 360)), RAD(0)),
                    MoveToPos = nil,
                    RotationX = 0,
                    RotationY = 5,
                    RotationZ = 0,
                    Material = "Neon",
                    Color = C3(1, 1, 1),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil
                }
            )
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-35), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck2.C0 =
                Clerp(
                Neck2.C0,
                mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(-35), RAD(MRANDOM(-3, 3)), RAD(MRANDOM(-3, 3))),
                1 / Animation_Speed
            )
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-45), RAD(0), RAD(25)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-45), RAD(0), RAD(-25)) * my,
                1 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -0.7 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(-80), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        mR = true
        if nM then
            CreateSound(1535995263, Head, 10, 1, false)
            for T = 0, 2.2, 0.1 / Animation_Speed do
                Swait()
                RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                RootJoint2.C0 =
                    Clerp(
                    RootJoint2.C0,
                    mv * CF(0, 0, 0.25 * COS(mG / 12)) * ANGLES(RAD(-5 + 2 * SIN(mG / 12)), RAD(15), RAD(35)),
                    0.5 / Animation_Speed
                )
                Neck2.C0 =
                    Clerp(
                    Neck2.C0,
                    mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25 - 2 * SIN(mG / 12)), RAD(0), RAD(-35)),
                    0.5 / Animation_Speed
                )
                RightShoulder2.C0 =
                    Clerp(
                    RightShoulder2.C0,
                    CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(60)) * mx,
                    0.5 / Animation_Speed
                )
                LeftShoulder2.C0 =
                    Clerp(
                    LeftShoulder2.C0,
                    CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(-60)) * my,
                    0.5 / Animation_Speed
                )
                RightHip2.C0 =
                    Clerp(
                    RightHip2.C0,
                    CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                        ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                    0.5 / Animation_Speed
                )
                LeftHip2.C0 =
                    Clerp(
                    LeftHip2.C0,
                    CF(-1 * fG, -0.3 * fG, -0.6 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                        ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                    0.5 / Animation_Speed
                )
                RootJoint.C0 =
                    Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(15), RAD(25), RAD(0)), 0.15 / Animation_Speed)
                RightShoulder.C0 =
                    Clerp(
                    RightShoulder.C0,
                    CF(1.5, 0.5, 0) * ANGLES(RAD(170), RAD(0), RAD(5)) * mx,
                    0.15 / Animation_Speed
                )
                LeftShoulder.C0 =
                    Clerp(
                    LeftShoulder.C0,
                    CF(-1.5, 0.5, 0) * ANGLES(RAD(170), RAD(0), RAD(-5)) * my,
                    0.15 / Animation_Speed
                )
                RightHip.C0 =
                    Clerp(
                    RightHip.C0,
                    CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                    0.15 / Animation_Speed
                )
                LeftHip.C0 =
                    Clerp(
                    LeftHip.C0,
                    CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                    0.15 / Animation_Speed
                )
            end
        end
        mB = false
        mF = false
    end
    function Punch()
        mB = true
        mF = false
        local nP = {}
        l = 12
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(-45)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(45)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(90), RAD(0), RAD(-45)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(25)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        CreateSound(588693579, RightArm2, 6, MRANDOM(8, 12) / 10, false)
        for T = 0, 0.3, 0.1 / Animation_Speed do
            Swait()
            WACKYEFFECT(
                {
                    EffectType = "Box",
                    Size = RightArm2.Size,
                    Size2 = RightArm2.Size,
                    Transparency = RightArm2.Transparency,
                    Transparency2 = 1,
                    CFrame = RightArm2.CFrame,
                    MoveToPos = nil,
                    RotationX = 0,
                    RotationY = 0,
                    RotationZ = 0,
                    Material = "Neon",
                    Color = C3(1, 1, 1),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil
                }
            )
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 3, -5), 0.4)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(45)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(-45)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.25 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(135), RAD(0), RAD(45)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(-25)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.35, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        for nD, nE in pairs(workspace:GetDescendants()) do
            if nE.ClassName == "Model" and nE ~= Character then
                do
                    local nF = nE:FindFirstChildOfClass("Torso")
                    if nF then
                        do
                            local nG = nE:FindFirstChild("Torso") or nE:FindFirstChild("UpperTorso")
                            if nG and (nG.Position - RightArm2.CFrame * CF(0, -2, 0).p).Magnitude <= 15 then
                                table.insert(nP, nE)
                                coroutine.resume(
                                    coroutine.create(
                                        function()
                                            CreateSound(260430117, nG, 3, MRANDOM(8, 12) / 10, false)
                                            nG.Anchored = true
                                            local nJ = nG.CFrame
                                            for T = 1, 35 do
                                                Swait()
                                                ApplyDamage(nF, MRANDOM(0, 0))
                                                nG.CFrame =
                                                    nJ *
                                                    CF(MRANDOM(-2, 2) / 10, MRANDOM(-2, 2) / 10, MRANDOM(-2, 2) / 10)
                                            end
                                            nG.Anchored = false
                                        end
                                    )
                                )
                            end
                        end
                    end
                end
            end
        end
        for T = 0, 0.2, 0.1 / Animation_Speed do
            Swait()
            WACKYEFFECT(
                {
                    EffectType = "Box",
                    Size = RightArm2.Size,
                    Size2 = RightArm2.Size,
                    Transparency = RightArm2.Transparency,
                    Transparency2 = 1,
                    CFrame = RightArm2.CFrame,
                    MoveToPos = nil,
                    RotationX = 0,
                    RotationY = 0,
                    RotationZ = 0,
                    Material = "Neon",
                    Color = C3(1, 1, 1),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil
                }
            )
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 3, -5), 0.5)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(45)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(-45)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.25 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(135), RAD(0), RAD(-70)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(-25)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.35, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        if #nP > 0 then
            for T = 0, 0.5, 0.1 / Animation_Speed do
                Swait()
                RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 3, -5), 0.5)
                RootJoint2.C0 =
                    Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(45)), 0.5 / Animation_Speed)
                Neck2.C0 =
                    Clerp(
                    Neck2.C0,
                    mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(-45)),
                    0.5 / Animation_Speed
                )
                RightShoulder2.C0 =
                    Clerp(
                    RightShoulder2.C0,
                    CF(1.25 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(135), RAD(0), RAD(-70)) * mx,
                    1 / Animation_Speed
                )
                LeftShoulder2.C0 =
                    Clerp(
                    LeftShoulder2.C0,
                    CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                    0.5 / Animation_Speed
                )
                RightHip2.C0 =
                    Clerp(
                    RightHip2.C0,
                    CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                        ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                    0.5 / Animation_Speed
                )
                LeftHip2.C0 =
                    Clerp(
                    LeftHip2.C0,
                    CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                        ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                    0.5 / Animation_Speed
                )
                RootJoint.C0 =
                    Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
                Neck.C0 =
                    Clerp(
                    Neck.C0,
                    mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(-25)),
                    1 / Animation_Speed
                )
                RightShoulder.C0 =
                    Clerp(
                    RightShoulder.C0,
                    CF(1.35, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(-25)) * mx,
                    1 / Animation_Speed
                )
                LeftShoulder.C0 =
                    Clerp(
                    LeftShoulder.C0,
                    CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my,
                    1 / Animation_Speed
                )
                RightHip.C0 =
                    Clerp(
                    RightHip.C0,
                    CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                    1 / Animation_Speed
                )
                LeftHip.C0 =
                    Clerp(
                    LeftHip.C0,
                    CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                    1 / Animation_Speed
                )
            end
            Roar(nP)
        end
        l = 16
        mB = false
        mF = false
    end
    function Throw()
        brug = false
        bruhmom = false
        pewhandle.Anchored = true
        mB = true
        mF = false
        local nt = {}
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 1, 2), 0.2)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(90), RAD(0), RAD(-25)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(90), RAD(0), RAD(25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(12)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        local fS = RootPart2.CFrame * CF(0, 50, 0)
        Humanoid.PlatformStand = true
        mQ = false
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            RootPart2.CFrame =
                Clerp(RootPart2.CFrame, CF(fS.p, VT(Mouse.Hit.p.X, RootPart2.Position.Y, Mouse.Hit.p.Z)), 0.2)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(90), RAD(0), RAD(-25)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(90), RAD(0), RAD(25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.5 * fG, -0.5 * fG) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootPart.CFrame = RootPart2.CFrame * CF(0, -1, -2)
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(12)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        local nQ =
            CreateWeldOrSnapOrMotor(
            "Weld",
            RightArm2,
            RightArm2,
            Torso,
            CF(0, -2, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)),
            CF(0, 0, 0)
        )
        for T = 0, 0.4, 0.1 / Animation_Speed do
            Swait()
            RootPart2.CFrame =
                Clerp(RootPart2.CFrame, CF(fS.p, VT(Mouse.Hit.p.X, RootPart2.Position.Y, Mouse.Hit.p.Z)), 0.2)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(140), RAD(0), RAD(0)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.5 * fG, -0.5) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck.C0 = Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CF(1.5, 0.5, -0.3) * ANGLES(RAD(90), RAD(0), RAD(-45)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CF(-1.5, 0.35, -0.3) * ANGLES(RAD(80), RAD(0), RAD(45)) * my,
                1 / Animation_Speed
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -0.4, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -0.4, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        local e9 = false
        nQ:remove()
        RootPart.CFrame = CF(RightArm2.CFrame * CF(0, -3, 0).p, Mouse.Hit.p)
        CreateSound(588693579, RightArm2, 6, MRANDOM(8, 12) / 10, false)
        for T = 0, 0.4, 0.1 / Animation_Speed do
            Swait()
            WACKYEFFECT(
                {
                    EffectType = "Box",
                    Size = RightArm2.Size,
                    Size2 = RightArm2.Size,
                    Transparency = RightArm2.Transparency,
                    Transparency2 = 1,
                    CFrame = RightArm2.CFrame,
                    MoveToPos = nil,
                    RotationX = 0,
                    RotationY = 0,
                    RotationZ = 0,
                    Material = "Neon",
                    Color = C3(1, 1, 1),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil
                }
            )
            RootPart2.CFrame =
                Clerp(RootPart2.CFrame, CF(fS.p, VT(Mouse.Hit.p.X, RootPart2.Position.Y, Mouse.Hit.p.Z)), 0.2)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(140), RAD(0), RAD(0)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -0.5 * fG, -0.5) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck.C0 = Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
            RightShoulder.C0 =
                Clerp(
                RightShoulder.C0,
                CF(1.5, 0.5, -0.3) * ANGLES(RAD(90), RAD(0), RAD(-45)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CF(-1.5, 0.35, -0.3) * ANGLES(RAD(80), RAD(0), RAD(45)) * my,
                1 / Animation_Speed
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -0.4, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -0.4, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        coroutine.resume(
            coroutine.create(
                function()
                    repeat
                        Swait()
                        RootJoint2.C0 =
                            Clerp(
                            RootJoint2.C0,
                            mv * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        Neck2.C0 =
                            Clerp(
                            Neck2.C0,
                            mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        RightShoulder2.C0 =
                            Clerp(
                            RightShoulder2.C0,
                            CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(140), RAD(0), RAD(0)) * mx,
                            0.5 / Animation_Speed
                        )
                        LeftShoulder2.C0 =
                            Clerp(
                            LeftShoulder2.C0,
                            CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * my,
                            0.5 / Animation_Speed
                        )
                        RightHip2.C0 =
                            Clerp(
                            RightHip2.C0,
                            CF(1 * fG, -0.5 * fG, -0.5) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        LeftHip2.C0 =
                            Clerp(
                            LeftHip2.C0,
                            CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        RootJoint.C0 =
                            Clerp(
                            RootJoint.C0,
                            mv * CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                        Neck.C0 =
                            Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(25), RAD(0), RAD(0)), 1 / Animation_Speed)
                        RightShoulder.C0 =
                            Clerp(
                            RightShoulder.C0,
                            CF(1.5, 0.5, -0.3) * ANGLES(RAD(90), RAD(0), RAD(-45)) * mx,
                            1 / Animation_Speed
                        )
                        LeftShoulder.C0 =
                            Clerp(
                            LeftShoulder.C0,
                            CF(-1.5, 0.35, -0.3) * ANGLES(RAD(80), RAD(0), RAD(45)) * my,
                            1 / Animation_Speed
                        )
                        RightHip.C0 =
                            Clerp(
                            RightHip.C0,
                            CF(1, -0.4, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                        LeftHip.C0 =
                            Clerp(
                            LeftHip.C0,
                            CF(-1, -0.4, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-1), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                    until e9 == true or mB == false
                end
            )
        )
        local FLOOR
        for T = 1, 80 do
            Swait()
            local nI, nJ = Raycast(RootPart.Position, RootPart.CFrame.lookVector, 6, Character)
            if nI then
                FLOOR = nI
                e9 = true
                local g8 = VT(0, RootPart.Orientation.Y, 0)
                RootPart.CFrame = CF(nJ + VT(0, 3.5, 0))
                RootPart.Orientation = g8
                RootJoint.Parent = RootPart
                break
            else
                RootPart.CFrame = RootPart.CFrame * CF(0, 0, -6)
            end
        end
        mQ = true
        if FLOOR then
            do
                local nR = false
                Humanoid.PlatformStand = false
                local mT = true
                local nB = false
                coroutine.resume(
                    coroutine.create(
                        function()
                            local nS = MRANDOM(8, 13)
                            for T = 1, nS do
                                local nT =
                                    CreatePart(
                                    3,
                                    Effects,
                                    FLOOR.Material,
                                    0,
                                    0,
                                    FLOOR.BrickColor,
                                    "Debree",
                                    VT(1, 1, 1) * MRANDOM(2, 7),
                                    true
                                )
                                nT.CFrame =
                                    CF(RootPart.Position - VT(0, 7, 0)) * ANGLES(RAD(0), RAD(360 / nS * T), RAD(0)) *
                                    CF(0, 0, MRANDOM(20, 28)) *
                                    ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
                                table.insert(nt, {nT, nT.Orientation, CF(nT.Position + VT(0, MRANDOM(3, 7) + 8, 0))})
                            end
                            repeat
                                Swait()
                                for mR = 1, #nt do
                                    local nU = nt[mR][1]
                                    nU.CFrame = Clerp(nU.CFrame, nt[mR][3], 0.3)
                                    nU.Orientation = nt[mR][2]
                                end
                            until nB == true or mB == false
                            if nB == false then
                                for mR = 1, #nt do
                                    local nU = nt[mR][1]
                                    nU.Anchored = false
                                    Debris:AddItem(nU, 4)
                                end
                            else
                                for mR = 1, #nt do
                                    do
                                        local nU = nt[mR][1]
                                        nU.CFrame = CF(nU.Position, Mouse.Hit.p)
                                        coroutine.resume(
                                            coroutine.create(
                                                function()
                                                    for T = 1, 150 do
                                                        Swait()
                                                        local nI, nJ, nV =
                                                            Raycast(nU.Position, nU.CFrame.lookVector, 3, Character)
                                                        if nI then
                                                            break
                                                        else
                                                            nU.CFrame = nU.CFrame * CF(0, 0, -3)
                                                        end
                                                    end
                                                    ApplyAoE(nU.Position, 22, 10, 15, 70, false)
                                                    WACKYEFFECT(
                                                        {
                                                            EffectType = "Box",
                                                            Size = nU.Size,
                                                            Size2 = nU.Size * 1.2,
                                                            Transparency = 0,
                                                            Transparency2 = 1,
                                                            CFrame = nU.CFrame,
                                                            MoveToPos = nil,
                                                            RotationX = 0,
                                                            RotationY = 0,
                                                            RotationZ = 0,
                                                            Material = "Neon",
                                                            Color = C3(1, 1, 1),
                                                            SoundID = nil,
                                                            SoundPitch = nil,
                                                            SoundVolume = nil
                                                        }
                                                    )
                                                    WACKYEFFECT(
                                                        {
                                                            Time = 15,
                                                            EffectType = "Sphere",
                                                            Size = nU.Size,
                                                            Size2 = VT(35, 35, 35),
                                                            Transparency = 0.8,
                                                            Transparency2 = 1,
                                                            CFrame = CF(nU.Position),
                                                            MoveToPos = nil,
                                                            RotationX = 0,
                                                            RotationY = 0,
                                                            RotationZ = 0,
                                                            Material = "Neon",
                                                            Color = C3(1, 1, 1),
                                                            SoundID = 174580476,
                                                            SoundPitch = 1,
                                                            SoundVolume = 3
                                                        }
                                                    )
                                                    nU:remove()
                                                end
                                            )
                                        )
                                        Swait(5)
                                    end
                                end
                            end
                        end
                    )
                )
                local no = FacialShadow()
                CreateSound(765590102, Torso, 2, MRANDOM(8, 12) / 10, false)
                KEY =
                    Mouse.KeyDown:connect(
                    function(nW)
                        if nW == "e" then
                            KEY:Disconnect()
                            nR = true
                        end
                    end
                )
                for T = 0, 2, 0.1 / Animation_Speed do
                    Swait()
                    if nR == true then
                        break
                    end
                    RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                    RootJoint2.C0 =
                        Clerp(
                        RootJoint2.C0,
                        mv * CF(0, 0, 0.25 * COS(mG / 12)) * ANGLES(RAD(-5 + 2 * SIN(mG / 12)), RAD(15), RAD(35)),
                        0.5 / Animation_Speed
                    )
                    Neck2.C0 =
                        Clerp(
                        Neck2.C0,
                        mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25 - 2 * SIN(mG / 12)), RAD(0), RAD(-35)),
                        0.5 / Animation_Speed
                    )
                    RightShoulder2.C0 =
                        Clerp(
                        RightShoulder2.C0,
                        CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(60)) * mx,
                        0.5 / Animation_Speed
                    )
                    LeftShoulder2.C0 =
                        Clerp(
                        LeftShoulder2.C0,
                        CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(-60)) * my,
                        0.5 / Animation_Speed
                    )
                    RightHip2.C0 =
                        Clerp(
                        RightHip2.C0,
                        CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                            ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                        0.5 / Animation_Speed
                    )
                    LeftHip2.C0 =
                        Clerp(
                        LeftHip2.C0,
                        CF(-1 * fG, -0.3 * fG, -0.6 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                            ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                        0.5 / Animation_Speed
                    )
                    RootJoint.C0 =
                        Clerp(RootJoint.C0, mv * CF(0, 0.5, -0.5) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
                    Neck.C0 = Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
                    RightShoulder.C0 =
                        Clerp(
                        RightShoulder.C0,
                        CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(12)) * mx,
                        1 / Animation_Speed
                    )
                    LeftShoulder.C0 =
                        Clerp(
                        LeftShoulder.C0,
                        CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my,
                        1 / Animation_Speed
                    )
                    RightHip.C0 =
                        Clerp(
                        RightHip.C0,
                        CF(1, -0.5, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                        1 / Animation_Speed
                    )
                    LeftHip.C0 =
                        Clerp(
                        LeftHip.C0,
                        CF(-1, -0.5, -0.5) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                        1 / Animation_Speed
                    )
                end
                if KEY then
                    KEY:Disconnect()
                end
                if nR == true then
                    for T = 0, 0.3, 0.1 / Animation_Speed do
                        Swait()
                        RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                        RootJoint2.C0 =
                            Clerp(
                            RootJoint2.C0,
                            mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)),
                            0.5 / Animation_Speed
                        )
                        Neck2.C0 =
                            Clerp(
                            Neck2.C0,
                            mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(0), RAD(0), RAD(25)),
                            0.5 / Animation_Speed
                        )
                        RightShoulder2.C0 =
                            Clerp(
                            RightShoulder2.C0,
                            CF(1.25 * fG, 0.5 * fG, -0.5 * fG) * ANGLES(RAD(0), RAD(0), RAD(-90)) * mx,
                            0.5 / Animation_Speed
                        )
                        LeftShoulder2.C0 =
                            Clerp(
                            LeftShoulder2.C0,
                            CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * my,
                            0.5 / Animation_Speed
                        )
                        RightHip2.C0 =
                            Clerp(
                            RightHip2.C0,
                            CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        LeftHip2.C0 =
                            Clerp(
                            LeftHip2.C0,
                            CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        RootJoint.C0 =
                            Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
                        Neck.C0 =
                            Clerp(
                            Neck.C0,
                            mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                        RightShoulder.C0 =
                            Clerp(
                            RightShoulder.C0,
                            CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(3)) * mx,
                            1 / Animation_Speed
                        )
                        LeftShoulder.C0 =
                            Clerp(
                            LeftShoulder.C0,
                            CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-3)) * my,
                            1 / Animation_Speed
                        )
                        RightHip.C0 =
                            Clerp(
                            RightHip.C0,
                            CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                        LeftHip.C0 =
                            Clerp(
                            LeftHip.C0,
                            CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                    end
                    nB = true
                    for T = 0, 1, 0.1 / Animation_Speed do
                        Swait()
                        RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                        RootJoint2.C0 =
                            Clerp(
                            RootJoint2.C0,
                            mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(45)),
                            2 / Animation_Speed
                        )
                        Neck2.C0 =
                            Clerp(
                            Neck2.C0,
                            mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(0), RAD(0), RAD(-35)),
                            2 / Animation_Speed
                        )
                        RightShoulder2.C0 =
                            Clerp(
                            RightShoulder2.C0,
                            CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(90)) * mx,
                            2 / Animation_Speed
                        )
                        LeftShoulder2.C0 =
                            Clerp(
                            LeftShoulder2.C0,
                            CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(0)) * my,
                            0.5 / Animation_Speed
                        )
                        RightHip2.C0 =
                            Clerp(
                            RightHip2.C0,
                            CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        LeftHip2.C0 =
                            Clerp(
                            LeftHip2.C0,
                            CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        RootJoint.C0 =
                            Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
                        Neck.C0 =
                            Clerp(
                            Neck.C0,
                            mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                        RightShoulder.C0 =
                            Clerp(
                            RightShoulder.C0,
                            CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(3)) * mx,
                            1 / Animation_Speed
                        )
                        LeftShoulder.C0 =
                            Clerp(
                            LeftShoulder.C0,
                            CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-3)) * my,
                            1 / Animation_Speed
                        )
                        RightHip.C0 =
                            Clerp(
                            RightHip.C0,
                            CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                        LeftHip.C0 =
                            Clerp(
                            LeftHip.C0,
                            CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                            1 / Animation_Speed
                        )
                    end
                end
                no()
            end
        end
        mT = false
        mB = false
        mF = false
        pewhandle.Anchored = false
        brug = true
        bruhmom = true
    end
    function Uppercut()
        mB = true
        mF = false
        local nP = {}
        l = 12
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(-45)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(45)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.5 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(90), RAD(0), RAD(-45)) * mx,
                0.5 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(25)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        CreateSound(588693579, RightArm2, 6, MRANDOM(8, 12) / 10, false)
        for T = 0, 0.3, 0.1 / Animation_Speed do
            Swait()
            WACKYEFFECT(
                {
                    EffectType = "Box",
                    Size = RightArm2.Size,
                    Size2 = RightArm2.Size,
                    Transparency = RightArm2.Transparency,
                    Transparency2 = 1,
                    CFrame = RightArm2.CFrame,
                    MoveToPos = nil,
                    RotationX = 0,
                    RotationY = 0,
                    RotationZ = 0,
                    Material = "Neon",
                    Color = C3(1, 1, 1),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil
                }
            )
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 3, -5), 0.4)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(45)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(-45)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.25 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(80), RAD(0), RAD(45)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(-25)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.35, 0.5, 0) * ANGLES(RAD(140), RAD(0), RAD(-25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        mT = true
        local nR = false
        local nX = false
        local nY = 0
        local nZ = 200
        local no = FacialShadow()
        for T = 0, 0.5, 0.1 / Animation_Speed do
            Swait()
            if nR == true then
                break
            end
            WACKYEFFECT(
                {
                    EffectType = "Box",
                    Size = RightArm2.Size,
                    Size2 = RightArm2.Size,
                    Transparency = RightArm2.Transparency,
                    Transparency2 = 1,
                    CFrame = RightArm2.CFrame,
                    MoveToPos = nil,
                    RotationX = 0,
                    RotationY = 0,
                    RotationZ = 0,
                    Material = "Neon",
                    Color = C3(1, 1, 1),
                    SoundID = nil,
                    SoundPitch = nil,
                    SoundVolume = nil
                }
            )
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 3, -5), 0.5)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(45)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(-45)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.25 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(185), RAD(0), RAD(-45)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(-25)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.35, 0.5, 0) * ANGLES(RAD(140), RAD(0), RAD(-25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        if #nP > 0 then
            KEY =
                Mouse.KeyDown:connect(
                function(nW)
                    if nW == "r" and nX == false then
                        if nR == false then
                            nR = true
                        end
                        nX = true
                        nZ = 70
                        nY = nY + 1
                        CreateSound(217767125, RightArm, 10, 1, false)
                        for T = 0, 0.25, 0.1 / Animation_Speed do
                            Swait()
                            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                            RootJoint2.C0 =
                                Clerp(
                                RootJoint2.C0,
                                mv * CF(0, 0, 0.2) * ANGLES(RAD(0), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            Neck2.C0 =
                                Clerp(
                                Neck2.C0,
                                mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            RightShoulder2.C0 =
                                Clerp(
                                RightShoulder2.C0,
                                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(90), RAD(0), RAD(90)) * mx,
                                0.5 / Animation_Speed
                            )
                            LeftShoulder2.C0 =
                                Clerp(
                                LeftShoulder2.C0,
                                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-15 - 1 * SIN(mG / 6))) * my,
                                0.5 / Animation_Speed
                            )
                            RightHip2.C0 =
                                Clerp(
                                RightHip2.C0,
                                CF(1 * fG, -0.5 * fG, -0.5 * fG) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            LeftHip2.C0 =
                                Clerp(
                                LeftHip2.C0,
                                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            RootJoint.C0 =
                                Clerp(
                                RootJoint.C0,
                                mv * CF(0, 0, 0.1) * ANGLES(RAD(0), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            Neck.C0 =
                                Clerp(
                                Neck.C0,
                                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            RightShoulder.C0 =
                                Clerp(
                                RightShoulder.C0,
                                CF(1.5, 0.5, 0) * ANGLES(RAD(90), RAD(0), RAD(90)) * mx,
                                1 / Animation_Speed
                            )
                            LeftShoulder.C0 =
                                Clerp(
                                LeftShoulder.C0,
                                CF(-1.5, 0.5, 0.4) * ANGLES(RAD(-25), RAD(0), RAD(45)) * my,
                                1 / Animation_Speed
                            )
                            RightHip.C0 =
                                Clerp(
                                RightHip.C0,
                                CF(1, -1.1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            LeftHip.C0 =
                                Clerp(
                                LeftHip.C0,
                                CF(-1, -1.1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                        end
                        nX = false
                    end
                end
            )
        end
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            if nR == true then
                break
            end
            RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 3, -5), 0.5)
            RootJoint2.C0 =
                Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(45), RAD(0), RAD(45)), 0.5 / Animation_Speed)
            Neck2.C0 =
                Clerp(Neck2.C0, mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(5), RAD(0), RAD(-45)), 0.5 / Animation_Speed)
            RightShoulder2.C0 =
                Clerp(
                RightShoulder2.C0,
                CF(1.25 * fG, 0.5 * fG, -0.25 * fG) * ANGLES(RAD(185), RAD(0), RAD(-45)) * mx,
                1 / Animation_Speed
            )
            LeftShoulder2.C0 =
                Clerp(
                LeftShoulder2.C0,
                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-25)) * my,
                0.5 / Animation_Speed
            )
            RightHip2.C0 =
                Clerp(
                RightHip2.C0,
                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(50 - 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            LeftHip2.C0 =
                Clerp(
                LeftHip2.C0,
                CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                0.5 / Animation_Speed
            )
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(25)), 1 / Animation_Speed)
            Neck.C0 =
                Clerp(
                Neck.C0,
                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(-25)),
                1 / Animation_Speed
            )
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.35, 0.5, 0) * ANGLES(RAD(140), RAD(0), RAD(-25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * my, 1 / Animation_Speed)
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-60), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        if nR == true then
            mF = true
            repeat
                Swait()
                if nX == false then
                    nZ = nZ - 1
                    if nZ <= 0 then
                        nR = false
                    end
                    RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                    RootJoint2.C0 =
                        Clerp(RootJoint2.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.5 / Animation_Speed)
                    Neck2.C0 =
                        Clerp(
                        Neck2.C0,
                        mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)),
                        0.5 / Animation_Speed
                    )
                    RightShoulder2.C0 =
                        Clerp(
                        RightShoulder2.C0,
                        CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(120)) * ANGLES(RAD(0), RAD(-90), RAD(0)) *
                            mx,
                        0.5 / Animation_Speed
                    )
                    LeftShoulder2.C0 =
                        Clerp(
                        LeftShoulder2.C0,
                        CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-15 - 1 * SIN(mG / 6))) * my,
                        0.5 / Animation_Speed
                    )
                    RightHip2.C0 =
                        Clerp(
                        RightHip2.C0,
                        CF(1 * fG, -0.5 * fG, -0.5 * fG) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                            ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                        0.5 / Animation_Speed
                    )
                    LeftHip2.C0 =
                        Clerp(
                        LeftHip2.C0,
                        CF(-1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                            ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                        0.5 / Animation_Speed
                    )
                    RootJoint.C0 =
                        Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
                    Neck.C0 =
                        Clerp(
                        Neck.C0,
                        mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(0)),
                        1 / Animation_Speed
                    )
                    RightShoulder.C0 =
                        Clerp(
                        RightShoulder.C0,
                        CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(120)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * mx,
                        1 / Animation_Speed
                    )
                    LeftShoulder.C0 =
                        Clerp(
                        LeftShoulder.C0,
                        CF(-1.5, 0.5, 0.4) * ANGLES(RAD(-25), RAD(0), RAD(45)) * my,
                        1 / Animation_Speed
                    )
                    RightHip.C0 =
                        Clerp(
                        RightHip.C0,
                        CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)),
                        1 / Animation_Speed
                    )
                    LeftHip.C0 =
                        Clerp(
                        LeftHip.C0,
                        CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-3), RAD(0), RAD(0)),
                        1 / Animation_Speed
                    )
                end
            until nR == false
        end
        if KEY then
            KEY:Disconnect()
        end
        if nY > 4 then
            CreateSound(1535994137, Head, 10, 1, false)
            for T = 0, 2.4, 0.1 / Animation_Speed do
                Swait()
                RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                RootJoint2.C0 =
                    Clerp(
                    RootJoint2.C0,
                    mv * CF(0, 0, 0.25 * COS(mG / 12)) * ANGLES(RAD(-5 + 2 * SIN(mG / 12)), RAD(15), RAD(35)),
                    0.5 / Animation_Speed
                )
                Neck2.C0 =
                    Clerp(
                    Neck2.C0,
                    mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25 - 2 * SIN(mG / 12)), RAD(0), RAD(-35)),
                    0.5 / Animation_Speed
                )
                RightShoulder2.C0 =
                    Clerp(
                    RightShoulder2.C0,
                    CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(60)) * mx,
                    0.5 / Animation_Speed
                )
                LeftShoulder2.C0 =
                    Clerp(
                    LeftShoulder2.C0,
                    CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(-60)) * my,
                    0.5 / Animation_Speed
                )
                RightHip2.C0 =
                    Clerp(
                    RightHip2.C0,
                    CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                        ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                    0.5 / Animation_Speed
                )
                LeftHip2.C0 =
                    Clerp(
                    LeftHip2.C0,
                    CF(-1 * fG, -0.3 * fG, -0.6 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                        ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                    0.5 / Animation_Speed
                )
                RootJoint.C0 =
                    Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(15), RAD(15)), 1 / Animation_Speed)
                RightShoulder.C0 =
                    Clerp(
                    RightShoulder.C0,
                    CF(1.5, 0.65, 0) * ANGLES(RAD(170), RAD(0), RAD(-13)) * mx,
                    1 / Animation_Speed
                )
                LeftShoulder.C0 =
                    Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-3)) * my, 1 / Animation_Speed)
                RightHip.C0 =
                    Clerp(
                    RightHip.C0,
                    CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                    1 / Animation_Speed
                )
                LeftHip.C0 =
                    Clerp(
                    LeftHip.C0,
                    CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-2), RAD(0), RAD(0)),
                    1 / Animation_Speed
                )
            end
        end
        no()
        l = 16
        mT = false
        mB = false
        mF = false
    end
    function TakeOn()
        mB = true
        mF = true
        coroutine.resume(
            coroutine.create(
                function()
                    repeat
                        Swait()
                        RootJoint2.C0 =
                            Clerp(
                            RootJoint2.C0,
                            mv * CF(0, 0, 0.25 * COS(mG / 12)) * ANGLES(RAD(-5 + 2 * SIN(mG / 12)), RAD(15), RAD(35)),
                            0.5 / Animation_Speed
                        )
                        Neck2.C0 =
                            Clerp(
                            Neck2.C0,
                            mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25 - 2 * SIN(mG / 12)), RAD(0), RAD(-35)),
                            0.5 / Animation_Speed
                        )
                        RightShoulder2.C0 =
                            Clerp(
                            RightShoulder2.C0,
                            CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(60)) * mx,
                            0.5 / Animation_Speed
                        )
                        LeftShoulder2.C0 =
                            Clerp(
                            LeftShoulder2.C0,
                            CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(-60)) * my,
                            0.5 / Animation_Speed
                        )
                        RightHip2.C0 =
                            Clerp(
                            RightHip2.C0,
                            CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                        LeftHip2.C0 =
                            Clerp(
                            LeftHip2.C0,
                            CF(-1 * fG, -0.3 * fG, -0.6 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                            0.5 / Animation_Speed
                        )
                    until mB == false
                end
            )
        )
        CreateSound(1535994669, Head, 10, 1, false)
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck.C0 = Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(35), RAD(0), RAD(0)), 1 / Animation_Speed)
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(170), RAD(0), RAD(-25)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CF(-1.35, 0.5, 0.2) * ANGLES(RAD(-25), RAD(0), RAD(45)) * my,
                1 / Animation_Speed
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        for T = 0, 1, 0.1 / Animation_Speed do
            Swait()
            RootJoint.C0 = Clerp(RootJoint.C0, mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / Animation_Speed)
            Neck.C0 = Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(-10), RAD(0), RAD(35)), 1 / Animation_Speed)
            RightShoulder.C0 =
                Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(130), RAD(0), RAD(0)) * mx, 1 / Animation_Speed)
            LeftShoulder.C0 =
                Clerp(
                LeftShoulder.C0,
                CF(-1.35, 0.5, 0.2) * ANGLES(RAD(-25), RAD(0), RAD(45)) * my,
                1 / Animation_Speed
            )
            RightHip.C0 =
                Clerp(
                RightHip.C0,
                CF(1, -1, -0.01) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
            LeftHip.C0 =
                Clerp(
                LeftHip.C0,
                CF(-1, -1, -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                1 / Animation_Speed
            )
        end
        mB = false
        mF = false
    end
    function MouseDown(Mouse)
        if mB == false then
        end
    end
    function MouseUp(Mouse)
        mD = false
    end
    function KeyDown(n_)
        mH = true
        if n_ == "z" and mB == false then
            blim = true
            Punch()
            blim = false
        end
        if n_ == "e" and mB == false and mT == false then
            Throw()
        end
        if n_ == "r" and mB == false and mT == false then
            blim = true
            Uppercut()
            blim = false
        end
        if n_ == "t" and mB == false then
            Roar()
        end
        if n_ == "y" and mB == false then
            TakeOn()
        end
    end
    function KeyUp(n_)
        mH = false
    end
    Mouse.Button1Down:connect(
        function(nW)
            MouseDown(nW)
        end
    )
    Mouse.Button1Up:connect(
        function(nW)
            MouseUp(nW)
        end
    )
    Mouse.KeyDown:connect(
        function(nW)
            KeyDown(nW)
        end
    )
    Mouse.KeyUp:connect(
        function(nW)
            KeyUp(nW)
        end
    )
    function unanchor()
        for U, c in pairs(Character:GetChildren()) do
            if c:IsA("BasePart") and c ~= RootPart then
                c.Anchored = false
            end
        end
        if mQ == true then
            RootPart.Anchored = false
        else
            RootPart.Anchored = true
        end
    end
    Humanoid.Changed:connect(
        function(o0)
            if o0 == "Jump" and Disable_Jump == true then
                Humanoid.Jump = false
            end
        end
    )
    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    Swait()
                    mG = mG + mI
                end
            end
        )
    )
    coroutine.resume(
        coroutine.create(
            function()
                while true do
                    Swait()
                    mP.Parent = nil
                    for U, v in next, Humanoid:GetPlayingAnimationTracks() do
                        v:Stop()
                    end
                    local o1 = (RootPart.Velocity * VT(1, 0, 1)).magnitude
                    local o2 = RootPart.Velocity.y
                    local nN =
                        Raycast(
                        RootPart.Position,
                        CF(RootPart.Position, RootPart.Position + VT(0, -1, 0)).lookVector,
                        4,
                        Character
                    )
                    local o3 = 4
                    if mA == "Walk" and o1 > 1 then
                        RootJoint.C1 =
                            Clerp(
                            RootJoint.C1,
                            mv * CF(0, 0, -0.05 * COS(mG / (o3 / 2))) *
                                ANGLES(RAD(0), RAD(0) - RootPart.RotVelocity.Y / 75, RAD(0)),
                            2 * Humanoid.WalkSpeed / 16 / Animation_Speed
                        )
                        Neck.C1 =
                            Clerp(
                            Neck.C1,
                            CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) *
                                ANGLES(RAD(2.5 * SIN(mG / (o3 / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 30),
                            0.2 * Humanoid.WalkSpeed / 16 / Animation_Speed
                        )
                        RightHip.C1 =
                            Clerp(
                            RightHip.C1,
                            CF(
                                0.5,
                                0.875 - 0.125 * SIN(mG / o3) - 0.15 * COS(mG / o3 * 2),
                                -0.125 * COS(mG / o3) + 0.2 - 0.2 * COS(mG / o3)
                            ) *
                                ANGLES(RAD(0), RAD(90), RAD(0)) *
                                ANGLES(RAD(0) - RightLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(mG / o3))),
                            0.4 * Humanoid.WalkSpeed / 16 / Animation_Speed
                        )
                        LeftHip.C1 =
                            Clerp(
                            LeftHip.C1,
                            CF(
                                -0.5,
                                0.875 + 0.125 * SIN(mG / o3) - 0.15 * COS(mG / o3 * 2),
                                0.125 * COS(mG / o3) + 0.2 + 0.2 * COS(mG / o3)
                            ) *
                                ANGLES(RAD(0), RAD(-90), RAD(0)) *
                                ANGLES(RAD(0) + LeftLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(mG / o3))),
                            0.4 * Humanoid.WalkSpeed / 16 / Animation_Speed
                        )
                    elseif mA ~= "Walk" or o1 < 1 then
                        RootJoint.C1 =
                            Clerp(
                            RootJoint.C1,
                            mv * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)),
                            0.2 / Animation_Speed
                        )
                        Neck.C1 =
                            Clerp(
                            Neck.C1,
                            CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                            0.2 / Animation_Speed
                        )
                        RightHip.C1 =
                            Clerp(
                            RightHip.C1,
                            CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                            0.2 / Animation_Speed
                        )
                        LeftHip.C1 =
                            Clerp(
                            LeftHip.C1,
                            CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)),
                            0.2 / Animation_Speed
                        )
                    end
                    if o2 > 1 and nN == nil then
                        mA = "Jump"
                        if mB == false then
                            RootJoint2.C0 =
                                Clerp(
                                RootJoint2.C0,
                                mv * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            Neck2.C0 =
                                Clerp(
                                Neck2.C0,
                                mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            RightShoulder2.C0 =
                                Clerp(
                                RightShoulder2.C0,
                                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(15)) * mx,
                                1 / Animation_Speed
                            )
                            LeftShoulder2.C0 =
                                Clerp(
                                LeftShoulder2.C0,
                                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-15)) * my,
                                1 / Animation_Speed
                            )
                            RightHip2.C0 =
                                Clerp(
                                RightHip2.C0,
                                CF(1 * fG, -0.4 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            LeftHip2.C0 =
                                Clerp(
                                LeftHip2.C0,
                                CF(-1 * fG, -0.4 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            RootJoint.C0 =
                                Clerp(
                                RootJoint.C0,
                                mv * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            Neck.C0 =
                                Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
                            RightShoulder.C0 =
                                Clerp(
                                RightShoulder.C0,
                                CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(mG / 12))) * mx,
                                1 / Animation_Speed
                            )
                            LeftShoulder.C0 =
                                Clerp(
                                LeftShoulder.C0,
                                CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(mG / 12))) * my,
                                1 / Animation_Speed
                            )
                            RightHip.C0 =
                                Clerp(
                                RightHip.C0,
                                CF(1, -0.4, -0.6) * ANGLES(RAD(0), RAD(90), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            LeftHip.C0 =
                                Clerp(
                                LeftHip.C0,
                                CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                        end
                    elseif o2 < -1 and nN == nil then
                        mA = "Fall"
                        if mB == false then
                            RootJoint2.C0 =
                                Clerp(
                                RootJoint2.C0,
                                mv * CF(0, 0, 0) * ANGLES(RAD(-5), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            Neck2.C0 =
                                Clerp(
                                Neck2.C0,
                                mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            RightShoulder2.C0 =
                                Clerp(
                                RightShoulder2.C0,
                                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(80)) * mx,
                                1 / Animation_Speed
                            )
                            LeftShoulder2.C0 =
                                Clerp(
                                LeftShoulder2.C0,
                                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(0), RAD(0), RAD(-80)) * my,
                                1 / Animation_Speed
                            )
                            RightHip2.C0 =
                                Clerp(
                                RightHip2.C0,
                                CF(1 * fG, -0.4 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            LeftHip2.C0 =
                                Clerp(
                                LeftHip2.C0,
                                CF(-1 * fG, -0.4 * fG, -0.5 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            RootJoint.C0 =
                                Clerp(
                                RootJoint.C0,
                                mv * CF(0, 0, 0) * ANGLES(RAD(15), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            Neck.C0 =
                                Clerp(Neck.C0, mw * CF(0, 0, 0) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
                            RightShoulder.C0 =
                                Clerp(
                                RightShoulder.C0,
                                CF(1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(mG / 6)), RAD(0), RAD(45 + 10 * COS(mG / 12))) *
                                    mx,
                                1 / Animation_Speed
                            )
                            LeftShoulder.C0 =
                                Clerp(
                                LeftShoulder.C0,
                                CF(-1.5, 0.5, 0) *
                                    ANGLES(RAD(35 - 4 * COS(mG / 6)), RAD(0), RAD(-45 - 10 * COS(mG / 12))) *
                                    my,
                                1 / Animation_Speed
                            )
                            RightHip.C0 =
                                Clerp(
                                RightHip.C0,
                                CF(1, -0.3, -0.7) * ANGLES(RAD(-25 + 5 * SIN(mG / 12)), RAD(90), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            LeftHip.C0 =
                                Clerp(
                                LeftHip.C0,
                                CF(-1, -0.8, -0.3) * ANGLES(RAD(-10), RAD(-80), RAD(0)) *
                                    ANGLES(RAD(-1 * SIN(mG / 6)), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                        end
                    elseif o1 < 1 and nN ~= nil then
                        mA = "Idle"
                        if mB == false then
                            RootJoint2.C0 =
                                Clerp(
                                RootJoint2.C0,
                                mv * CF(0, 0, 0.25 * COS(mG / 12)) *
                                    ANGLES(RAD(-5 + 2 * SIN(mG / 12)), RAD(15), RAD(35)),
                                0.5 / Animation_Speed
                            )
                            Neck2.C0 =
                                Clerp(
                                Neck2.C0,
                                mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(25 - 2 * SIN(mG / 12)), RAD(0), RAD(-35)),
                                0.5 / Animation_Speed
                            )
                            RightShoulder2.C0 =
                                Clerp(
                                RightShoulder2.C0,
                                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(60)) * mx,
                                0.5 / Animation_Speed
                            )
                            LeftShoulder2.C0 =
                                Clerp(
                                LeftShoulder2.C0,
                                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(-60)) * my,
                                0.5 / Animation_Speed
                            )
                            RightHip2.C0 =
                                Clerp(
                                RightHip2.C0,
                                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            LeftHip2.C0 =
                                Clerp(
                                LeftHip2.C0,
                                CF(-1 * fG, -0.3 * fG, -0.6 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            RootJoint.C0 =
                                Clerp(
                                RootJoint.C0,
                                mv * CF(0, 0, 0 + 0.05 * COS(mG / 12)) * ANGLES(RAD(0), RAD(0), RAD(-15)),
                                1 / Animation_Speed
                            )
                            Neck.C0 =
                                Clerp(
                                Neck.C0,
                                mw * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(mG / 12)), RAD(0), RAD(15)),
                                1 / Animation_Speed
                            )
                            RightShoulder.C0 =
                                Clerp(
                                RightShoulder.C0,
                                CF(1.5, 0.5 + 0.05 * SIN(mG / 12), 0) * ANGLES(RAD(0), RAD(0), RAD(3)) * mx,
                                1 / Animation_Speed
                            )
                            LeftShoulder.C0 =
                                Clerp(
                                LeftShoulder.C0,
                                CF(-1.35, 0.5, 0.2) * ANGLES(RAD(-25), RAD(0), RAD(45)) * my,
                                1 / Animation_Speed
                            )
                            RightHip.C0 =
                                Clerp(
                                RightHip.C0,
                                CF(1.1, -1 - 0.05 * COS(mG / 12), -0.2) * ANGLES(RAD(0), RAD(100), RAD(0)) *
                                    ANGLES(RAD(0), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            LeftHip.C0 =
                                Clerp(
                                LeftHip.C0,
                                CF(-1, -1 - 0.05 * COS(mG / 12), 0) * ANGLES(RAD(0), RAD(-70), RAD(0)) *
                                    ANGLES(RAD(0), RAD(-2), RAD(0)),
                                1 / Animation_Speed
                            )
                        end
                    elseif o1 > 1 and nN ~= nil then
                        mA = "Walk"
                        if mB == false then
                            RootJoint2.C0 =
                                Clerp(
                                RootJoint2.C0,
                                mv * CF(0, 0, 0.25 * COS(mG / 12)) * ANGLES(RAD(35 + 2 * SIN(mG / 12)), RAD(0), RAD(35)),
                                0.5 / Animation_Speed
                            )
                            Neck2.C0 =
                                Clerp(
                                Neck2.C0,
                                mw * CF(0, 0, 0 + 1 * fG - 1) * ANGLES(RAD(-25 - 2 * SIN(mG / 12)), RAD(0), RAD(-35)),
                                0.5 / Animation_Speed
                            )
                            RightShoulder2.C0 =
                                Clerp(
                                RightShoulder2.C0,
                                CF(1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(60)) * mx,
                                0.5 / Animation_Speed
                            )
                            LeftShoulder2.C0 =
                                Clerp(
                                LeftShoulder2.C0,
                                CF(-1.5 * fG, 0.5 * fG, 0) * ANGLES(RAD(-35 + 15 * SIN(mG / 12)), RAD(0), RAD(-60)) * my,
                                0.5 / Animation_Speed
                            )
                            RightHip2.C0 =
                                Clerp(
                                RightHip2.C0,
                                CF(1 * fG, -1 * fG, 0) * ANGLES(RAD(0), RAD(80 - 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            LeftHip2.C0 =
                                Clerp(
                                LeftHip2.C0,
                                CF(-1 * fG, -0.5 * fG, -0.3 * fG) * ANGLES(RAD(-25), RAD(-80 + 1 * SIN(mG / 6)), RAD(0)) *
                                    ANGLES(RAD(-3 * SIN(mG / 12)), RAD(0), RAD(0)),
                                0.5 / Animation_Speed
                            )
                            RootJoint.C0 =
                                Clerp(
                                RootJoint.C0,
                                mv * CF(0, 0, -0.05) * ANGLES(RAD(5), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            Neck.C0 =
                                Clerp(
                                Neck.C0,
                                mw * CF(0, 0, 0) * ANGLES(RAD(5 - 1 * SIN(mG / (o3 / 2))), RAD(0), RAD(0)),
                                1 / Animation_Speed
                            )
                            RightShoulder.C0 =
                                Clerp(
                                RightShoulder.C0,
                                CF(1.5, 0.5, 0) * ANGLES(RAD(30 * COS(mG / o3)), RAD(0), RAD(5)) * mx,
                                1 / Animation_Speed
                            )
                            LeftShoulder.C0 =
                                Clerp(
                                LeftShoulder.C0,
                                CF(-1.5, 0.5, 0) * ANGLES(RAD(-30 * COS(mG / o3)), RAD(0), RAD(-5)) * my,
                                1 / Animation_Speed
                            )
                            RightHip.C0 =
                                Clerp(
                                RightHip.C0,
                                CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-15)),
                                2 / Animation_Speed
                            )
                            LeftHip.C0 =
                                Clerp(
                                LeftHip.C0,
                                CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(15)),
                                2 / Animation_Speed
                            )
                        end
                    end
                    if mB == false then
                        RootPart2.CFrame = Clerp(RootPart2.CFrame, RootPart.CFrame * CF(0, 6, 5), 0.1)
                    end
                    unanchor()
                    RootPart2.Anchored = true
                    Humanoid.MaxHealth = 200
                    Humanoid.Health = 200
                    if mF == false then
                        Disable_Jump = false
                        Humanoid.WalkSpeed = l
                    elseif mF == true then
                        Disable_Jump = true
                        Humanoid.WalkSpeed = 0
                    end
                    for U, c in pairs(mN:GetChildren()) do
                        if c:IsA("Part") then
                            c.Color = C3(1, 1, 1)
                            if c ~= RootPart2 then
                                c.Transparency = 1
                            end
                            if c:FindFirstChildOfClass("Decal") then
                                c:ClearAllChildren()
                            end
                            c.CanCollide = false
                            c.Material = "Neon"
                        else
                            c:remove()
                        end
                    end
                    mu.SoundId = "rbxassetid://609005478"
                    mu.Looped = true
                    mu.Pitch = 1
                    mu.Volume = 1.5
                    mu.Parent = Character
                    mu.Playing = mS
                    if mC == false then
                        Intro()
                    end
                end
            end
        )
    )
    R.rightarm.Handle.Touched:connect(
        function(hit)
            local F = hit.Parent:findFirstChild("Torso")
            if F and F.Parent.Name ~= L and F.Parent.Name ~= "giantstando" and blim == true then
                brug = false
                bruhmom = false
                pimbob = Instance.new("BodyAngularVelocity", pewhandle)
                pimbob.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                pimbob.P = 1000000000000000000000000000
                pimbob.AngularVelocity =
                    Vector3.new(10000000000000000000000000000000, 100000000000000000000000000, 100000000000000000)
                pewhandle.Position = hit.Parent:findFirstChild("Torso").Position
                wait(0.5)
                pimbob:Destroy()
                brug = true
                bruhmom = true
            end
        end
    )
    wait(0.25)
    for T, v in next, R do
        v.Handle.Anchored = true
    end
    wait(0.75)
    for T, v in next, R do
        v.Handle.Anchored = false
    end
    W(R.head.Handle, mN["Head"])
    W(R.torso.Handle, mN["Torso"])
    W(R.rightarm.Handle, mN["Right Arm"])
    W(R.leftarm.Handle, mN["Left Arm"])
    W(R.rightleg.Handle, mN["Right Leg"])
    W(R.leftleg.Handle, mN["Left Leg"])
    R.rightarm.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
    R.leftarm.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
    R.rightleg.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
    R.leftleg.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
    Character.Effects:Destroy()
