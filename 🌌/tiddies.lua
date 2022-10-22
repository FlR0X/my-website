if getgenv().b7b09d85e600f432269def391385162e09e8255bd5a2848c15056fa596c7e124 == true then
      local hairAccessoriesWithoutHairInName = {
['PinkHeartPurse'] = true;
['FluffyEars'] = true;
['LooseSideBuns'] = true;
['EmotimaskCute'] = true;
['Pink Pom poms'] = true;
['Pink Pom poms'] = true;
}
 
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("Accessory","LongStraightHair") and not hairAccessoriesWithoutHairInName[v.Name] and v.Handle:FindFirstChild("Mesh") then
    ag = v.Handle:FindFirstChild("Mesh")
    ag:Destroy()
    end
    end
 
     for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("Accessory","LongStraightHair") and not hairAccessoriesWithoutHairInName[v.Name] and v.Handle:FindFirstChild("SpecialMesh") then
    ag = v.Handle:FindFirstChild("SpecialMesh")
    ag:Destroy()
    end
    end
wait(0.5)
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

wait(0.5)

--reanimate by MyWorld#4430 discord.gg/pYVHtSJmEY
local v3_net, v3_808 = Vector3.new(0, 25.1, 0), Vector3.new(8, 0, 8)
local function getNetlessVelocity(realPartVelocity)
    local mag = realPartVelocity.Magnitude
    if mag > 1 then
        local unit = realPartVelocity.Unit
        if (unit.Y > 0.25) or (unit.Y < -0.75) then
            return unit * (25.1 / unit.Y)
        end
    end
    return v3_net + realPartVelocity * v3_808
end
local simradius = "shp" --simulation radius (net bypass) method
--"shp" - sethiddenproperty
--"ssr" - setsimulationradius
--false - disable
local simrad = 1000 --simulation radius value
local healthHide = false --moves your head away every 3 seconds so players dont see your health bar (alignmode 4 only)
local reclaim = true --if you lost control over a part this will move your primary part to the part so you get it back (alignmode 4)
local novoid = true --prevents parts from going under workspace.FallenPartsDestroyHeight if you control them (alignmode 4 only)
local physp = nil --PhysicalProperties.new(0.01, 0, 1, 0, 0) --sets .CustomPhysicalProperties to this for each part
local noclipAllParts = false --set it to true if you want noclip
local antiragdoll = true --removes hingeConstraints and ballSocketConstraints from your character
local newanimate = true --disables the animate script and enables after reanimation
local discharscripts = true --disables all localScripts parented to your character before reanimation
local R15toR6 = true --tries to convert your character to r6 if its r15
local hatcollide = false --makes hats cancollide (credit to ShownApe) (works only with reanimate method 0)
local humState16 = true --enables collisions for limbs before the humanoid dies (using hum:ChangeState)
local addtools = false --puts all tools from backpack to character and lets you hold them after reanimation
local hedafterneck = true --disable aligns for head and enable after neck or torso is removed
local loadtime = game:GetService("Players").RespawnTime + 0.5 --anti respawn delay
local method = 1 --reanimation method
--methods:
--0 - breakJoints (takes [loadtime] seconds to load)
--1 - limbs
--2 - limbs + anti respawn
--3 - limbs + breakJoints after [loadtime] seconds
--4 - remove humanoid + breakJoints
--5 - remove humanoid + limbst
local alignmode = 4 --AlignPosition mode
--modes:
--1 - AlignPosition rigidity enabled true
--2 - 2 AlignPositions rigidity enabled both true and false
--3 - AlignPosition rigidity enabled false
--4 - CFrame
local flingpart = "HumanoidRootPart" --name of the part or the hat used for flinging
--the fling function
--usage: fling(target, duration, velocity)
--target can be set to: basePart, CFrame, Vector3, character model or humanoid (flings at mouse.Hit if argument not provided))
--duration (fling time in seconds) can be set to a number or a string convertable to the number (0.5s if not provided),
--velocity (fling part rotation velocity) can be set to a vector3 value (Vector3.new(20000, 20000, 20000) if not provided)

local lp = game:GetService("Players").LocalPlayer
local rs, ws, sg = game:GetService("RunService"), game:GetService("Workspace"), game:GetService("StarterGui")
local stepped, heartbeat, renderstepped = rs.Stepped, rs.Heartbeat, rs.RenderStepped
local twait, tdelay, rad, inf, abs, clamp = task.wait, task.delay, math.rad, math.huge, math.abs, math.clamp
local cf, v3 = CFrame.new, Vector3.new
local angles = CFrame.Angles
local v3_0, cf_0 = v3(0, 0, 0), cf(0, 0, 0)

