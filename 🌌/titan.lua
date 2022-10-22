if getgenv().b7b09d85e600f432269def391385162e09e8255bd5a2848c15056fa596c7e124 == true then
      local hairAccessoriesWithoutHairInName = {
['MeshPartAccessory'] = true;
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
local hatcollide = true --makes hats cancollide (credit to ShownApe) (works only with reanimate method 0)
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
local alignmode = 1 --AlignPosition mode
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

local unanchoredparts = {}
local movers = {}
local tog = true
local move = false
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local mov = {};
local mov2 = {};

local Head = "Nose Piercing" --press f9 and find the hat that looks like a heads name and put it here
local x = 0   --Edit Position for head
local y = 0   --Edit Position for head x2
local z = 0 --Edit Position for head x3
Character["Bang w bun"].Name = "bang1"
Character["Bang w bun"].Name = "bang2"
Character["Bang w bun"].Name = "bang3"

local Hats = {ra = Character:WaitForChild("bang1"),
	t = Character:WaitForChild("Cyber Peacock Tail 2.0"),
	la = Character:WaitForChild("bang2"),
	rl = Character:WaitForChild("bang3"),
	lr = Character:WaitForChild("BoyAnimeHair"),
	hed = Character:WaitForChild("MeshPartAccessory")
	
}

for i,v in next, Hats do
	v.Handle.AccessoryWeld:Remove()
	for _,mesh in next, v:GetDescendants() do
		if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
			mesh:Clone() 
		end
	end
end
local NetworkAccess = coroutine.create(function()
	while true do game:GetService("RunService").RenderStepped:Wait()
		game:GetService("Players").LocalPlayer.ReplicationFocus = workspace
		game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
		sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",99999999999999999999999999999999999999999*999999999999999999999999999999999999999999999999999999999) end end)
coroutine.resume(NetworkAccess)

function ftp(str)
	local pt = {};
	if str ~= 'me' and str ~= 'random' then
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Name:lower():find(str:lower()) then
				table.insert(pt, v);
			end
		end
	elseif str == 'me' then
		table.insert(pt, plr);
	elseif str == 'random' then
		table.insert(pt, game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]);
	end
	return pt;
end

Character.Head.Transparency = 0
Character.Head.face:Clone()
Character.Torso.Transparency = 0
Character["Right Arm"].Transparency = 0
Character["Left Arm"].Transparency = 0
Character["Right Leg"].Transparency = 0
Character["Left Leg"].Transparency = 0
local function align(i,v)
	local att0 = Instance.new("Attachment", i)
	att0.Position = Vector3.new(0,0,0)
	local att1 = Instance.new("Attachment", v)
	att1.Position = Vector3.new(0,0,0)
	local AP = Instance.new("AlignPosition", i)
	AP.Attachment0 = att0
	AP.Attachment1 = att1
	AP.RigidityEnabled = false
	AP.ReactionForceEnabled = false
	AP.ApplyAtCenterOfMass = true
	AP.MaxForce = 9999999
	AP.MaxVelocity = math.huge
	AP.Responsiveness = 65
	local AO = Instance.new("AlignOrientation", i)
	AO.Attachment0 = att0
	AO.Attachment1 = att1
	AO.ReactionTorqueEnabled = true
	AO.PrimaryAxisOnly = false
	AO.MaxTorque = 9999999
	AO.MaxAngularVelocity = math.huge
	AO.Responsiveness = 50
end

align(Hats.ra.Handle, Character["Right Arm"])

align(Hats.la.Handle, Character["Left Arm"])

align(Hats.t.Handle, Character.Torso)
Hats.t.Handle.Attachment.Rotation = Vector3.new(-88, -180, 180)
align(Hats.hed.Handle, Character.Head)

align(Hats.lr.Handle, Character["Left Leg"])


align(Hats.rl.Handle, Character["Right Leg"])
wait(1)

for _,p in pairs(Character:GetChildren()) do
	if p.Name == "Left Leg" or p.Name == "Right Leg" or p.Name == "Right Arm" or p.Name == "Left Arm" or p.Name == "Torso" or p.Name == "Head" then
		p.Transparency = 1
	end
end



wait(0.2)



Player = game:GetService("Players").LocalPlayer
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Humanoid = Character.Humanoid
Mouse = Player:GetMouse()
RootPart = Character["HumanoidRootPart"]
Torso = Character["Torso"]
Head = Character["Head"]
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart["RootJoint"]
Neck = Torso["Neck"]
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
Humanoid.DisplayDistanceType = "None"
script.Name = "CREEP"

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

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

--//=================================\\
--||		  CUSTOMIZATION
--\\=================================//

Player_Size = 2 --Size of the player.
Animation_Speed = 3
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)

