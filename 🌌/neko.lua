if getgenv().b7b09d85e600f432269def391385162e09e8255bd5a2848c15056fa596c7e124 == true then
       local hairAccessoriesWithoutHairInName = {
['FluffyEarringsAccessory'] = true;
['EmotimaskCute'] = true;
['FluffyEars'] = true;
['Red Beak'] = true;
['LooseSideBuns'] = true;
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
            local L = game.Players.LocalPlayer.Name
            local M = workspace:WaitForChild(L)
            local R = {
                tiddie = Character:WaitForChild("Memorial Day 2009 Army Helmet"),
                othertiddie = Character:WaitForChild("Racing Helmet Flames"),
                behindzatiddie = Character:WaitForChild("Racing Helmet"),
                behindzaothertiddie = Character:WaitForChild("Racing Helmet USA"),
                vaggie = Character:WaitForChild("Stinger77")
            }
            local S = {
                nipples = Character:WaitForChild("FluffyEarringsAccessory"),
                lips = Character:WaitForChild("Red Beak")
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
                Z.Responsiveness = 200
                local _ = Instance.new("AlignOrientation", T)
                _.Attachment0 = X
                _.Attachment1 = Y
                _.ReactionTorqueEnabled = true
                _.PrimaryAxisOnly = false
                _.MaxTorque = 9999999
                _.MaxAngularVelocity = math.huge
                _.Responsiveness = 200
            end
            Players = game:GetService("Players")
            LocalPlayer = Players.LocalPlayer
            Char = LocalPlayer.Character
            Char.Archivable = true
            FakeChar = Char:Clone()
            FakeChar.Parent = workspace
            workspace.CurrentCamera.CameraSubject = FakeChar.Humanoid
            for T, v in pairs(FakeChar:GetDescendants()) do
                if v:IsA("Part") then
                    v.Transparency = 1
                end
                if v:IsA("SpecialMesh") then
                    v.MeshId = "rbxassetid://0"
                end
            end
            game:GetService("RunService").Stepped:Connect(
                function()
                    pcall(
                        function()
                            FakeChar:FindFirstChild("Head").CanCollide = false
                            FakeChar:FindFirstChild("Torso").CanCollide = false
                            Char.Head.CanCollide = false
                            Char.Torso.CanCollide = false
                        end
                    )
                end
            )
            game:GetService("RunService").RenderStepped:Connect(
                function()
                    pcall(
                        function()
                            FakeChar:FindFirstChild("Head").CanCollide = false
                            FakeChar:FindFirstChild("Torso").CanCollide = false
                            Char.Head.CanCollide = false
                            Char.Torso.CanCollide = false
                        end
                    )
                end
            )
            game:GetService("RunService").Heartbeat:Connect(
                function()
                    pcall(
                        function()
                            FakeChar:FindFirstChild("Head").CanCollide = false
                            FakeChar:FindFirstChild("Torso").CanCollide = false
                            Char.Head.CanCollide = false
                            Char.Torso.CanCollide = false
                        end
                    )
                end
            )
            function died()
                LocalPlayer.Character = Char
                FakeChar:Destroy()
                Char:BreakJoints()
            end
            function Align(aA, Part0, i, k8)
                local k9 = Instance.new("AlignPosition", aA)
                k9.Parent.CanCollide = false
                k9.ApplyAtCenterOfMass = true
                k9.MaxForce = 67752
                k9.MaxVelocity = math.huge / 9e110
                k9.ReactionForceEnabled = false
                k9.Responsiveness = math.huge
                k9.RigidityEnabled = false
                local ka = Instance.new("AlignOrientation", aA)
                ka.MaxAngularVelocity = math.huge / 9e110
                ka.MaxTorque = 67752
                ka.PrimaryAxisOnly = false
                ka.ReactionTorqueEnabled = false
                ka.Responsiveness = math.huge
                ka.RigidityEnabled = false
                local kb = Instance.new("Attachment", aA)
                local kc = Instance.new("Attachment", Part0)
                kc.Orientation = k8
                kc.Position = i
                k9.Attachment0 = kb
                k9.Attachment1 = kc
                ka.Attachment0 = kb
                ka.Attachment1 = kc
            end
            function LoadLibrary(a)
                return loadstring(game:HttpGet("https://pastebin.com/raw/KstdzZVB", true))()
            end
            Char.Torso["Right Shoulder"]:Destroy()
            Char.Torso["Left Shoulder"]:Destroy()
            Char.Torso["Right Hip"]:Destroy()
            Char.Torso["Left Hip"]:Destroy()
            Char.HumanoidRootPart["RootJoint"]:Destroy()
            Char.HumanoidRootPart.Anchored = true
            Char.Humanoid.PlatformStand = true
            FakeChar["Torso"].Position = Char["Torso"].Position
            for T, v in pairs(Char:GetChildren()) do
                if v:IsA("Part") and v.Name ~= "Head" then
                    if v.Name == "Torso" then
                        Align(Char[v.Name], FakeChar[v.Name], Vector3.new(0, 0.5, 0), Vector3.new(0, 0, 0))
                    else
                        Align(Char[v.Name], FakeChar[v.Name], Vector3.new(0, 0, 0), Vector3.new(0, 0, 0))
                    end
                end
            end
            FakeChar.Humanoid.Died:Connect(died)
            Char.Humanoid.Died:Connect(died)
            LocalPlayer.Character = FakeChar
            FakeChar.Name = "nigra"
            wait(1)
            for T, v in next, R do
                v.Handle.Anchored = true
            end
            for T, v in next, S do
                v.Handle.Anchored = true
            end
            game["Run Service"].Stepped:connect(
                function()
                    local kd = game.Players.LocalPlayer.Character:FindFirstChild("HingeConstraint")
                    if kd then
                        kd:Remove()
                    end
                end
            )
            local TweenService = game:GetService("TweenService")
            loadstring(game:GetObjects("rbxassetid://5728837072")[1].Source)()
            local dz = LoadLibrary("RbxUtility")
            local Create = dz.Create
            local Player = game:GetService("Players").LocalPlayer
            ZTfade = false
            ZT = false
            Character = Player.Character
            EffectPack = Character.Extras:Clone()
            Character.Extras:Destroy()
            local ke = false
            Target = Vector3.new()
            Torso = Character.Torso
            Torso.Transparency = 0
            Head = Character.Head
            Humanoid = Character.Humanoid
            LeftArm = Character["Left Arm"]
            LeftLeg = Character["Left Leg"]
            RightArm = Character["Right Arm"]
            RightLeg = Character["Right Leg"]
            RootPart = Character["HumanoidRootPart"]
            local N = "Idle"
            local mouse = Player:GetMouse()
            local dO = 0
            local dP = 0
            local dQ = 0
            local dR = 1
            local kf = false
            local kg = false
            local kh = false
            local ki = false
            Animstep = 0
            WalkAnimMove = 0.05
            Combo = 0
            local dS = false
            local kj = false
            local kk = false
            local dT = Character.HumanoidRootPart:FindFirstChild("RootJoint")
            local Neck = Character.Torso:FindFirstChild("Neck")
            local RootCF = CFrame.fromEulerAnglesXYZ(-1.57, 0, 3.14)
            local NeckCF = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)
            local dU = 0
            local dV = 0
            Effects = Instance.new("Folder", Character)
            Effects.Name = "Effects"
            it = Instance.new
            vt = Vector3.new
            cf = CFrame.new
            euler = CFrame.fromEulerAnglesXYZ
            angles = CFrame.Angles
            local cn = CFrame.new
            mr = math.rad
            mememode = false
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
            local dZ = "http://www.roblox.com/asset/?id=3852221223"
            local d_ = it("Sound", Torso)
            local e0 = 1
            d_.EmitterSize = 30
            local e1 = d_:Clone()
            playsong = true
            d_.SoundId = dZ
            if playsong == true then
                wait(2)
                d_:play()
            elseif playsong == false then
                d_:stop()
            end
            lastsongpos = 0
            crosshair = Instance.new("BillboardGui", Character)
            crosshair.Size = UDim2.new(10, 0, 10, 0)
            crosshair.Enabled = false
            imgl = Instance.new("ImageLabel", crosshair)
            imgl.Position = UDim2.new(0, 0, 0, 0)
            imgl.Size = UDim2.new(1, 0, 1, 0)
            imgl.Image = "rbxassetid://578065407"
            imgl.BackgroundTransparency = 1
            imgl.ImageTransparency = .7
            imgl.ImageColor3 = Color3.new(1, 1, 1)
            crosshair.StudsOffset = Vector3.new(0, 0, -1)
            local e2 = 1544355717
            local e3 = 528589382
            local e4 = 376976397
            local e5 = 459523898
            local e6 = 424195979
            local e7 = 698824317
            local e8 = 874376217
            local e9 = 231917744
            local ea = 168513088
            local eb = 299058146
            local kl = Instance.new("Weld")
            local km = Instance.new("Weld")
            local kn = Instance.new("Part")
            local ko = Instance.new("Part")
            local kp = Instance.new("Model")
            if Character:FindFirstChild("Animate") then
                Character.Animate:Destroy()
            end
            function RemoveOutlines(ec)
                ec.TopSurface, ec.BottomSurface, ec.LeftSurface, ec.RightSurface, ec.FrontSurface, ec.BackSurface =
                    10,
                    10,
                    10,
                    10,
                    10,
                    10
            end
            CFuncs = {
                Part = {
                    Create = function(ed, ee, ef, eg, eh, ei, k)
                        local Part =
                            Create("Part")(
                            {
                                Parent = ed,
                                Reflectance = ef,
                                Transparency = eg,
                                CanCollide = false,
                                Locked = true,
                                BrickColor = BrickColor.new(tostring(eh)),
                                Name = ei,
                                Size = k,
                                Material = ee
                            }
                        )
                        RemoveOutlines(Part)
                        return Part
                    end
                },
                Mesh = {Create = function(Mesh, Part, ej, ek, el, em)
                        local en = Create(Mesh)({Parent = Part, Offset = el, Scale = em})
                        if Mesh == "SpecialMesh" then
                            en.MeshType = ej
                            en.MeshId = ek
                        end
                        return en
                    end},
                Mesh = {Create = function(Mesh, Part, ej, ek, el, em)
                        local en = Create(Mesh)({Parent = Part, Offset = el, Scale = em})
                        if Mesh == "SpecialMesh" then
                            en.MeshType = ej
                            en.MeshId = ek
                        end
                        return en
                    end},
                Weld = {Create = function(ed, Part0, aA, eo, ep)
                        local Weld = Create("Weld")({Parent = ed, Part0 = Part0, Part1 = aA, C0 = eo, C1 = ep})
                        return Weld
                    end},
                Sound = {
                    Create = function(eq, par, er, pit)
                        coroutine.resume(
                            coroutine.create(
                                function()
                                    local dA =
                                        Create("Sound")(
                                        {
                                            Volume = er,
                                            Pitch = pit or 1,
                                            SoundId = "http://www.roblox.com/asset/?id=" .. eq,
                                            Parent = par or workspace
                                        }
                                    )
                                    wait()
                                    dA:play()
                                    game:GetService("Debris"):AddItem(dA, 6)
                                end
                            )
                        )
                    end
                },
                ParticleEmitter = {
                    Create = function(ed, es, et, eu, k, ev, eg, ew, ex, ey, ez, eA, eB, eC, eD, eE, eF, eG, l, eH)
                        local eI =
                            Create("ParticleEmitter")(
                            {
                                Parent = ed,
                                Color = ColorSequence.new(es, et),
                                LightEmission = eu,
                                Size = k,
                                Texture = ev,
                                Transparency = eg,
                                ZOffset = ew,
                                Acceleration = ex,
                                Drag = ey,
                                LockedToPart = ez,
                                VelocityInheritance = eA,
                                EmissionDirection = eB,
                                Enabled = eC,
                                Lifetime = eD,
                                Rate = eE,
                                Rotation = eF,
                                RotSpeed = eG,
                                Speed = l,
                                VelocitySpread = eH
                            }
                        )
                        return eI
                    end
                }
            }
            wait(0.1)
            eyes = Instance.new("Decal", Head)
            eyes.Face = "Front"
            mouth = Instance.new("Decal", Head)
            mouth.Face = "Front"
            brows = Instance.new("Decal", Head)
            brows.Face = "Front"
            blush = Instance.new("Decal", Head)
            blush.Face = "Front"
            extra = Instance.new("Decal", Head)
            extra.Face = "Front"
            coroutine.resume(
                coroutine.create(
                    function()
                        wait(.5)
                        for T, v in pairs(Character:GetDescendants()) do
                            if
                                v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") or
                                    v:IsA("Hat") or
                                    v:IsA("BodyColors")
                             then
                            end
                        end
                        local eJ = EffectPack.Outfit:Clone()
                        for T, v in pairs(eJ:GetChildren()) do
                            if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
                            end
                            if v:IsA("BasePart") then
                                local eK = v:FindFirstChildOfClass("Attachment")
                                local eL = nil
                                for T, eM in pairs(Character:GetDescendants()) do
                                    if eM:IsA("Attachment") and eM.Name == eK.Name and eM.Parent.Parent == Character then
                                        eL = eM
                                    end
                                end
                                kn.Name = "Left"
                                kn.Parent = Player.Character
                                kn.CFrame =
                                    CFrame.new(
                                    -0.864785671,
                                    5.40298271,
                                    1.08804584,
                                    0.00171390176,
                                    0.0015738951,
                                    0.999997795,
                                    0.0481499843,
                                    0.998839736,
                                    -0.00165481726,
                                    -0.998839498,
                                    0.0481527671,
                                    0.00163629651
                                )
                                kn.Orientation = Vector3.new(0.0900000036, 89.9100037, 2.75999999)
                                kn.Position = Vector3.new(-0.864785671, 5.40298271, 1.08804584)
                                kn.Rotation = Vector3.new(45.3199997, 89.8799973, -42.5600014)
                                kn.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
                                kn.Size = Vector3.new(1.03999996, 0.419999987, 1.05999994)
                                kn.BottomSurface = Enum.SurfaceType.Smooth
                                kn.BrickColor = BrickColor.new("Really black")
                                kn.CanCollide = false
                                kn.Locked = true
                                kn.Material = Enum.Material.SmoothPlastic
                                kn.brickColor = BrickColor.new("Really black")
                                kn.FormFactor = Enum.FormFactor.Symmetric
                                kn.formFactor = Enum.FormFactor.Symmetric
                                kl.Name = "Left Leg"
                                kl.Parent = kn
                                kl.C0 = CFrame.new(0, -0.8, 0)
                                kl.Part0 = kn
                                kl.Part1 = LeftLeg
                                kl.part1 = LeftLeg
                                ko.Name = "Right"
                                ko.Parent = Player.Character
                                ko.CFrame =
                                    CFrame.new(
                                    -0.862425506,
                                    5.4220829,
                                    2.09170222,
                                    -0.34028101,
                                    -0.0131851267,
                                    0.940231562,
                                    -0.0387370177,
                                    0.99925065,
                                    -6.86116982e-06,
                                    -0.939526379,
                                    -0.0364240296,
                                    -0.340536386
                                )
                                ko.Orientation = Vector3.new(0, 109.910004, -2.22000003)
                                ko.Position = Vector3.new(-0.862425506, 5.4220829, 2.09170222)
                                ko.Rotation = Vector3.new(180, 70.0899963, 177.779999)
                                ko.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
                                ko.Size = Vector3.new(1.03999996, 0.419999808, 1.05999994)
                                ko.BottomSurface = Enum.SurfaceType.Smooth
                                ko.BrickColor = BrickColor.new("Really black")
                                ko.CanCollide = false
                                ko.Locked = true
                                ko.Material = Enum.Material.SmoothPlastic
                                ko.brickColor = BrickColor.new("Really black")
                                ko.FormFactor = Enum.FormFactor.Symmetric
                                ko.formFactor = Enum.FormFactor.Symmetric
                                km.Name = "Right Leg"
                                km.Parent = ko
                                km.C0 = CFrame.new(0, -0.8, 0)
                                km.Part0 = ko
                                km.Part1 = RightLeg
                                km.part1 = RightLeg
                                local Model0 = Instance.new("Model")
                                local aA = Instance.new("Part")
                                local kq = Instance.new("SpecialMesh")
                                local kr = Instance.new("Weld")
                                local Part4 = Instance.new("Part")
                                local ks = Instance.new("SpecialMesh")
                                local kt = Instance.new("Weld")
                                local ku = Instance.new("Part")
                                local kv = Instance.new("SpecialMesh")
                                local kw = Instance.new("Weld")
                                local kx = Instance.new("Part")
                                local ky = Instance.new("SpecialMesh")
                                local kz = Instance.new("Weld")
                                local kA = Instance.new("Part")
                                local kB = Instance.new("SpecialMesh")
                                local kC = Instance.new("Weld")
                                local Part17 = Instance.new("Part")
                                local kD = Instance.new("SpecialMesh")
                                local kE = Instance.new("Weld")
                                local Part20 = Instance.new("Part")
                                local kF = Instance.new("SpecialMesh")
                                local kG = Instance.new("Weld")
                                local kH = Instance.new("Part")
                                local kI = Instance.new("SpecialMesh")
                                local kJ = Instance.new("Weld")
                                Model0.Name = "vag"
                                Model0.Parent = Torso
                                Model0.PrimaryPart = aA
                                aA.Name = "mainskin"
                                aA.Parent = Model0
                                aA.CFrame =
                                    CFrame.new(
                                    -0.866321027,
                                    5.57360649,
                                    1.57845628,
                                    0.00160500058,
                                    -0.0125150038,
                                    0.999920428,
                                    0.999988377,
                                    -0.00454756292,
                                    -0.00166202663,
                                    0.00456800172,
                                    0.999911368,
                                    0.0125075588
                                )
                                aA.Orientation = Vector3.new(0.100000001, 89.2799988, 90.2600021)
                                aA.Position = Vector3.new(-0.866321027, 5.57360649, 1.57845628)
                                aA.Rotation = Vector3.new(7.57000017, 89.2799988, 82.6900024)
                                aA.Color = Color3.new(1, 0.8, 0.6)
                                aA.Size = Vector3.new(0.900895953, 1.80179191, 0.900895953)
                                aA.Anchored = false
                                aA.BottomSurface = Enum.SurfaceType.Smooth
                                aA.BrickColor = BrickColor.new("Pastel brown")
                                aA.CanCollide = false
                                aA.Material = Enum.Material.SmoothPlastic
                                aA.TopSurface = Enum.SurfaceType.Smooth
                                aA.brickColor = BrickColor.new("Pastel brown")
                                kq.Parent = aA
                                kq.Scale = Vector3.new(0.899999976, 0.400000006, 0.899999976)
                                kq.MeshType = Enum.MeshType.Sphere
                                kr.Name = "Torso"
                                kr.Parent = aA
                                kr.C0 =
                                    CFrame.new(
                                    1.00810242,
                                    0.00668120384,
                                    -0.0114426017,
                                    5.99958003e-06,
                                    0.999901295,
                                    0.0141194807,
                                    -0.999941111,
                                    0.000160070136,
                                    -0.0109077049,
                                    -0.0109090386,
                                    -0.0141187282,
                                    0.999840915
                                )
                                kr.Part0 = aA
                                kr.Part1 = Torso
                                kr.part1 = Torso
                                Part4.Name = "Vg"
                                Part4.Parent = Model0
                                Part4.CFrame =
                                    CFrame.new(
                                    -0.866321027,
                                    5.57360649,
                                    1.57845628,
                                    0.00160500058,
                                    -0.0125150038,
                                    0.999920428,
                                    0.999988377,
                                    -0.00454756292,
                                    -0.00166202663,
                                    0.00456800172,
                                    0.999911368,
                                    0.0125075588
                                )
                                Part4.Orientation = Vector3.new(0.100000001, 89.2799988, 90.2600021)
                                Part4.Position = Vector3.new(-0.866321027, 5.57360649, 1.57845628)
                                Part4.Rotation = Vector3.new(7.57000017, 89.2799988, 82.6900024)
                                Part4.Color = Color3.new(0.854902, 0.52549, 0.478431)
                                Part4.Size = Vector3.new(0.900895953, 1.80179191, 0.900895953)
                                Part4.Anchored = false
                                Part4.BottomSurface = Enum.SurfaceType.Smooth
                                Part4.BrickColor = BrickColor.new("Medium red")
                                Part4.CanCollide = false
                                Part4.Material = Enum.Material.SmoothPlastic
                                Part4.TopSurface = Enum.SurfaceType.Smooth
                                Part4.brickColor = BrickColor.new("Medium red")
                                ks.Parent = Part4
                                ks.Scale = Vector3.new(0.910000026, 0.300000012, 0.910000026)
                                ks.MeshType = Enum.MeshType.Sphere
                                kt.Name = "mainskin"
                                kt.Parent = Part4
                                kt.C0 =
                                    CFrame.new(
                                    0,
                                    0,
                                    0,
                                    1.00000024,
                                    4.65661287e-10,
                                    1.23691279e-10,
                                    4.65661287e-10,
                                    1,
                                    9.31322575e-10,
                                    1.23691279e-10,
                                    9.31322575e-10,
                                    1
                                )
                                kt.Part0 = Part4
                                kt.Part1 = aA
                                kt.part1 = aA
                                ku.Name = "Vg2"
                                ku.Parent = Model0
                                ku.CFrame =
                                    CFrame.new(
                                    -0.865878761,
                                    5.55604744,
                                    1.57808244,
                                    0.00160500058,
                                    -0.0125150038,
                                    0.999920428,
                                    0.999988377,
                                    -0.00454756292,
                                    -0.00166202663,
                                    0.00456800172,
                                    0.999911368,
                                    0.0125075588
                                )
                                ku.Orientation = Vector3.new(0.100000001, 89.2799988, 90.2600021)
                                ku.Position = Vector3.new(-0.865878761, 5.55604744, 1.57808244)
                                ku.Rotation = Vector3.new(7.57000017, 89.2799988, 82.6900024)
                                ku.Color = Color3.new(0.639216, 0.294118, 0.294118)
                                ku.Size = Vector3.new(0.900895953, 0.900895953, 0.900895953)
                                ku.Anchored = false
                                ku.BottomSurface = Enum.SurfaceType.Smooth
                                ku.BrickColor = BrickColor.new("Dusty Rose")
                                ku.CanCollide = false
                                ku.Material = Enum.Material.SmoothPlastic
                                ku.TopSurface = Enum.SurfaceType.Smooth
                                ku.brickColor = BrickColor.new("Dusty Rose")
                                kv.Parent = ku
                                kv.Scale = Vector3.new(0.910000026, 0.300000012, 0.910000026)
                                kv.MeshType = Enum.MeshType.Sphere
                                kw.Name = "mainskin"
                                kw.Parent = ku
                                kw.C0 =
                                    CFrame.new(
                                    0.0175599698,
                                    0.000299525098,
                                    -0.00046673941,
                                    1.00000024,
                                    4.65661287e-10,
                                    1.23691279e-10,
                                    4.65661287e-10,
                                    1,
                                    9.31322575e-10,
                                    1.23691279e-10,
                                    9.31322575e-10,
                                    1
                                )
                                kw.Part0 = ku
                                kw.Part1 = aA
                                kw.part1 = aA
                                kx.Name = "Skin"
                                kx.Parent = Model0
                                kx.CFrame =
                                    CFrame.new(
                                    -0.776254952,
                                    5.58247375,
                                    1.58018422,
                                    -0.572227836,
                                    -0.0160920434,
                                    0.819936872,
                                    0.820094705,
                                    -0.0112283546,
                                    0.572117686,
                                    0,
                                    0.999807537,
                                    0.0196221787
                                )
                                kx.Orientation = Vector3.new(-34.9000015, 88.6299973, 90.7799988)
                                kx.Position = Vector3.new(-0.776254952, 5.58247375, 1.58018422)
                                kx.Rotation = Vector3.new(-88.0400009, 55.0800018, 178.389999)
                                kx.Color = Color3.new(1, 0.8, 0.6)
                                kx.Size = Vector3.new(0.891887307, 1.49548769, 0.900895953)
                                kx.Anchored = false
                                kx.BottomSurface = Enum.SurfaceType.Smooth
                                kx.BrickColor = BrickColor.new("Pastel brown")
                                kx.CanCollide = false
                                kx.Material = Enum.Material.SmoothPlastic
                                kx.TopSurface = Enum.SurfaceType.Smooth
                                kx.brickColor = BrickColor.new("Pastel brown")
                                ky.Parent = kx
                                ky.Scale = Vector3.new(0.899999976, 0.400000006, 0.899999976)
                                ky.MeshType = Enum.MeshType.Sphere
                                kz.Name = "mainskin"
                                kz.Parent = kx
                                kz.C0 =
                                    CFrame.new(
                                    0.0442657135,
                                    -0.000178598173,
                                    -0.0789558589,
                                    0.81916672,
                                    0.00343200099,
                                    -0.573545337,
                                    -0.00668692915,
                                    0.99997133,
                                    -0.00356695056,
                                    0.573516667,
                                    0.00675718486,
                                    0.819166183
                                )
                                kz.Part0 = kx
                                kz.Part1 = aA
                                kz.part1 = aA
                                kp.Name = "vagcover"
                                kp.Parent = Torso
                                kp.PrimaryPart = kA
                                kA.Name = "mainskin"
                                kA.Parent = kp
                                kA.CFrame =
                                    CFrame.new(
                                    -0.866962552,
                                    5.56903839,
                                    1.57845902,
                                    0.00160500058,
                                    -0.0125150038,
                                    0.999920428,
                                    0.999988377,
                                    -0.00454756292,
                                    -0.00166202663,
                                    0.00456800172,
                                    0.999911368,
                                    0.0125075588
                                )
                                kA.Orientation = Vector3.new(0.100000001, 89.2799988, 90.2600021)
                                kA.Position = Vector3.new(-0.866962552, 5.56903839, 1.57845902)
                                kA.Rotation = Vector3.new(7.57000017, 89.2799988, 82.6900024)
                                kA.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
                                kA.Size = Vector3.new(0.90731889, 1.81463778, 0.90731889)
                                kA.Anchored = false
                                kA.BottomSurface = Enum.SurfaceType.Smooth
                                kA.BrickColor = BrickColor.new("Really black")
                                kA.CanCollide = false
                                kA.Material = Enum.Material.SmoothPlastic
                                kA.TopSurface = Enum.SurfaceType.Smooth
                                kA.brickColor = BrickColor.new("Really black")
                                kB.Parent = kA
                                kB.Scale = Vector3.new(0.899999976, 0.400000006, 0.899999976)
                                kB.MeshType = Enum.MeshType.Sphere
                                kC.Name = "Torso"
                                kC.Parent = kA
                                kC.C0 =
                                    CFrame.new(
                                    1.01267099,
                                    0.00664961338,
                                    -0.0108087659,
                                    6.00004569e-06,
                                    0.999901056,
                                    0.0141194789,
                                    -0.999941051,
                                    0.000160070136,
                                    -0.0109077059,
                                    -0.0109090377,
                                    -0.0141187273,
                                    0.999840915
                                )
                                kC.Part0 = kA
                                kC.Part1 = Torso
                                kC.part1 = Torso
                                Part17.Name = "Vg"
                                Part17.Parent = kp
                                Part17.CFrame =
                                    CFrame.new(
                                    -0.866962552,
                                    5.56903839,
                                    1.57845902,
                                    0.00160500058,
                                    -0.0125150038,
                                    0.999920428,
                                    0.999988377,
                                    -0.00454756292,
                                    -0.00166202663,
                                    0.00456800172,
                                    0.999911368,
                                    0.0125075588
                                )
                                Part17.Orientation = Vector3.new(0.100000001, 89.2799988, 90.2600021)
                                Part17.Position = Vector3.new(-0.866962552, 5.56903839, 1.57845902)
                                Part17.Rotation = Vector3.new(7.57000017, 89.2799988, 82.6900024)
                                Part17.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
                                Part17.Size = Vector3.new(0.90731889, 1.81463778, 0.90731889)
                                Part17.Anchored = false
                                Part17.BottomSurface = Enum.SurfaceType.Smooth
                                Part17.BrickColor = BrickColor.new("Really black")
                                Part17.CanCollide = false
                                Part17.Material = Enum.Material.SmoothPlastic
                                Part17.TopSurface = Enum.SurfaceType.Smooth
                                Part17.brickColor = BrickColor.new("Really black")
                                kD.Parent = Part17
                                kD.Scale = Vector3.new(0.910000026, 0.300000012, 0.910000026)
                                kD.MeshType = Enum.MeshType.Sphere
                                kE.Name = "mainskin"
                                kE.Parent = Part17
                                kE.C0 =
                                    CFrame.new(
                                    0,
                                    0,
                                    0,
                                    1.00000024,
                                    4.65661287e-10,
                                    1.23691279e-10,
                                    4.65661287e-10,
                                    1,
                                    9.31322575e-10,
                                    1.23691279e-10,
                                    9.31322575e-10,
                                    1
                                )
                                kE.Part0 = Part17
                                kE.Part1 = kA
                                kE.part1 = kA
                                Part20.Name = "Vg2"
                                Part20.Parent = kp
                                Part20.CFrame =
                                    CFrame.new(
                                    -0.86652112,
                                    5.55135584,
                                    1.57807875,
                                    0.00160500058,
                                    -0.0125150038,
                                    0.999920428,
                                    0.999988377,
                                    -0.00454756292,
                                    -0.00166202663,
                                    0.00456800172,
                                    0.999911368,
                                    0.0125075588
                                )
                                Part20.Orientation = Vector3.new(0.100000001, 89.2799988, 90.2600021)
                                Part20.Position = Vector3.new(-0.86652112, 5.55135584, 1.57807875)
                                Part20.Rotation = Vector3.new(7.57000017, 89.2799988, 82.6900024)
                                Part20.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
                                Part20.Size = Vector3.new(0.90731889, 0.90731889, 0.90731889)
                                Part20.Anchored = false
                                Part20.BottomSurface = Enum.SurfaceType.Smooth
                                Part20.BrickColor = BrickColor.new("Really black")
                                Part20.CanCollide = false
                                Part20.Material = Enum.Material.SmoothPlastic
                                Part20.TopSurface = Enum.SurfaceType.Smooth
                                Part20.brickColor = BrickColor.new("Really black")
                                kF.Parent = Part20
                                kF.Scale = Vector3.new(0.910000026, 0.300000012, 0.910000026)
                                kF.MeshType = Enum.MeshType.Sphere
                                kG.Name = "mainskin"
                                kG.Parent = Part20
                                kG.C0 =
                                    CFrame.new(
                                    0.0176836904,
                                    0.00030521708,
                                    -0.000466041354,
                                    1.00000024,
                                    4.65661287e-10,
                                    1.23691279e-10,
                                    4.65661287e-10,
                                    1,
                                    9.31322575e-10,
                                    1.23691279e-10,
                                    9.31322575e-10,
                                    1
                                )
                                kG.Part0 = Part20
                                kG.Part1 = kA
                                kG.part1 = kA
                                kH.Name = "Skin"
                                kH.Parent = kp
                                kH.CFrame =
                                    CFrame.new(
                                    -0.776253998,
                                    5.57796907,
                                    1.58019507,
                                    -0.572227836,
                                    -0.0160920434,
                                    0.819936872,
                                    0.820094705,
                                    -0.0112283546,
                                    0.572117686,
                                    0,
                                    0.999807537,
                                    0.0196221787
                                )
                                kH.Orientation = Vector3.new(-34.9000015, 88.6299973, 90.7799988)
                                kH.Position = Vector3.new(-0.776253998, 5.57796907, 1.58019507)
                                kH.Rotation = Vector3.new(-88.0400009, 55.0800018, 178.389999)
                                kH.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
                                kH.Size = Vector3.new(0.898245931, 1.50614965, 0.90731889)
                                kH.Anchored = false
                                kH.BottomSurface = Enum.SurfaceType.Smooth
                                kH.BrickColor = BrickColor.new("Really black")
                                kH.CanCollide = false
                                kH.Material = Enum.Material.SmoothPlastic
                                kH.TopSurface = Enum.SurfaceType.Smooth
                                kH.brickColor = BrickColor.new("Really black")
                                kI.Parent = kH
                                kI.Scale = Vector3.new(0.899999976, 0.400000006, 0.899999976)
                                kI.MeshType = Enum.MeshType.Sphere
                                kJ.Name = "mainskin"
                                kJ.Parent = kH
                                kJ.C0 =
                                    CFrame.new(
                                    0.0445814133,
                                    -0.000175714493,
                                    -0.0795190334,
                                    0.81916672,
                                    0.00343200099,
                                    -0.573545337,
                                    -0.00668692915,
                                    0.99997133,
                                    -0.00356695056,
                                    0.573516667,
                                    0.00675718486,
                                    0.819166183
                                )
                                kJ.Part0 = kH
                                kJ.Part1 = kA
                                kJ.part1 = kA
                                v.Parent = eL.Parent
                                local eN = weld(v, eL.Parent, v, CF())
                                eN.C0 =
                                    CF(eL.Position) *
                                    ANGLES(mr(eL.Orientation.x), mr(eL.Orientation.y), mr(eL.Orientation.z))
                                eN.C1 =
                                    CF(eK.Position) *
                                    ANGLES(mr(eK.Orientation.x), mr(eK.Orientation.y), mr(eK.Orientation.z))
                            end
                        end
                    end
                )
            )
            function Swait(eO)
                if eO == 0 or eO == nil then
                    game:GetService("RunService").Heartbeat:wait()
                    game:GetService("RunService").Heartbeat:wait()
                else
                    for T = 1, eO do
                        game:GetService("RunService").Heartbeat:wait()
                        game:GetService("RunService").Heartbeat:wait()
                    end
                end
            end
            so = function(eq, par, er, pit)
                CFuncs.Sound.Create(eq, par, er, pit)
            end
            function weld(eP, eQ, eR, dH)
                local weld = it("Weld")
                weld.Parent = eP
                weld.Part0 = eQ
                weld.Part1 = eR
                weld.C0 = dH
                return weld
            end
            rayCast = function(eS, eT, eU, eV)
                return game:service("Workspace"):FindPartOnRay(Ray.new(eS, eT.unit * (eU or 999.999)), eV)
            end
            function SetTween(eW, eX, eY, eZ, e_)
                local f0 = Enum.EasingStyle[eY]
                local f1 = Enum.EasingDirection[eZ]
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                if eW.Name == "Bullet" then
                    f2 = 1
                end
                local f3 = TweenInfo.new(e_ / f2, f0, f1, 0, false, 0)
                local f4 = eX
                local f5 = TweenService:Create(eW, f3, f4)
                f5:Play()
            end
            function GatherAllInstances(ed, f6)
                local f7 = {}
                local eV = nil
                if f6 ~= nil then
                    eV = f6
                end
                local function f8(ed, eV)
                    for T, v in pairs(ed:GetChildren()) do
                        if v ~= eV then
                            f8(v, eV)
                            table.insert(f7, v)
                        end
                    end
                end
                f8(ed, eV)
                return f7
            end
            function weld(eP, eQ, eR, dH)
                local weld = it("Weld")
                weld.Parent = eP
                weld.Part0 = eQ
                weld.Part1 = eR
                weld.C0 = dH
                return weld
            end
            function joint(eP, eQ, eR, dH)
                local weld = it("Motor6D")
                weld.Parent = eP
                weld.Part0 = eQ
                weld.Part1 = eR
                weld.C0 = dH
                return weld
            end
            ArmorParts = {}
            function WeldAllTo(aA, Part2, scan, f9)
                local fa = Part2.CFrame * f9
                for T, v3 in pairs(scan:GetDescendants()) do
                    if v3:isA("BasePart") then
                        local fb = weld(v3, v3, aA, fa:toObjectSpace(v3.CFrame):inverse())
                        v3.Anchored = false
                        v3.Massless = true
                        v3.CanCollide = false
                        v3.Parent = aA
                        v3.Locked = true
                        if not v3:FindFirstChild("Destroy") then
                            table.insert(
                                ArmorParts,
                                {Part = v3, Par = v3.Parent, Col = v3.Color, Mat = v3.Material.Name}
                            )
                        else
                            v3:Destroy()
                        end
                    end
                end
                aA.Transparency = 1
            end
            function JointAllTo(aA, Part2, scan, f9)
                local fa = Part2.CFrame * f9
                for T, v3 in pairs(scan:GetDescendants()) do
                    if v3:isA("BasePart") then
                        local fb = joint(v3, v3, aA, fa:toObjectSpace(v3.CFrame):inverse())
                        v3.Anchored = false
                        v3.Massless = true
                        v3.CanCollide = false
                        v3.Parent = aA
                        v3.Locked = true
                        if not v3:FindFirstChild("Destroy") then
                        else
                            v3:Destroy()
                        end
                    end
                end
                aA.Transparency = 1
            end
            local kK = EffectPack.Part:Clone()
            kK.Parent = Character
            kK.Name = "RightClaw"
            RCW = weld(RightArm, RightArm, kK, cf(0, 0, 0))
            local kL = EffectPack.Part:Clone()
            kL.Parent = Character
            kL.Name = "LeftClaw"
            LCW = weld(LeftArm, LeftArm, kL, cf(0, 0, 0))
            local kM = EffectPack.Part:Clone()
            kM.Parent = Character.Torso
            kM.Name = "Tail"
            taew = weld(Torso, Torso, Tail, cf(0, 0, 0))
            taew.Parent = kM
            tailw = Torso:WaitForChild("Tail").Weld
            tailc0 = tailw.C0
            for U, v in pairs(Character.Armor:children()) do
                if v:IsA("Model") then
                    if Character:FindFirstChild("" .. v.Name) then
                        local aA = Character:FindFirstChild("" .. v.Name)
                        local Part2 = v.Handle
                        WeldAllTo(aA, Part2, v, CFrame.new(0, 0, 0))
                    end
                end
            end
            local kN = Character.LArmYes.LeftArm:WaitForChild "REF"
            for T, v in pairs(Character.LArmYes.LeftArm:GetChildren()) do
                v.Anchored = false
            end
            local kO = IT("Weld")
            kO.Parent = LeftArm
            kO.Part0 = LeftArm
            kO.Part1 = kN
            kO.C1 = CF(0, 0, 0) * angles(0, 0, 0)
            local kP = Character.RArmYes.RightArm:WaitForChild "REF"
            for T, v in pairs(Character.RArmYes.RightArm:GetChildren()) do
                v.Anchored = false
            end
            local kQ = IT("Weld")
            kQ.Parent = RightArm
            kQ.Part0 = RightArm
            kQ.Part1 = kP
            kQ.C1 = CF(0, 0, 0) * angles(0, 0, 0)
            local kR = Character.TorsoYes.Torso:WaitForChild "REF"
            for T, v in pairs(Character.TorsoYes.Torso:GetChildren()) do
                v.Anchored = false
            end
            local kO = IT("Weld")
            kO.Parent = Torso
            kO.Part0 = Torso
            kO.Part1 = kR
            kO.C1 = CF(0, 0, 0) * angles(0, RAD(0), 0)
            local kS = Character.LLegYes.LeftLeg:WaitForChild "REF"
            for T, v in pairs(Character.LLegYes.LeftLeg:GetChildren()) do
                v.Anchored = false
            end
            local kT = IT("Weld")
            kT.Parent = LeftLeg
            kT.Part0 = LeftLeg
            kT.Part1 = kS
            kT.C1 = CF(0, 0, 0) * angles(0, 102.1, 0)
            local kU = Character.RLegYes.RightLeg:WaitForChild "REF"
            for T, v in pairs(Character.RLegYes.RightLeg:GetChildren()) do
                v.Anchored = false
            end
            local kV = IT("Weld")
            kV.Parent = RightLeg
            kV.Part0 = RightLeg
            kV.Part1 = kU
            kV.C1 = CF(0, 0, 0) * angles(0, -102.1, 0)
            local fc =
                Create("Texture")(
                {
                    Texture = "http://www.roblox.com/asset/?id=1693385655",
                    Color3 = Color3.new(163 / 255, 162 / 255, 165 / 255)
                }
            )
            function AddStoneTexture(ec)
                coroutine.resume(
                    coroutine.create(
                        function()
                            for T = 0, 6, 1 do
                                local fd = fc:Clone()
                                fd.Face = T
                                fd.Parent = ec
                            end
                        end
                    )
                )
            end
            New = function(j, ed, ei, fe)
                local j = Instance.new(j)
                for ff, fg in pairs(fe or {}) do
                    j[ff] = fg
                end
                j.Parent = ed
                j.Name = ei
                return j
            end
            function Tran(fh)
                local fi = ""
                if fh == "1" then
                    fi = "a"
                elseif fh == "2" then
                    fi = "b"
                elseif fh == "3" then
                    fi = "c"
                elseif fh == "4" then
                    fi = "d"
                elseif fh == "5" then
                    fi = "e"
                elseif fh == "6" then
                    fi = "f"
                elseif fh == "7" then
                    fi = "g"
                elseif fh == "8" then
                    fi = "h"
                elseif fh == "9" then
                    fi = "i"
                elseif fh == "10" then
                    fi = "j"
                elseif fh == "11" then
                    fi = "k"
                elseif fh == "12" then
                    fi = "l"
                elseif fh == "13" then
                    fi = "m"
                elseif fh == "14" then
                    fi = "n"
                elseif fh == "15" then
                    fi = "o"
                elseif fh == "16" then
                    fi = "p"
                elseif fh == "17" then
                    fi = "q"
                elseif fh == "18" then
                    fi = "r"
                elseif fh == "19" then
                    fi = "s"
                elseif fh == "20" then
                    fi = "t"
                elseif fh == "21" then
                    fi = "u"
                elseif fh == "22" then
                    fi = "v"
                elseif fh == "23" then
                    fi = "w"
                elseif fh == "24" then
                    fi = "x"
                elseif fh == "25" then
                    fi = "y"
                elseif fh == "26" then
                    fi = "z"
                elseif fh == "27" then
                    fi = "_"
                elseif fh == "28" then
                    fi = "0"
                elseif fh == "29" then
                    fi = "1"
                elseif fh == "30" then
                    fi = "2"
                elseif fh == "31" then
                    fi = "3"
                elseif fh == "32" then
                    fi = "4"
                elseif fh == "33" then
                    fi = "5"
                elseif fh == "34" then
                    fi = "6"
                elseif fh == "35" then
                    fi = "7"
                elseif fh == "36" then
                    fi = "8"
                elseif fh == "37" then
                    fi = "9"
                end
                return fi
            end
            function MaybeOk(fj, f9)
                local fk = ""
                if fj == 1 then
                    local fl = ""
                    local fm = f9
                    local fn = ""
                    local fo = 0
                    local fp = 0
                    delay(
                        wait(0),
                        function()
                            for v3 = 1, #fm do
                                if string.sub(fm, 0 + v3, v3) == "," then
                                    local fq = string.sub(fm, fp, v3 - 1)
                                    local fr = Tran(string.sub(fm, fp, v3 - 1))
                                    fo = fo + 1
                                    fl = fl .. fr
                                    fp = v3 + 1
                                    fn = ""
                                end
                                fn = string.sub(fm, 1, v3)
                                wait()
                            end
                            fk = fl
                            for v3 = 1, #fn do
                                fn = string.sub(fm, -1, v3)
                            end
                        end
                    )
                elseif fj == 2 then
                    print("fat")
                end
                while fk == "" do
                    wait()
                end
                return fk
            end
            function CreateMesh2(fs, ft, fu, fv, fw, fx, fy)
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
            function CreatePart2(fA, ft, fB, fC, fD, fE, fF, fG, fH)
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
            local dA = IT("Sound")
            function CreateSound2(fJ, ft, fK, fL, fM)
                local fN = nil
                coroutine.resume(
                    coroutine.create(
                        function()
                            fN = dA:Clone()
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
                            local g2 = nil
                            local g3 = CreatePart2(3, Effects, fB, 0, fD, BRICKC("Pearl"), "Effect", VT(1, 1, 1), true)
                            if fZ ~= nil and f_ ~= nil and g0 ~= nil then
                                g1 = true
                                g2 = CreateSound2(fZ, g3, g0, f_, false)
                            end
                            g3.Color = fX
                            local g4 = nil
                            if fP == "Sphere" then
                                g4 = CreateMesh2("SpecialMesh", g3, "Sphere", "", "", fG, VT(0, 0, 0))
                            elseif fP == "Cylinder" then
                                g4 = CreateMesh2("SpecialMesh", g3, "Cylinder", "", "", fG, VT(0, 0, 0))
                            elseif fP == "Block" then
                                g4 = IT("BlockMesh", g3)
                                g4.Scale = VT(fG.X, fG.X, fG.X)
                            elseif fP == "Cube" then
                                g4 = IT("BlockMesh", g3)
                                g4.Scale = VT(fG.X, fG.X, fG.X)
                            elseif fP == "Wave" then
                                g4 = CreateMesh2("SpecialMesh", g3, "FileMesh", "20329976", "", fG, VT(0, 0, -fG.X / 8))
                            elseif fP == "Ring" then
                                g4 =
                                    CreateMesh2(
                                    "SpecialMesh",
                                    g3,
                                    "FileMesh",
                                    "559831844",
                                    "",
                                    VT(fG.X, fG.X, 0.1),
                                    VT(0, 0, 0)
                                )
                            elseif fP == "Slash" then
                                g4 =
                                    CreateMesh2(
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
                                    CreateMesh2(
                                    "SpecialMesh",
                                    g3,
                                    "FileMesh",
                                    "662585058",
                                    "",
                                    VT(fG.X / 10, 0, fG.X / 10),
                                    VT(0, 0, 0)
                                )
                            elseif fP == "Swirl" then
                                g4 = CreateMesh2("SpecialMesh", g3, "FileMesh", "1051557", "", fG, VT(0, 0, 0))
                            elseif fP == "Skull" then
                                g4 = CreateMesh2("SpecialMesh", g3, "FileMesh", "4770583", "", fG, VT(0, 0, 0))
                            elseif fP == "Crystal" then
                                g4 = CreateMesh2("SpecialMesh", g3, "FileMesh", "9756362", "", fG, VT(0, 0, 0))
                            elseif fP == "Crown" then
                                g4 = CreateMesh2("SpecialMesh", g3, "FileMesh", "173770780", "", fG, VT(0, 0, 0))
                            end
                            if g4 ~= nil then
                                local g5 = nil
                                if fT ~= nil then
                                    g5 = (fS.p - fT).Magnitude / fY
                                end
                                local g6 = fG - fQ
                                local g7 = fD - fR
                                if fP == "Block" then
                                    SetTween(
                                        g3,
                                        {
                                            CFrame = fS *
                                                ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
                                        },
                                        "Linear",
                                        "InOut",
                                        fY / 60
                                    )
                                else
                                    SetTween(g3, {CFrame = fS}, "Linear", "InOut", 0)
                                end
                                wait()
                                SetTween(g3, {Transparency = g3.Transparency - g7}, "Linear", "InOut", fY / 60)
                                if fP == "Block" then
                                    SetTween(
                                        g3,
                                        {
                                            CFrame = fS *
                                                ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
                                        },
                                        "Linear",
                                        "InOut",
                                        0
                                    )
                                else
                                    SetTween(
                                        g3,
                                        {CFrame = g3.CFrame * ANGLES(RAD(fU), RAD(fV), RAD(fW))},
                                        "Linear",
                                        "InOut",
                                        0
                                    )
                                end
                                if fT ~= nil then
                                    local g8 = g3.Orientation
                                    SetTween(g3, {CFrame = CF(fT)}, "Linear", "InOut", fY / 60)
                                    SetTween(g3, {Orientation = g8}, "Linear", "InOut", fY / 60)
                                end
                                g4.Scale = g4.Scale - g6 / fY
                                SetTween(g4, {Scale = fQ}, "Linear", "InOut", fY / 60)
                                if fP == "Wave" then
                                    SetTween(g4, {Offset = VT(0, 0, -g4.Scale.X / 8)}, "Linear", "InOut", fY / 60)
                                end
                                for g9 = 1, fY + 1 do
                                    wait(.05)
                                    if fP == "Block" then
                                    else
                                    end
                                    if fT ~= nil then
                                        local g8 = g3.Orientation
                                    end
                                end
                                game:GetService("Debris"):AddItem(g3, 15)
                                if g1 == false then
                                    g3:remove()
                                else
                                    g2.Stopped:Connect(
                                        function()
                                            g3:remove()
                                        end
                                    )
                                end
                            else
                                if g1 == false then
                                    g3:remove()
                                else
                                    repeat
                                        wait()
                                    until g2.Playing == false
                                    g3:remove()
                                end
                            end
                        end
                    )
                )
            end
            function CreatePart(ed, ee, ef, eg, eh, ei, k)
                local Part =
                    Create("Part") {
                    Parent = ed,
                    Reflectance = ef,
                    Transparency = eg,
                    CanCollide = false,
                    Locked = true,
                    BrickColor = BrickColor.new(tostring(eh)),
                    Name = ei,
                    Size = k,
                    Material = ee
                }
                RemoveOutlines(Part)
                return Part
            end
            local ga =
                Create("ParticleEmitter") {
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(170 / 255, 255 / 255, 255 / 255)),
                Transparency = NumberSequence.new(
                    {
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(.75, .4),
                        NumberSequenceKeypoint.new(1, 1)
                    }
                ),
                Size = NumberSequence.new({NumberSequenceKeypoint.new(0, .5), NumberSequenceKeypoint.new(1, .0)}),
                Texture = "rbxassetid://241922778",
                Lifetime = NumberRange.new(0.55, 0.95),
                Rate = 100,
                VelocitySpread = 180,
                Rotation = NumberRange.new(0),
                RotSpeed = NumberRange.new(-200, 200),
                Speed = NumberRange.new(8.0),
                LightEmission = 1,
                LockedToPart = false,
                Acceleration = Vector3.new(0, 0, 0),
                EmissionDirection = "Top",
                Drag = 4,
                Enabled = false
            }
            local gb =
                Create("ParticleEmitter") {
                Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(1, 1, 1)),
                Transparency = NumberSequence.new(
                    {
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.1, 0),
                        NumberSequenceKeypoint.new(0.3, 0),
                        NumberSequenceKeypoint.new(0.5, .2),
                        NumberSequenceKeypoint.new(1, 1)
                    }
                ),
                Size = NumberSequence.new(
                    {
                        NumberSequenceKeypoint.new(0, 0),
                        NumberSequenceKeypoint.new(.15, 1.5),
                        NumberSequenceKeypoint.new(.75, 1.5),
                        NumberSequenceKeypoint.new(1, 0)
                    }
                ),
                Texture = "rbxassetid://936193661",
                Lifetime = NumberRange.new(1.5),
                Rate = 100,
                VelocitySpread = 0,
                Rotation = NumberRange.new(0),
                RotSpeed = NumberRange.new(-10, 10),
                Speed = NumberRange.new(0),
                LightEmission = .25,
                LockedToPart = true,
                Acceleration = Vector3.new(0, -0, 0),
                EmissionDirection = "Top",
                Drag = 4,
                ZOffset = 1,
                Enabled = false
            }
            Damagefunc = function(Part, hit, gc, gd, ge, gf, gg, Delay, gh, gi)
                if hit.Parent == nil then
                    return
                end
                local h = hit.Parent:FindFirstChildOfClass("Torso")
                for U, v in pairs(hit.Parent:children()) do
                    if v:IsA("Torso") then
                        if h.Health > 0.0001 then
                            h = v
                        else
                        end
                    end
                end
                if h == nil then
                    return
                elseif h ~= nil and h.Health < 0.001 then
                    return
                elseif h ~= nil and h.Parent:FindFirstChild("Fly away") then
                    return
                end
                coroutine.resume(
                    coroutine.create(
                        function()
                            if
                                h.Health > 9999999 and gc < 9999 and gf ~= "IgnoreType" and
                                    (h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")) and
                                    not h.Parent:FindFirstChild("Fly away")
                             then
                                local gj = Instance.new("Model", h.Parent)
                                gj.Name = "Fly away"
                                game:GetService("Debris"):AddItem(gj, 2.5)
                                for U, v in pairs(h.Parent:children()) do
                                    if v:IsA("BasePart") and v.Parent:FindFirstChildOfClass("Humanoid") then
                                        v.Anchored = true
                                    end
                                end
                                wait(.25)
                                if h.Parent:FindFirstChildOfClass("Body Colors") then
                                    h.Parent:FindFirstChildOfClass("Body Colors"):Destroy()
                                end
                                local gk = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
                                coroutine.resume(
                                    coroutine.create(
                                        function()
                                            local gl = Instance.new("Part")
                                            gl.Reflectance = 0
                                            gl.Transparency = 1
                                            gl.CanCollide = false
                                            gl.Locked = true
                                            gl.Anchored = true
                                            gl.BrickColor = BrickColor.new("Really blue")
                                            gl.Name = "YourGone"
                                            gl.Size = Vector3.new()
                                            gl.Material = "SmoothPlastic"
                                            gl:BreakJoints()
                                            gl.Parent = gk
                                            gl.CFrame = gk.CFrame
                                            local gm = Instance.new("ParticleEmitter")
                                            gm.Parent = gl
                                            gm.Acceleration = Vector3.new(0, 0, 0)
                                            gm.Size =
                                                NumberSequence.new(
                                                {NumberSequenceKeypoint.new(0, 10), NumberSequenceKeypoint.new(1, .0)}
                                            )
                                            gm.Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 0, 0))
                                            gm.Lifetime = NumberRange.new(0.55, 0.95)
                                            gm.Transparency =
                                                NumberSequence.new(
                                                {
                                                    NumberSequenceKeypoint.new(0, 1),
                                                    NumberSequenceKeypoint.new(.25, .0),
                                                    NumberSequenceKeypoint.new(1, 1)
                                                }
                                            )
                                            gm.Speed = NumberRange.new(0, 0.0)
                                            gm.ZOffset = 2
                                            gm.Texture = "rbxassetid://243660364"
                                            gm.RotSpeed = NumberRange.new(-0, 0)
                                            gm.Rotation = NumberRange.new(-180, 180)
                                            gm.Enabled = false
                                            game:GetService("Debris"):AddItem(gl, 3)
                                            for T = 0, 2, 1 do
                                                gm:Emit(1)
                                                so("1448044156", gk, 2, 1)
                                                h.Parent:BreakJoints()
                                                gl.CFrame = gk.CFrame
                                                for U, v in pairs(h.Parent:children()) do
                                                    if v:IsA("BasePart") and v.Parent:FindFirstChildOfClass("Humanoid") then
                                                        v.Anchored = false
                                                        if v:FindFirstChildOfClass("SpecialMesh") then
                                                        end
                                                        if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
                                                        end
                                                        local gn =
                                                            Create("BodyVelocity")(
                                                            {
                                                                P = 500,
                                                                maxForce = Vector3.new(1000, 1000, 1000),
                                                                velocity = Vector3.new(
                                                                    math.random(-10, 10),
                                                                    4,
                                                                    math.random(-10, 10)
                                                                )
                                                            }
                                                        )
                                                        gn.Parent = v
                                                        game:GetService("Debris"):AddItem(
                                                            gn,
                                                            math.random(50, 100) / 1000
                                                        )
                                                    end
                                                end
                                                wait(.2)
                                            end
                                            wait(.1)
                                            gm:Emit(3)
                                            so("1448044156", gk, 2, .8)
                                            h.Parent:BreakJoints()
                                            gl.CFrame = gk.CFrame
                                            for U, v in pairs(h.Parent:children()) do
                                                if v:IsA("BasePart") and v.Parent:FindFirstChildOfClass("Humanoid") then
                                                    v.Anchored = false
                                                    if v:FindFirstChildOfClass("SpecialMesh") then
                                                    end
                                                    if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
                                                    end
                                                    local gn =
                                                        Create("BodyVelocity")(
                                                        {
                                                            P = 500,
                                                            maxForce = Vector3.new(1000, 1000, 1000),
                                                            velocity = Vector3.new(
                                                                math.random(-10, 10),
                                                                4,
                                                                math.random(-10, 10)
                                                            )
                                                        }
                                                    )
                                                    gn.Parent = v
                                                    game:GetService("Debris"):AddItem(gn, math.random(100, 200) / 1000)
                                                end
                                            end
                                        end
                                    )
                                )
                                wait(.1)
                            end
                        end
                    )
                )
                if
                    h ~= nil and hit.Parent ~= Character and hit.Parent:FindFirstChild("Torso") or
                        hit.Parent:FindFirstChild("UpperTorso") ~= nil
                 then
                    if hit.Parent:findFirstChild("DebounceHit") ~= nil and hit.Parent.DebounceHit.Value == true then
                        return
                    end
                    local c =
                        Create("ObjectValue")(
                        {Name = "creator", Value = game:service("Players").LocalPlayer, Parent = h}
                    )
                    game:GetService("Debris"):AddItem(c, 0.5)
                    if gh ~= nil and gi ~= nil then
                        so(gh, hit, 1, gi)
                    end
                    local Damage = math.random(gc, gd)
                    local go = false
                    local gq = hit.Parent:findFirstChild("Block")
                    if gq ~= nil and gq.className == "IntValue" and gq.Value > 0 then
                        go = true
                        gq.Value = gq.Value - 1
                        print(gq.Value)
                    end
                    if go == false then
                        h.Health = h.Health - Damage
                        ShowDamage(
                            Part.CFrame * CFrame.new(0, 0, Part.Size.Z / 2).p + Vector3.new(0, 1.5, 0),
                            -Damage,
                            1.5,
                            Color3.new(0, 0, 0)
                        )
                    else
                        h.Health = h.Health - Damage / 2
                        ShowDamage(
                            Part.CFrame * CFrame.new(0, 0, Part.Size.Z / 2).p + Vector3.new(0, 1.5, 0),
                            -Damage,
                            1.5,
                            Color3.new(0, 0, 0)
                        )
                    end
                    if gf == "Knockdown" then
                        local hum = h
                        hum.PlatformStand = true
                        coroutine.resume(
                            coroutine.create(
                                function(gr)
                                    wait(.2)
                                    gr.PlatformStand = false
                                end
                            ),
                            hum
                        )
                        local gk = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
                        local gs = hit.Position - (gg.Position + Vector3.new(0, 0, 0)).unit
                        local gt =
                            Create("BodyVelocity")(
                            {
                                P = 500,
                                maxForce = Vector3.new(math.huge, 0, math.huge),
                                velocity = CFrame.new(Part.Position, gk.Position).lookVector * ge,
                                Parent = hit
                            }
                        )
                        local gu =
                            Create("BodyAngularVelocity")(
                            {
                                P = 3000,
                                maxTorque = Vector3.new(5000, 5000, 5000) * 5,
                                angularvelocity = Vector3.new(
                                    math.random(-10, 10),
                                    math.random(-10, 10),
                                    math.random(-10, 10)
                                ),
                                Parent = hit
                            }
                        )
                        game:GetService("Debris"):AddItem(gt, 2)
                        game:GetService("Debris"):AddItem(gu, 0.125)
                    elseif gf == "Knockdown2" then
                        local hum = h
                        hum.PlatformStand = true
                        coroutine.resume(
                            coroutine.create(
                                function(gr)
                                    Combo = 1
                                    wait(.2)
                                    gr.PlatformStand = false
                                end
                            ),
                            hum
                        )
                        local gs = hit.Position - (gg.Position + Vector3.new(0, 0, 0)).unit
                        local gt =
                            Create("BodyVelocity")(
                            {
                                P = 500,
                                maxForce = Vector3.new(math.huge, 0, math.huge),
                                velocity = CFrame.new(Part.Position, gg.Position).lookVector * ge
                            }
                        )
                        local gu =
                            Create("BodyAngularVelocity")(
                            {
                                P = 3000,
                                maxTorque = Vector3.new(5000, 5000, 5000) * 50,
                                angularvelocity = Vector3.new(
                                    math.random(-10, 10),
                                    math.random(-10, 10),
                                    math.random(-10, 10)
                                ),
                                Parent = hit
                            }
                        )
                        game:GetService("Debris"):AddItem(gt, 0.2)
                        game:GetService("Debris"):AddItem(gu, 0.2)
                        local gv =
                            Create("BodyVelocity")(
                            {
                                velocity = Vector3.new(0, 60, 0),
                                P = 5000,
                                maxForce = Vector3.new(8000, 12000, 8000),
                                Parent = RootPart
                            }
                        )
                        game:GetService("Debris"):AddItem(gv, 0.1)
                    elseif gf == "Normal" then
                        local gk = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
                        local gs = hit.Position - (gg.Position + Vector3.new(0, 0, 0)).unit
                        local gt =
                            Create("BodyVelocity")(
                            {
                                P = 500,
                                maxForce = Vector3.new(math.huge, 0, math.huge),
                                velocity = CFrame.new(Part.Position, gk.Position).lookVector * ge,
                                Parent = hit
                            }
                        )
                        game:GetService("Debris"):AddItem(gt, .1)
                    elseif gf == "Fire" then
                        local gw = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")
                        local kW = 0
                        for U, eM in next, gw:GetChildren() do
                            if eM:IsA("Folder") and eM.Name == "OnFire" then
                                kW = kW + 1
                            end
                        end
                        if kW < 2 then
                            local kX = EffectPack.FireEffect:Clone()
                            local kY = Instance.new("Folder", gw)
                            kY.Name = "OnFire"
                            game:GetService("Debris"):AddItem(kY, 4.5)
                            for U, v in next, kX:GetDescendants() do
                                if v:IsA("ParticleEmitter") or v:IsA("SpotLight") then
                                    game:GetService("Debris"):AddItem(v, 5)
                                    v.Parent = gw
                                    coroutine.resume(
                                        coroutine.create(
                                            function()
                                                for T = 1, 35 do
                                                    coroutine.resume(
                                                        coroutine.create(
                                                            function()
                                                                v:Emit(2)
                                                            end
                                                        )
                                                    )
                                                    coroutine.resume(
                                                        coroutine.create(
                                                            function()
                                                                Damagefunc(
                                                                    gw,
                                                                    gw,
                                                                    4 / 2,
                                                                    6 / 2,
                                                                    0,
                                                                    "Normal",
                                                                    RootPart,
                                                                    0.1,
                                                                    "1273118342",
                                                                    math.random(10, 30) / 10
                                                                )
                                                            end
                                                        )
                                                    )
                                                    if
                                                        gw.Parent:FindFirstChildOfClass("Humanoid") and
                                                            gw.Parent:FindFirstChildOfClass("Humanoid").Health > .01
                                                     then
                                                    else
                                                        for U, eM in next, gw.Parent:GetDescendants() do
                                                            if eM:isA("BasePart") then
                                                                SetTween(eM, {Color = C3(0, 0, 0)}, "Quad", "Out", .5)
                                                            end
                                                        end
                                                        break
                                                    end
                                                    wait(.1)
                                                end
                                            end
                                        )
                                    )
                                end
                            end
                            kX:Destroy()
                        else
                        end
                    elseif gf == "Instakill" then
                        coroutine.resume(
                            coroutine.create(
                                function()
                                    if
                                        (h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")) and
                                            not h.Parent:FindFirstChild("Fly away")
                                     then
                                        local gj = Instance.new("Model", h.Parent)
                                        gj.Name = "Fly away"
                                        game:GetService("Debris"):AddItem(gj, 2.5)
                                        for U, v in pairs(h.Parent:children()) do
                                            if v:IsA("BasePart") and v.Parent:FindFirstChildOfClass("Humanoid") then
                                                v.Anchored = true
                                            end
                                        end
                                        wait(.25)
                                        if h.Parent:FindFirstChildOfClass("Body Colors") then
                                            h.Parent:FindFirstChildOfClass("Body Colors"):Destroy()
                                        end
                                        local gk =
                                            h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
                                        coroutine.resume(
                                            coroutine.create(
                                                function()
                                                    local gl = Instance.new("Part")
                                                    gl.Reflectance = 0
                                                    gl.Transparency = 1
                                                    gl.CanCollide = false
                                                    gl.Locked = true
                                                    gl.Anchored = true
                                                    gl.BrickColor = BrickColor.new("Really blue")
                                                    gl.Name = "YourGone"
                                                    gl.Size = Vector3.new()
                                                    gl.Material = "SmoothPlastic"
                                                    gl:BreakJoints()
                                                    gl.Parent = gk
                                                    gl.CFrame = gk.CFrame
                                                    local gm = Instance.new("ParticleEmitter")
                                                    gm.Parent = gl
                                                    gm.Acceleration = Vector3.new(0, 0, 0)
                                                    gm.Size =
                                                        NumberSequence.new(
                                                        {
                                                            NumberSequenceKeypoint.new(0, 10),
                                                            NumberSequenceKeypoint.new(1, .0)
                                                        }
                                                    )
                                                    gm.Color =
                                                        ColorSequence.new(Color3.new(1, 0, 0), Color3.new(1, 0, 0))
                                                    gm.Lifetime = NumberRange.new(0.55, 0.95)
                                                    gm.Transparency =
                                                        NumberSequence.new(
                                                        {
                                                            NumberSequenceKeypoint.new(0, 1),
                                                            NumberSequenceKeypoint.new(.25, .0),
                                                            NumberSequenceKeypoint.new(1, 1)
                                                        }
                                                    )
                                                    gm.Speed = NumberRange.new(0, 0.0)
                                                    gm.ZOffset = 2
                                                    gm.Texture = "rbxassetid://243660364"
                                                    gm.RotSpeed = NumberRange.new(-0, 0)
                                                    gm.Rotation = NumberRange.new(-180, 180)
                                                    gm.Enabled = false
                                                    game:GetService("Debris"):AddItem(gl, 3)
                                                    for T = 0, 2, 1 do
                                                        gm:Emit(1)
                                                        so("1448044156", gk, 2, 1)
                                                        h.Parent:BreakJoints()
                                                        gl.CFrame = gk.CFrame
                                                        for U, v in pairs(h.Parent:children()) do
                                                            if
                                                                v:IsA("BasePart") and
                                                                    v.Parent:FindFirstChildOfClass("Humanoid")
                                                             then
                                                                v.Anchored = false
                                                                if v:FindFirstChildOfClass("SpecialMesh") then
                                                                end
                                                                if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
                                                                end
                                                                local gn =
                                                                    Create("BodyVelocity")(
                                                                    {
                                                                        P = 500,
                                                                        maxForce = Vector3.new(1000, 1000, 1000),
                                                                        velocity = Vector3.new(
                                                                            math.random(-10, 10),
                                                                            4,
                                                                            math.random(-10, 10)
                                                                        )
                                                                    }
                                                                )
                                                                gn.Parent = v
                                                                game:GetService("Debris"):AddItem(
                                                                    gn,
                                                                    math.random(50, 100) / 1000
                                                                )
                                                            end
                                                        end
                                                        wait(.2)
                                                    end
                                                    wait(.1)
                                                    gm:Emit(3)
                                                    so("1448044156", gk, 2, .8)
                                                    h.Parent:BreakJoints()
                                                    gl.CFrame = gk.CFrame
                                                    for U, v in pairs(h.Parent:children()) do
                                                        if
                                                            v:IsA("BasePart") and
                                                                v.Parent:FindFirstChildOfClass("Humanoid")
                                                         then
                                                            v.Anchored = false
                                                            if v:FindFirstChildOfClass("SpecialMesh") then
                                                            end
                                                            if v:FindFirstChildOfClass("Decal") and v.Name == "face" then
                                                            end
                                                            local gn =
                                                                Create("BodyVelocity")(
                                                                {
                                                                    P = 500,
                                                                    maxForce = Vector3.new(1000, 1000, 1000),
                                                                    velocity = Vector3.new(
                                                                        math.random(-10, 10),
                                                                        4,
                                                                        math.random(-10, 10)
                                                                    )
                                                                }
                                                            )
                                                            gn.Parent = v
                                                            game:GetService("Debris"):AddItem(
                                                                gn,
                                                                math.random(100, 200) / 1000
                                                            )
                                                        end
                                                    end
                                                end
                                            )
                                        )
                                        wait(.1)
                                    end
                                end
                            )
                        )
                    elseif gf == "HPSteal" then
                        Humanoid.Health = Humanoid.Health + Damage
                        local hum = h
                        hum.PlatformStand = true
                        coroutine.resume(
                            coroutine.create(
                                function(gr)
                                    Combo = 1
                                    wait(.2)
                                    gr.PlatformStand = false
                                end
                            ),
                            hum
                        )
                        local gs = hit.Position - (gg.Position + Vector3.new(0, 0, 0)).unit
                        local gt =
                            Create("BodyVelocity")(
                            {
                                P = 500,
                                maxForce = Vector3.new(math.huge, 0, math.huge),
                                velocity = CFrame.new(Part.Position, gg.Position).lookVector * ge
                            }
                        )
                        local gu =
                            Create("BodyAngularVelocity")(
                            {
                                P = 3000,
                                maxTorque = Vector3.new(5000, 5000, 5000) * 50,
                                angularvelocity = Vector3.new(
                                    math.random(-10, 10),
                                    math.random(-10, 10),
                                    math.random(-10, 10)
                                ),
                                Parent = hit
                            }
                        )
                        game:GetService("Debris"):AddItem(gt, 0.2)
                        game:GetService("Debris"):AddItem(gu, 0.2)
                        local gv =
                            Create("BodyVelocity")(
                            {
                                velocity = Vector3.new(0, 60, 0),
                                P = 5000,
                                maxForce = Vector3.new(8000, 12000, 8000),
                                Parent = RootPart
                            }
                        )
                        game:GetService("Debris"):AddItem(gv, 0.1)
                    elseif gf == "Impale" then
                        CFuncs.Sound.Create("http://www.roblox.com/asset/?id=268249319", Spike, .8, 2)
                        hit.Parent.Humanoid.PlatformStand = true
                        wait(1)
                        hit.Parent.Humanoid.PlatformStand = false
                    elseif gf == "IgnoreType" then
                    elseif gf == "Up" then
                        local gx =
                            Create("BodyVelocity")(
                            {
                                velocity = Vector3.new(0, 20, 0),
                                P = 5000,
                                maxForce = Vector3.new(8000, 8000, 8000),
                                Parent = hit
                            }
                        )
                        game:GetService("Debris"):AddItem(gx, 0.1)
                        local gx =
                            Create("BodyVelocity")(
                            {
                                velocity = Vector3.new(0, 20, 0),
                                P = 5000,
                                maxForce = Vector3.new(8000, 8000, 8000),
                                Parent = hit
                            }
                        )
                        game:GetService("Debris"):AddItem(gx, .1)
                    elseif gf == "Snare" then
                        local gy =
                            Create("BodyPosition")(
                            {
                                P = 900,
                                D = 1000,
                                maxForce = Vector3.new(math.huge, math.huge, math.huge),
                                position = hit.Parent.Torso.Position,
                                Parent = h.Parent:FindFirstChild("Torso") or h.Parent:FindFirstChild("UpperTorso")
                            }
                        )
                        game:GetService("Debris"):AddItem(gy, 1)
                    elseif gf == "Freeze2" then
                        local gz =
                            Create("BodyPosition")(
                            {
                                P = 50000,
                                D = 1000,
                                maxForce = Vector3.new(math.huge, math.huge, math.huge),
                                position = hit.Parent.Torso.Position,
                                Parent = hit.Parent.Torso
                            }
                        )
                        local gA =
                            Create("BodyGyro")(
                            {
                                maxTorque = Vector3.new(400000, 400000, 400000) * math.huge,
                                P = 20000,
                                Parent = hit.Parent.Torso,
                                cframe = hit.Parent.Torso.CFrame
                            }
                        )
                        hit.Parent.Torso.Anchored = true
                        coroutine.resume(
                            coroutine.create(
                                function(Part)
                                    wait(1.5)
                                    Part.Anchored = false
                                end
                            ),
                            hit.Parent.Torso
                        )
                        game:GetService("Debris"):AddItem(gz, 3)
                        game:GetService("Debris"):AddItem(gA, 3)
                    end
                    local gB = Create("BoolValue")({Name = "DebounceHit", Parent = hit.Parent, Value = true})
                    game:GetService("Debris"):AddItem(gB, Delay)
                    c = Instance.new("ObjectValue")
                    c.Name = "creator"
                    c.Value = Player
                    c.Parent = h
                    game:GetService("Debris"):AddItem(c, 0.5)
                end
            end
            ShowDamage = function(eS, gC, gD, Color)
                local eE = 0.033333333333333
                if not eS then
                    local eS = Vector3.new(0, 0, 0)
                end
                local gC = gC or ""
                local gD = gD or 2
                if not Color then
                    local Color = Color3.new(1, 0, 1)
                end
                local gE =
                    CreatePart(workspace, "SmoothPlastic", 0, 1, BrickColor.new(Color), "Effect", Vector3.new(0, 0, 0))
                gE.Anchored = true
                local gF = Create("BillboardGui")({Size = UDim2.new(2, 0, 2, 0), Adornee = gE, Parent = gE})
                local gG =
                    Create("TextLabel")(
                    {
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 1, 0),
                        Text = "DMG: " .. gC .. "",
                        TextColor3 = Color,
                        TextScaled = true,
                        Font = Enum.Font.ArialBold,
                        Parent = gF
                    }
                )
                gG.TextTransparency = 1
                game.Debris:AddItem(gE, gD + 0.1)
                gE.Parent = game:GetService("Workspace")
                delay(
                    0,
                    function()
                        local gH = gD / eE
                        gE.CFrame = CFrame.new(eS)
                        wait()
                        gG.TextTransparency = 0
                        SetTween(gG, {TextTransparency = 1}, "Quad", "In", gH / 60)
                        SetTween(gG, {Rotation = math.random(-25, 25)}, "Elastic", "InOut", gH / 60)
                        SetTween(gG, {TextColor3 = Color3.new(1, 0, 0)}, "Elastic", "InOut", gH / 60)
                        SetTween(
                            gE,
                            {
                                CFrame = CFrame.new(eS) +
                                    Vector3.new(math.random(-5, 5), math.random(1, 5), math.random(-5, 5))
                            },
                            "Linear",
                            "InOut",
                            gH / 60
                        )
                        wait(gH / 60)
                        if gE and gE.Parent then
                            gE:Destroy()
                        end
                    end
                )
            end
            MagniDamage = function(Part, gI, gJ, gK, gL, gM)
                local gf = ""
                if mememode == true then
                    gf = "Instakill"
                else
                    gf = gM
                end
                if gM == "NormalKnockdown" then
                    gf = "Knockdown"
                end
                for U, c in pairs(workspace:children()) do
                    local hum = c:FindFirstChild("Humanoid")
                    for U, v in pairs(c:children()) do
                        if v:IsA("Humanoid") then
                            hum = v
                        end
                    end
                    if hum ~= nil then
                        local head = c:findFirstChild("Head")
                        if head ~= nil then
                            local gN = head.Position - Part.Position
                            local gO = gN.magnitude
                            if gO <= gI and c.Name ~= Player.Name then
                                Damagefunc(Part, head, gJ, gK, gL, gf, RootPart, 0.1, "851453784", 1.2)
                            end
                        end
                    end
                end
            end
            function CFMagniDamage(gP, gI, gJ, gK, gL, gf)
                local gQ = Instance.new("Part")
                gQ.Parent = Character
                gQ.Size = Vector3.new(0.05, 0.05, 0.05)
                gQ.Transparency = 1
                gQ.CanCollide = false
                gQ.Anchored = true
                RemoveOutlines(gQ)
                gQ.Position = gQ.Position + Vector3.new(0, -.1, 0)
                gQ.CFrame = gP
                coroutine.resume(
                    coroutine.create(
                        function()
                            MagniDamage(gQ, gI, gJ, gK, gL, gf)
                        end
                    )
                )
                game:GetService("Debris"):AddItem(gQ, .05)
                gQ.Archivable = false
            end
            function BulletHitEffectSpawn(gZ, g_)
                local h0 = Instance.new("Part", Effects)
                h0.Reflectance = 0
                h0.Transparency = 1
                h0.CanCollide = false
                h0.Locked = true
                h0.Anchored = true
                h0.BrickColor = BrickColor.new("Bright green")
                h0.Name = "Bullet"
                h0.Size = Vector3.new(.05, .05, .05)
                h0.Material = "Neon"
                h0:BreakJoints()
                h0.CFrame = gZ
                local h1 = Instance.new("Attachment", h0)
                game:GetService("Debris"):AddItem(h0, 15)
                if g_ == "Explode" then
                    h1.Orientation = Vector3.new(90, 0, 0)
                    local h3 = EffectPack.Bang2:Clone()
                    h3.Parent = h0
                    h3:Emit(150)
                    local h4 = EffectPack.Bang1:Clone()
                    h4.Parent = h0
                    h4:Emit(25)
                    local h5 = EffectPack.Bang3:Clone()
                    h5.Parent = h0
                    h5:Emit(185)
                    game:GetService("Debris"):AddItem(h0, 2)
                end
                if g_ == "Spark" then
                    h1.Orientation = Vector3.new(90, 0, 0)
                    local h3 = EffectPack.Spark:Clone()
                    h3.Parent = h0
                    h3:Emit(1)
                    game:GetService("Debris"):AddItem(h0, 2)
                end
                if g_ == "ShockWave" then
                    h1.Orientation = Vector3.new(90, 0, 0)
                    local h3 = EffectPack.ShockWave1:Clone()
                    h3.Parent = h0
                    h3:Emit(0)
                    local h4 = EffectPack.ShockWave2:Clone()
                    h4.Parent = h0
                    h4:Emit(2)
                    game:GetService("Debris"):AddItem(h0, 2)
                end
                if g_ == "Nuke" then
                    so(923073285, h0, 8, 2)
                    h1.Orientation = Vector3.new(0, 0, 0)
                    local kZ = Instance.new("Attachment", h0)
                    kZ.Orientation = Vector3.new(0, 0, 0)
                    local h3 = EffectPack.Nuke_Flash:Clone()
                    h3.Parent = h1
                    h3:Emit(20)
                    local h4 = EffectPack.Nuke_Smoke:Clone()
                    h4.Parent = kZ
                    h4.Enabled = true
                    coroutine.resume(
                        coroutine.create(
                            function()
                                for T = 0, 2, .025 / 1.5 do
                                    h4.Transparency =
                                        NumberSequence.new(
                                        {
                                            NumberSequenceKeypoint.new(0, 1),
                                            NumberSequenceKeypoint.new(.15, .5 + T / 4),
                                            NumberSequenceKeypoint.new(.95, .5 + T / 4),
                                            NumberSequenceKeypoint.new(1, 1)
                                        }
                                    )
                                    Swait()
                                end
                                h4.Transparency =
                                    NumberSequence.new(
                                    {NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1)}
                                )
                                h4.Enabled = false
                            end
                        )
                    )
                    local h5 = EffectPack.Nuke_Wave:Clone()
                    h5.Parent = h1
                    h5:Emit(185)
                    game:GetService("Debris"):AddItem(h1, 10)
                end
            end
            local hI = weld(dT.Parent, dT.Part0, dT.Part1, dT.C0)
            hI.C1 = dT.C1
            hI.Name = dT.Name
            local hJ = weld(Neck.Parent, Neck.Part0, Neck.Part1, Neck.C0)
            hJ.C1 = Neck.C1
            hJ.Name = Neck.Name
            local RW = weld(Torso, Torso, RightArm, cf(0, 0, 0))
            local LW = weld(Torso, Torso, LeftArm, cf(0, 0, 0))
            local RH = weld(Torso, Torso, RightLeg, cf(0, 0, 0))
            local LH = weld(Torso, Torso, LeftLeg, cf(0, 0, 0))
            RW.C1 = cn(0, 0.5, 0)
            LW.C1 = cn(0, 0.5, 0)
            RH.C1 = cn(0, 1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
            LH.C1 = cn(0, 1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
            SetTween(hI, {C0 = RootCF * CFrame.new(0, 0, 0)}, "Quad", "InOut", 0.1)
            SetTween(hJ, {C0 = NeckCF * CFrame.new(0, 0, 0)}, "Quad", "InOut", 0.1)
            SetTween(RW, {C0 = CFrame.new(1.5, 0.5, -.0)}, "Quad", "InOut", 0.1)
            SetTween(LW, {C0 = CFrame.new(-1.5, 0.5, -.0)}, "Quad", "InOut", 0.1)
            SetTween(RH, {C0 = CFrame.new(.5, -0.90, 0)}, "Quad", "InOut", 0.1)
            SetTween(LH, {C0 = CFrame.new(-.5, -0.90, 0)}, "Quad", "InOut", 0.1)
            function AT1()
                dS = true
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(20), math.rad(0), math.rad(-40))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(40))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(30), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(30), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -.6, -.4) * angles(math.rad(-20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(20), math.rad(0), math.rad(20))},
                    "Quad",
                    "InOut",
                    0.2
                )
                wait(.2 / f2)
                CFMagniDamage(RootPart.CFrame * CF(0, -1, -1), 7, 10, 20, 20, "Normal")
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, -1, 0) * angles(math.rad(-40), math.rad(0), math.rad(40))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-40))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(-30), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(-30), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(120), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(-60), math.rad(0), math.rad(-20))},
                    "Back",
                    "Out",
                    0.2
                )
                wait(.2 / f2)
                dS = false
            end
            function AT2()
                dS = true
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(-20), math.rad(0), math.rad(60))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-60))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(90), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -.5, -.4) * angles(math.rad(-20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(-20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                CFMagniDamage(RootPart.CFrame * CF(0, -0, -1), 9, 10, 15, 0, "Normal")
                wait(.2 / f2)
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, -1, 0) * angles(math.rad(0), math.rad(0), math.rad(-70))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(70))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(-20), math.rad(-90))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, -0) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(-20), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                wait(.2 / f2)
                dS = false
            end
            function AT3()
                dS = true
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(-20), math.rad(0), math.rad(120))},
                    "Quad",
                    "In",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-80))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(90), math.rad(0), math.rad(20))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(20), math.rad(-0), math.rad(-0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, -0) * angles(math.rad(-20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -.8, 0) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                wait(.2 / f2)
                CFMagniDamage(RootPart.CFrame * CF(-2, -.25, -1), 9, 20, 30, 10, "Knockdown")
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, -1, 0) * angles(math.rad(20), math.rad(0), math.rad(-0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(90))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(20), math.rad(-0), math.rad(-0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, -0) * angles(math.rad(-40), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                wait(.2 / f2)
                dS = false
            end
            function AT4()
                dS = true
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(-20), math.rad(0), math.rad(-80))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(20), math.rad(0), math.rad(80))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(-20), math.rad(-70), math.rad(-90))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, -.0) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -.5, -0.4) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                CFMagniDamage(RootPart.CFrame * CF(0, -0, -1), 9, 30, 45, 0, "Normal")
                so("3051417237", LeftArm, 3, math.random(100, 155) / 100)
                wait(0.2 / f2)
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, -1, 0) * angles(math.rad(20), math.rad(0), math.rad(45))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(-20), math.rad(0), math.rad(-45))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(-0), math.rad(-90))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, -0) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(-10), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                wait(.2 / f2)
                dS = false
            end
            function AT5()
                dS = true
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(-20), math.rad(0), math.rad(80))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(20), math.rad(0), math.rad(-80))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(-20), math.rad(70), math.rad(90))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(-90))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -.5, -0.4) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, -0) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Quad",
                    "InOut",
                    0.2
                )
                CFMagniDamage(RootPart.CFrame * CF(0, -0, -1), 9, 30, 45, 0, "Normal")
                so("3051417237", RightArm, 3, math.random(100, 155) / 80)
                wait(0.2 / f2)
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, -1, 0) * angles(math.rad(20), math.rad(0), math.rad(-45))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(-20), math.rad(0), math.rad(45))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(90))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(-0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, -0) * angles(math.rad(-10), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                wait(.2 / f2)
                dS = false
            end
            function AT6()
                dS = true
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, -1, -.3) * angles(math.rad(45), math.rad(0), math.rad(0))},
                    "Quad",
                    "Out",
                    0.3
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(-20), math.rad(0), math.rad(0))},
                    "Quad",
                    "Out",
                    0.3
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.1, 0.5, -.3) * angles(math.rad(20), math.rad(115), math.rad(90))},
                    "Quad",
                    "In",
                    0.15
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.1, 0.5, -.3) * angles(math.rad(20), math.rad(-115), math.rad(-90))},
                    "Quad",
                    "In",
                    0.15
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(-60), math.rad(0), math.rad(0))},
                    "Quad",
                    "Out",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(60), math.rad(0), math.rad(0))},
                    "Quad",
                    "Out",
                    0.3
                )
                so("3051417237", Torso, 3, math.random(140, 185) / 80)
                CFMagniDamage(RootPart.CFrame * CF(-1.4, -0, -1), 9, 40, 55, 10, "Knockdown")
                CFMagniDamage(RootPart.CFrame * CF(1.4, -0, -1), 9, 40, 55, 10, "Knockdown")
                wait(0.175 / f2)
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, -1.7, -.4) * angles(math.rad(45), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(90))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(-90))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(65), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.2
                )
                wait(.2 / f2)
                dS = false
            end
            function AT7()
                dS = true
                local f2 = 1
                if dS == true and mememode == true then
                    f2 = 5
                end
                so("3051417237", Torso, 3, .8)
                coroutine.resume(
                    coroutine.create(
                        function()
                            for T = 1, 2 do
                                Swait(3)
                                so("3051417087", RightArm, 3, math.random(100, 155) / 100)
                            end
                        end
                    )
                )
                for T = 1, 10, 1 do
                    SetTween(
                        hI,
                        {
                            C0 = RootCF * CFrame.new(0, -1.7 + .17 * T, -.4) *
                                angles(math.rad(25 - 5 * T), math.rad(0), math.rad(36 * T))
                        },
                        "Quad",
                        "Out",
                        0.1
                    )
                    SetTween(
                        hJ,
                        {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                        "Quad",
                        "Out",
                        0.2
                    )
                    SetTween(
                        RW,
                        {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(180), math.rad(0), math.rad(90))},
                        "Quad",
                        "Out",
                        0.2
                    )
                    SetTween(
                        LW,
                        {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(-90))},
                        "Quad",
                        "Out",
                        0.2
                    )
                    SetTween(
                        RH,
                        {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(-25), math.rad(0), math.rad(0))},
                        "Quad",
                        "Out",
                        0.2
                    )
                    SetTween(
                        LH,
                        {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(25), math.rad(0), math.rad(0))},
                        "Quad",
                        "Out",
                        0.2
                    )
                    CFMagniDamage(RootPart.CFrame * CF(1.4, -0, -1 + .17 * T), 9, 10, 15, 10, "Knockdown")
                    Swait()
                end
                dS = false
            end
            function joke()
            end
            function Attack1()
                dS = true
                Humanoid.JumpPower = 0
                Humanoid.WalkSpeed = 0.1
                so("299058146", RightArm, 2, 2.5)
                SetTween(
                    hI,
                    {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(20), math.rad(0), math.rad(-20))},
                    "Back",
                    "Out",
                    0.6
                )
                SetTween(
                    hJ,
                    {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(20))},
                    "Back",
                    "Out",
                    0.6
                )
                SetTween(
                    RW,
                    {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(-10), math.rad(0), math.rad(20))},
                    "Back",
                    "Out",
                    0.6
                )
                SetTween(
                    LW,
                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(-20))},
                    "Back",
                    "Out",
                    0.6
                )
                SetTween(
                    RH,
                    {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(-20), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.6
                )
                SetTween(
                    LH,
                    {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(20), math.rad(0), math.rad(0))},
                    "Back",
                    "Out",
                    0.6
                )
                Swait(.2 * 30)
                coroutine.resume(
                    coroutine.create(
                        function()
                            local h1 = Instance.new("Attachment", RightArm)
                            h1.Orientation = Vector3.new(0, 0, 0)
                            h1.Position = Vector3.new(0, -1, 0)
                            local h3 = EffectPack.Spark:Clone()
                            h3.Parent = h1
                            h3:Emit(1)
                            game:GetService("Debris"):AddItem(h1, 2)
                        end
                    )
                )
                local k_ = Instance.new("Part")
                k_.Reflectance = 0
                k_.Transparency = 1
                k_.CanCollide = false
                k_.Locked = true
                k_.Anchored = false
                k_.BrickColor = BrickColor.new("Really blue")
                k_.Name = "BHandle"
                k_.Size = Vector3.new(2.5, 1, 2.5)
                k_.Material = "SmoothPlastic"
                k_:BreakJoints()
                k_.Parent = Effects
                k_.CFrame = RootPart.CFrame
                k_.Massless = false
                local l0 = weld(k_, RootPart, k_, cf(0, 0, -3) * angles(math.rad(0), math.rad(0), math.rad(0)))
                local l1 = false
                local function onTouch(l2)
                    if l1 == false then
                        local c = l2.Parent
                        local h = l2.Parent:FindFirstChild("Humanoid")
                        for U, v in pairs(l2.Parent:children()) do
                            if v:IsA("Humanoid") then
                                h = v
                            end
                        end
                        local head = c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
                        local l3 = c:FindFirstChild("Head")
                        if h ~= nil and head ~= nil and l3 ~= nil then
                            l1 = true
                            head.Anchored = true
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        k_:Destroy()
                                    end
                                )
                            )
                            local l4 = Instance.new("Part")
                            l4.Reflectance = 0
                            l4.Transparency = 1
                            l4.CanCollide = false
                            l4.Locked = true
                            l4.Anchored = true
                            l4.BrickColor = BrickColor.new("Really blue")
                            l4.Name = "FHandle"
                            l4.Size = Vector3.new(1, 1, 1)
                            l4.Material = "SmoothPlastic"
                            l4:BreakJoints()
                            l4.Parent = Effects
                            l4.CFrame = RootPart.CFrame
                            l4.Massless = false
                            local l5 = joint(l4, RootPart, l4, cf())
                            local l6 = 25 - 4.5 * 1
                            local h1 = Instance.new("Attachment", RightArm)
                            h1.Orientation = Vector3.new(0, 0, 0)
                            h1.Position = Vector3.new(0, -1, 0)
                            local h3 = EffectPack.UpperCutSmoke:Clone()
                            h3.Parent = h1
                            h3.Enabled = true
                            game:GetService("Debris"):AddItem(h1, 5)
                            so("231917750", Torso, 2, 0.9)
                            for T = 1, 10, 0.4 do
                                SetTween(
                                    hI,
                                    {
                                        C0 = RootCF * CFrame.new(-0.5 * math.sin(T), 0.5 * math.cos(T), 0) *
                                            angles(math.rad(25 - 4.5 * T), math.rad(0), math.rad(36 * T * 2))
                                    },
                                    "Quad",
                                    "InOut",
                                    0.05
                                )
                                SetTween(
                                    hJ,
                                    {
                                        C0 = NeckCF * CFrame.new(0, 0, 0) *
                                            angles(math.rad(20), math.rad(0), math.rad(-80))
                                    },
                                    "Quad",
                                    "InOut",
                                    0.15
                                )
                                SetTween(
                                    RW,
                                    {
                                        C0 = CFrame.new(1.5, 0.65, -.0) *
                                            angles(math.rad(160 + 2 * T), math.rad(0), math.rad(30 - 3 * T))
                                    },
                                    "Quad",
                                    "Out",
                                    0.15
                                )
                                SetTween(
                                    LW,
                                    {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                                    "Quad",
                                    "Out",
                                    0.15
                                )
                                SetTween(
                                    RH,
                                    {
                                        C0 = CFrame.new(.5, -1, 0) *
                                            angles(math.rad(0 + 6.5 * T), math.rad(0), math.rad(0))
                                    },
                                    "Quad",
                                    "InOut",
                                    0.15
                                )
                                SetTween(
                                    LH,
                                    {
                                        C0 = CFrame.new(-.5, -1, 0) *
                                            angles(math.rad(0 - 6.5 * T), math.rad(0), math.rad(0))
                                    },
                                    "Quad",
                                    "InOut",
                                    0.15
                                )
                                SetTween(
                                    head,
                                    {
                                        CFrame = RootPart.CFrame * CF(0, 0, -1) *
                                            angles(
                                                math.rad(math.random(-180, 180)),
                                                math.rad(math.random(-180, 180)),
                                                math.rad(math.random(-180, 180))
                                            )
                                    },
                                    "Quad",
                                    "InOut",
                                    0.05
                                )
                                SetTween(l5, {C0 = CFrame.new(0, -T * 2, T / 2)}, "Quad", "InOut", 0.05)
                                l6 = l6 + 75
                                if l6 > 180 then
                                    l6 = -180
                                    print(1)
                                end
                                if l6 > -45 and l6 < 45 then
                                    BulletHitEffectSpawn(head.CFrame, "ShockWave")
                                    so("471882019", head, 3, 2.5)
                                end
                                Swait()
                            end
                            h3.Enabled = false
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        local h1 = Instance.new("Attachment", RightArm)
                                        h1.Orientation = Vector3.new(0, 0, 0)
                                        h1.Position = Vector3.new(0, -1, 0)
                                        local h3 = EffectPack.Spark:Clone()
                                        h3.Parent = h1
                                        h3:Emit(1)
                                        game:GetService("Debris"):AddItem(h1, 2)
                                    end
                                )
                            )
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        local h1 = Instance.new("Attachment", LeftArm)
                                        h1.Orientation = Vector3.new(0, 0, 0)
                                        h1.Position = Vector3.new(0, -1, 0)
                                        local h3 = EffectPack.Spark:Clone()
                                        h3.Parent = h1
                                        h3:Emit(1)
                                        game:GetService("Debris"):AddItem(h1, 2)
                                    end
                                )
                            )
                            so("782353117", Torso, 2, 0.9)
                            so("588738949", RightArm, 3, math.random(90, 110) / 100)
                            so("588738949", LeftArm, 3, math.random(90, 110) / 100)
                            SetTween(
                                hI,
                                {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(-65), math.rad(0), math.rad(-0))},
                                "Back",
                                "Out",
                                0.3
                            )
                            SetTween(
                                hJ,
                                {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(65), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.3
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(90), math.rad(0), math.rad(90))},
                                "Back",
                                "Out",
                                0.3
                            )
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(90), math.rad(0), math.rad(-90))},
                                "Back",
                                "Out",
                                0.3
                            )
                            SetTween(
                                RH,
                                {C0 = CFrame.new(.5, -.7, -.2) * angles(math.rad(-40), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.3
                            )
                            SetTween(
                                LH,
                                {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(-30), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.3
                            )
                            SetTween(l5, {C0 = CFrame.new(0, -30, 5)}, "Back", "Out", 0.6)
                            for T = 1, 3 do
                                SetTween(
                                    head,
                                    {CFrame = RootPart.CFrame * CF(0, 0, -6) * angles(mr(0), mr(180), mr(0))},
                                    "Linear",
                                    "Out",
                                    0.1
                                )
                                Swait(0.1 * 30)
                            end
                            for T = 1, 2.5, .225 do
                                SetTween(
                                    hI,
                                    {
                                        C0 = RootCF * CFrame.new(0, 2 + -0.75 * T, 20 - 1.8 * T) *
                                            angles(math.rad(15 + 30 * T * 2), math.rad(0), math.rad(-0))
                                    },
                                    "Quad",
                                    "Out",
                                    0.2
                                )
                                SetTween(
                                    hJ,
                                    {
                                        C0 = NeckCF * CFrame.new(0, 0, 0) *
                                            angles(math.rad(-25), math.rad(0), math.rad(0))
                                    },
                                    "Quad",
                                    "Out",
                                    0.3
                                )
                                SetTween(
                                    RW,
                                    {
                                        C0 = CFrame.new(1.5, 0.5, -.0) *
                                            angles(math.rad(170), math.rad(0), math.rad(90 - 90 / 2.0 * T))
                                    },
                                    "Quad",
                                    "Out",
                                    0.2
                                )
                                SetTween(
                                    LW,
                                    {
                                        C0 = CFrame.new(-1.5, 0.5, -.0) *
                                            angles(math.rad(170), math.rad(0), math.rad(-90 + 90 / 2.0 * T))
                                    },
                                    "Quad",
                                    "Out",
                                    0.2
                                )
                                SetTween(
                                    RH,
                                    {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(40), math.rad(0), math.rad(0))},
                                    "Quad",
                                    "Out",
                                    0.3
                                )
                                SetTween(
                                    LH,
                                    {C0 = CFrame.new(-.5, -1, -0) * angles(math.rad(40), math.rad(0), math.rad(0))},
                                    "Quad",
                                    "Out",
                                    0.3
                                )
                                Swait()
                                SetTween(l5, {C0 = CFrame.new(0, -(20 - 1.8 * T), 13 - 1.2 * T)}, "Quad", "Out", 0.2)
                            end
                            so("231917750", Torso, 5, 0.9)
                            local kZ = Instance.new("Attachment", Torso)
                            kZ.Orientation = Vector3.new(0, 0, 0)
                            kZ.Position = Vector3.new(0, 0, 0)
                            local h4 = EffectPack.SmashSmoke:Clone()
                            h4.Parent = kZ
                            h4.Enabled = true
                            game:GetService("Debris"):AddItem(kZ, 7)
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        local l7 = c.Parent
                                        c.Parent = Effects
                                        local l8, l9, ih =
                                            rayCast(
                                            Torso.Position,
                                            CFrame.new(Torso.Position, (RootPart.CFrame * CF(0, -4, -10)).p).lookVector,
                                            54,
                                            Character
                                        )
                                        c.Parent = l7
                                        SetTween(
                                            head,
                                            {
                                                CFrame = cf(l9 - VT(0, 0, 0), Torso.Position) *
                                                    angles(mr(0), mr(180), mr(-45))
                                            },
                                            "Quad",
                                            "In",
                                            0.3
                                        )
                                        Swait(.3 * 30)
                                        so("231917744", head, 4, 1.25)
                                        BulletHitEffectSpawn(CF(l9, l9 + ih), "Explode")
                                    end
                                )
                            )
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        Swait(0.3 * 30)
                                        if c:FindFirstChild("UpperTorso") then
                                            local ragdoll = EffectPack.R15Ragdoll:Clone()
                                            ragdoll.Parent = c
                                            ragdoll.Disabled = false
                                        else
                                            local ragdoll = EffectPack.R6Ragdoll:Clone()
                                            ragdoll.Parent = c
                                            ragdoll.Disabled = false
                                        end
                                        c:BreakJoints()
                                        h.Health = 0
                                        head.Anchored = false
                                    end
                                )
                            )
                            SetTween(l5, {C0 = CFrame.new(0, 0, 27)}, "Quad", "In", 0.3)
                            SetTween(
                                hI,
                                {C0 = RootCF * CFrame.new(0, -0, -.5) * angles(math.rad(85), math.rad(0), math.rad(-0))},
                                "Quad",
                                "Out",
                                0.2
                            )
                            SetTween(
                                hJ,
                                {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(-65), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.2
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(130), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.2
                            )
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(130), math.rad(0), math.rad(-0))},
                                "Back",
                                "Out",
                                0.2
                            )
                            SetTween(
                                RH,
                                {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(-25), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.2
                            )
                            SetTween(
                                LH,
                                {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(-25), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.2
                            )
                            Swait(0.3 * 30)
                            h4.Enabled = false
                            SetTween(
                                hI,
                                {C0 = RootCF * CFrame.new(0, -0, 0) * angles(math.rad(-0), math.rad(0), math.rad(-0))},
                                "Quad",
                                "Out",
                                0.25
                            )
                            SetTween(
                                hJ,
                                {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(35), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.25
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(30), math.rad(0), math.rad(30))},
                                "Back",
                                "Out",
                                0.25
                            )
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(30), math.rad(0), math.rad(-30))},
                                "Back",
                                "Out",
                                0.25
                            )
                            SetTween(
                                RH,
                                {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(10), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.25
                            )
                            SetTween(
                                LH,
                                {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(-10), math.rad(0), math.rad(0))},
                                "Back",
                                "Out",
                                0.25
                            )
                            Swait(0.25 * 30)
                            l4:Destroy()
                            dS = false
                        end
                    end
                end
                local la = k_.Touched:connect(onTouch)
                Swait(.5 * 30)
                if k_.Parent == Effects then
                    la:disconnect()
                    k_:Destroy()
                    dS = false
                end
                while true do
                    Swait()
                    if dS == false then
                        break
                    end
                end
                print("aaaaaaaaaaaaaaaaaa")
                la:disconnect()
                Humanoid.JumpPower = 60
                Humanoid.WalkSpeed = 16
            end
            function Attack6()
                for T, v in pairs(GatherAllInstances(Effects)) do
                    if v.Name == "Zombie" then
                        v.Parent:Destroy()
                    end
                end
            end
            function ClickCombo()
                if N == "Fall" or N == "Jump" then
                    if Combo == 0 then
                    end
                else
                    if ke == false then
                        if Combo == 0 then
                            AT1()
                            Combo = 1
                        elseif Combo == 1 then
                            AT2()
                            Combo = 2
                        elseif Combo == 2 then
                            AT3()
                            Combo = 0
                        elseif Combo == 3 then
                            Combo = 0
                            ClickCombo()
                        end
                    else
                        if Combo == 0 then
                            AT4()
                            Combo = 1
                        elseif Combo == 1 then
                            AT5()
                            Combo = 2
                        elseif Combo == 2 then
                            AT6()
                            Combo = 3
                        elseif Combo == 3 then
                            AT7()
                            Combo = 0
                        end
                    end
                end
            end
            local lb = Instance.new("IntValue", nil)
            for T, v in pairs(Character.TorsoYes.Torso:GetChildren()) do
                if v:IsA("Part") and v.Name == "Chest" then
                    lb.Value = lb.Value + 1
                    v.Name = "Chest" .. lb.Value
                end
            end
            local Hold = false
            mouse.Button1Down:connect(
                function()
                    Hold = true
                    while Hold == true do
                        if dS == false then
                            ClickCombo()
                        else
                        end
                        Swait()
                    end
                end
            )
            mouse.Button1Up:connect(
                function()
                    if Hold == true then
                        Hold = false
                    end
                end
            )
            mouse.KeyUp:connect(
                function(dr)
                end
            )
            mouse.KeyDown:connect(
                function(dr)
                    if dr == "f" and dS == false and kf == false then
                        if ke == false then
                            SetTween(RCW, {C0 = CF(0, -.75, 0)}, "Quad", "Out", .5)
                            SetTween(LCW, {C0 = CF(0, -.75, 0)}, "Quad", "Out", .5)
                            ke = true
                            so("3051417649", RightArm, 1.5, .8)
                            so("3051417649", LeftArm, 1.5, .8)
                        else
                            SetTween(RCW, {C0 = CF(0, -0, 0)}, "Quad", "In", .5)
                            SetTween(LCW, {C0 = CF(0, -0, 0)}, "Quad", "In", .5)
                            ke = false
                            so("3051417791", RightArm, 1.5, .8)
                            so("3051417791", LeftArm, 1.5, .8)
                        end
                    end
                    if dr == "f" and dS == false and kf == true then
                        if ke == false then
                            SetTween(RCW, {C0 = CF(0, -.75, 0)}, "Quad", "Out", .5)
                            SetTween(LCW, {C0 = CF(0, -.75, 0)}, "Quad", "Out", .5)
                            ke = true
                            so("3051417649", RightArm, 1.5, .8)
                            so("3051417649", LeftArm, 1.5, .8)
                        else
                            SetTween(RCW, {C0 = CF(0, -0, 0)}, "Quad", "In", .5)
                            SetTween(LCW, {C0 = CF(0, -0, 0)}, "Quad", "In", .5)
                            ke = false
                            so("3051417791", RightArm, 1.5, .8)
                            so("3051417791", LeftArm, 1.5, .8)
                        end
                    end
                    if dr == "e" and dS == false then
                        dS = true
                        local lc = true
                        while lc == true do
                            SetTween(
                                hI,
                                {
                                    C0 = RootCF * CFrame.new(0, 0, -2.20) *
                                        angles(
                                            math.rad(75),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                hJ,
                                {
                                    C0 = NeckCF * CFrame.new(0, 0, 0) *
                                        angles(math.rad(-40), math.rad(15 * math.sin(dQ / 8)), math.rad(0))
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {
                                    C0 = CFrame.new(1.0, 0.5, -.4) *
                                        angles(
                                            math.rad(160),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(-50 + 5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "Out",
                                0.1
                            )
                            SetTween(
                                LW,
                                {
                                    C0 = CFrame.new(-1.0, 0.5, -.4) *
                                        angles(
                                            math.rad(160),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(40 + 5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "Out",
                                0.1
                            )
                            SetTween(
                                RH,
                                {
                                    C0 = CFrame.new(.5, -.9 - .1 * math.cos(dQ / 8), -.4 + .4 * math.cos(dQ / 8)) *
                                        angles(
                                            math.rad(-50 + 35 * math.cos(dQ / 8)),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(-15 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LH,
                                {
                                    C0 = CFrame.new(-.5, -.9 + .1 * math.cos(dQ / 8), -.4 - .4 * math.cos(dQ / 8)) *
                                        angles(
                                            math.rad(-50 - 35 * math.cos(dQ / 8)),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(-15 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                tailw,
                                {
                                    C0 = CF(-.2 * math.cos(dQ / 8), 0, .30 + .15 * math.sin(dQ / 4)) *
                                        ANGLES(
                                            mr(80 + 10 * math.sin(dQ / 4)),
                                            mr(10 * math.cos(dQ / 8)),
                                            mr(10 - 30 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "In",
                                .1
                            )
                            Swait()
                            if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
                                lc = false
                            end
                        end
                        dS = false
                    end
                    if dr == "r" and dS == false and kf == false then
                        dS = true
                        local lc = true
                        while lc == true do
                            SetTween(
                                hI,
                                {
                                    C0 = RootCF * CFrame.new(0, 0, -2.20) *
                                        angles(
                                            math.rad(75),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                hJ,
                                {
                                    C0 = NeckCF * CFrame.new(0, 0, 0) *
                                        angles(math.rad(-40), math.rad(15 * math.sin(dQ / 8)), math.rad(0))
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {
                                    C0 = CFrame.new(1.0, 0.5, -.4) *
                                        angles(
                                            math.rad(160),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(-50 + 5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "Out",
                                0.1
                            )
                            SetTween(
                                LW,
                                {
                                    C0 = CFrame.new(-1.0, 0.5, -.4) *
                                        angles(
                                            math.rad(160),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(40 + 5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "Out",
                                0.1
                            )
                            SetTween(
                                RH,
                                {
                                    C0 = CFrame.new(.5, -.9 - .1 * math.cos(dQ / 8), -.4 + .4 * math.cos(dQ / 8)) *
                                        angles(
                                            math.rad(-50 + 35 * math.cos(dQ / 8)),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(-15 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LH,
                                {
                                    C0 = CFrame.new(-.5, -.9 + .1 * math.cos(dQ / 8), -.4 - .4 * math.cos(dQ / 8)) *
                                        angles(
                                            math.rad(-50 - 35 * math.cos(dQ / 8)),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(-15 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                tailw,
                                {
                                    C0 = CF(-.2 * math.cos(dQ / 8), 0, .30 + .15 * math.sin(dQ / 4)) *
                                        ANGLES(
                                            mr(80 + 10 * math.sin(dQ / 4)),
                                            mr(10 * math.cos(dQ / 8)),
                                            mr(10 - 30 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "In",
                                .1
                            )
                            Swait()
                            if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
                                lc = false
                            end
                        end
                        dS = false
                    end
                    if dr == "r" and dS == false and kf == true then
                        dS = true
                        local lc = true
                        while lc == true do
                            SetTween(
                                hI,
                                {
                                    C0 = RootCF * CFrame.new(0, 0, -1.8) *
                                        angles(
                                            math.rad(140),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                hJ,
                                {
                                    C0 = NeckCF * CFrame.new(0, 0, 0) *
                                        angles(math.rad(-100), math.rad(15 * math.sin(dQ / 8)), math.rad(0))
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {
                                    C0 = CFrame.new(1.0, 1, 0) *
                                        angles(
                                            math.rad(210),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(40 + 5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "Out",
                                0.1
                            )
                            SetTween(
                                LW,
                                {
                                    C0 = CFrame.new(-1.0, 1, 0) *
                                        angles(
                                            math.rad(210),
                                            math.rad(5 * math.cos(dQ / 8)),
                                            math.rad(-40 + 5 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "Out",
                                0.1
                            )
                            SetTween(
                                RH,
                                {
                                    C0 = CFrame.new(.5, -0.7, 0) *
                                        angles(
                                            math.rad(130 + 5 * math.cos(dQ / 8)),
                                            math.rad(15 * math.sin(dQ / 8)),
                                            math.rad(-15 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LH,
                                {
                                    C0 = CFrame.new(-.5, -0.7, 0) *
                                        angles(
                                            math.rad(130 - 5 * math.cos(dQ / 8)),
                                            math.rad(-15 * math.sin(dQ / 8)),
                                            math.rad(-15 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                tailw,
                                {
                                    C0 = CF(-.2 * math.cos(dQ / 8), 0, .30 + .15 * math.sin(dQ / 4)) *
                                        ANGLES(
                                            mr(80 + 10 * math.sin(dQ / 4)),
                                            mr(10 * math.cos(dQ / 8)),
                                            mr(10 - 30 * math.cos(dQ / 8))
                                        )
                                },
                                "Linear",
                                "In",
                                .1
                            )
                            Swait()
                            if (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude > .5 then
                                lc = false
                            end
                        end
                        dS = false
                    end
                    if dr == "z" and dS == false then
                        Attack1()
                    end
                    if dr == "x" and dS == false then
                    end
                    if dr == "c" and dS == false then
                    end
                    if dr == "v" and dS == false then
                    end
                    if dr == "f" and dS == false then
                    end
                    if dr == "y" and dS == false then
                        joke()
                    end
                    if dr == "t" and dS == false then
                        dS = true
                        SetTween(
                            hI,
                            {C0 = RootCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(30))},
                            "Back",
                            "Out",
                            0.3
                        )
                        SetTween(
                            hJ,
                            {C0 = NeckCF * CFrame.new(0, 0, 0) * angles(math.rad(0), math.rad(0), math.rad(-30))},
                            "Back",
                            "Out",
                            0.3
                        )
                        SetTween(
                            RW,
                            {C0 = CFrame.new(1.3, 0.5, -.0) * angles(math.rad(120), math.rad(0), math.rad(-40))},
                            "Back",
                            "Out",
                            0.3
                        )
                        SetTween(
                            LW,
                            {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                            "Back",
                            "Out",
                            0.3
                        )
                        SetTween(
                            RH,
                            {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                            "Back",
                            "Out",
                            0.3
                        )
                        SetTween(
                            LH,
                            {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                            "Back",
                            "Out",
                            0.3
                        )
                        Swait(.3 * 30)
                        so("875978120", Torso, 4, .9)
                        dR = 4.3
                        for T = 1, 4, 0.1 do
                            SetTween(
                                hI,
                                {
                                    C0 = RootCF * CFrame.new(0, 0, -.1 - .05 * math.cos(dQ / 8)) *
                                        angles(
                                            math.rad(1 + 1 * math.cos(dQ / 8)),
                                            math.rad(0),
                                            math.rad(30 + 1 * math.cos(dQ / 8))
                                        )
                                },
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                hJ,
                                {
                                    C0 = NeckCF * CFrame.new(0, 0, 0) *
                                        angles(math.rad(0), math.rad(0), math.rad(-30 + 1 * math.cos(dQ / 8)))
                                },
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.3, 0.5, -.0) * angles(math.rad(120), math.rad(0), math.rad(-40))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RH,
                                {
                                    C0 = CFrame.new(.5, -.95 + .05 * math.cos(dQ / 8), -.2 + .05 * math.cos(dQ / 8)) *
                                        angles(
                                            math.rad(-10 + 1 * math.cos(dQ / 8)),
                                            math.rad(25 * math.cos(dQ / 16)),
                                            math.rad(0)
                                        )
                                },
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LH,
                                {
                                    C0 = CFrame.new(-.5, -.95 + .05 * math.cos(dQ / 8), 0) *
                                        angles(math.rad(1 + 1 * math.cos(dQ / 8)), math.rad(0), math.rad(0))
                                },
                                "Quad",
                                "InOut",
                                0.1
                            )
                            Swait()
                        end
                        dS = false
                    end
                    if dr == "g" and ki == true and kh == true then
                        ki = false
                    end
                    if dr == "g" and dS == false and kh == false and kf == true then
                        dS = true
                        ki = true
                        local ld = mouse.Target
                        if ld.Parent ~= nil then
                            local ji =
                                ld.Parent:FindFirstChild("HumanoidRootPart") or
                                ld.Parent.Parent:FindFirstChild("HumanoidRootPart")
                            local le =
                                ld.Parent:FindFirstChildOfClass("Humanoid") or
                                ld.Parent.Parent:FindFirstChildOfClass("Humanoid")
                            if ji == nil then
                                ji = ld.Parent:FindFirstChild("Torso") or ld.Parent.Parent:FindFirstChild("Torso")
                            end
                            print(ji, le)
                            if ji == nil or le == nil then
                                dS = false
                            end
                            if ji ~= nil and le ~= nil then
                                local lf = ji
                                RootPart.Anchored = true
                                local hum = le
                                local lg = Instance.new("Part")
                                local li = Instance.new("ParticleEmitter")
                                lg.Parent = Player.Character
                                lg.CFrame = CFrame.new(51.1425285, 1.88000441, -7.34444237, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                                lg.Position = Vector3.new(51.1425285, 1.88000441, -7.34444237)
                                lg.Transparency = 1
                                lg.Size = Vector3.new(5.54000139, 3.71999788, 4.06999826)
                                lg.BottomSurface = Enum.SurfaceType.Smooth
                                lg.TopSurface = Enum.SurfaceType.Smooth
                                lg.CanCollide = false
                                lg.Anchored = true
                                li.Parent = lg
                                li.Speed = NumberRange.new(0.5, 0.5)
                                li.Rotation = NumberRange.new(0, 360)
                                li.Enabled = true
                                li.Texture = "rbxassetid://244221440"
                                li.Transparency = NumberSequence.new(0.89999997615814, 0.89999997615814)
                                li.ZOffset = 5
                                li.Size = NumberSequence.new(3.7200000286102, 3.7200000286102)
                                li.Acceleration = Vector3.new(0, 1, 0)
                                li.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
                                li.Rate = 20000
                                li.RotSpeed = NumberRange.new(-30, 30)
                                li.SpreadAngle = Vector2.new(360, 360)
                                li.VelocitySpread = 360
                                lg.CFrame = lf.CFrame * CFrame.Angles(0, 0, math.rad(90))
                                lg.CFrame = lg.CFrame * CFrame.new(0, 0, -2)
                                coroutine.resume(
                                    coroutine.create(
                                        function()
                                            wait(0.3)
                                            li.Enabled = false
                                        end
                                    )
                                )
                                local lj = Instance.new("Model")
                                local aA = Instance.new("Part")
                                local kq = Instance.new("SpecialMesh")
                                local kr = Instance.new("Weld")
                                local Part4 = Instance.new("Part")
                                local lk = Instance.new("Weld")
                                local Part6 = Instance.new("Part")
                                local ll = Instance.new("Weld")
                                lj.Name = "D"
                                lj.Parent = nil
                                aA.Parent = lj
                                aA.CFrame =
                                    CFrame.new(
                                    60.5641861,
                                    1.69272184,
                                    -20.9960651,
                                    0.000150388281,
                                    0.0221676175,
                                    0.999754369,
                                    -1.6669499e-05,
                                    0.999754369,
                                    -0.0221676137,
                                    -1,
                                    -1.33316544e-05,
                                    0.000150720865
                                )
                                aA.Orientation = Vector3.new(1.26999998, 89.9899979, 0)
                                aA.Position = Vector3.new(60.5641861, 1.69272184, -20.9960651)
                                aA.Rotation = Vector3.new(89.6100006, 88.7300034, -89.6100006)
                                aA.Color = Color3.new(0.745098, 0.407843, 0.384314)
                                aA.Size = Vector3.new(0.0600000024, 0.950895786, 0.220896259)
                                aA.BottomSurface = Enum.SurfaceType.Smooth
                                aA.BrickColor = BrickColor.new("Terra Cotta")
                                aA.CanCollide = false
                                aA.Material = Enum.Material.SmoothPlastic
                                aA.TopSurface = Enum.SurfaceType.Smooth
                                aA.brickColor = BrickColor.new("Terra Cotta")
                                kq.Parent = aA
                                kq.Scale = Vector3.new(0.910000026, 0.300000012, 0.910000026)
                                kq.MeshType = Enum.MeshType.Sphere
                                kr.Name = "Part"
                                kr.Parent = aA
                                kr.C0 =
                                    CFrame.new(
                                    -5.7220459e-05,
                                    -0.414992213,
                                    3.05175781e-05,
                                    3.20026317e-07,
                                    -1,
                                    5.29796484e-11,
                                    -1,
                                    -3.20026317e-07,
                                    -1.69109037e-15,
                                    1.70804522e-15,
                                    -5.29796484e-11,
                                    -1
                                )
                                kr.Part0 = aA
                                kr.Part1 = Part6
                                kr.part1 = Part6
                                Part4.Parent = lj
                                Part4.CFrame =
                                    CFrame.new(
                                    60.5637436,
                                    1.67272615,
                                    -20.9960651,
                                    0.999754369,
                                    0.0221676175,
                                    -0.000150395441,
                                    -0.0221676137,
                                    0.999754369,
                                    1.63495533e-05,
                                    0.000150720924,
                                    -1.30116277e-05,
                                    1
                                )
                                Part4.Orientation = Vector3.new(0, -0.00999999978, -1.26999998)
                                Part4.Position = Vector3.new(60.5637436, 1.67272615, -20.9960651)
                                Part4.Rotation = Vector3.new(0, -0.00999999978, -1.26999998)
                                Part4.Color = Color3.new(1, 0.580392, 0.580392)
                                Part4.Size = Vector3.new(0.310000956, 0.310000956, 0.310000956)
                                Part4.BottomSurface = Enum.SurfaceType.Smooth
                                Part4.BrickColor = BrickColor.new("Salmon")
                                Part4.Material = Enum.Material.SmoothPlastic
                                Part4.TopSurface = Enum.SurfaceType.Smooth
                                Part4.brickColor = BrickColor.new("Salmon")
                                Part4.Shape = Enum.PartType.Ball
                                Part4.CanCollide = false
                                lk.Name = "Part"
                                lk.Parent = Part4
                                lk.C0 =
                                    CFrame.new(
                                    2.67028809e-05,
                                    -0.394991755,
                                    5.7220459e-05,
                                    -3.47415857e-23,
                                    0,
                                    -1,
                                    -1,
                                    0,
                                    -3.47415857e-23,
                                    0,
                                    1,
                                    0
                                )
                                lk.Part0 = Part4
                                lk.Part1 = Part6
                                lk.part1 = Part6
                                Part6.Parent = lj
                                Part6.CFrame =
                                    CFrame.new(
                                    60.5550156,
                                    1.27783084,
                                    -20.9960022,
                                    -0.0221676175,
                                    -0.000150395441,
                                    -0.999754369,
                                    -0.999754369,
                                    1.63495533e-05,
                                    0.0221676137,
                                    1.30116277e-05,
                                    1,
                                    -0.000150720924
                                )
                                Part6.Orientation = Vector3.new(-1.26999998, -90.0100021, -90)
                                Part6.Position = Vector3.new(60.5550156, 1.27783084, -20.9960022)
                                Part6.Rotation = Vector3.new(-90.3899994, -88.7300034, 179.610001)
                                Part6.Color = Color3.new(1, 0.8, 0.6)
                                Part6.Size = Vector3.new(0.789999664, 0.315000653, 0.315000653)
                                Part6.BottomSurface = Enum.SurfaceType.Smooth
                                Part6.BrickColor = BrickColor.new("Pastel brown")
                                Part6.Material = Enum.Material.SmoothPlastic
                                Part6.TopSurface = Enum.SurfaceType.Smooth
                                Part6.brickColor = BrickColor.new("Pastel brown")
                                Part6.Shape = Enum.PartType.Cylinder
                                if lf.Name == "HumanoidRootPart" then
                                    Part6.BrickColor = lf.BrickColor
                                elseif lf.Name ~= "HumanoidRootPart" then
                                    local lm = lf.Parent:FindFirstChildOfClass("BodyColors")
                                    if lm ~= nil then
                                        Part6.BrickColor = lm.TorsoColor
                                    end
                                end
                                Part6.CanCollide = false
                                ll.Name = "HumanoidRootPart"
                                ll.Parent = Part6
                                ll.C0 =
                                    CFrame.new(
                                    0.749751091,
                                    -0.000104904175,
                                    -1.27482605,
                                    -1.30116277e-05,
                                    -0.0221676175,
                                    0.999754369,
                                    -1,
                                    -0.000150395441,
                                    -1.63495533e-05,
                                    0.000150720924,
                                    -0.999754369,
                                    -0.0221676137
                                )
                                ll.Part0 = Part6
                                ll.Part1 = lf
                                ll.part1 = lf
                                wait(0.2)
                                for T = 0, 0.1, 0.1 do
                                    SetTween(hJ, {C0 = NeckCF}, "Quad", "InOut", 0.1)
                                end
                                local ln = 0
                                kh = true
                                spawn(
                                    function()
                                        tploop =
                                            game.RunService.RenderStepped:Connect(
                                            function()
                                                if kh == true then
                                                    RootPart.CFrame =
                                                        lf.CFrame * CFrame.new(0, -0.2, 0) * angles(math.rad(-90), 0, 0)
                                                    RootPart.CFrame =
                                                        RootPart.CFrame * CFrame.new(0, 1.5, 0) *
                                                        angles(0, math.rad(180), 0)
                                                end
                                            end
                                        )
                                        while kh == true do
                                            wait()
                                        end
                                        print("Ran")
                                        RootPart.Anchored = false
                                        tploop:Disconnect()
                                    end
                                )
                                repeat
                                    ln = ln + 1
                                    for T = 0, 0.8, 0.1 do
                                        SetTween(
                                            hI,
                                            {C0 = CFrame.fromEulerAnglesXYZ(-2.9, 0, 3.14)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(-.5, -.95 + .05, 0) *
                                                    angles(math.rad(30), 0, math.rad(-25))
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RH,
                                            {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(30), 0, math.rad(25))},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LW,
                                            {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        Swait()
                                    end
                                    for T = 0, 0.8, 0.1 do
                                        SetTween(
                                            hI,
                                            {C0 = CFrame.fromEulerAnglesXYZ(-3.05, 0, 3.14)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(-.5, -.95 + .05, 0) *
                                                    angles(math.rad(45), 0, math.rad(-25))
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RH,
                                            {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(45), 0, math.rad(25))},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LW,
                                            {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(100), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(100), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        Swait()
                                    end
                                    local sound = CreateSound2("836796971", Torso, 10, 1, false)
                                    game:GetService("Debris"):AddItem(sound, 2)
                                    wait(0.5)
                                until ln > 20 or ki == false
                                repeat
                                    ln = ln + 1
                                    for T = 0, 0.5, 0.1 do
                                        SetTween(
                                            hI,
                                            {C0 = CFrame.fromEulerAnglesXYZ(-2.9, 0, 3.14)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(-.5, -.95 + .05, 0) *
                                                    angles(math.rad(30), 0, math.rad(-25))
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RH,
                                            {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(30), 0, math.rad(25))},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LW,
                                            {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        Swait()
                                    end
                                    local sound = CreateSound2("836796971", Torso, 10, 1, false)
                                    game:GetService("Debris"):AddItem(sound, 2)
                                    for T = 0, 0.5, 0.1 do
                                        SetTween(
                                            hI,
                                            {C0 = CFrame.fromEulerAnglesXYZ(-3.05, 0, 3.14)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(-.5, -.95 + .05, 0) *
                                                    angles(math.rad(45), 0, math.rad(-25))
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RH,
                                            {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(45), 0, math.rad(25))},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LW,
                                            {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(100), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(100), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        Swait()
                                    end
                                    wait(0.2)
                                until ln > 35 or ki == false
                                repeat
                                    wait()
                                    for T = 0, 0.4, 0.1 do
                                        SetTween(
                                            hI,
                                            {C0 = CFrame.fromEulerAnglesXYZ(-3, 0, 3.14)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(-.5, -.95 + .05, 0) *
                                                    angles(math.rad(35), 0, math.rad(-25))
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RH,
                                            {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(35), 0, math.rad(25))},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LW,
                                            {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        Swait()
                                    end
                                    local sound = CreateSound2("836796971", Torso, 10, 1, false)
                                    game:GetService("Debris"):AddItem(sound, 5)
                                    for T = 0, 0.4, 0.1 do
                                        SetTween(
                                            hI,
                                            {C0 = CFrame.fromEulerAnglesXYZ(-2.7, 0, 3.14)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(-.5, -.95 + .05, 0) *
                                                    angles(math.rad(10), 0, math.rad(-25))
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RH,
                                            {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(10), 0, math.rad(25))},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LW,
                                            {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(75), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(75), 0, 0)},
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        Swait()
                                    end
                                    wait(0.1)
                                until ki == false
                                for T = 0, 0.4, 0.1 do
                                    SetTween(hI, {C0 = CFrame.fromEulerAnglesXYZ(-3, 0, 3.14)}, "Quad", "InOut", 0.1)
                                    SetTween(
                                        LH,
                                        {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(35), 0, math.rad(-25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RH,
                                        {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(35), 0, math.rad(25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LW,
                                        {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RW,
                                        {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    Swait()
                                end
                                wait(0.5)
                                for T = 0, 0.4, 0.1 do
                                    SetTween(hI, {C0 = CFrame.fromEulerAnglesXYZ(-2.65, 0, 3.14)}, "Quad", "InOut", 0.1)
                                    SetTween(
                                        LH,
                                        {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(8), 0, math.rad(-25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RH,
                                        {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(8), 0, math.rad(25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LW,
                                        {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(72), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RW,
                                        {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(72), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    Swait()
                                end
                                local sound = CreateSound2("1430568042", Torso, 10, 1, false)
                                game:GetService("Debris"):AddItem(sound, 5)
                                wait(0.5)
                                for T = 0, 0.4, 0.1 do
                                    SetTween(hI, {C0 = CFrame.fromEulerAnglesXYZ(-3, 0, 3.14)}, "Quad", "InOut", 0.1)
                                    SetTween(
                                        LH,
                                        {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(35), 0, math.rad(-25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RH,
                                        {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(35), 0, math.rad(25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LW,
                                        {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RW,
                                        {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    Swait()
                                end
                                wait(0.5)
                                for T = 0, 0.4, 0.1 do
                                    SetTween(hI, {C0 = CFrame.fromEulerAnglesXYZ(-2.65, 0, 3.14)}, "Quad", "InOut", 0.1)
                                    SetTween(
                                        LH,
                                        {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(8), 0, math.rad(-25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RH,
                                        {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(8), 0, math.rad(25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LW,
                                        {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(72), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RW,
                                        {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(72), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    Swait()
                                end
                                local sound = CreateSound2("1430568042", Torso, 10, 1, false)
                                game:GetService("Debris"):AddItem(sound, 5)
                                wait(0.5)
                                for T = 0, 0.4, 0.1 do
                                    SetTween(hI, {C0 = CFrame.fromEulerAnglesXYZ(-3, 0, 3.14)}, "Quad", "InOut", 0.1)
                                    SetTween(
                                        LH,
                                        {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(35), 0, math.rad(-25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RH,
                                        {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(35), 0, math.rad(25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LW,
                                        {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RW,
                                        {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(90), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    Swait()
                                end
                                wait(0.5)
                                for T = 0, 0.4, 0.1 do
                                    SetTween(hI, {C0 = CFrame.fromEulerAnglesXYZ(-2.65, 0, 3.14)}, "Quad", "InOut", 0.1)
                                    SetTween(
                                        LH,
                                        {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(8), 0, math.rad(-25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RH,
                                        {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(8), 0, math.rad(25))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LW,
                                        {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(math.rad(72), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RW,
                                        {C0 = CFrame.new(1.5, 0.4, -.0) * angles(math.rad(72), 0, 0)},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    Swait()
                                end
                                local sound = CreateSound2("1430568042", Torso, 10, 1, false)
                                game:GetService("Debris"):AddItem(sound, 5)
                                wait(0.5)
                                dS = false
                                li.Enabled = true
                                coroutine.resume(
                                    coroutine.create(
                                        function()
                                            wait(0.3)
                                            li.Enabled = false
                                            game:GetService("Debris"):AddItem(li, 2)
                                        end
                                    )
                                )
                                lj:Destroy()
                                kh = false
                            end
                        end
                    end
                    if dr == "c" and kj == false and dS == false and kf == false then
                        dS = true
                        RootPart.Anchored = true
                        kj = true
                        kf = true
                        for T = 0, 0.3, 0.1 do
                            SetTween(hI, {C0 = CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8)}, "Quad", "InOut", 0.1)
                            SetTween(
                                LH,
                                {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(0, 0, math.rad(-5))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RH,
                                {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(0, 0, math.rad(5))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(0, 0, math.rad(10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.5, 0.4, -.0) * angles(0, 0, math.rad(-10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            Swait()
                        end
                        for T = 0, 0.3, 0.1 do
                            SetTween(
                                hI,
                                {
                                    C0 = CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8) * CFrame.new(0, 0, -0.1) *
                                        angles(math.rad(20), math.rad(0), math.rad(0))
                                },
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LH,
                                {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(20), 0, math.rad(-5))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RH,
                                {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(20), 0, math.rad(5))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0.4, -.0) * angles(0, 0, math.rad(10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.5, 0.4, -.0) * angles(0, 0, math.rad(-10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            Swait()
                        end
                        local lo = true
                        for T = 0, 0.6, 0.1 do
                            SetTween(
                                hI,
                                {
                                    C0 = CFrame.fromEulerAnglesXYZ(-1.57, 0, 2.8) * CFrame.new(0, 0, -0.3) *
                                        angles(math.rad(40), math.rad(0), math.rad(0))
                                },
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LH,
                                {C0 = CFrame.new(-.5, -.95 + .05, 0) * angles(math.rad(40), 0, math.rad(-5))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RH,
                                {C0 = CFrame.new(.5, -.95 + .05, 0) * angles(math.rad(40), 0, math.rad(5))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0.4, 0.2) * angles(math.rad(30), 0, math.rad(10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.5, 0.4, 0.2) * angles(math.rad(30), 0, math.rad(-10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(kl, {C0 = CFrame.new(0, -0.6, 0)}, "Quad", "InOut", 0.1)
                            SetTween(km, {C0 = CFrame.new(0, -0.6, 0)}, "Quad", "InOut", 0.1)
                            if lo == true then
                                lo = false
                                for T, v in pairs(kp:GetChildren()) do
                                    if v:IsA("BasePart") then
                                        v.Transparency = 1
                                    end
                                end
                            end
                            Swait()
                        end
                        for T = 0, 1, 0.1 do
                            SetTween(
                                LW,
                                {C0 = CFrame.new(-1.5, 0, 0) * angles(math.rad(30), 0, math.rad(10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(
                                RW,
                                {C0 = CFrame.new(1.5, 0, 0) * angles(math.rad(30), 0, math.rad(-10))},
                                "Quad",
                                "InOut",
                                0.1
                            )
                            SetTween(kl, {C0 = CFrame.new(0, 0.8, 0)}, "Quad", "InOut", 0.1)
                            SetTween(km, {C0 = CFrame.new(0, 0.8, 0)}, "Quad", "InOut", 0.1)
                            Swait()
                        end
                        LocalPlayer.Character = M
                        for U, v in pairs(M:GetChildren()) do
                            if v:IsA("Pants") then
                                v:Destroy()
                            end
                        end
                        for U, v in pairs(game.workspace.nigra:GetChildren()) do
                            if v:IsA("Pants") then
                                v:Destroy()
                            end
                        end
                        LocalPlayer.Character = FakeChar
                        RootPart.Anchored = false
                        dS = false
                        kj = false
                        R.vaggie.Handle.Anchored = false
                        S.lips.Handle.Anchored = false
                        W(R.vaggie.Handle, Character["Torso"])
                        W(S.lips.Handle, Character["Torso"])
                        S.lips.Handle.Attachment.Rotation = Vector3.new(-58, -177, 180)
                        Character:WaitForChild("Torso"):FindFirstChild("Attachment").Name = "Attachment69"
                        Character:WaitForChild("Torso"):FindFirstChild("Attachment").Name = "Attachment1337"
                        Character:WaitForChild("Torso"):FindFirstChild("Attachment").Name = "Attachment420"
                        Character:WaitForChild("Torso").Attachment1337.Position = Vector3.new(0, -1, 0)
                        Character:WaitForChild("Torso").Attachment420.Position = Vector3.new(0, -1.325, -0.22)
                    elseif dr == "c" and dS == false and kf == true then
                    end
                    if dr == "v" and dS == false and kg == false then
                        kg = true
                        local lp = Instance.new("ParticleEmitter")
                        lp.Parent = Character.TorsoYes.Torso.REF
                        lp.Speed = NumberRange.new(0.5, 0.5)
                        lp.Rotation = NumberRange.new(0, 360)
                        lp.Enabled = true
                        lp.Texture = "rbxassetid://244221440"
                        lp.Transparency = NumberSequence.new(0.89999997615814, 0.89999997615814)
                        lp.ZOffset = 5
                        lp.Acceleration = Vector3.new(0, 1, 0)
                        lp.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
                        lp.Rate = 20000
                        lp.RotSpeed = NumberRange.new(-30, 30)
                        lp.SpreadAngle = Vector2.new(360, 360)
                        lp.VelocitySpread = 360
                        local li = Instance.new("ParticleEmitter")
                        li.Parent = Character.TorsoYes.Torso.Out
                        li.Speed = NumberRange.new(0.5, 0.5)
                        li.Rotation = NumberRange.new(0, 360)
                        li.Enabled = true
                        li.Texture = "rbxassetid://244221440"
                        li.Transparency = NumberSequence.new(0.89999997615814, 0.89999997615814)
                        li.ZOffset = 5
                        li.Acceleration = Vector3.new(0, 1, 0)
                        li.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
                        li.Rate = 20000
                        li.RotSpeed = NumberRange.new(-30, 30)
                        li.SpreadAngle = Vector2.new(360, 360)
                        li.VelocitySpread = 360
                        for T, v in pairs(Character.TorsoYes.Torso:GetChildren()) do
                            if v.Name == "Chest" or v.Name == "Chest2" then
                                local lq = Instance.new("ParticleEmitter")
                                lq.Parent = v
                                lq.Speed = NumberRange.new(0.5, 0.5)
                                lq.Rotation = NumberRange.new(0, 360)
                                lq.Enabled = true
                                lq.Texture = "rbxassetid://244221440"
                                lq.Transparency = NumberSequence.new(0.89999997615814, 0.89999997615814)
                                lq.ZOffset = 5
                                lq.Acceleration = Vector3.new(0, 1, 0)
                                lq.Lifetime = NumberRange.new(0.10000000149012, 0.20000000298023)
                                lq.Rate = 20000
                                lq.RotSpeed = NumberRange.new(-30, 30)
                                lq.SpreadAngle = Vector2.new(360, 360)
                                lq.VelocitySpread = 360
                                v.Transparency = 0
                                v.Anchored = false
                                v.CanCollide = false
                                coroutine.resume(
                                    coroutine.create(
                                        function()
                                            wait(0.2)
                                            lq.Enabled = false
                                        end
                                    )
                                )
                            elseif v:IsA("Beam") then
                                game:GetService("Debris"):AddItem(v, 0.2)
                            end
                        end
                        for T, v in pairs(Character.TorsoYes.Torso:GetChildren()) do
                            if v:IsA("BasePart") and v.Name ~= "Chest" then
                                v.Transparency = 1
                            end
                        end
                        for T, v in pairs(Character.LArmYes.LeftArm:GetChildren()) do
                            if v:IsA("BasePart") and v.Name ~= "REF" then
                                v.Transparency = 1
                            end
                        end
                        for T, v in pairs(Character.RArmYes.RightArm:GetChildren()) do
                            if v:IsA("BasePart") and v.Name ~= "REF" then
                                v.Transparency = 1
                            end
                        end
                        Torso.Transparency = 0
                        LocalPlayer.Character = M
                        for U, v in pairs(M:GetChildren()) do
                            if v:IsA("Shirt") then
                                v:Destroy()
                            end
                        end
                        for U, v in pairs(game.workspace.nigra:GetChildren()) do
                            if v:IsA("Shirt") then
                                v:Destroy()
                            end
                        end
                        LocalPlayer.Character = FakeChar
                        wait(0.2)
                        lp.Enabled = false
                        li.Enabled = false
                        game:GetService("Debris"):AddItem(lp, 2)
                        game:GetService("Debris"):AddItem(li, 2)
                        R.tiddie.Handle.Anchored = false
                        R.othertiddie.Handle.Anchored = false
                        S.nipples.Handle.Anchored = false
                        R.behindzatiddie.Handle.Anchored = false
                        R.behindzaothertiddie.Handle.Anchored = false
                        W(R.tiddie.Handle, Character.TorsoYes.Torso.Chest1)
                        W(R.othertiddie.Handle, Character.TorsoYes.Torso.Chest2)
                        W(S.nipples.Handle, Character.TorsoYes.Torso.Chest3)
                        W(R.behindzatiddie.Handle, Character.TorsoYes.Torso.Chest3)
                        W(R.behindzaothertiddie.Handle, Character.TorsoYes.Torso.Chest4)
                        S.nipples.Handle.Attachment.Orientation = Vector3.new(-25, 90, -45)
                        Character:WaitForChild("TorsoYes").Torso.Chest1:FindFirstChild("Attachment").Name =
                            "Attachment69"
                        Character:WaitForChild("TorsoYes").Torso.Chest2:FindFirstChild("Attachment").Name =
                            "Attachment69"
                        Character:WaitForChild("TorsoYes").Torso.Chest3:FindFirstChild("Attachment").Name =
                            "Attachment69"
                        Character:WaitForChild("TorsoYes").Torso.Chest3:FindFirstChild("Attachment").Name =
                            "Attachment420"
                        Character:WaitForChild("TorsoYes").Torso.Chest4:FindFirstChild("Attachment").Name =
                            "Attachment69"
                        Character:WaitForChild("TorsoYes").Torso.Chest1.Attachment69.Position = Vector3.new(0, 0, 0)
                        Character:WaitForChild("TorsoYes").Torso.Chest2.Attachment69.Position = Vector3.new(0, 0, 0)
                        Character:WaitForChild("TorsoYes").Torso.Chest3.Attachment69.Position =
                            Vector3.new(0.3, 0.2, -0.425)
                        Character:WaitForChild("TorsoYes").Torso.Chest3.Attachment420.Position = Vector3.new(0, 0, 0)
                        Character:WaitForChild("TorsoYes").Torso.Chest4.Attachment69.Position = Vector3.new(0, 0, 0)
                        kk = false
                    elseif dr == "v" and dS == false and kg == true then
                    end
                    if dr == "p" and dS == false then
                        if mememode == false then
                            mememode = true
                            dZ = "http://www.roblox.com/asset/?id=836590183"
                            lastsongpos = 0
                            d_.TimePosition = lastsongpos
                        else
                            mememode = false
                            e0 = e0 - 1
                            KeyDownF("n")
                        end
                    end
                    if dr == "0" then
                        if isruning == false then
                            isruning = true
                        end
                    end
                    if dr == "m" then
                        if playsong == true then
                            playsong = false
                            d_:pause()
                        elseif playsong == false then
                            playsong = true
                            d_:resume()
                        end
                    end
                    if dr == "n" and mememode == false then
                        e0 = e0 + 1
                        if e0 > 6 then
                            e0 = 1
                        end
                        warn("now playing song Nr" .. e0)
                        if e0 == 1 then
                            dZ = "http://www.roblox.com/asset/?id=617334987"
                        elseif e0 == 2 then
                            dZ = "http://www.roblox.com/asset/?id=3464477488"
                        elseif e0 == 3 then
                            dZ = "http://www.roblox.com/asset/?id=198665867"
                        elseif e0 == 4 then
                            dZ = "http://www.roblox.com/asset/?id=493674525"
                        elseif e0 == 5 then
                            dZ = "http://www.roblox.com/asset/?id=2984966954"
                        elseif e0 == 6 then
                            dZ = "http://www.roblox.com/asset/?id=3547074406"
                        end
                        lastsongpos = 0
                        d_.TimePosition = lastsongpos
                    end
                end
            )
            FF = Instance.new("ForceField", Character)
            FF.Visible = false
            Humanoid.DisplayDistanceType = "None"
            Humanoid.MaxHealth = 9999
            Humanoid.Health = 9999
            GainCharge = function()
                Humanoid.MaxHealth = 9999
                Humanoid.Health = 9999
            end
            Humanoid.HealthChanged:connect(
                function()
                    GainCharge(Humanoid)
                end
            )
            coroutine.resume(
                coroutine.create(
                    function()
                        while Humanoid.Health > 0.001 do
                            dQ = dQ + dR
                            hitfloor =
                                rayCast(
                                RootPart.Position,
                                CFrame.new(RootPart.Position, RootPart.Position - Vector3.new(0, 1, 0)).lookVector,
                                4,
                                Character
                            )
                            if Character:FindFirstChild("Sound") then
                                Character:FindFirstChild("Sound"):Destroy()
                            end
                            local hW = (Humanoid.MoveDirection * Vector3.new(1, 0, 1)).magnitude
                            local hX = RootPart.Velocity.y
                            if RootPart.Velocity.y > 1 and hitfloor == nil then
                                N = "Jump"
                            elseif RootPart.Velocity.y < -1 and hitfloor == nil then
                                N = "Fall"
                            elseif Humanoid.Sit == true then
                                N = "Sit"
                            elseif hW < .5 and hitfloor ~= nil then
                                N = "Idle"
                            elseif hW > .5 and hitfloor ~= nil then
                                N = "Walk"
                            else
                                N = ""
                            end
                            local hY = RootPart.CFrame
                            local hZ = Humanoid.MoveDirection * hY.LookVector
                            local h_ = Humanoid.MoveDirection * hY.RightVector
                            dU = hZ.X + hZ.Z
                            dV = h_.X + h_.Z
                            coroutine.resume(
                                coroutine.create(
                                    function()
                                        if d_.Parent == nil or d_ == nil then
                                            d_ = e1:Clone()
                                            d_.Parent = Torso
                                            d_.Name = "BGMusic"
                                            d_.Pitch = 1
                                            d_.Volume = 1.5
                                            d_.Looped = true
                                            d_.archivable = false
                                            d_.TimePosition = lastsongpos
                                            if playsong == true then
                                                d_:play()
                                            elseif playsong == false then
                                                d_:stop()
                                            end
                                        else
                                            lastsongpos = d_.TimePosition
                                            d_.Pitch = 1
                                            d_.Volume = 1.5
                                            d_.Looped = true
                                            d_.SoundId = dZ
                                            d_.EmitterSize = 30
                                        end
                                    end
                                )
                            )
                            dO = hW * 1
                            if dO > 30 then
                                dO = 30
                            end
                            dO = dO / 50 * 2
                            if dS == false then
                                if N == "Jump" then
                                    dR = 0.60 * 2
                                    SetTween(
                                        hI,
                                        {
                                            C0 = RootCF *
                                                cn(
                                                    0,
                                                    0 + 0.0395 / 2 * math.cos(dQ / 8),
                                                    -0.1 + 0.0395 * math.cos(dQ / 8)
                                                ) *
                                                angles(
                                                    math.rad(-6.5 - 1.5 * math.cos(dQ / 8)) + dO * dU / 2,
                                                    math.rad(0) - dO * dV / 2,
                                                    math.rad(0)
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.25
                                    )
                                    SetTween(
                                        hJ,
                                        {
                                            C0 = NeckCF * CFrame.new(0, 0, 0) *
                                                angles(
                                                    math.rad(-26.5 + 2.5 * math.cos(dQ / 8)),
                                                    math.rad(0),
                                                    math.rad(-0)
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.25
                                    )
                                    SetTween(
                                        RW,
                                        {
                                            C0 = cf(1.4 + .05 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                angles(
                                                    math.rad(140 - 2 * math.cos(dQ / 8)),
                                                    math.rad(-5),
                                                    math.rad(8 + 4 * math.cos(dQ / 8))
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.2
                                    )
                                    SetTween(
                                        LW,
                                        {
                                            C0 = cf(-1.4 + .05 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                angles(
                                                    math.rad(140 - 2 * math.cos(dQ / 8)),
                                                    math.rad(5),
                                                    math.rad(-8 - 4 * math.cos(dQ / 8))
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.2
                                    )
                                    SetTween(
                                        RH,
                                        {
                                            C0 = CFrame.new(.5, -0.85 + .05 * math.cos(dQ / 15), -.2) *
                                                CFrame.Angles(
                                                    math.rad(-15 - 1 * math.cos(dQ / 10)),
                                                    math.rad(0),
                                                    math.rad(0)
                                                )
                                        },
                                        "Quad",
                                        "InOut",
                                        0.075
                                    )
                                    SetTween(
                                        LH,
                                        {
                                            C0 = CFrame.new(-.5, -0.35 + .05 * math.cos(dQ / 15), -.4) *
                                                CFrame.Angles(
                                                    math.rad(-25 + 1 * math.cos(dQ / 10)),
                                                    math.rad(0),
                                                    math.rad(0)
                                                )
                                        },
                                        "Quad",
                                        "InOut",
                                        0.075
                                    )
                                elseif N == "Fall" then
                                    dR = 0.60 * 2
                                    SetTween(
                                        hI,
                                        {
                                            C0 = RootCF *
                                                cn(
                                                    0,
                                                    0 + 0.0395 / 2 * math.cos(dQ / 8),
                                                    -0.5 + 0.0395 * math.cos(dQ / 8)
                                                ) *
                                                angles(
                                                    math.rad(5.5 - 1.5 * math.cos(dQ / 8)) - dO * dU / 2,
                                                    math.rad(0) + dO * dV / 2,
                                                    math.rad(0)
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.35
                                    )
                                    SetTween(
                                        hJ,
                                        {
                                            C0 = NeckCF * CFrame.new(0, 0, 0) *
                                                angles(
                                                    math.rad(26.5 + 2.5 * math.cos(dQ / 8)),
                                                    math.rad(0),
                                                    math.rad(-0)
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.25
                                    )
                                    SetTween(
                                        RW,
                                        {
                                            C0 = cf(1.4 + .05 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                angles(
                                                    math.rad(105 - 2 * math.cos(dQ / 8)),
                                                    math.rad(-15),
                                                    math.rad(80 + 4 * math.cos(dQ / 8))
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.2
                                    )
                                    SetTween(
                                        LW,
                                        {
                                            C0 = cf(-1.4 + .05 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                angles(
                                                    math.rad(105 - 2 * math.cos(dQ / 8)),
                                                    math.rad(15),
                                                    math.rad(-80 - 4 * math.cos(dQ / 8))
                                                )
                                        },
                                        "Quad",
                                        "Out",
                                        0.2
                                    )
                                    SetTween(
                                        RH,
                                        {
                                            C0 = CFrame.new(.5, -0.15 + .05 * math.cos(dQ / 15), -.4) *
                                                CFrame.Angles(
                                                    math.rad(-15 - 1 * math.cos(dQ / 10)),
                                                    math.rad(0),
                                                    math.rad(0)
                                                )
                                        },
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LH,
                                        {
                                            C0 = CFrame.new(-.5, -0.55 + .05 * math.cos(dQ / 15), -.4) *
                                                CFrame.Angles(
                                                    math.rad(-0 + 1 * math.cos(dQ / 10)),
                                                    math.rad(0),
                                                    math.rad(0)
                                                )
                                        },
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                elseif N == "Idle" then
                                    local f2 = 1
                                    if dS == true and mememode == true then
                                        f2 = 5
                                    end
                                    if ke == false then
                                        dR = 0.60 * 1.75 * f2
                                        Humanoid.JumpPower = 60
                                        Humanoid.WalkSpeed = 16
                                        local i0 = 0
                                        SetTween(
                                            hI,
                                            {
                                                C0 = RootCF *
                                                    cn(
                                                        0,
                                                        0,
                                                        -0.1 + 0.0395 * math.cos(dQ / 8 + i0 * math.cos(dQ / 8 * 2))
                                                    ) *
                                                    angles(
                                                        math.rad(1.5 - 1 * math.cos(dQ / 8)),
                                                        math.rad(0 + 0 * math.cos(dQ / 8) / 20),
                                                        math.rad(-20)
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            hJ,
                                            {
                                                C0 = NeckCF *
                                                    angles(
                                                        math.rad(
                                                            6.5 - 3.5 * math.sin(dQ / 8 + i0 * math.cos(dQ / 8 * 2))
                                                        ),
                                                        math.rad(2.5 - 5.5 * math.cos(dQ / 16)),
                                                        math.rad(20 - 6.5 * math.cos(dQ / 15 + .4 * math.cos(dQ / 10)))
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {
                                                C0 = cf(1.45 + .0 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                    angles(
                                                        math.rad(0 + 3 * math.sin(dQ / 8)),
                                                        math.rad(-5),
                                                        math.rad(4 + 4 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "Out",
                                            0.2
                                        )
                                        SetTween(
                                            LW,
                                            {
                                                C0 = cf(-1.45 + .0 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                    angles(
                                                        math.rad(0 + 3 * math.sin(dQ / 8)),
                                                        math.rad(5),
                                                        math.rad(-4 - 4 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "Out",
                                            0.2
                                        )
                                        SetTween(
                                            RH,
                                            {
                                                C0 = CFrame.new(
                                                    .5,
                                                    -0.95 - .04 * math.cos(dQ / 8 + i0 * math.cos(dQ / 8 * 2)),
                                                    0
                                                ) *
                                                    CFrame.Angles(
                                                        math.rad(1.5 - 1 * math.cos(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(2.5 - 0.0 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(
                                                    -.5,
                                                    -0.95 - .04 * math.cos(dQ / 8 + i0 * math.cos(dQ / 8 * 2)),
                                                    0
                                                ) *
                                                    CFrame.Angles(
                                                        math.rad(1.5 - 1 * math.cos(dQ / 8)),
                                                        math.rad(20),
                                                        math.rad(-2.5 - 0.0 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                    else
                                        dR = 0.60 * 1.75 * f2
                                        Humanoid.JumpPower = 60
                                        Humanoid.WalkSpeed = 16
                                        local i0 = 0
                                        SetTween(
                                            hI,
                                            {
                                                C0 = RootCF *
                                                    cn(
                                                        0,
                                                        0,
                                                        -0.1 + 0.0395 * math.cos(dQ / 8 + i0 * math.cos(dQ / 8 * 2))
                                                    ) *
                                                    angles(
                                                        math.rad(10.5 - 1 * math.cos(dQ / 8)),
                                                        math.rad(0 + 0 * math.cos(dQ / 8) / 20),
                                                        math.rad(-5)
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            hJ,
                                            {
                                                C0 = NeckCF *
                                                    angles(
                                                        math.rad(
                                                            -6.5 - 3.5 * math.sin(dQ / 8 + i0 * math.cos(dQ / 8 * 2))
                                                        ),
                                                        math.rad(2.5 - 5.5 * math.cos(dQ / 16)),
                                                        math.rad(5 - 6.5 * math.cos(dQ / 15 + .4 * math.cos(dQ / 10)))
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            RW,
                                            {
                                                C0 = cf(1.45 + .0 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                    angles(
                                                        math.rad(10 + 3 * math.sin(dQ / 8)),
                                                        math.rad(25),
                                                        math.rad(40 + 4 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "Out",
                                            0.2
                                        )
                                        SetTween(
                                            LW,
                                            {
                                                C0 = cf(-1.45 + .0 * math.cos(dQ / 8), 0.5 + .05 * math.cos(dQ / 8), .0) *
                                                    angles(
                                                        math.rad(10 + 3 * math.sin(dQ / 8)),
                                                        math.rad(-25),
                                                        math.rad(-40 - 4 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "Out",
                                            0.2
                                        )
                                        SetTween(
                                            RH,
                                            {
                                                C0 = CFrame.new(
                                                    .5,
                                                    -0.95 - .04 * math.cos(dQ / 8 + i0 * math.cos(dQ / 8 * 2)),
                                                    0
                                                ) *
                                                    CFrame.Angles(
                                                        math.rad(20.5 - 1 * math.cos(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(2.5 - 0.0 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(
                                                    -.5,
                                                    -0.95 - .04 * math.cos(dQ / 8 + i0 * math.cos(dQ / 8 * 2)),
                                                    0
                                                ) *
                                                    CFrame.Angles(
                                                        math.rad(1.5 - 1 * math.cos(dQ / 8)),
                                                        math.rad(20),
                                                        math.rad(-2.5 - 0.0 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Quad",
                                            "InOut",
                                            0.1
                                        )
                                    end
                                elseif N == "Walk" then
                                    if ke == false then
                                        local speed = 1.0
                                        if mememode == true then
                                            speed = 4
                                        end
                                        dR = 2.4 * speed
                                        Humanoid.JumpPower = 60 * speed
                                        Humanoid.WalkSpeed = 16 * speed
                                        local i1 =
                                            cf(-dV / 7 * math.cos(dQ / 8), 0, dU / 7 * math.cos(dQ / 8)) *
                                            angles(
                                                math.rad(-dU * 30) * math.cos(dQ / 8),
                                                0,
                                                math.rad(-dV * 30) * math.cos(dQ / 8)
                                            )
                                        local i2 =
                                            cf(dV / 7 * math.cos(dQ / 8), 0, -dU / 7 * math.cos(dQ / 8)) *
                                            angles(
                                                math.rad(dU * 30) * math.cos(dQ / 8),
                                                0,
                                                math.rad(dV * 30) * math.cos(dQ / 8)
                                            )
                                        SetTween(
                                            hI,
                                            {
                                                C0 = RootCF *
                                                    CFrame.new(
                                                        0,
                                                        0,
                                                        -0.05 + 0.055 * math.cos(dQ / 4) + -math.sin(dQ / 4) / 8
                                                    ) *
                                                    angles(
                                                        math.rad((dU * 2 - dU * math.cos(dQ / 4)) * 7),
                                                        math.rad((-dV * 2 - -dV * math.cos(dQ / 4)) * 5),
                                                        math.rad(8 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            hJ,
                                            {
                                                C0 = NeckCF * CFrame.new(0, 0, 0 + 0.025 * math.cos(dQ / 4)) *
                                                    angles(
                                                        math.rad((-dU * 1 - -dU * math.cos(dQ / 4)) * 7),
                                                        math.rad((dV * 2 - dV * math.cos(dQ / 4)) * 3.5),
                                                        math.rad(-dV * 45 + -8 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            RW,
                                            {
                                                C0 = cf(
                                                    1.45 + .0 * math.cos(dQ / 8),
                                                    0.5 + dV / 50 * math.cos(dQ / 8),
                                                    0
                                                ) *
                                                    angles(
                                                        math.rad(0 + dU * 15 * math.cos(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(8 + dV * 5 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "Out",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            LW,
                                            {
                                                C0 = cf(
                                                    -1.45 + .0 * math.cos(dQ / 8),
                                                    0.5 + dV / 50 * math.cos(dQ / 8),
                                                    0
                                                ) *
                                                    angles(
                                                        math.rad(0 - dU * 15 * math.cos(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(-8 - dV * 5 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "Out",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            RH,
                                            {
                                                C0 = CFrame.new(
                                                    .5,
                                                    -0.85 + .15 * math.sin(dQ / 8),
                                                    -.15 + .15 * math.cos(dQ / 8)
                                                ) *
                                                    i1 *
                                                    CFrame.Angles(
                                                        math.rad(0 - 5 * math.cos(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(2.5 - 0.0 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(
                                                    -.5,
                                                    -0.85 - .15 * math.sin(dQ / 8),
                                                    -.15 - .15 * math.cos(dQ / 8)
                                                ) *
                                                    i2 *
                                                    CFrame.Angles(
                                                        math.rad(0 + 5 * math.cos(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(-2.5 - 0.0 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                    else
                                        local speed = 1.6
                                        if mememode == true then
                                            speed = 4
                                        end
                                        dR = 2.5 * speed
                                        Humanoid.JumpPower = 60 * speed
                                        Humanoid.WalkSpeed = 22 * speed
                                        local i1 =
                                            cf(-dV / 7 * math.cos(dQ / 8), 0, dU / 7 * math.cos(dQ / 8)) *
                                            angles(
                                                math.rad(dU * 89) * math.cos(dQ / 8),
                                                mr(-dV * 55 / 2 * math.cos(dQ / 8)),
                                                math.rad(dV * 55 / 1 * math.cos(dQ / 8))
                                            )
                                        local i2 =
                                            cf(dV / 7 * math.sin(dQ / 8), 0, -dU / 7 * math.cos(dQ / 8)) *
                                            angles(
                                                math.rad(dU * 89) * math.cos(dQ / 8),
                                                mr(dV * 55 / 2 * math.sin(dQ / 8)),
                                                math.rad(-dV * 55 / 1 * math.sin(dQ / 8))
                                            )
                                        SetTween(
                                            hI,
                                            {
                                                C0 = RootCF *
                                                    CFrame.new(
                                                        dV * 1 * math.sin(dQ / 8),
                                                        dU * 1 * math.sin(dQ / 8),
                                                        -0.5 - 0.255 * math.cos(dQ / 8) + -math.sin(dQ / 8) / 8
                                                    ) *
                                                    angles(
                                                        math.rad(85 + dU * math.cos(dQ / 8) * 20),
                                                        math.rad(-dV * math.cos(dQ / 4) * 1),
                                                        math.rad(-dV * math.cos(dQ / 8) * 10)
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            hJ,
                                            {
                                                C0 = NeckCF * CFrame.new(0, 0, 0 + 0.025 * math.cos(dQ / 4)) *
                                                    angles(
                                                        math.rad(-20 + (-dU * 1 - -dU * math.cos(dQ / 4)) * 5),
                                                        math.rad((dV * 2 - dV * math.cos(dQ / 4)) * 3.5),
                                                        math.rad(-dV * 45 + -8 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            RW,
                                            {
                                                C0 = cf(
                                                    1.0 + .0 * math.cos(dQ / 8),
                                                    .5 - dU * 0.5 * math.sin(dQ / 8),
                                                    -.4
                                                ) *
                                                    angles(
                                                        math.rad(95 - dU * 75 * math.sin(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(
                                                            -8 + -dV * 55 * math.sin(dQ / 8) + 10 * math.cos(dQ / 8)
                                                        )
                                                    )
                                            },
                                            "Linear",
                                            "Out",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            LW,
                                            {
                                                C0 = cf(
                                                    -1.0 + .0 * math.cos(dQ / 8),
                                                    .5 - dU * 0.5 * math.sin(dQ / 8),
                                                    -.4
                                                ) *
                                                    angles(
                                                        math.rad(95 - dU * 75 * math.sin(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(8 + dV * 55 * math.cos(dQ / 8) - 10 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "Out",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            RH,
                                            {
                                                C0 = CFrame.new(
                                                    .5,
                                                    -0.85 - .25 * math.sin(dQ / 8),
                                                    -.15 - .25 * math.sin(dQ / 8)
                                                ) *
                                                    i1 *
                                                    CFrame.Angles(
                                                        math.rad(60 - 5 * math.cos(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(-2.5 - 0.0 * math.cos(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            LH,
                                            {
                                                C0 = CFrame.new(
                                                    -.5,
                                                    -0.85 - .25 * math.sin(dQ / 8),
                                                    -.15 - .25 * math.sin(dQ / 8)
                                                ) *
                                                    i2 *
                                                    CFrame.Angles(
                                                        math.rad(60 - 5 * math.sin(dQ / 8)),
                                                        math.rad(0),
                                                        math.rad(2.5 - 0.0 * math.sin(dQ / 8))
                                                    )
                                            },
                                            "Linear",
                                            "InOut",
                                            WalkAnimMove / speed
                                        )
                                        SetTween(
                                            tailw,
                                            {
                                                C0 = CF(0, 0, .3) *
                                                    ANGLES(
                                                        mr(90 + 10 * math.cos(dQ / 8)),
                                                        0,
                                                        mr(20 * math.cos(dQ / 16))
                                                    )
                                            },
                                            "Linear",
                                            "In",
                                            .1
                                        )
                                    end
                                elseif N == "Sit" then
                                    SetTween(
                                        hI,
                                        {
                                            C0 = RootCF * CFrame.new(0, 0, 0) *
                                                angles(math.rad(0), math.rad(0), math.rad(0))
                                        },
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        hJ,
                                        {
                                            C0 = NeckCF * CFrame.new(0, 0, 0) *
                                                angles(math.rad(0), math.rad(0), math.rad(0))
                                        },
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        RW,
                                        {C0 = CFrame.new(1.5, 0.5, -.0) * angles(math.rad(0), math.rad(0), math.rad(0))},
                                        "Quad",
                                        "Out",
                                        0.1
                                    )
                                    SetTween(
                                        LW,
                                        {
                                            C0 = CFrame.new(-1.5, 0.5, -.0) *
                                                angles(math.rad(0), math.rad(0), math.rad(0))
                                        },
                                        "Quad",
                                        "Out",
                                        0.1
                                    )
                                    SetTween(
                                        RH,
                                        {C0 = CFrame.new(.5, -1, 0) * angles(math.rad(90), math.rad(0), math.rad(0))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                    SetTween(
                                        LH,
                                        {C0 = CFrame.new(-.5, -1, 0) * angles(math.rad(90), math.rad(0), math.rad(0))},
                                        "Quad",
                                        "InOut",
                                        0.1
                                    )
                                end
                            end
                            if dS == false and not (ke == true and N == "Walk") then
                                SetTween(
                                    tailw,
                                    {
                                        C0 = tailc0 * CF(0, .2, 0) *
                                            ANGLES(mr(4 + 2 * math.cos(dQ / 8)), 0, mr(20 + 20 * math.cos(dQ / 16)))
                                    },
                                    "Linear",
                                    "In",
                                    .1
                                )
                            end
                            Swait(Animstep * 30)
                        end
                    end
                )
            )
            p = Character.RightClaw:GetChildren()
            for T = 1, #p do
                p[T].Transparency = 0
            end
            p = Character.LeftClaw:GetChildren()
            for T = 1, #p do
                p[T].Transparency = 0
            end
            wait(0.1)
            p = Character.RightClaw:GetChildren()
            for T = 1, #p do
                p[T].Transparency = 1
            end
            p = Character.LeftClaw:GetChildren()
            for T = 1, #p do
                p[T].Transparency = 1
            end
end