local c = lp.Character
if not (c and c.Parent) then
    return
end

c:GetPropertyChangedSignal("Parent"):Connect(function()
    if not (c and c.Parent) then
        c = nil
    end
end)

local clone, destroy, getchildren, getdescendants, isa = c.Clone, c.Destroy, c.GetChildren, c.GetDescendants, c.IsA

local function gp(parent, name, className)
    if typeof(parent) == "Instance" then
        for i, v in pairs(getchildren(parent)) do
            if (v.Name == name) and isa(v, className) then
                return v
            end
        end
    end
    return nil
end

local fenv = getfenv()

local shp = fenv.sethiddenproperty or fenv.set_hidden_property or fenv.set_hidden_prop or fenv.sethiddenprop
local ssr = fenv.setsimulationradius or fenv.set_simulation_radius or fenv.set_sim_radius or fenv.setsimradius or fenv.setsimrad or fenv.set_sim_rad

healthHide = healthHide and ((method == 0) or (method == 3)) and gp(c, "Head", "BasePart")

local reclaim, lostpart = reclaim and c.PrimaryPart, nil

local function align(Part0, Part1)
    
    local att0 = Instance.new("Attachment")
    att0.Position, att0.Orientation, att0.Name = v3_0, v3_0, "att0_" .. Part0.Name
    local att1 = Instance.new("Attachment")
    att1.Position, att1.Orientation, att1.Name = v3_0, v3_0, "att1_" .. Part1.Name

    if alignmode == 4 then
    
        local hide = false
        if Part0 == healthHide then
            healthHide = false
            tdelay(0, function()
                while twait(2.9) and Part0 and c do
                    hide = #Part0:GetConnectedParts() == 1
                    twait(0.1)
                    hide = false
                end
            end)
        end
        
        local rot = rad(0.05)
        local con0, con1 = nil, nil
        con0 = stepped:Connect(function()
            if not (Part0 and Part1) then return con0:Disconnect() and con1:Disconnect() end
            Part0.RotVelocity = Part1.RotVelocity
        end)
        local lastpos = Part0.Position
        con1 = heartbeat:Connect(function(delta)
            if not (Part0 and Part1 and att1) then return con0:Disconnect() and con1:Disconnect() end
            if (not Part0.Anchored) and (Part0.ReceiveAge == 0) then
                if lostpart == Part0 then
                    lostpart = nil
                end
                rot = -rot
                local newcf = Part1.CFrame * att1.CFrame * angles(0, 0, rot)
                if Part1.Velocity.Magnitude > 0.01 then
                    Part0.Velocity = getNetlessVelocity(Part1.Velocity)
                else
                    Part0.Velocity = getNetlessVelocity((newcf.Position - lastpos) / delta)
                end
                lastpos = newcf.Position
                if lostpart and (Part0 == reclaim) then
                    newcf = lostpart.CFrame
                elseif hide then
                    newcf += v3(0, 3000, 0)
                end
                if novoid and (newcf.Y < ws.FallenPartsDestroyHeight + 0.1) then
                    newcf += v3(0, ws.FallenPartsDestroyHeight + 0.1 - newcf.Y, 0)
                end
                Part0.CFrame = newcf
            elseif (not Part0.Anchored) and (abs(Part0.Velocity.X) < 45) and (abs(Part0.Velocity.Y) < 25) and (abs(Part0.Velocity.Z) < 45) then
                lostpart = Part0
            end
        end)
    
    else
        
        Part0.CustomPhysicalProperties = physp
        if (alignmode == 1) or (alignmode == 2) then
            local ape = Instance.new("AlignPosition")
            ape.MaxForce, ape.MaxVelocity, ape.Responsiveness = inf, inf, inf
            ape.ReactionForceEnabled, ape.RigidityEnabled, ape.ApplyAtCenterOfMass = false, true, false
            ape.Attachment0, ape.Attachment1, ape.Name = att0, att1, "AlignPositionRtrue"
            ape.Parent = att0
        end
        
        if (alignmode == 2) or (alignmode == 3) then
            local apd = Instance.new("AlignPosition")
            apd.MaxForce, apd.MaxVelocity, apd.Responsiveness = inf, inf, inf
            apd.ReactionForceEnabled, apd.RigidityEnabled, apd.ApplyAtCenterOfMass = false, false, false
            apd.Attachment0, apd.Attachment1, apd.Name = att0, att1, "AlignPositionRfalse"
            apd.Parent = att0
        end
        
        local ao = Instance.new("AlignOrientation")
        ao.MaxAngularVelocity, ao.MaxTorque, ao.Responsiveness = inf, inf, inf
        ao.PrimaryAxisOnly, ao.ReactionTorqueEnabled, ao.RigidityEnabled = false, false, false
        ao.Attachment0, ao.Attachment1 = att0, att1
        ao.Parent = att0
        
        local con0, con1 = nil, nil
        local vel = Part0.Velocity
        con0 = renderstepped:Connect(function()
            if not (Part0 and Part1) then return con0:Disconnect() and con1:Disconnect() end
            Part0.Velocity = vel
        end)
        local lastpos = Part0.Position
        con1 = heartbeat:Connect(function(delta)
            if not (Part0 and Part1) then return con0:Disconnect() and con1:Disconnect() end
            vel = Part0.Velocity
            if Part1.Velocity.Magnitude > 0.01 then
                Part0.Velocity = getNetlessVelocity(Part1.Velocity)
            else
                Part0.Velocity = getNetlessVelocity((Part0.Position - lastpos) / delta)
            end
            lastpos = Part0.Position
        end)
    
    end

    att0:GetPropertyChangedSignal("Parent"):Connect(function()
        Part0 = att0.Parent
        if not isa(Part0, "BasePart") then
            att0 = nil
            if lostpart == Part0 then
                lostpart = nil
            end
            Part0 = nil
        end
    end)
    att0.Parent = Part0
    
    att1:GetPropertyChangedSignal("Parent"):Connect(function()
        Part1 = att1.Parent
        if not isa(Part1, "BasePart") then
            att1 = nil
            Part1 = nil
        end
    end)
    att1.Parent = Part1