local Speed = 16
local Effects2 = {}


for _,p in pairs(Character:GetChildren()) do
	if p.Name == "Left Arm" or p.Name == "Right Arm" or p.Name == "Left Leg" or p.Name == "Right Leg" or p.Name == "Torso" or p.Name == "Head" then
		p.Transparency = 1
	end
end

--//=================================\\
--|| 	  END OF CUSTOMIZATION
--\\=================================//

local function weldBetween(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end

function createbodypart(TYPE,COLOR,PART,OFFSET,SIZE)
	if TYPE == "Gem" then
		local acs = CreatePart(3, PART, "Plastic", 0, 0, COLOR, "Part", VT(0,0,0))
		acs.Anchored = false
		acs.CanCollide = false
		acs.CFrame = PART.CFrame
		local acs2 = CreateMesh("SpecialMesh", acs, "FileMesh", "9756362", "", SIZE, OFFSET)
		weldBetween(PART,acs)
	elseif TYPE == "Skull" then
		local acs = CreatePart(3, PART, "Plastic", 0, 0, COLOR, "Part", VT(0,0,0))
		acs.Anchored = false
		acs.CanCollide = false
		acs.CFrame = PART.CFrame
		local acs2 = CreateMesh("SpecialMesh", acs, "FileMesh", "4770583", "", SIZE, OFFSET)
		weldBetween(PART,acs)
	elseif TYPE == "Eye" then
		local acs = CreatePart(3, PART, "Neon", 0, 0, COLOR, "Part", VT(0,0,0))
		acs.Anchored = false
		acs.CanCollide = false
		acs.CFrame = PART.CFrame
		local acs2 = CreateMesh("SpecialMesh", acs, "Sphere", "", "", SIZE, OFFSET)
		weldBetween(PART,acs)
	end
end

--//=================================\\
--|| 	      USEFUL VALUES
--\\=================================//

local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local CHANGEDEFENSE = 0
local CHANGEDAMAGE = 0
local CHANGEMOVEMENT = 0
local ANIM = "Idle"
local ATTACK = false
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local WALK = 0
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
--ROBLOXIDLEANIMATION.Parent = Humanoid
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Weapon = IT("Model")
Weapon.Name = "Adds"
local Effects = IT("Folder", Weapon)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
local HITPLAYERSOUNDS = {--[["199149137", "199149186", "199149221", "199149235", "199149269", "199149297"--]]"263032172", "263032182", "263032200", "263032221", "263032252", "263033191"}
local HITARMORSOUNDS = {"199149321", "199149338", "199149367", "199149409", "199149452"}
local HITWEAPONSOUNDS = {"199148971", "199149025", "199149072", "199149109", "199149119"}
local HITBLOCKSOUNDS = {"199148933", "199148947"}
local UNANCHOR = true
local TAUNTS = {"368794227","368794903","368794985"}

local SKILLTEXTCOLOR = C3(0,0,0)

--//=================================\\
--\\=================================//


--//=================================\\
--|| SAZERENOS' ARTIFICIAL HEARTBEAT
--\\=================================//

ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"

script:WaitForChild("ArtificialHB")

frame = Frame_Speed
tf = 0
allowframeloss = false
tossremainder = false
lastframe = tick()
script.ArtificialHB:Fire()

game:GetService("RunService").Heartbeat:connect(function(s, p)
	tf = tf + s
	if tf >= frame then
		if allowframeloss then
			script.ArtificialHB:Fire()
			lastframe = tick()
		else
			for i = 1, math.floor(tf / frame) do
				script.ArtificialHB:Fire()
			end
			lastframe = tick()
		end
		if tossremainder then
			tf = 0
		else
			tf = tf - frame * math.floor(tf / frame)
		end
	end
end)

--//=================================\\
--\\=================================//





--//=================================\\
--|| 	      SOME FUNCTIONS
--\\=================================//

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:wait()
	else
		for i = 1, NUMBER do
			ArtificialHB.Event:wait()
		end
	end
end

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then 
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end

function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end

function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp;
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end

function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end

function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end


function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end

function CreateSound(ID, PARENT, VOLUME, PITCH)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = IT("Sound", PARENT)
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		Swait()
		NEWSOUND:play()
		game:GetService("Debris"):AddItem(NEWSOUND, 10)
	end))
	return NEWSOUND
