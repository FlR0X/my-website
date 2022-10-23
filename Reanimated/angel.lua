loadstring(game:HttpGet("https://firox.cf/Reanimations/NormalReanimate.lua"))()

		local unanchoredparts = {}
		local Count = 1
		local movers = {}
		local tog = true
		local move = false
		local Player = game:GetService("Players").LocalPlayer
		local Character = Player.Character
		local mov = {};
		local mov2 = {};

		local Hats = {pp  = Character:WaitForChild("Northern Star"),
		    		}
		local Hats2 = {pp2  = Character:WaitForChild("Cloud"),


		}

		--Dont touch below

		for i,v in next, Hats do
			v.Handle.AccessoryWeld:Remove()
			for _,mesh in next, v:GetDescendants() do
				if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
print("mesh")
				end
			end
		end
		
				for i,v in next, Hats2 do
			v.Handle.AccessoryWeld:Remove()
			for _,mesh in next, v:GetDescendants() do
				if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
print("mesh")
				end
			end
		end

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
			AP.ApplyAtCenterOfMass = false
			AP.MaxForce = 9999999
			AP.MaxVelocity = math.huge
			AP.Responsiveness = 65
			local AO = Instance.new("AlignOrientation", i)
			AO.Attachment0 = att0
			AO.Attachment1 = att1
			AO.ReactionTorqueEnabled = false
			AO.PrimaryAxisOnly = false
			AO.MaxTorque = 9999999
			AO.MaxAngularVelocity = math.huge
			AO.Responsiveness = 50
		end

		local function align2(i,v)
			local att0 = Instance.new("Attachment", i)
			att0.Position = Vector3.new(0,0,0)
			local att1 = Instance.new("Attachment", v)
			att1.Position = Vector3.new(0,0,0)
			local AP = Instance.new("AlignPosition", i)
			AP.Attachment0 = att0
			AP.Attachment1 = att1
			AP.RigidityEnabled = false
			AP.ReactionForceEnabled = false
			AP.ApplyAtCenterOfMass = false
			AP.MaxForce = 9999999
			AP.MaxVelocity = math.huge
			AP.Responsiveness = 65
			local AO = Instance.new("AlignOrientation", i)
			AO.Attachment0 = att0
			AO.Attachment1 = att1
			AO.ReactionTorqueEnabled = false
			AO.PrimaryAxisOnly = false
			AO.MaxTorque = 9999999
			AO.MaxAngularVelocity = math.huge
			AO.Responsiveness = 50
		end



		--Dont touch above

		align(Hats.pp.Handle, Character["Head"])
				align2(Hats2.pp2.Handle, Character["Head"])


		Hats.pp.Handle.Attachment.Rotation = Vector3.new(90, 0, 0)
		Hats2.pp2.Handle.Attachment.Rotation = Vector3.new(0, 0, 0)


		--Attachmment1 is the 1st hat u put in Hats at the top. it goes in order

		Character:WaitForChild("Head"):FindFirstChild("Attachment").Name = "Attachment1"
		Character:WaitForChild("Head").Attachment1.Position = Vector3.new(0, 2, 0)
				Character:WaitForChild("Head"):FindFirstChild("Attachment").Name = "Attachment2"
		Character:WaitForChild("Head").Attachment2.Position = Vector3.new(0, -5, 0)
				while true do wait(0)
 Character:WaitForChild("Head").Attachment1.Rotation = Vector3.new (0, 0 ..Count , 0)
 Character:WaitForChild("Head").Attachment2.Rotation = Vector3.new(0, 0 ..Count, 0)
     Count = Count + 1
end