end

local function respawnrequest()
    local ccfr, c = ws.CurrentCamera.CFrame, lp.Character
    lp.Character = nil
    lp.Character = c
    local con = nil
    con = ws.CurrentCamera.Changed:Connect(function(prop)
        if (prop ~= "Parent") and (prop ~= "CFrame") then
            return
        end
        ws.CurrentCamera.CFrame = ccfr
        con:Disconnect()
    end)
end

local destroyhum = (method == 4) or (method == 5)
local breakjoints = (method == 0) or (method == 4)
local antirespawn = (method == 0) or (method == 2) or (method == 3)

hatcollide = hatcollide and (method == 0)

addtools = addtools and lp:FindFirstChildOfClass("Backpack")

if type(simrad) ~= "number" then simrad = 1000 end
if shp and (simradius == "shp") then
    tdelay(0, function()
        while c do
            shp(lp, "SimulationRadius", simrad)
            heartbeat:Wait()
        end
    end)
elseif ssr and (simradius == "ssr") then
    tdelay(0, function()
        while c do
            ssr(simrad)
            heartbeat:Wait()
        end
    end)
end

if antiragdoll then
    antiragdoll = function(v)
        if isa(v, "HingeConstraint") or isa(v, "BallSocketConstraint") then
            v.Parent = nil
        end
    end
    for i, v in pairs(getdescendants(c)) do
        antiragdoll(v)
    end
    c.DescendantAdded:Connect(antiragdoll)
end

if antirespawn then
    respawnrequest()
end

if method == 0 then
    twait(loadtime)
    if not c then
        return
    end
end

if discharscripts then
    for i, v in pairs(getdescendants(c)) do
        if isa(v, "LocalScript") then
            v.Disabled = true
        end
    end
elseif newanimate then
    local animate = gp(c, "Animate", "LocalScript")
    if animate and (not animate.Disabled) then
        animate.Disabled = true
    else
        newanimate = false
    end
end

if addtools then
    for i, v in pairs(getchildren(addtools)) do
        if isa(v, "Tool") then
            v.Parent = c
        end
    end
end

pcall(function()
    settings().Physics.AllowSleep = false
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
end)

local OLDscripts = {}

for i, v in pairs(getdescendants(c)) do
    if v.ClassName == "Script" then
        OLDscripts[v.Name] = true
    end
end

local scriptNames = {}