end

function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end

function MagicSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.9, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (0.1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

function CheckTableForString(Table, String)
	for i, v in pairs(Table) do
		if string.find(string.lower(String), string.lower(v)) then
			return true
		end
	end
	return false
end

function CheckIntangible(Hit)
	local ProjectileNames = {"Water", "Arrow", "Projectile", "Effect", "Rail", "Lightning", "Bullet"}
	if Hit and Hit.Parent then
		if ((not Hit.CanCollide or CheckTableForString(ProjectileNames, Hit.Name)) and not Hit.Parent:FindFirstChild("Humanoid")) then
			return true
		end
	end
	return false
end

Debris = game:GetService("Debris")

function CastZapRay(StartPos, Vec, Length, Ignore, DelayIfHit)
	local Direction = CFrame.new(StartPos, Vec).lookVector
	local Ignore = ((type(Ignore) == "table" and Ignore) or {Ignore})
	local RayHit, RayPos, RayNormal = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(StartPos, Direction * Length), Ignore)
	if RayHit and CheckIntangible(RayHit) then
		if DelayIfHit then
			wait()
		end
		RayHit, RayPos, RayNormal = CastZapRay((RayPos + (Vec * 0.01)), Vec, (Length - ((StartPos - RayPos).magnitude)), Ignore, DelayIfHit)
	end
	return RayHit, RayPos, RayNormal
end

function turnto(position)
	RootPart.CFrame=CFrame.new(RootPart.CFrame.p,VT(position.X,RootPart.Position.Y,position.Z)) * CFrame.new(0, 0, 0)
end

--//=================================\\
--|| 			SPEECH
--\\=================================//

function chatfunc(text,waitt)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("TalkingBillBoard")~= nil then
			Character:FindFirstChild("TalkingBillBoard"):destroy()
		end
		local naeeym2 = Instance.new("BillboardGui",Character)
		naeeym2.Size = UDim2.new(0,100,0,40)
		naeeym2.StudsOffset = Vector3.new(0,5,0)
		naeeym2.Adornee = Character.Head
		naeeym2.Name = "TalkingBillBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = Instance.new("TextLabel",naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = "SciFi"
		tecks2.TextSize = 30
		tecks2.TextStrokeTransparency = 1
		tecks2.TextColor3 = SKILLTEXTCOLOR
		tecks2.TextStrokeColor3 = Color3.new(0,0,0)
		tecks2.Size = UDim2.new(1,0,0.5,0)
		for i = 1,string.len(text),1 do
			tecks2.Text = string.sub(text,1,i)
			Swait()
		end
		wait(waitt)
		coroutine.resume(coroutine.create(function()
			for i = 1, 10 do
				tecks2.TextTransparency = tecks2.TextTransparency + 0.1
				Swait()
			end
			naeeym2:Destroy()
		end))
	end)
	chat()
end

--//=================================\\
--||	     WEAPON CREATION
--\\=================================//

