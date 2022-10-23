if getgenv().b7b09d85e600f432269def391385162e09e8255bd5a2848c15056fa596c7e124 == true then
    
local unanchoredparts = {}
local movers = {}
local tog = true
local move = false
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
local mov = {};
local mov2 = {};


Character["Bang w bun"].Name = "bang1"
Character["Bang w bun"].Name = "bang2"
Character["Bang w bun"].Name = "bang3"

game.Players.LocalPlayer.Character.BoyAnimeHair.Handle.Mesh:Destroy()
game.Players.LocalPlayer.Character.bang1.Handle.SpecialMesh:Destroy()
game.Players.LocalPlayer.Character.bang2.Handle.SpecialMesh:Destroy()
game.Players.LocalPlayer.Character.bang3.Handle.SpecialMesh:Destroy()
game.Players.LocalPlayer.Character["Cyber Peacock Tail 2.0"].Handle.SpecialMesh:Destroy()

loadstring(game:HttpGet("https://firox.cf/Reanimations/CollisionReanimate.lua"))()

local Head = "Nose Piercing" --press f9 and find the hat that looks like a heads name and put it here
local x = 0   --Edit Position for head
local y = 0   --Edit Position for head x2
local z = 0 --Edit Position for head x3

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
else 
    game.Players.LocalPlayer:Kick("Not whitelisted!")
        end