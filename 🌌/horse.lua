if getgenv().b7b09d85e600f432269def391385162e09e8255bd5a2848c15056fa596c7e124 == true then
       local hairAccessoriesWithoutHairInName = {
['MeshPartAccessory'] = true;
['VarietyShades10'] = true;
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

            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character
            local K = Player:GetMouse()
            local L = game.Players.LocalPlayer.Name
            local M = workspace:WaitForChild(L)
            bloop = false
            bloopy = false
            M.MeshPartAccessory.Name = "HorseyEye"
            On = true
            Off = false
            local N = Instance.new("Animation")
            N.AnimationId = "rbxassetid://179224234"
            local O = Player.Character.Humanoid:LoadAnimation(N)
            O:AdjustSpeed(1)
            O:Play()
            game.Players.LocalPlayer.Chatted:connect(
                function(P)
                    if P == "Eyes" then
                        game.workspace.Horse:WaitForChild("Head").Attachment69.Position = Vector3.new(0, 1, 0.575)
                        game.workspace.Horse:WaitForChild("Head").Attachment420.Position = Vector3.new(0, 1, -0.575)
                    end
                    if P == "Joust" then
                        game.Players.LocalPlayer.Character = M
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Backpack.Foil.Parent = Character
                        local Q = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        Q.Grip = Q.Grip * CFrame.fromEulerAnglesXYZ(math.rad(90), 0, 0)
                        Q.Parent = game.Players.LocalPlayer.Backpack
                        Q.Parent = game.Players.LocalPlayer.Character
                        wait(0.1)
                        game.Players.LocalPlayer.Character = game.workspace.Horse
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                    end
                    if P == "Away" then
                        game.Players.LocalPlayer.Character = M
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                        local Q = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                        Q.Grip = Q.Grip * CFrame.fromEulerAnglesXYZ(math.rad(-90), 0, 0)
                        Q.Parent = game.Players.LocalPlayer.Backpack
                        Q.Parent = game.Players.LocalPlayer.Character
                        game.Players.LocalPlayer.Character.Foil.Parent = game.Players.LocalPlayer.Backpack
                        wait(0.1)
                        game.Players.LocalPlayer.Character = game.workspace.Horse
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                    end
                    if P == "No Eyes" then
                        game.workspace.Horse:WaitForChild("Head").Attachment69.Position = Vector3.new(0, 0, 0)
                        game.workspace.Horse:WaitForChild("Head").Attachment420.Position = Vector3.new(0, 0, 0)
                    end
                    if P == "Wander" then
                        bloopy = false
                        game.Players.LocalPlayer.Character = game.workspace.Horse
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                    end
                    if P == "Back" then
                        bloopy = true
                        game.Players.LocalPlayer.Character = M
                        game.workspace.Camera.CameraSubject = M.Humanoid
                        wait(0.1)
                        game.Players.LocalPlayer.Character = M
                        game.workspace.Camera.CameraSubject = M.Humanoid
                        wait(0.1)
                        game.Players.LocalPlayer.Character = M
                        game.workspace.Camera.CameraSubject = M.Humanoid
                    end
                    if P == "Off" then
                        bloop = true
                        bloopy = true
                        On = false
                        M.Humanoid.HipHeight = 0
                        game.Players.LocalPlayer.Character = M
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                        O:Stop()
                    end
                    if P == "On" then
                        game.Players.LocalPlayer.Character = M
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                        bloop = false
                        bloopy = false
                        On = true
                        M.Humanoid.HipHeight = 1.5
                        O:Play()
                        wait(0.1)
                        game.Players.LocalPlayer.Character = game.workspace.Horse
                        game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                        coroutine.resume(
                            coroutine.create(
                                function()
                                    while On do
                                        game:GetService("RunService").Heartbeat:wait()
                                        M.HumanoidRootPart.CFrame =
                                            game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                                        M.HumanoidRootPart.CFrame =
                                            game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                                        M.HumanoidRootPart.CFrame =
                                            game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                                        M.HumanoidRootPart.CFrame =
                                            game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                                        M.HumanoidRootPart.CFrame =
                                            game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                                    end
                                end
                            )
                        )
                    end
                end
            )
            local R = {
                horsebody = Character:WaitForChild("Bang w bun"),
                horseneck = Character:WaitForChild("Kate Hair"),
                horserightleg = Character:WaitForChild("Pal Hair"),
                horseleftleg = Character:WaitForChild("Pink Hair"),
                horserightarm = Character:WaitForChild("LavanderHair"),
                horseleftarm = Character:WaitForChild("Hat1"),
                horsetail = Character:WaitForChild("Vets Day Cap"),
                horsehead = Character:WaitForChild("Robloxclassicred")
            }
            local S = {
                horseeye = Character:WaitForChild("HorseyEye"),
                horseeye2 = Character:WaitForChild("MeshPartAccessory")
            }
            for T, v in next, R do
                v.Handle.AccessoryWeld:Remove()
                for U, V in next, v:GetDescendants() do
                    if V:IsA("Mesh") or V:IsA("SpecialMesh") then
                        V:Remove()
                    end
                end
            end
            for T, v in next, S do
                v.Handle.AccessoryWeld:Remove()
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
            Model0 = Instance.new("Model")
            UnionOperation1 = Instance.new("UnionOperation")
            UnionOperation2 = Instance.new("UnionOperation")
            UnionOperation3 = Instance.new("UnionOperation")
            Motor6D4 = Instance.new("Motor6D")
            Motor6D5 = Instance.new("Motor6D")
            UnionOperation6 = Instance.new("UnionOperation")
            UnionOperation7 = Instance.new("UnionOperation")
            UnionOperation8 = Instance.new("UnionOperation")
            UnionOperation9 = Instance.new("UnionOperation")
            Motor6D10 = Instance.new("Motor6D")
            UnionOperation11 = Instance.new("UnionOperation")
            UnionOperation12 = Instance.new("UnionOperation")
            Motor6D13 = Instance.new("Motor6D")
            Motor6D14 = Instance.new("Motor6D")
            Motor6D15 = Instance.new("Motor6D")
            Motor6D16 = Instance.new("Motor6D")
            Motor6D17 = Instance.new("Motor6D")
            Motor6D18 = Instance.new("Motor6D")
            Motor6D19 = Instance.new("Motor6D")
            UnionOperation20 = Instance.new("UnionOperation")
            UnionOperation21 = Instance.new("UnionOperation")
            Motor6D22 = Instance.new("Motor6D")
            UnionOperation23 = Instance.new("UnionOperation")
            Motor6D24 = Instance.new("Motor6D")
            Seat25 = Instance.new("Seat")
            Humanoid26 = Instance.new("Humanoid")
            Folder27 = Instance.new("Folder")
            Animation28 = Instance.new("Animation")
            Animation29 = Instance.new("Animation")
            Animation30 = Instance.new("Animation")
            Animation31 = Instance.new("Animation")
            Folder32 = Instance.new("Folder")
            Script33 = Instance.new("Script")
            Script34 = Instance.new("Script")
            LocalScript35 = Instance.new("LocalScript")
            ObjectValue36 = Instance.new("ObjectValue")
            ScreenGui37 = Instance.new("ScreenGui")
            TextLabel38 = Instance.new("TextLabel")
            Model0.Name = "Horse"
            Model0.Parent = mas
            UnionOperation1.Name = "Bridle"
            UnionOperation1.Parent = Model0
            UnionOperation1.CFrame =
                CFrame.new(
                -49.9946136,
                5.63413048,
                18.9536285,
                5.81264548e-09,
                4.23944257e-09,
                1,
                0.999998152,
                2.23517418e-07,
                -5.81264015e-09,
                -2.23517418e-07,
                0.999998152,
                -4.23950297e-09
            )
            UnionOperation1.Orientation = Vector3.new(0, 90, 90)
            UnionOperation1.Position = Character.Torso.Position
            UnionOperation1.Rotation = Vector3.new(90, 90, 0)
            UnionOperation1.Color = Color3.new(0.105882, 0.164706, 0.207843)
            UnionOperation1.Size = Vector3.new(1.41772509, 1.52062428, 1.1000247)
            UnionOperation1.BrickColor = BrickColor.new("Black")
            UnionOperation1.CanCollide = false
            UnionOperation1.brickColor = BrickColor.new("Black")
            UnionOperation2.Name = "Ears"
            UnionOperation2.Parent = Model0
            UnionOperation2.CFrame =
                CFrame.new(
                -49.9946136,
                5.98617172,
                19.539629,
                -5.19995531e-08,
                2.70967213e-08,
                1,
                0.965924025,
                0.258818507,
                4.32144844e-08,
                -0.258818507,
                0.965924025,
                -3.96318924e-08
            )
            UnionOperation2.Orientation = Vector3.new(0, 90, 75)
            UnionOperation2.Position = Character.Torso.Position
            UnionOperation2.Rotation = Vector3.new(75, 90, 0)
            UnionOperation2.Color = Color3.new(0.105882, 0.164706, 0.207843)
            UnionOperation2.Size = Vector3.new(1.40000141, 1.19999993, 1)
            UnionOperation2.BrickColor = BrickColor.new("Black")
            UnionOperation2.CanCollide = false
            UnionOperation2.brickColor = BrickColor.new("Black")
            UnionOperation3.Name = "Head"
            UnionOperation3.Parent = Model0
            UnionOperation3.CFrame =
                CFrame.new(
                -49.9946136,
                5.61092854,
                18.9154816,
                3.96033739e-09,
                9.83023352e-09,
                1,
                0.965924799,
                0.258819014,
                -6.36964037e-09,
                -0.258819014,
                0.965924799,
                -8.47027959e-09
            )
            UnionOperation3.Orientation = Vector3.new(0, 90, 75)
            UnionOperation3.Position = Character.Torso.Position
            UnionOperation3.Rotation = Vector3.new(75, 90, 0)
            UnionOperation3.Color = Color3.new(0.486275, 0.360784, 0.27451)
            UnionOperation3.Size = Vector3.new(1.0018127, 2.39992595, 1.00000024)
            UnionOperation3.BrickColor = BrickColor.new("Brown")
            UnionOperation3.brickColor = BrickColor.new("Brown")
            Motor6D4.Name = "Bridle Joint"
            Motor6D4.Parent = UnionOperation3
            Motor6D4.C0 = CFrame.new(0, 0.400000006, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D4.C1 =
                CFrame.new(
                0.080325596,
                0.34822306,
                1.69231318e-09,
                0.965925038,
                0.258818835,
                -5.56992563e-10,
                -0.258818835,
                0.965925038,
                -4.23081659e-09,
                -5.56986124e-10,
                4.23078284e-09,
                1
            )
            Motor6D4.Part0 = UnionOperation3
            Motor6D4.Part1 = UnionOperation1
            Motor6D4.part1 = UnionOperation1
            Motor6D5.Name = "Ear Joint"
            Motor6D5.Parent = UnionOperation3
            Motor6D5.C0 = CFrame.new(0, 0.800000012, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D5.C1 =
                CFrame.new(
                -0.200916082,
                0.0999985337,
                -1.38131968e-08,
                0.999999106,
                2.68220901e-07,
                -5.59598909e-08,
                -2.68220901e-07,
                0.999999106,
                1.72664976e-08,
                5.59598661e-08,
                -1.72664958e-08,
                1
            )
            Motor6D5.Part0 = UnionOperation3
            Motor6D5.Part1 = UnionOperation2
            Motor6D5.part1 = UnionOperation2
            UnionOperation6.Name = "Tail"
            UnionOperation6.Parent = Model0
            UnionOperation6.CFrame = CFrame.new(-49.9946136, 2.63727212, 24.0214939, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation6.Position = Character.Torso.Position
            UnionOperation6.Color = Color3.new(0.486275, 0.360784, 0.27451)
            UnionOperation6.Size = Vector3.new(0.600000203, 3.14548206, 1.8539381)
            UnionOperation6.BrickColor = BrickColor.new("Brown")
            UnionOperation6.CanCollide = false
            UnionOperation6.brickColor = BrickColor.new("Brown")
            UnionOperation7.Name = "Right Arm"
            UnionOperation7.Parent = Model0
            UnionOperation7.CFrame = CFrame.new(-49.1821136, 1.71001315, 20.594492, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation7.Position = Character.Torso.Position
            UnionOperation7.Color = Color3.new(0.105882, 0.164706, 0.207843)
            UnionOperation7.Size = Vector3.new(1.02501225, 3.40000153, 1)
            UnionOperation7.BrickColor = BrickColor.new("Black")
            UnionOperation7.CanCollide = false
            UnionOperation7.brickColor = BrickColor.new("Black")
            UnionOperation8.Name = "Right Leg"
            UnionOperation8.Parent = Model0
            UnionOperation8.CFrame = CFrame.new(-49.2771149, 1.81001318, 23.3945408, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation8.Position = Character.Torso.Position
            UnionOperation8.Color = Color3.new(0.486275, 0.360784, 0.27451)
            UnionOperation8.Size = Vector3.new(1.21500862, 3.60000014, 1)
            UnionOperation8.BrickColor = BrickColor.new("Brown")
            UnionOperation8.CanCollide = false
            UnionOperation8.brickColor = BrickColor.new("Brown")
            UnionOperation9.Name = "Torso"
            UnionOperation9.Parent = Model0
            UnionOperation9.CFrame =
                CFrame.new(
                -49.9946136,
                4.38101387,
                20.2431183,
                0,
                0,
                1,
                0.258818954,
                -0.965925574,
                0,
                0.965925574,
                0.258818954,
                0
            )
            UnionOperation9.Orientation = Vector3.new(0, 90, 165)
            UnionOperation9.Position = Character.Torso.Position
            UnionOperation9.Rotation = Vector3.new(165, 90, 0)
            UnionOperation9.Color = Color3.new(0.486275, 0.360784, 0.27451)
            UnionOperation9.Size = Vector3.new(1.82508302, 3.42743158, 1.00000012)
            UnionOperation9.BrickColor = BrickColor.new("Brown")
            UnionOperation9.brickColor = BrickColor.new("Brown")
            Motor6D10.Name = "Neck"
            Motor6D10.Parent = UnionOperation9
            Motor6D10.C0 = CFrame.new(-0.300000012, -1.20000005, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D10.C1 =
                CFrame.new(
                -0.331624597,
                0.664073646,
                -1.80332327e-09,
                -2.38418579e-07,
                -0.999999285,
                3.96033739e-09,
                0.999999285,
                -2.38418579e-07,
                9.83023352e-09,
                -9.83024862e-09,
                3.96033162e-09,
                1
            )
            Motor6D10.Part0 = UnionOperation9
            Motor6D10.Part1 = UnionOperation3
            Motor6D10.part1 = UnionOperation3
            UnionOperation11.Name = "Left Leg"
            UnionOperation11.Parent = Model0
            UnionOperation11.CFrame = CFrame.new(-50.7121429, 1.81001318, 23.3945408, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation11.Position = Character.Torso.Position
            UnionOperation11.Color = Color3.new(0.486275, 0.360784, 0.27451)
            UnionOperation11.Size = Vector3.new(1.21491718, 3.60000014, 1)
            UnionOperation11.BrickColor = BrickColor.new("Brown")
            UnionOperation11.CanCollide = false
            UnionOperation11.brickColor = BrickColor.new("Brown")
            UnionOperation12.Name = "Body"
            UnionOperation12.Parent = Model0
            UnionOperation12.CFrame = CFrame.new(-49.9946136, 3.11006212, 21.9945164, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation12.Position = Character.Torso.Position
            UnionOperation12.Color = Color3.new(0.486275, 0.360784, 0.27451)
            UnionOperation12.Size = Vector3.new(2.20000029, 2.20009971, 4.60001278)
            UnionOperation12.BrickColor = BrickColor.new("Brown")
            UnionOperation12.brickColor = BrickColor.new("Brown")
            Motor6D13.Name = "Upper Spine"
            Motor6D13.Parent = UnionOperation12
            Motor6D13.C0 = CFrame.new(0, 0, -1.39999998, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D13.C1 =
                CFrame.new(
                0.0104781389,
                1.3185941,
                0,
                0,
                0.258818954,
                0.965925574,
                0,
                -0.965925574,
                0.258818954,
                1,
                0,
                0
            )
            Motor6D13.Part0 = UnionOperation12
            Motor6D13.Part1 = UnionOperation9
            Motor6D13.part1 = UnionOperation9
            Motor6D14.Name = "Lower Spine"
            Motor6D14.Parent = UnionOperation12
            Motor6D14.C0 = CFrame.new(0, 0.900000036, 1.5999999, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D14.C1 = CFrame.new(0, 1.37278998, -0.426977575, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D14.Part0 = UnionOperation12
            Motor6D14.Part1 = UnionOperation6
            Motor6D14.part1 = UnionOperation6
            Motor6D15.Name = "Saddle Joint"
            Motor6D15.Parent = UnionOperation12
            Motor6D15.C1 = CFrame.new(0, -0.364952087, -0.141479492, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D15.Part0 = UnionOperation12
            Motor6D15.Part1 = UnionOperation23
            Motor6D15.part1 = UnionOperation23
            Motor6D16.Name = "Right Hip"
            Motor6D16.Parent = UnionOperation12
            Motor6D16.C0 = CFrame.new(0.800000012, 0, 1.39999998, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D16.C1 = CFrame.new(0.0825012326, 1.30004895, -2.44379044e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D16.Part0 = UnionOperation12
            Motor6D16.Part1 = UnionOperation8
            Motor6D16.part1 = UnionOperation8
            Motor6D17.Name = "Left Hip"
            Motor6D17.Parent = UnionOperation12
            Motor6D17.C0 = CFrame.new(-0.800000012, 0, 1.39999998, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D17.C1 = CFrame.new(-0.082470715, 1.30004895, -2.44379044e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D17.Part0 = UnionOperation12
            Motor6D17.Part1 = UnionOperation11
            Motor6D17.part1 = UnionOperation11
            Motor6D18.Name = "Left Shoulder"
            Motor6D18.Parent = UnionOperation12
            Motor6D18.C0 = CFrame.new(-0.800000012, 0, -1.39999998, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D18.C1 = CFrame.new(0.0124999881, 1.40004897, 2.44379044e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D18.Part0 = UnionOperation12
            Motor6D18.Part1 = UnionOperation20
            Motor6D18.part1 = UnionOperation20
            Motor6D19.Name = "Right Shoulder"
            Motor6D19.Parent = UnionOperation12
            Motor6D19.C0 = CFrame.new(0.800000012, 0, -1.39999998, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D19.C1 = CFrame.new(-0.0124999881, 1.40004897, 2.44379044e-05, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D19.Part0 = UnionOperation12
            Motor6D19.Part1 = UnionOperation7
            Motor6D19.part1 = UnionOperation7
            UnionOperation20.Name = "Left Arm"
            UnionOperation20.Parent = Model0
            UnionOperation20.CFrame = CFrame.new(-50.8071136, 1.71001315, 20.594492, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation20.Position = Character.Torso.Position
            UnionOperation20.Color = Color3.new(0.105882, 0.164706, 0.207843)
            UnionOperation20.Size = Vector3.new(1.02501237, 3.40000153, 1.00000012)
            UnionOperation20.BrickColor = BrickColor.new("Black")
            UnionOperation20.CanCollide = false
            UnionOperation20.brickColor = BrickColor.new("Black")
            UnionOperation21.Name = "HumanoidRootPart"
            UnionOperation21.Parent = Model0
            UnionOperation21.CFrame = CFrame.new(-49.9946136, 4.71006203, 21.9945164, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation21.Position = Character.Torso.Position
            UnionOperation21.Color = Color3.new(0.486275, 0.360784, 0.27451)
            UnionOperation21.Transparency = 1
            UnionOperation21.Size = Vector3.new(2.20000029, 2.20009971, 4.60001278)
            UnionOperation21.BrickColor = BrickColor.new("Brown")
            UnionOperation21.CanCollide = false
            UnionOperation21.brickColor = BrickColor.new("Brown")
            Motor6D22.Name = "Root Joint"
            Motor6D22.Parent = UnionOperation21
            Motor6D22.C0 = CFrame.new(0, -1.60000002, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D22.Part0 = UnionOperation21
            Motor6D22.Part1 = UnionOperation12
            Motor6D22.part1 = UnionOperation12
            UnionOperation23.Name = "Saddle"
            UnionOperation23.Parent = Model0
            UnionOperation23.CFrame = CFrame.new(-49.9946136, 3.47501421, 22.1359959, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            UnionOperation23.Position = Character.Torso.Position
            UnionOperation23.Color = Color3.new(0.423529, 0.345098, 0.294118)
            UnionOperation23.Size = Vector3.new(2.04000044, 2.67000055, 2.08303714)
            UnionOperation23.BrickColor = BrickColor.new("Pine Cone")
            UnionOperation23.CanCollide = false
            UnionOperation23.brickColor = BrickColor.new("Pine Cone")
            Motor6D24.Name = "Saddle Joint"
            Motor6D24.Parent = UnionOperation23
            Motor6D24.C0 = CFrame.new(0, 0.400000006, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D24.C1 = CFrame.new(-7.62939453e-06, -0.199998945, 0.000480651855, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Motor6D24.Part0 = UnionOperation23
            Motor6D24.Part1 = Seat25
            Motor6D24.part1 = Seat25
            Seat25.Parent = Model0
            Seat25.CFrame = CFrame.new(-49.994606, 4.07501316, 22.1355152, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            Seat25.Position = Character.Torso.Position
            Seat25.Color = Color3.new(0.105882, 0.164706, 0.207843)
            Seat25.Transparency = 1
            Seat25.Size = Vector3.new(1.20000005, 0.200000003, 2)
            Seat25.BottomSurface = Enum.SurfaceType.Smooth
            Seat25.BrickColor = BrickColor.new("Black")
            Seat25.CanCollide = false
            Seat25.TopSurface = Enum.SurfaceType.Smooth
            Seat25.brickColor = BrickColor.new("Black")
            Seat25.FormFactor = Enum.FormFactor.Custom
            Seat25.formFactor = Enum.FormFactor.Custom
            Humanoid26.Parent = Model0
            Humanoid26.LeftLeg = UnionOperation11
            Humanoid26.NameOcclusion = Enum.NameOcclusion.NoOcclusion
            Humanoid26.RightLeg = UnionOperation8
            Humanoid26.Torso = UnionOperation21
            Humanoid26.WalkSpeed = 20
            Folder27.Name = "Animations"
            Folder27.Parent = Model0
            Animation28.Name = "Walk"
            Animation28.Parent = Folder27
            Animation28.AnimationId = "rbxassetid://289443727"
            Animation29.Name = "Ride"
            Animation29.Parent = Folder27
            Animation29.AnimationId = "rbxassetid://289454972"
            Animation30.Name = "Jump"
            Animation30.Parent = Folder27
            Animation30.AnimationId = "rbxassetid://289877829"
            Animation31.Name = "Fall"
            Animation31.Parent = Folder27
            Animation31.AnimationId = "rbxassetid://289878116"
            Folder32.Name = "Scripts"
            Folder32.Parent = Model0
            Script33.Name = "AnimateScript"
            Script33.Parent = Folder32
            table.insert(
                cors,
                sandbox(
                    Script33,
                    function()
                        local a7 = script.Parent.Parent
                        local a8 = a7:WaitForChild("Humanoid")
                        local a9 = {}
                        for T, aa in pairs(a7:WaitForChild("Animations"):GetChildren()) do
                            a9[aa.Name] = a8:LoadAnimation(aa)
                        end
                        local ab = "None"
                        local function ac()
                            local ray =
                                Ray.new(a7.HumanoidRootPart.Position + Vector3.new(0, -4.3, 0), Vector3.new(0, -1, 0))
                            local hit, ad = game.Workspace:FindPartOnRay(ray, a7)
                            if hit and hit.CanCollide then
                                return true
                            else
                                return false
                            end
                        end
                        local function ae()
                            for T, aa in pairs(a9) do
                                aa:Stop()
                            end
                        end
                        local function af(ag)
                            if ab ~= ag then
                                ae()
                                ab = ag
                                if a9[ab] then
                                    a9[ab]:Play()
                                end
                            end
                        end
                        while true do
                            game:GetService("RunService").Stepped:wait()
                            if a8.Health > 0 then
                                if ac() then
                                    local speed =
                                        Vector3.new(a7.HumanoidRootPart.Velocity.X, 0, a7.HumanoidRootPart.Velocity.Z).magnitude
                                    if speed > 1 then
                                        af("Walk")
                                    else
                                        af("Idle")
                                    end
                                else
                                    local ah = a7.HumanoidRootPart.Velocity.Y
                                    if ah > 0 then
                                        af("Jump")
                                    else
                                        af("Fall")
                                    end
                                end
                            else
                                af("Dead")
                            end
                        end
                    end
                )
            )
            Script34.Name = "ControlScript"
            Script34.Parent = Folder32
            table.insert(
                cors,
                sandbox(
                    Script34,
                    function()
                        local a7 = script.Parent.Parent
                        local a8 = a7:WaitForChild("Humanoid")
                        local seat = a7:WaitForChild("Seat")
                        local ai = seat.Occupant
                        script.Parent.Parent.Seat.Changed:connect(
                            function(aj)
                                if seat.Occupant ~= ai then
                                    ai = seat.Occupant
                                    if ai then
                                        local player = game.Players:GetPlayerFromCharacter(ai.Parent)
                                        if player then
                                            local ak = script.LocalControlScript:Clone()
                                            ak.Horse.Value = a7
                                            ak.Parent = player.PlayerGui
                                            ak.Disabled = false
                                        end
                                    end
                                end
                            end
                        )
                    end
                )
            )
            LocalScript35.Name = "LocalControlScript"
            LocalScript35.Parent = Script34
            table.insert(
                cors,
                sandbox(
                    LocalScript35,
                    function()
                        local al = game:GetService("UserInputService")
                        local player = game.Players.LocalPlayer
                        local a7 = player.Character
                        local a8 = a7.Humanoid
                        local am = script:WaitForChild("Horse").Value
                        local an = script:WaitForChild("HorseGui")
                        an.Parent = player.PlayerGui
                        a8:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                        local ao = a8:LoadAnimation(am.Animations.Ride)
                        ao:Play()
                        local ap = Vector3.new(0, 0, 0)
                        al.InputBegan:connect(
                            function(aq, ar)
                                if not ar then
                                    if aq.KeyCode == Enum.KeyCode.W or aq.KeyCode == Enum.KeyCode.Up then
                                        ap = Vector3.new(ap.X, ap.Y, -1)
                                    elseif aq.KeyCode == Enum.KeyCode.S or aq.KeyCode == Enum.KeyCode.Down then
                                        ap = Vector3.new(ap.X, ap.Y, 1)
                                    elseif aq.KeyCode == Enum.KeyCode.A or aq.KeyCode == Enum.KeyCode.Left then
                                        ap = Vector3.new(-1, ap.Y, ap.Z)
                                    elseif aq.KeyCode == Enum.KeyCode.D or aq.KeyCode == Enum.KeyCode.Right then
                                        ap = Vector3.new(1, ap.Y, ap.Z)
                                    elseif aq.KeyCode == Enum.KeyCode.Space then
                                        local ray =
                                            Ray.new(
                                            am.HumanoidRootPart.Position + Vector3.new(0, -4.3, 0),
                                            Vector3.new(0, -1, 0)
                                        )
                                        local hit, ad = game.Workspace:FindPartOnRay(ray, am)
                                        if hit and hit.CanCollide then
                                            am.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                                        end
                                    elseif aq.KeyCode == Enum.KeyCode.LeftShift then
                                        a8:ChangeState(Enum.HumanoidStateType.Jumping)
                                    end
                                end
                            end
                        )
                        al.InputEnded:connect(
                            function(aq, ar)
                                if not ar then
                                    if aq.KeyCode == Enum.KeyCode.W or aq.KeyCode == Enum.KeyCode.Up then
                                        if ap.Z < 0 then
                                            ap = Vector3.new(ap.X, ap.Y, 0)
                                        end
                                    elseif aq.KeyCode == Enum.KeyCode.S or aq.KeyCode == Enum.KeyCode.Down then
                                        if ap.Z > 0 then
                                            ap = Vector3.new(ap.X, ap.Y, 0)
                                        end
                                    elseif aq.KeyCode == Enum.KeyCode.A or aq.KeyCode == Enum.KeyCode.Left then
                                        if ap.X < 0 then
                                            ap = Vector3.new(0, ap.Y, ap.Z)
                                        end
                                    elseif aq.KeyCode == Enum.KeyCode.D or aq.KeyCode == Enum.KeyCode.Right then
                                        if ap.X > 0 then
                                            ap = Vector3.new(0, ap.Y, ap.Z)
                                        end
                                    end
                                end
                            end
                        )
                        spawn(
                            function()
                                while am.Seat.Occupant == a8 do
                                    game:GetService("RunService").RenderStepped:wait()
                                    am.Humanoid:Move(ap, true)
                                end
                                an:Destroy()
                                a8:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                                am.Humanoid:Move(Vector3.new())
                                ao:Stop()
                                script:Destroy()
                            end
                        )
                    end
                )
            )
            LocalScript35.Disabled = true
            ObjectValue36.Name = "Horse"
            ObjectValue36.Parent = LocalScript35
            ScreenGui37.Name = "HorseGui"
            ScreenGui37.Parent = LocalScript35
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
            W(R.horsebody.Handle, game.workspace.Horse.Body)
            W(R.horsehead.Handle, game.workspace.Horse.Head)
            W(S.horseeye.Handle, game.workspace.Horse.Head)
            W(S.horseeye2.Handle, game.workspace.Horse.Head)
            W(R.horseneck.Handle, game.workspace.Horse.Torso)
            W(R.horserightarm.Handle, game.workspace.Horse["Right Arm"])
            W(R.horseleftarm.Handle, game.workspace.Horse["Left Arm"])
            W(R.horserightleg.Handle, game.workspace.Horse["Right Leg"])
            W(R.horseleftleg.Handle, game.workspace.Horse["Left Leg"])
            W(R.horsetail.Handle, game.workspace.Horse.Tail)
            R.horsebody.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            R.horsehead.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            S.horseeye.Handle.Attachment.Rotation = Vector3.new(0, 180, 0)
            S.horseeye2.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)
            R.horseneck.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            R.horserightarm.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            R.horseleftarm.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            R.horserightleg.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            R.horseleftleg.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            R.horsetail.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
            game.workspace.Horse:WaitForChild("Right Arm"):FindFirstChild("Attachment").Name = "Attachment1"
            game.workspace.Horse:WaitForChild("Left Arm"):FindFirstChild("Attachment").Name = "Attachment2"
            game.workspace.Horse:WaitForChild("Right Leg"):FindFirstChild("Attachment").Name = "Attachment1"
            game.workspace.Horse:WaitForChild("Left Leg"):FindFirstChild("Attachment").Name = "Attachment2"
            game.workspace.Horse:WaitForChild("Head"):FindFirstChild("Attachment").Name = "Attachment2"
            game.workspace.Horse:WaitForChild("Head"):FindFirstChild("Attachment").Name = "Attachment69"
            game.workspace.Horse:WaitForChild("Head"):FindFirstChild("Attachment").Name = "Attachment420"
            game.workspace.Horse:WaitForChild("Body"):FindFirstChild("Attachment").Name = "Attachment2"
            game.workspace.Horse:WaitForChild("Right Arm").Attachment1.Position = Vector3.new(0, -0.7, 0)
            game.workspace.Horse:WaitForChild("Left Arm").Attachment2.Position = Vector3.new(0, -0.7, 0)
            game.workspace.Horse:WaitForChild("Right Leg").Attachment1.Position = Vector3.new(0, -0.8, 0)
            game.workspace.Horse:WaitForChild("Left Leg").Attachment2.Position = Vector3.new(0, -0.8, 0)
            game.workspace.Horse:WaitForChild("Head").Attachment2.Position = Vector3.new(-0.1, 0.465, 0)
            game.workspace.Horse:WaitForChild("Head").Attachment69.Position = Vector3.new(0, 1, 0.575)
            game.workspace.Horse:WaitForChild("Head").Attachment420.Position = Vector3.new(0, 1, -0.575)
            game.workspace.Horse:WaitForChild("Body").Attachment2.Position = Vector3.new(0, -0.1, 0)
            coroutine.resume(
                coroutine.create(
                    function()
                        while On do
                            game:GetService("RunService").Heartbeat:wait()
                            M.HumanoidRootPart.CFrame = game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                            M.HumanoidRootPart.CFrame = game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                            M.HumanoidRootPart.CFrame = game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                            M.HumanoidRootPart.CFrame = game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                            M.HumanoidRootPart.CFrame = game.workspace.Horse.Body.CFrame + Vector3.new(0, 2, 0)
                        end
                    end
                )
            )
            function dieded()
                game.workspace.Horse:Remove()
                game.Players.LocalPlayer.Character = M
                game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
                Character:Remove()
            end
            M.Humanoid.Died:Connect(dieded)
            game.workspace.Horse.Humanoid.Died:Connect(dieded)
            game.Players.LocalPlayer.Character = game.workspace.Horse
            game.workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
            Model0.Name = "Horse"
            M.Humanoid.HipHeight = 1.5
            game.workspace.Horse.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            game.workspace.Horse.Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
            game["Run Service"].Stepped:connect(
                function()
                    M.Torso.CanCollide = bloop
                    M.Head.CanCollide = bloop
                    game.workspace.Horse.Body.CanCollide = bloopy
                    game.workspace.Horse.Torso.CanCollide = bloopy
                    game.workspace.Horse.Head.CanCollide = bloopy
                end
            )
        end