for i, v in pairs(getdescendants(c)) do
    if isa(v, "BasePart") then
        local newName, exists = tostring(i), true
        while exists do
            exists = OLDscripts[newName]
            if exists then
                newName = newName .. "_"    
            end
        end
        table.insert(scriptNames, newName)
        Instance.new("Script", v).Name = newName
    end
end

local hum = c:FindFirstChildOfClass("Humanoid")
if hum then
    for i, v in pairs(hum:GetPlayingAnimationTracks()) do
        v:Stop()
    end
end
c.Archivable = true
local cl = clone(c)
if hum and humState16 then
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    if destroyhum then
        twait(1.6)
    end
end
if destroyhum then
    pcall(destroy, hum)
end

if not c then
    return
end

local head, torso, root = gp(c, "Head", "BasePart"), gp(c, "Torso", "BasePart") or gp(c, "UpperTorso", "BasePart"), gp(c, "HumanoidRootPart", "BasePart")
if hatcollide then
    pcall(destroy, torso)
    pcall(destroy, root)
    pcall(destroy, c:FindFirstChildOfClass("BodyColors") or gp(c, "Health", "Script"))
end

local model = Instance.new("Model", c)
model:GetPropertyChangedSignal("Parent"):Connect(function()
    if not (model and model.Parent) then
        model = nil
    end
end)

for i, v in pairs(getchildren(c)) do
    if v ~= model then
        if addtools and isa(v, "Tool") then
            for i1, v1 in pairs(getdescendants(v)) do
                if v1 and v1.Parent and isa(v1, "BasePart") then
                    local bv = Instance.new("BodyVelocity")
                    bv.Velocity, bv.MaxForce, bv.P, bv.Name = v3_0, v3(1000, 1000, 1000), 1250, "bv_" .. v.Name
                    bv.Parent = v1
                end
            end
        end
        v.Parent = model
    end
end

if breakjoints then
    model:BreakJoints()
else
    if head and torso then
        for i, v in pairs(getdescendants(model)) do
            if isa(v, "JointInstance") then
                local save = false
                if (v.Part0 == torso) and (v.Part1 == head) then
                    save = true
                end
                if (v.Part0 == head) and (v.Part1 == torso) then
                    save = true
                end
                if save then
                    if hedafterneck then
                        hedafterneck = v
                    end
                else
                    pcall(destroy, v)
                end
            end
        end
    end
    if method == 3 then
        task.delay(loadtime, pcall, model.BreakJoints, model)
    end
end

cl.Parent = ws
for i, v in pairs(getchildren(cl)) do
    v.Parent = c
end
pcall(destroy, cl)

local uncollide, noclipcon = nil, nil
if noclipAllParts then
    uncollide = function()
        if c then
            for i, v in pairs(getdescendants(c)) do
                if isa(v, "BasePart") then
                    v.CanCollide = false
                end
            end
        else
            noclipcon:Disconnect()
        end
    end
else
    uncollide = function()
        if model then
            for i, v in pairs(getdescendants(model)) do
                if isa(v, "BasePart") then
                    v.CanCollide = false
                end
            end
        else
            noclipcon:Disconnect()
        end
    end
end
noclipcon = stepped:Connect(uncollide)
uncollide()

for i, scr in pairs(getdescendants(model)) do
    if (scr.ClassName == "Script") and table.find(scriptNames, scr.Name) then
        local Part0 = scr.Parent
        if isa(Part0, "BasePart") then
            for i1, scr1 in pairs(getdescendants(c)) do
                if (scr1.ClassName == "Script") and (scr1.Name == scr.Name) and (not scr1:IsDescendantOf(model)) then
                    local Part1 = scr1.Parent
                    if (Part1.ClassName == Part0.ClassName) and (Part1.Name == Part0.Name) then
                        align(Part0, Part1)
                        pcall(destroy, scr)
                        pcall(destroy, scr1)
                        break
                    end
                end
            end
        end
    end
end

for i, v in pairs(getdescendants(c)) do
    if v and v.Parent and (not v:IsDescendantOf(model)) then
        if isa(v, "Decal") then
            v.Transparency = 1
        elseif isa(v, "BasePart") then
            v.Transparency = 1
            v.Anchored = false
        elseif isa(v, "ForceField") then
            v.Visible = false
        elseif isa(v, "Sound") then
            v.Playing = false
        elseif isa(v, "BillboardGui") or isa(v, "SurfaceGui") or isa(v, "ParticleEmitter") or isa(v, "Fire") or isa(v, "Smoke") or isa(v, "Sparkles") then
            v.Enabled = false
        end
    end