if Player_Size ~= 1 then
	RootPart.Size = RootPart.Size * Player_Size
	Torso.Size = Torso.Size * Player_Size
	Head.Size = Head.Size * Player_Size
	RightArm.Size = RightArm.Size * Player_Size
	LeftArm.Size = LeftArm.Size * Player_Size
	RightLeg.Size = RightLeg.Size * Player_Size
	LeftLeg.Size = LeftLeg.Size * Player_Size
	RootJoint.Parent = RootPart
	Neck.Parent = Torso
	RightShoulder.Parent = Torso
	LeftShoulder.Parent = Torso
	RightHip.Parent = Torso
	LeftHip.Parent = Torso
	
	RootJoint.C0 = ROOTC0 * CF(0 * Player_Size, 0 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(0), RAD(0))
	RootJoint.C1 = ROOTC0 * CF(0 * Player_Size, 0 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(0), RAD(0))
	Neck.C0 = NECKC0 * CF(0 * Player_Size, 0 * Player_Size, 0 + ((1 * Player_Size) - 1)) * ANGLES(RAD(0), RAD(0), RAD(0))
	Neck.C1 = CF(0 * Player_Size, -0.5 * Player_Size, 0 * Player_Size) * ANGLES(RAD(-90), RAD(0), RAD(180))
	RightShoulder.C0 = CF(1.5 * Player_Size, 0.5 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(0), RAD(0)) * RIGHTSHOULDERC0
	LeftShoulder.C0 = CF(-1.5 * Player_Size, 0.5 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(0), RAD(0)) * LEFTSHOULDERC0
	--if Disable_Moving_Arms == false then
	RightShoulder.C1 = ANGLES(0, RAD(90), 0) * CF(0 * Player_Size, 0.5 * Player_Size, -0.5)
	LeftShoulder.C1 = ANGLES(0, RAD(-90), 0) * CF(0 * Player_Size, 0.5 * Player_Size, -0.5)
	--else
	--RightShoulder.C1 = CF(0 * Player_Size, 0.5 * Player_Size, 0 * Player_Size)
	--LeftShoulder.C1 = CF(0 * Player_Size, 0.5 * Player_Size, 0 * Player_Size)
	--end
	RightHip.C0 = CF(1 * Player_Size, -1 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
	LeftHip.C0 = CF(-1 * Player_Size, -1 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
	RightHip.C1 = CF(0.5 * Player_Size, 1 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
	LeftHip.C1 = CF(-0.5 * Player_Size, 1 * Player_Size, 0 * Player_Size) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
end

for _, c in pairs(Weapon:GetChildren()) do
	if c.ClassName == "Part" then
		c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	end
end

Weapon.Parent = Character

Humanoid.Died:connect(function()
	ATTACK = true
end)

--//=================================\\
--||	     DAMAGE FUNCTIONS
--\\=================================//

--//=================================\\
--||			DAMAGING
--\\=================================//

function dealdamage(hit,min,max,maxstrength,beserk,critrate,critmultiplier)
	print("no")
end



function Stun(HUMANOID,LAST)
	if HUMANOID.Parent:FindFirstChild("StunnedBy"..Player.Name) == nil then
		HUMANOID.PlatformStand = true
		local defence = Instance.new("BoolValue",HUMANOID.Parent)
		defence.Name = ("StunnedBy"..Player.Name)
		game:GetService("Debris"):AddItem(defence, LAST)
		if HUMANOID.Parent:FindFirstChild("Head") then
			StatLabel("Normal", HUMANOID.Parent.Head.CFrame * CF(0, 0 + (HUMANOID.Parent.Head.Size.z - 1), 0), "Stunned!", C3(0.3, 0.3, 0.3))
		end
		coroutine.resume(coroutine.create(function()
			Swait(LAST*50)
			HUMANOID.PlatformStand = false
		end))
	end
end

--//=================================\\
--||	ATTACK FUNCTIONS AND STUFF
--\\=================================//

function AttackTemplate()
	ATTACK = true
	Rooted = false
	for i=0, 1, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5*2, 0.5*2, 0) * ANGLES(RAD(15), RAD(0), RAD(12)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end

function Strike()
	ATTACK = true
	Rooted = false
	CreateSound(TAUNTS[MRANDOM(1,#TAUNTS)], Head, 3, 2)
	for i=0, 0.5, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)*2) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.5 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5*2, 0.5*2, 0) * ANGLES(RAD(160), RAD(45), RAD(12)) * RIGHTSHOULDERC0, 0.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(160), RAD(-45), RAD(-12)) * LEFTSHOULDERC0, 0.5 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12*2), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12*2), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.5 / Animation_Speed)
	end
	local HIT1 = CLAW1.Touched:Connect(function(hit)
		dealdamage(hit,25,65,6,false,5,2)
	end)
	local HIT2 = CLAW2.Touched:Connect(function(hit)
		dealdamage(hit,25,65,6,false,5,2)
	end)
	for i=0, 0.5, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.1, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(25), RAD(0), RAD(0)), 0.75 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.75 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.15*2, 0.5*2, -1) * ANGLES(RAD(55), RAD(75), RAD(-22)) * RIGHTSHOULDERC0, 0.75 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15*2, 0.5*2, -1) * ANGLES(RAD(55), RAD(-75), RAD(22)) * LEFTSHOULDERC0, 0.75 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12*2), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-5)), 0.75 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12*2), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-25)), 0.75 / Animation_Speed)
	end
	HIT1:disconnect()
	HIT2:disconnect()
	ATTACK = false
	Rooted = false
