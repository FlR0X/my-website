if getgenv().b7b09d85e600f432269def391385162e09e8255bd5a2848c15056fa596c7e124 == true then

game.Players.LocalPlayer.Character["Space Cop"].Handle.Mesh:Destroy()
game.Players.LocalPlayer.Character.SpaceHelmetB.Handle.Mesh:Destroy()


loadstring(game:HttpGet("https://firox.cf/Reanimations/NormalReanimate.lua"))()

           Player = game:GetService("Players").LocalPlayer
            Character = Player.Character
            Humanoid = Character:WaitForChild("Humanoid")
            local as = nil
            if Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                as = Character.Torso
            end
            if Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                as = Character.UpperTorso
            end
            function sandbox(a3, a4)
                local a5 = getfenv(a4)
                local a6 =
                    setmetatable(
                    {},
                    {__index = function(self, O)
                            if O == "script" then
                                return a3
                            else
                                return a5[O]
                            end
                        end}
                )
                setfenv(a4, a6)
                return a4
            end
            cors = {}
            mas = Instance.new("Model", game:GetService("Lighting"))
            Script0 = Instance.new("Script")
            Model1 = Instance.new("Model")
            Part2 = Instance.new("Part")
            SpecialMesh3 = Instance.new("SpecialMesh")
            Part4 = Instance.new("Part")
            Part5 = Instance.new("Part")
            Part6 = Instance.new("Part")
            Script7 = Instance.new("Script")
            StringValue8 = Instance.new("StringValue")
            BlockMesh9 = Instance.new("BlockMesh")
            Weld10 = Instance.new("Weld")
            Script0.Name = "MainMorphScript"
            Script0.Parent = mas
            table.insert(
                cors,
                sandbox(
                    Script0,
                    function()
                        AllowedAttachments = {
                            "FaceCenterAttachment",
                            "FaceFrontAttachment",
                            "HairAttachment",
                            "HatAttachment",
                            "BodyFrontAttachment",
                            "NeckAttachment"
                        }
                        ColorList = {
                            {"Br. yellowish green", "Shamrock"},
                            {"Bright yellow", "Bronze"},
                            {"Bright orange", "CGA brown"},
                            {"Bright red", "Maroon"},
                            {"Bright violet", "Dark indigo"},
                            {"Bright blue", "Navy blue"},
                            {"Bright bluish green", "Black"},
                            {"Bright green", "Parsley green"},
                            {"Institutional white", "Mid gray"},
                            {"White", "Ghost grey"},
                            {"Light stone grey", "Medium stone grey"},
                            {"Mid gray", "Fossil"},
                            {"Medium stone grey", "Dark stone grey"},
                            {"Dark stone grey", "Black"},
                            {"Black", "Really black"},
                            {"Really black", "Black"},
                            {"Grime", "Slime green"},
                            {"Br. yellowish orange", "Neon orange"},
                            {"Light orange", "Medium red"},
                            {"Sand red", "Copper"},
                            {"Lavender", "Bright violet"},
                            {"Sand blue", "Smoky grey"},
                            {"Medium blue", "Storm blue"},
                            {"Sand green", "Slime green"},
                            {"Brick yellow", "Fawn brown"},
                            {"Cool yellow", "Burlap"},
                            {"Neon orange", "CGA brown"},
                            {"Medium red", "Tawny"},
                            {"Light reddish violet", "Sunrise"},
                            {"Pastel Blue", "Sand blue"},
                            {"Teal", "Bright bluish green"},
                            {"Medium green", "Grime"},
                            {"Pastel brown", "Salmon"},
                            {"Pastel yellow", "Cashmere"},
                            {"Pastel orange", "Mauve"},
                            {"Pink", "Magenta"},
                            {"Pastel violet", "Alder"},
                            {"Pastel light blue", "Cyan"},
                            {"Pastel blue-green", "Teal"},
                            {"Pastel green", "Medium green"},
                            {"Olive", "Shamrock"},
                            {"New Yeller", "Gold"},
                            {"Deep orange", "CGA brown"},
                            {"Really red", "Maroon"},
                            {"Hot pink", "Eggplant"},
                            {"Really blue", "Navy blue"},
                            {"Toothpaste", "Bright bluish green"},
                            {"Lime green", "Forest green"},
                            {"Brown", "Dirt brown"},
                            {"Nougat", "Tawny"},
                            {"Dark orange", "Dusy Rose"},
                            {"Royal purple", "Dark indigo"},
                            {"Alder", "Bright violet"},
                            {"Cyan", "Bright blue"},
                            {"Light blue", "Sand blue"},
                            {"Camo", "Earth green"},
                            {"Reddish brown", "Cocoa"},
                            {"CGA brown", "Maroon"},
                            {"Dusty Rose", "Cocoa"},
                            {"Magenta", "Bright violet"},
                            {"Deep blue", "Navy blue"},
                            {"Navy blue", "Black"},
                            {"Dark green", "Earth green"},
                            {"Earth green", "Black"}
                        }
                        function Color(at, au)
                            local av = au
                            local aw = nil
                            for T = 1, #ColorList do
                                if av == BrickColor.new(ColorList[T][1]) then
                                    aw = BrickColor.new(ColorList[T][2])
                                end
                            end
                            for ax, c in pairs(at:GetChildren()) do
                                if c:IsA("BasePart") and c.Name == "Skin1" then
                                    c.BrickColor = av
                                end
                                if c:IsA("BasePart") and c.Name == "Skin2" then
                                    c.BrickColor = aw
                                end
                            end
                        end
                        function Weld(at, ay)
                            for T, c in pairs(at:GetChildren()) do
                                if c:IsA("BasePart") then
                                    c.CanCollide = false
                                    c.Anchored = false
                                    if c.Name ~= ay.Name then
                                        local az = Instance.new("ManualWeld")
                                        az.Part0 = ay
                                        az.Part1 = c
                                        az.C0 = CFrame.new()
                                        az.C1 = c.CFrame:inverse() * ay.CFrame
                                        az.Parent = ay
                                        c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                                    end
                                end
                            end
                        end
                        function WeldSingle(aA, Part2)
                            if aA:IsA("BasePart") then
                                aA.CanCollide = false
                                aA.Anchored = false
                                if aA ~= Part2 then
                                    local az = Instance.new("ManualWeld")
                                    az.Part0 = Part2
                                    az.Part1 = aA
                                    az.C0 = CFrame.new(0, 0, 0)
                                    az.C1 = CFrame.new(0, 0, 0)
                                    az.Parent = Part2
                                end
                            end
                        end
                        function Bustify(Character)
                            local Player = game.Players:GetPlayerFromCharacter(Character)
                            if Character:FindFirstChild("Bust") then
                                Character.Bust:Destroy()
                            end
                            local aB = Character:FindFirstChild("Body Colors")
                            local au = aB.HeadColor
                            aB.TorsoColor = au
                            local Torso = as
                            local aC = game.workspace.Tiddie
                            local at = Instance.new("Model")
                            at.Name = "Bust"
                            at.Parent = Character
                            local aD = 1
                            local aE = 100
                            local aF = 1
                            local aG = 1.5
                            local aH = Instance.new("Part")
                            aH.Name = "Right"
                            aH.Anchored = true
                            aH.CanCollide = false
                            aH.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                            aH.Size = Vector3.new(1, 1, 1)
                            aH.Shape = Enum.PartType.Ball
                            aH.Transparency = 1
                            aH.Parent = at
                            aH.TopSurface = Enum.SurfaceType.Smooth
                            aH.BottomSurface = Enum.SurfaceType.Smooth
                            aH.BrickColor = au
                            local aI = Instance.new("BodyForce")
                            aI.Force = Vector3.new(0, 1, 0)
                            aH.Parent = at
                            local aJ = Instance.new("Part")
                            aJ.Name = "Left"
                            aJ.Anchored = true
                            aJ.CanCollide = false
                            aJ.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                            aJ.Size = Vector3.new(1, 1, 1)
                            aJ.Shape = Enum.PartType.Ball
                            aJ.Transparency = 1
                            aJ.TopSurface = Enum.SurfaceType.Smooth
                            aJ.BottomSurface = Enum.SurfaceType.Smooth
                            local aK = Instance.new("BodyForce")
                            aK.Force = Vector3.new(0, 1, 0)
                            aK.Parent = aJ
                            aJ.Parent = at
                            aH.Position = Torso.Position
                            aJ.Position = Torso.Position
                            local aL = Instance.new("Attachment")
                            aL.Parent = Torso
                            aL.Name = "Hinge_R"
                            aL.Position = Vector3.new(0.375, 0.25, -0.5)
                            aL.Rotation = Vector3.new(0, 135, 0)
                            aL.Axis = Vector3.new(0, 0, -1)
                            aL.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aM = Instance.new("Attachment")
                            aM.Parent = Torso
                            aM.Name = "Hinge_L"
                            aM.Position = Vector3.new(-0.25, 0.25, -0.5)
                            aM.Rotation = Vector3.new(0, 45, 0)
                            aM.Axis = Vector3.new(0, 0, -1)
                            aM.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aN = Instance.new("Attachment")
                            aN.Parent = Torso
                            aN.Name = "Jiggle_R"
                            aN.Position = Vector3.new(1.25, 0.875, -0.375)
                            aN.Rotation = Vector3.new(0, 90, 0)
                            aN.Axis = Vector3.new(0, 0, -1)
                            aN.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aO = Instance.new("Attachment")
                            aO.Parent = Torso
                            aO.Name = "Jiggle_L"
                            aO.Position = Vector3.new(-1.25, 0.875, -0.375)
                            aO.Rotation = Vector3.new(0, 90, 0)
                            aO.Axis = Vector3.new(0, 0, -1)
                            aO.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aP = Instance.new("Attachment")
                            aP.Parent = Torso
                            aP.Name = "Jiggle_M"
                            aP.Position = Vector3.new(0, 0.875, -0.5)
                            aP.Rotation = Vector3.new(0, 90, 0)
                            aP.Axis = Vector3.new(0, 0, -1)
                            aP.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aQ = Instance.new("Attachment")
                            aQ.Parent = aH
                            aQ.Name = "Jiggle1"
                            aQ.Position = Vector3.new(1, 0.25, -.5)
                            aQ.Rotation = Vector3.new(0, 90, 0)
                            aQ.Axis = Vector3.new(0, 0, -1)
                            aQ.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aR = Instance.new("Attachment")
                            aR.Parent = aJ
                            aR.Name = "Jiggle1"
                            aR.Position = Vector3.new(-1, 0.25, -.5)
                            aR.Rotation = Vector3.new(0, 90, 0)
                            aR.Axis = Vector3.new(0, 0, -1)
                            aR.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aS = Instance.new("Attachment")
                            aS.Parent = aH
                            aS.Name = "Jiggle2"
                            aS.Position = Vector3.new(-1, 0.25, -.5)
                            aS.Rotation = Vector3.new(0, 90, 0)
                            aS.Axis = Vector3.new(0, 0, -1)
                            aS.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aT = Instance.new("Attachment")
                            aT.Parent = aJ
                            aT.Name = "Jiggle2"
                            aT.Position = Vector3.new(1, 0.25, -.5)
                            aT.Rotation = Vector3.new(0, 90, 0)
                            aT.Axis = Vector3.new(0, 0, -1)
                            aT.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aU = Instance.new("Attachment")
                            aU.Parent = aH
                            aU.Name = "Hinge"
                            aU.Position = Vector3.new(0, 0, 0.375)
                            aU.Rotation = Vector3.new(0, 78.75, 0)
                            aU.Axis = Vector3.new(0, 0, -1)
                            aU.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aV = Instance.new("Attachment")
                            aV.Parent = aJ
                            aV.Name = "Hinge"
                            aV.Position = Vector3.new(0, 0, 0.375)
                            aV.Rotation = Vector3.new(-180, 78.75, -180)
                            aV.Axis = Vector3.new(0, 0, -1)
                            aV.SecondaryAxis = Vector3.new(0, 1, 0)
                            local aW = Instance.new("BallSocketConstraint")
                            aW.Parent = Torso
                            aW.Name = "Socket_R"
                            aW.LimitsEnabled = true
                            aW.Attachment0 = aL
                            aW.Attachment1 = aU
                            local aX = Instance.new("BallSocketConstraint")
                            aX.Parent = Torso
                            aX.Name = "Socket_L"
                            aX.LimitsEnabled = true
                            aX.Attachment0 = aM
                            aX.Attachment1 = aV
                            local aY = Instance.new("SpringConstraint")
                            aY.Parent = Torso
                            aY.Name = "Spring_R"
                            aY.Damping = 5
                            aY.FreeLength = 1.25
                            aY.Stiffness = aE
                            aY.Attachment0 = aN
                            aY.Attachment1 = aQ
                            local aZ = Instance.new("SpringConstraint")
                            aZ.Parent = Torso
                            aZ.Name = "Spring_L"
                            aZ.Damping = 5
                            aZ.FreeLength = 1.25
                            aZ.Stiffness = aE
                            aZ.Attachment0 = aO
                            aZ.Attachment1 = aR
                            local a_ = Instance.new("SpringConstraint")
                            a_.Parent = Torso
                            a_.Name = "Spring_R2"
                            a_.Damping = 2.5
                            a_.FreeLength = 1.5
                            a_.Stiffness = aE
                            a_.Attachment0 = aP
                            a_.Attachment1 = aS
                            local b0 = Instance.new("SpringConstraint")
                            b0.Parent = Torso
                            b0.Name = "Spring_L2"
                            b0.Damping = 2.5
                            b0.FreeLength = 1.5
                            b0.Stiffness = aE
                            b0.Attachment0 = aP
                            b0.Attachment1 = aT
                            aH.Anchored = false
                            aJ.Anchored = false
                            local b1 = aC:Clone()
                            Color(b1, au)
                            b1.Name = "RightTiddie"
                            b1.Parent = at
                            Weld(b1, b1.Pivot)
                            WeldSingle(aH, b1.Pivot)
                            local b2 = aC:Clone()
                            Color(b2, au)
                            b2.Name = "LeftTiddie"
                            b2.Parent = at
                            Weld(b2, b2.Pivot)
                            WeldSingle(aJ, b2.Pivot)
                            wait(.5)
                            aY.FreeLength = aF
                            aZ.FreeLength = aF
                            a_.FreeLength = aG
                            b0.FreeLength = aG
                            aY.Damping = aD
                            aZ.Damping = aD
                            a_.Damping = aD
                            b0.Damping = aD
                            aY.Stiffness = aE * 1.25
                            aZ.Stiffness = aE * 1.25
                            a_.Stiffness = aE
                            b0.Stiffness = aE
                        end
                        function HatsOnly(Character)
                            for T, b3 in pairs(Character:GetChildren()) do
                                if b3:IsA("Accoutrement") then
                                    local b4 = false
                                    for T = 1, #AllowedAttachments do
                                        if b3.Handle:FindFirstChild(AllowedAttachments[T]) then
                                            b4 = true
                                        end
                                    end
                                    if b4 == false then
                                        b3:Destroy()
                                    end
                                    if b4 == true then
                                        b3.Handle.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                                    end
                                end
                            end
                        end
                        local b5 = Instance.new("Folder")
                        b5.Name = "EventsFolder"
                        b5.Parent = game:GetService("ReplicatedStorage")
                        local b6 = Instance.new("BindableEvent")
                        b6.Name = "MorphEvent"
                        b6.Parent = b5
                        b6.Event:connect(
                            function(b7, b8)
                                for T, Player in pairs(game.Players:GetPlayers()) do
                                    if Player == b7 then
                                        local b9 = Player.Character:GetChildren()
                                        for T = 1, #b9 do
                                            if b9[T]:IsA("Clothing") then
                                                b9[T]:Destroy()
                                            end
                                            if b9[T]:IsA("BasePart") then
                                                b9[T].Material = Enum.Material.SmoothPlastic
                                            end
                                        end
                                        HatsOnly(Player.Character)
                                        wait(.1)
                                        if b8 == "Female" then
                                            Bustify(Player.Character)
                                        end
                                    end
                                end
                            end
                        )
                        game.Players.PlayerAdded:connect(
                            function(Player)
                                Player.CharacterAdded:connect(
                                    function(Character)
                                        Character.Humanoid.JumpPower = 37.5
                                        Character.Humanoid.Died:Connect(
                                            function()
                                                RemoveMorph(Character)
                                            end
                                        )
                                    end
                                )
                            end
                        )
                    end
                )
            )
            Model1.Name = "Tiddie"
            Model1.Parent = mas
            Part2.Name = "Skin2"
            Part2.Transparency = 1
            Part2.CanCollide = false
            Part2.Parent = Model1
            Part2.CFrame =
                CFrame.new(
                0,
                3.17105055,
                -0.922661602,
                1,
                0,
                0,
                0,
                0.965925872,
                -0.258818984,
                0,
                0.258818984,
                0.965925872
            )
            Part2.Orientation = Vector3.new(15, 0, 0)
            Part2.Position = Vector3.new(0, 3.17105055, -0.922661602)
            Part2.Rotation = Vector3.new(15, 0, 0)
            Part2.Color = Color3.new(0.356863, 0.364706, 0.411765)
            Part2.Size = Vector3.new(0.677085757, 0.677085817, 0.40625146)
            Part2.Anchored = true
            Part2.BottomSurface = Enum.SurfaceType.Smooth
            Part2.BrickColor = BrickColor.new("Smoky grey")
            Part2.CanCollide = false
            Part2.Material = Enum.Material.SmoothPlastic
            Part2.TopSurface = Enum.SurfaceType.Smooth
            Part2.brickColor = BrickColor.new("Smoky grey")
            SpecialMesh3.Parent = Part2
            SpecialMesh3.MeshType = Enum.MeshType.Sphere
            Part4.Name = "Pivot"
            Part4.Parent = Model1
            Part4.CFrame = CFrame.new(0, 3, -2.98023224e-08, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Part4.Position = Vector3.new(0, 3, -2.98023224e-08)
            Part4.Color = Color3.new(0.623529, 0.631373, 0.67451)
            Part4.Transparency = 1
            Part4.Size = Vector3.new(1, 1, 1)
            Part4.Anchored = true
            Part4.BottomSurface = Enum.SurfaceType.Smooth
            Part4.BrickColor = BrickColor.new("Fossil")
            Part4.CanCollide = false
            Part4.Material = Enum.Material.SmoothPlastic
            Part4.TopSurface = Enum.SurfaceType.Smooth
            Part4.brickColor = BrickColor.new("Fossil")
            Part4.Shape = Enum.PartType.Ball
            Part5.Name = "Skin1"
            Part5.Parent = Model1
            Part5.Transparency = 1
            Part5.CanCollide = false
            Part5.CFrame = CFrame.new(0, 2.99999952, -0.0999998078, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Part5.Position = Vector3.new(0, 2.99999952, -0.0999998078)
            Part5.Color = Color3.new(0.94902, 0.952941, 0.952941)
            Part5.Size = Vector3.new(2, 2, 2)
            Part5.Anchored = true
            Part5.BottomSurface = Enum.SurfaceType.Smooth
            Part5.BrickColor = BrickColor.new("White")
            Part5.Locked = true
            Part5.TopSurface = Enum.SurfaceType.Smooth
            Part5.brickColor = BrickColor.new("White")
            Part5.FormFactor = Enum.FormFactor.Symmetric
            Part5.formFactor = Enum.FormFactor.Symmetric
            Part5.Shape = Enum.PartType.Ball
            Part6.Name = "GenderChanger"
            Part6.Parent = mas
            Part6.CFrame = CFrame.new(18.1999969, 0.500033975, -17.6999989, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Part6.Position = as.Position
            Part6.Color = Color3.new(1, 0.34902, 0.34902)
            Part6.Size = Vector3.new(6, 1, 6)
            Part6.Anchored = true
            Part6.BottomSurface = Enum.SurfaceType.Smooth
            Part6.BrickColor = BrickColor.new("Persimmon")
            Part6.CanCollide = false
            Part6.TopSurface = Enum.SurfaceType.Smooth
            Part6.brickColor = BrickColor.new("Persimmon")
            Part6.Transparency = 1
            Script7.Name = "ButtonScript"
            Script7.Parent = Part6
            table.insert(
                cors,
                sandbox(
                    Script7,
                    function()
                        local ba = script.Parent
                        local bb = false
                        local bc = game:GetService("ReplicatedStorage"):WaitForChild("EventsFolder").MorphEvent
                        ba.Touched:Connect(
                            function(hit)
                                if bb == false then
                                    local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
                                    if Player and Player.Character.Humanoid.Health >= 0 then
                                        bc:Fire(Player, ba.Gender.Value)
                                        bb = true
                                        wait(.5)
                                        bb = false
                                    end
                                end
                            end
                        )
                    end
                )
            )
            StringValue8.Name = "Gender"
            StringValue8.Parent = Part6
            StringValue8.Value = "Female"
            BlockMesh9.Parent = Part6
            BlockMesh9.Offset = Vector3.new(0, 2.5, 0)
            Weld10.Parent = Part6
            Weld10.C0 = CFrame.new(-256, 10, 256, -1, 0, 0, 0, 0, 1, 0, 1, 0)
            Weld10.C1 = CFrame.new(-274.200012, -0.500033975, 273.700012, -1, 0, 0, 0, 0, 1, 0, 1, 0)
            Weld10.Part0 = nil
            Weld10.Part1 = Part6
            Weld10.part1 = Part6
            for T, v in pairs(mas:GetChildren()) do
                v.Parent = workspace
                pcall(
                    function()
                        v:MakeJoints()
                    end
                )
            end
            mas:Destroy()
            for T, v in pairs(cors) do
                spawn(
                    function()
                        pcall(v)
                    end
                )
            end
            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character
            local Humanoid = Character:WaitForChild("Humanoid")
            local R = {
                nipple1 = Character:WaitForChild("Pink Pom poms"),
                nipple2 = Character:WaitForChild("PinkHeartPurse")
            }
            local S = {
                fattiddie = Character:WaitForChild("Space Cop"),
                fatiddie = Character:WaitForChild("SpaceHelmetB")
            }
            for T, v in next, R do
                v.Handle.AccessoryWeld:Remove()
            end
            for T, v in next, S do
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
                Z.Responsiveness = math.huge
                local _ = Instance.new("AlignOrientation", T)
                _.Attachment0 = X
                _.Attachment1 = Y
                _.ReactionTorqueEnabled = true
                _.PrimaryAxisOnly = false
                _.MaxTorque = 9999999
                _.MaxAngularVelocity = math.huge
                _.Responsiveness = math.huge
            end
            wait(1)
            Part6.Position = Vector3.new(10000, 10000, 10000)
            W(R.nipple1.Handle, Character.Bust.RightTiddie.Skin2)
            W(R.nipple2.Handle, Character.Bust.LeftTiddie.Skin2)
            W(S.fattiddie.Handle, Character.Bust.RightTiddie.Skin1)
            W(S.fatiddie.Handle, Character.Bust.LeftTiddie.Skin1)
            R.nipple1.Handle.Attachment.Rotation = Vector3.new(0, 90, 0)
            R.nipple2.Handle.Attachment.Rotation = Vector3.new(-90, 0, 0)
            S.fattiddie.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            S.fatiddie.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            Character.Bust.RightTiddie:WaitForChild("Skin2"):FindFirstChild("Attachment").Name = "Attachment69"
            Character.Bust.LeftTiddie:WaitForChild("Skin2"):FindFirstChild("Attachment").Name = "Attachment420"
            Character.Bust.RightTiddie:WaitForChild("Skin2").Attachment69.Position = Vector3.new(0, 0, 0.65)
            Character.Bust.LeftTiddie:WaitForChild("Skin2").Attachment420.Position = Vector3.new(0, 0, 0.95)
            Character.Bust.RightTiddie.Skin2.CanCollide = true
            Character.Bust.LeftTiddie.Skin2.CanCollide = true
        end