end

if newanimate then
    local animate = gp(c, "Animate", "LocalScript")
    if animate then
        animate.Disabled = false
    end
end

if addtools then
    for i, v in pairs(getchildren(c)) do
        if isa(v, "Tool") then
            v.Parent = addtools
        end
    end
end

local hum0, hum1 = model:FindFirstChildOfClass("Humanoid"), c:FindFirstChildOfClass("Humanoid")
if hum0 then
    hum0:GetPropertyChangedSignal("Parent"):Connect(function()
        if not (hum0 and hum0.Parent) then
            hum0 = nil
        end
    end)
end
if hum1 then
    hum1:GetPropertyChangedSignal("Parent"):Connect(function()
        if not (hum1 and hum1.Parent) then
            hum1 = nil
        end
    end)

    ws.CurrentCamera.CameraSubject = hum1
    local camSubCon = nil
    local function camSubFunc()
        camSubCon:Disconnect()
        if c and hum1 then
            ws.CurrentCamera.CameraSubject = hum1
        end
    end
    camSubCon = renderstepped:Connect(camSubFunc)
    if hum0 then
        hum0:GetPropertyChangedSignal("Jump"):Connect(function()
            if hum1 then
                hum1.Jump = hum0.Jump
            end
        end)
    else
        respawnrequest()
    end
end

local rb = Instance.new("BindableEvent", c)
rb.Event:Connect(function()
    pcall(destroy, rb)
    sg:SetCore("ResetButtonCallback", true)
    if destroyhum then
        if c then c:BreakJoints() end
        return
    end
    if model and hum0 and (hum0.Health > 0) then
        model:BreakJoints()
        hum0.Health = 0
    end
    if antirespawn then
        respawnrequest()
    end
end)
sg:SetCore("ResetButtonCallback", rb)

tdelay(0, function()
    while c do
        if hum0 and hum1 then
            hum1.Jump = hum0.Jump
        end
        wait()
    end
    sg:SetCore("ResetButtonCallback", true)
end)