end

function Shriek()
	ATTACK = true
	Rooted = false
	for i=0, 2.5, 0.1 / Animation_Speed do
		Swait()
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)*2) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5*2, 0.5*2, 0) * ANGLES(RAD(160), RAD(45), RAD(12)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(160), RAD(-45), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12)*2, -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12)*2, -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
	end
	Rooted = true
	CreateSound(TAUNTS[MRANDOM(1,#TAUNTS)], Effects, 10, 1)
	for i=0, 4, 0.1 / Animation_Speed do
		Swait()
		AoEStun(Head.Position,40,12)
		MagicSphere(VT(0,0,0),5,Head.CFrame,"Pearl",VT(15,15,15))
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, -0.4*2, -0.65*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(55), RAD(0), RAD(0)), 0.7 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(-35+MRANDOM(-5,5)), RAD(MRANDOM(-5,5)), RAD(MRANDOM(-5,1))), 1)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5*2, 0.5*2, 0) * ANGLES(RAD(-15), RAD(45), RAD(12)) * RIGHTSHOULDERC0, 0.75 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(-15), RAD(-45), RAD(-12)) * LEFTSHOULDERC0, 0.75 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12)*2, -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(15)), 0.75 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12)*2, -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-55)), 0.75 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end

local asd = Instance.new("ParticleEmitter")
asd.Color = ColorSequence.new(Color3.new(1, 0, 0), Color3.new(.5, 0, 0))
asd.LightEmission = .1
asd.Size = NumberSequence.new(0.2)
asd.Texture = "http://www.roblox.com/asset/?ID=291880914"
aaa = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2),NumberSequenceKeypoint.new(1, 5)})
bbb = NumberSequence.new({NumberSequenceKeypoint.new(0, 1),NumberSequenceKeypoint.new(0.0636, 0), NumberSequenceKeypoint.new(1, 1)})
asd.Transparency = bbb
asd.Size = aaa
asd.ZOffset = .9
asd.Acceleration = Vector3.new(0, -15, 0)
asd.LockedToPart = false
asd.EmissionDirection = "Back"
asd.Lifetime = NumberRange.new(1, 2)
asd.Rotation = NumberRange.new(-100, 100)
asd.RotSpeed = NumberRange.new(-100, 100)
asd.Speed = NumberRange.new(2,6)
asd.Enabled = false
asd.VelocitySpread = 5

function getbloody(victim,amount)
	local PART = IT("Part",Effects)
	PART.Transparency = 1
	PART.Size = victim.Size
	PART.Anchored = true
	PART.CanCollide = false
	PART.CFrame = CF(victim.Position,victim.CFrame*CF(0,1,0).p)
	local HITPLAYERSOUNDS = {"356551938","264486467"}
	Debris:AddItem(PART,5)
	local prtcl = asd:Clone()
	prtcl.Parent = PART
	prtcl:Emit(amount*10)
end

function Devour()
	ATTACK = true
	Rooted = false
	local TORS = nil
	local WELD = nil
	local HIT1 = CLAW1.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChildOfClass("Humanoid") then
			TORS = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")
			if TORS ~= nil then
				UNANCHOR = false
				Rooted = true
				RootPart.Anchored = true
				WELD = CreateWeldOrSnapOrMotor("Weld", TORS, RightArm, TORS, CF(0,-2.5,-0.5) * ANGLES(RAD(-90), RAD(90), RAD(0)), CF(0, 0, 0))
			end
		end
	end)
	for i=1, 45 do
		Swait()
		if TORS ~= nil then
			break
		end
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
	end
	HIT1:disconnect()
	if TORS ~= nil then
		for i=0, 2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(-15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		end
		for i=0, 0.3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 1.5 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, -1, -1.5) * ANGLES(RAD(170), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1.5 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15*2, -1, -1.2) * ANGLES(RAD(160), RAD(0), RAD(30)) * LEFTSHOULDERC0, 1.15 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 1.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 1.15 / Animation_Speed)
		end
		local HITPLAYERSOUNDS2 = {"356551938","264486467"}
		if TORS ~= nil then
			if TORS.Parent:FindFirstChild("Head") then
				CreateSound(HITPLAYERSOUNDS2[MRANDOM(1, #HITPLAYERSOUNDS2)], Head, 1, (math.random(8,12)/10))
				CreateSound("230346233", Head, 10, (math.random(5,7)/10))
				getbloody(TORS,4)
				TORS.Parent.Head:remove()
				TORS.Parent:remove()
				for i=0, 1, 0.1 / Animation_Speed do
					Swait()
					RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 1.5 / Animation_Speed)
					Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 1.15 / Animation_Speed)
					RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, -1, -1.2) * ANGLES(RAD(170), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1.5 / Animation_Speed)
					LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.15*2, -1, -1.2) * ANGLES(RAD(160), RAD(0), RAD(30)) * LEFTSHOULDERC0, 1.15 / Animation_Speed)
					RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 1.15 / Animation_Speed)
					LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 1.15 / Animation_Speed)
				end
			end
		end
		UNANCHOR = true
	end
	ATTACK = false
	Rooted = false
end

function Snap()
	ATTACK = true
	Rooted = false
	local TORS = nil
	local WELD = nil
	local HIT1 = CLAW1.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChildOfClass("Humanoid") and hit.Parent.Parent ~= Effects then
			TORS = hit.Parent:FindFirstChild("Torso") or hit.Parent:FindFirstChild("UpperTorso")
			if TORS ~= nil then
				UNANCHOR = false
				Rooted = true
				RootPart.Anchored = true
				WELD = CreateWeldOrSnapOrMotor("Weld", TORS, RightArm, TORS, CF(0,-2.5,-0.5) * ANGLES(RAD(-90), RAD(90), RAD(0)), CF(0, 0, 0))
			end
		end
	end)
	for i=1, 45 do
		Swait()
		if TORS ~= nil then
			break
		end
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 1.5 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
	end
	HIT1:disconnect()
	if TORS ~= nil then
		local CLONE = IT("Model",Weapon)
		CLONE.Name = "Corpse"
		for i=0, 2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(5 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(0), RAD(-35)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5*2, 0.5*2, 0) * ANGLES(RAD(15), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		end
		for i=0, 2, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(10 - 2.5 * SIN(SINE / 12)), RAD(15), RAD(0)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(25), RAD(-35)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35*2, 0.5*2, -0.5) * ANGLES(RAD(80), RAD(0), RAD(25)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		end
		for i=0, 3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(10 - 2.5 * SIN(SINE / 12)), RAD(15), RAD(0)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(25), RAD(-35)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35*2, 0.5*2, -0.6) * ANGLES(RAD(70), RAD(0), RAD(20)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		end
		local HITPLAYERSOUNDS = {"356551938","264486467"}
		local DummyHead = nil
		local q = TORS.Parent:GetChildren()
		for i = 1,#q do
			if q[i].ClassName ~= "LocalScript" and q[i].ClassName ~= "Script" and q[i].ClassName ~= "Accessory" and q[i].ClassName ~= "Hat" and q[i].ClassName ~= "Gear" then
				q[i].Parent = CLONE
				if q[i].ClassName == "Humanoid" then
					q[i].PlatformStand = true
				end
				if q[i].Name == "Head" then
					DummyHead = CLONE.Head:Clone()
					q[i]:ClearAllChildren()
					q[i].Transparency = 1
				end
			else
				q[i]:remove()
			end
		end
		local TORS2 = CLONE:FindFirstChild("Torso") or CLONE:FindFirstChild("UpperTorso")
		DummyHead.Parent = Effects
		local WELD1 = CreateWeldOrSnapOrMotor("Weld", DummyHead, LeftArm, DummyHead, CF(0,-2.5,0) * ANGLES(RAD(-90), RAD(90), RAD(0)), CF(0, 0, 0))
		local WELD2 = CreateWeldOrSnapOrMotor("Weld", TORS2, RightArm, TORS2, CF(0,-2.5,-0.5) * ANGLES(RAD(-90), RAD(90), RAD(0)), CF(0, 0, 0))
		local HITPLAYERSOUNDS2 = {"356551938","264486467"}
		CreateSound(HITPLAYERSOUNDS2[MRANDOM(1, #HITPLAYERSOUNDS2)], TORS2, 1, (math.random(8,12)/10))
		getbloody(DummyHead,5)
		for i=0, 3, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(20 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-15)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(25), RAD(-25)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35*2, 0.5*2, -0.6) * ANGLES(RAD(120), RAD(0), RAD(20)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		end
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(20 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(25), RAD(-25)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35*2, 0.5*2, -0.6) * ANGLES(RAD(35), RAD(0), RAD(-75)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		end
		WELD1:remove()
		for i=0, 0.5, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(20 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(55), RAD(25), RAD(-25)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35*2, 0.5*2, -0.6) * ANGLES(RAD(35), RAD(0), RAD(-75)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		end
		local GROWLS = {"368795088","368795352","368795492","368795580"}
		CreateSound(GROWLS[MRANDOM(1, #GROWLS)], Head, 4, (math.random(15,20)/10))
		repeat
			Swait()
			turnto(Mouse.Hit.p)
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 0.15 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(-10 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, -1.5) * ANGLES(RAD(170), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 0.15 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35*2, 0.5*2, -0.6) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 0.15 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 0.15 / Animation_Speed)
		until HOLD == true
		WELD2:remove()
		local bv = Instance.new("BodyVelocity") 
		bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
		bv.velocity = CF(TORS2.Position,Mouse.Hit.p).lookVector*300
		bv.Parent = TORS2
		bv.Name = "MOVE"
		coroutine.resume(coroutine.create(function()
			local HIT1 = TORS2.Touched:Connect(function(hit)
				dealdamage(hit,25,65,3,false,5,2)
			end)
			Swait(2)
			HIT1:disconnect()
		end))
		Debris:AddItem(bv,0.2)
		TORS2.Velocity = CF(TORS2.Position,Mouse.Hit.p).lookVector*300
		for i=0, 1, 0.1 / Animation_Speed do
			Swait()
			RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0 * CF(0, 0, -0.5*2 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(15), RAD(0), RAD(15)), 1)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1*2) - 1)) * ANGLES(RAD(-10 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(-25)), 1)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1*2, 0.35*2, 0) * ANGLES(RAD(25), RAD(0), RAD(0)) * RIGHTSHOULDERC0, 1)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.35*2, 0.5*2, -0.6) * ANGLES(RAD(0), RAD(0), RAD(-15)) * LEFTSHOULDERC0, 1)
			RightHip.C0 = Clerp(RightHip.C0, CF(1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(-15), RAD(-15)), 1)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1.1*2, -0.5*2 - 0.05 * COS(SINE / 12), -0.4*2) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(15), RAD(-15)), 1)
		end
	end
	UNANCHOR = true
	ATTACK = false
	Rooted = false