R15toR6 = R15toR6 and hum1 and (hum1.RigType == Enum.HumanoidRigType.R15)
if R15toR6 then
    local part = gp(c, "HumanoidRootPart", "BasePart") or gp(c, "UpperTorso", "BasePart") or gp(c, "LowerTorso", "BasePart") or gp(c, "Head", "BasePart") or c:FindFirstChildWhichIsA("BasePart")
    if part then
        local cfr = part.CFrame
        local R6parts = { 
            head = {
                Name = "Head",
                Size = v3(2, 1, 1),
                R15 = {
                    Head = 0
                }
            },
            torso = {
                Name = "Torso",
                Size = v3(2, 2, 1),
                R15 = {
                    UpperTorso = 0.2,
                    LowerTorso = -0.8
                }
            },
            root = {
                Name = "HumanoidRootPart",
                Size = v3(2, 2, 1),
                R15 = {
                    HumanoidRootPart = 0
                }
            },
            leftArm = {
                Name = "Left Arm",
                Size = v3(1, 2, 1),
                R15 = {
                    LeftHand = -0.849,
                    LeftLowerArm = -0.174,
                    LeftUpperArm = 0.415
                }
            },
            rightArm = {
                Name = "Right Arm",
                Size = v3(1, 2, 1),
                R15 = {
                    RightHand = -0.849,
                    RightLowerArm = -0.174,
                    RightUpperArm = 0.415
                }
            },
            leftLeg = {
                Name = "Left Leg",
                Size = v3(1, 2, 1),
                R15 = {
                    LeftFoot = -0.85,
                    LeftLowerLeg = -0.29,
                    LeftUpperLeg = 0.49
                }
            },
            rightLeg = {
                Name = "Right Leg",
                Size = v3(1, 2, 1),
                R15 = {
                    RightFoot = -0.85,
                    RightLowerLeg = -0.29,
                    RightUpperLeg = 0.49
                }
            }
        }
        for i, v in pairs(getchildren(c)) do
            if isa(v, "BasePart") then
                for i1, v1 in pairs(getchildren(v)) do
                    if isa(v1, "Motor6D") then
                        v1.Part0 = nil
                    end
                end
            end
        end
        part.Archivable = true
        for i, v in pairs(R6parts) do
            local part = clone(part)
            part:ClearAllChildren()
            part.Name, part.Size, part.CFrame, part.Anchored, part.Transparency, part.CanCollide = v.Name, v.Size, cfr, false, 1, false
            for i1, v1 in pairs(v.R15) do
                local R15part = gp(c, i1, "BasePart")
                local att = gp(R15part, "att1_" .. i1, "Attachment")
                if R15part then
                    local weld = Instance.new("Weld")
                    weld.Part0, weld.Part1, weld.C0, weld.C1, weld.Name = part, R15part, cf(0, v1, 0), cf_0, "Weld_" .. i1
                    weld.Parent = R15part
                    R15part.Massless, R15part.Name = true, "R15_" .. i1
                    R15part.Parent = part
                    if att then
                        att.Position = v3(0, v1, 0)
                        att.Parent = part
                    end
                end
            end
            part.Parent = c
            R6parts[i] = part
        end
        local R6joints = {
            neck = {
                Parent = R6parts.torso,
                Name = "Neck",
                Part0 = R6parts.torso,
                Part1 = R6parts.head,
                C0 = cf(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                C1 = cf(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
            },
            rootJoint = {
                Parent = R6parts.root,
                Name = "RootJoint" ,
                Part0 = R6parts.root,
                Part1 = R6parts.torso,
                C0 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
                C1 = cf(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
            },
            rightShoulder = {
                Parent = R6parts.torso,
                Name = "Right Shoulder",
                Part0 = R6parts.torso,
                Part1 = R6parts.rightArm,
                C0 = cf(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                C1 = cf(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            },
            leftShoulder = {
                Parent = R6parts.torso,
                Name = "Left Shoulder",
                Part0 = R6parts.torso,
                Part1 = R6parts.leftArm,
                C0 = cf(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                C1 = cf(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            },
            rightHip = {
                Parent = R6parts.torso,
                Name = "Right Hip",
                Part0 = R6parts.torso,
                Part1 = R6parts.rightLeg,
                C0 = cf(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
                C1 = cf(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            },
            leftHip = {
                Parent = R6parts.torso,
                Name = "Left Hip" ,
                Part0 = R6parts.torso,
                Part1 = R6parts.leftLeg,
                C0 = cf(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
                C1 = cf(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            }
        }
        for i, v in pairs(R6joints) do
            local joint = Instance.new("Motor6D")
            for prop, val in pairs(v) do
                joint[prop] = val
            end
            R6joints[i] = joint
        end
        if hum1 then
            hum1.RigType, hum1.HipHeight = Enum.HumanoidRigType.R6, 0
        end
    end
end

local torso1 = torso
torso = gp(c, "Torso", "BasePart") or ((not R15toR6) and gp(c, torso.Name, "BasePart"))
if (typeof(hedafterneck) == "Instance") and head and torso and torso1 then
    local conNeck, conTorso, conTorso1 = nil, nil, nil
    local aligns = {}
    local function enableAligns()
        conNeck:Disconnect()
        conTorso:Disconnect()
        conTorso1:Disconnect()
        for i, v in pairs(aligns) do
            v.Enabled = true
        end
    end
    conNeck = hedafterneck.Changed:Connect(function(prop)
        if table.find({"Part0", "Part1", "Parent"}, prop) then
            enableAligns()
        end
    end)
    conTorso = torso:GetPropertyChangedSignal("Parent"):Connect(enableAligns)
    conTorso1 = torso1:GetPropertyChangedSignal("Parent"):Connect(enableAligns)
    for i, v in pairs(getdescendants(head)) do
        if isa(v, "AlignPosition") or isa(v, "AlignOrientation") then
            i = tostring(i)
            aligns[i] = v
            v:GetPropertyChangedSignal("Parent"):Connect(function()
                aligns[i] = nil
            end)
            v.Enabled = false
        end
    end
end

local flingpart0 = gp(model, flingpart, "BasePart") or gp(gp(model, flingpart, "Accessory"), "Handle", "BasePart")
local flingpart1 = gp(c, flingpart, "BasePart") or gp(gp(c, flingpart, "Accessory"), "Handle", "BasePart")

local fling = function() end
if flingpart0 and flingpart1 then
    flingpart0:GetPropertyChangedSignal("Parent"):Connect(function()
        if not (flingpart0 and flingpart0.Parent) then
            flingpart0 = nil
            fling = function() end
        end
    end)
    flingpart0.Archivable = true
    flingpart1:GetPropertyChangedSignal("Parent"):Connect(function()
        if not (flingpart1 and flingpart1.Parent) then
            flingpart1 = nil
            fling = function() end
        end
    end)
    local att0 = gp(flingpart0, "att0_" .. flingpart0.Name, "Attachment")
    local att1 = gp(flingpart1, "att1_" .. flingpart1.Name, "Attachment")
    if att0 and att1 then
        att0:GetPropertyChangedSignal("Parent"):Connect(function()
            if not (att0 and att0.Parent) then
                att0 = nil
                fling = function() end
            end
        end)
        att1:GetPropertyChangedSignal("Parent"):Connect(function()
            if not (att1 and att1.Parent) then
                att1 = nil
                fling = function() end
            end
        end)
        local lastfling = nil
        local mouse = lp:GetMouse()
        fling = function(target, duration, rotVelocity)
            if typeof(target) == "Instance" then
                if isa(target, "BasePart") then
                    target = target.Position
                elseif isa(target, "Model") then
                    target = gp(target, "HumanoidRootPart", "BasePart") or gp(target, "Torso", "BasePart") or gp(target, "UpperTorso", "BasePart") or target:FindFirstChildWhichIsA("BasePart")
                    if target then
                        target = target.Position
                    else
                        return
                    end
                elseif isa(target, "Humanoid") then
                    target = target.Parent
                    if not (target and isa(target, "Model")) then
                        return
                    end
                    target = gp(target, "HumanoidRootPart", "BasePart") or gp(target, "Torso", "BasePart") or gp(target, "UpperTorso", "BasePart") or target:FindFirstChildWhichIsA("BasePart")
                    if target then
                        target = target.Position
                    else
                        return
                    end
                else
                    return
                end
            elseif typeof(target) == "CFrame" then
                target = target.Position
            elseif typeof(target) ~= "Vector3" then
                target = mouse.Hit
                if target then
                    target = target.Position
                else
                    return
                end
            end
            if target.Y < ws.FallenPartsDestroyHeight + 5 then
                target = v3(target.X, ws.FallenPartsDestroyHeight + 5, target.Z)
            end
            lastfling = target
            if type(duration) ~= "number" then
                duration = tonumber(duration) or 0.5
            end
            if typeof(rotVelocity) ~= "Vector3" then
                rotVelocity = v3(20000, 20000, 20000)
            end
            if not (target and flingpart0 and flingpart1 and att0 and att1) then
                return
            end
            flingpart0.Archivable = true
            local flingpart = clone(flingpart0)
            flingpart.Transparency = 1
            flingpart.CanCollide = false
            flingpart.Name = "flingpart_" .. flingpart0.Name
            flingpart.Anchored = true
            flingpart.Velocity = v3_0
            flingpart.RotVelocity = v3_0
            flingpart.Position = target
            flingpart:GetPropertyChangedSignal("Parent"):Connect(function()
                if not (flingpart and flingpart.Parent) then
                    flingpart = nil
                end
            end)
            flingpart.Parent = flingpart1
            if flingpart0.Transparency > 0.5 then
                flingpart0.Transparency = 0.5
            end
            att1.Parent = flingpart
            local con = nil
            local rotchg = v3(0, rotVelocity.Unit.Y * -1000, 0)
            con = heartbeat:Connect(function(delta)
                if target and (lastfling == target) and flingpart and flingpart0 and flingpart1 and att0 and att1 then
                    flingpart.Orientation += rotchg * delta
                    flingpart0.RotVelocity = rotVelocity
                else
                    con:Disconnect()
                end
            end)
            if alignmode ~= 4 then
                local con = nil
                con = renderstepped:Connect(function()
                    if flingpart0 and target then
                        flingpart0.RotVelocity = v3_0
                    else
                        con:Disconnect()
                    end
                end)
            end
            twait(duration)
            if lastfling ~= target then
                if flingpart then
                    if att1 and (att1.Parent == flingpart) then
                        att1.Parent = flingpart1
                    end
                    pcall(destroy, flingpart)
                end
                return
            end
            target = nil
            if not (flingpart and flingpart0 and flingpart1 and att0 and att1) then
                return
            end
            flingpart0.RotVelocity = v3_0
            att1.Parent = flingpart1
            pcall(destroy, flingpart)
        end
    end
end

--lp:GetMouse().Button1Down:Connect(fling) --click fling
wait(0.1)


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