end
--//=================================\\
--\\=================================//


function unanchor()
	if UNANCHOR == true then
		g = Character:GetChildren()
		for i = 1, #g do
			if g[i].ClassName == "Part" then
				g[i].Anchored = false
			end
		end
	end
end


--//=================================\\
--||	WRAP THE WHOLE SCRIPT UP
--\\=================================//

Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and (Disable_Jump == true) then
		Humanoid.Jump = false
	end
end)

Speed = 20


--//=================================\\
--\\=================================//
Character:WaitForChild(Head).Handle.AccessoryWeld:Remove()
local alignpos = Instance.new("AlignPosition", Character)
local alignorien = Instance.new("AlignOrientation", Character)
local att1 = Instance.new("Attachment", Character:WaitForChild(Head).Handle)
local att2 = Instance.new("Attachment", Character:WaitForChild("Head"))
alignpos.Attachment0 = att1
alignpos.Attachment1 = att2
alignpos.RigidityEnabled = false
alignpos.ReactionForceEnabled = false
alignpos.ApplyAtCenterOfMass = true
alignpos.MaxForce = 99999999
alignpos.MaxVelocity = math.huge
alignpos.Responsiveness = 65
alignorien.Attachment0 = att1
alignorien.Attachment1 = att2
alignorien.ReactionTorqueEnabled = true
alignorien.PrimaryAxisOnly = false
alignorien.MaxTorque = 99999999
alignorien.MaxAngularVelocity = math.huge
alignorien.Responsiveness = 50
att2.Position = Vector3.new(x,y,z)
--//====================================================\\--
--||			  		 END OF SCRIPT
--\\====================================================//--
end