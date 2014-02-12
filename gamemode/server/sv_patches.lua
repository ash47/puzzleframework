//Setup our patch table:
puzzle_patches = puzzle_patches or {}

function NewTracker(n)
	local e=ents.Create("puzzle_score")
	e:SetName(n)
	e:Spawn()
end

function new_patch(name, callback)
	table.insert(puzzle_patches,{name=name, callback=callback})
end

local fMapName = string.lower(game.GetMap())
local SearchPath = PUZZLE_ADDON_NAME.."/gamemode/server/patches/"..fMapName..".lua"

-- Include the patch:
if file.Exists(SearchPath,"LUA") then
	include("patches/"..fMapName..".lua")
end

-- Run the patches:
function Patches()
	-- Ensure the patch file exists:
	if file.Exists(SearchPath,"LUA") then
		print("\nApplying map patch...")
		map_patch()
	else
		print("\nNo setting file found: "..SearchPath.."\n")
	end

	-- Patch things:
	for k, v in pairs(ents.GetAll()) do
		-- Patch the finishes:
		if v:GetClass() == "game_end" then
			local finish = ents.Create("patched_finish")
			finish:Spawn()
			finish:SetName(v:GetName())
			v:Remove()
		end
		if v:GetClass() == "point_servercommand" then
			local finish = ents.Create("patched_finish")
			finish:Spawn()
			finish:SetName(v:GetName())
			v:Remove()
		end

		-- Airboat patch:
		if(v:GetClass() == "prop_vehicle_airboat") then
			-- Build new ones:
			local new = ents.Create(v:GetClass())
			new:SetName(v:GetName())
			new:SetModel(v:GetModel())
			new:SetPos(v:GetPos())
			new:SetAngles(v:GetAngles())
			for kk, vv in pairs(v:GetKeyValues()) do
				new:SetKeyValue(kk, vv)
			end
			new:SetKeyValue("VehicleScript", "scripts/vehicles/puzzle_airboat.txt")
			new:Spawn()
			new:Activate()

			-- Remove the old one:
			v:Remove()
		end

		--[[if v:GetClass() == "trigger_gravity" then
			local n = ents.Create("gravity_controller")
			n:SetName(v:GetName())
			local k = v:GetKeyValues()
			n:SetKeyValue("gravity",k["gravity"])
			n:SetKeyValue("end","0")
			n:SetModel(v:GetModel())
			n:SetPos(v:GetPos())
			n:SetAngles(v:GetAngles())
			n:Spawn()
			v:Remove()
		end]]--
	end

	--[[for k,v in pairs(ents.FindByClass("info_player_coop")) do
		local n = ents.Create("info_player_coop_puzzle")
		n:SetName(v:GetName())
		n:SetPos(v:GetPos())
		n:SetAngles(v:GetAngles())
		for kk, vv in pairs(v:GetKeyValues()) do
			n:SetKeyValue(kk, vv)
		end
		n:Spawn()

		-- Remove old one:
		v:Remove()

		print("remove")
	end]]--
end

--[[hook.Add("OnEntityCreated", "TempCoopSpawnHook", function(ent)
	if ent:GetClass() == "info_player_coop" then
		print("Found one!")

		ent.KeyValue = function(name, activator, caller, data)
			print(name)
		end

		function ent:KeyValue(name)
			print("test!")
		end

		function ent:AcceptInput()
			print("ARSE!")
		end
	end
end)]]--

function PatchSend(ply)
	-- Only bother if there are patches:
	if #puzzle_patches > 0 then
		net.Start("patches")

		-- Write each patch:
		for k,v in pairs(puzzle_patches) do
			net.WriteString(v.name)
		end

		-- Send:
		net.Send(ply)
	end
end

net.Receive("patches", function(len, ply)
	-- Read p:
	local p = net.ReadInt(16)
	local str = net.ReadString()

	-- Simple validation:
	if p <= 0 or (not puzzle_patches[p]) then
		ply:Notify(1, 5, "You selected an invalid patch... O_o")
		return
	end

	-- Spam protection:
	if ply.Patches then
		if ply.Patches == -1 then
			ply:Notify(1, 5, "Please wait for your last vote to finish.")
			return
		elseif ply.Patches>CurTime() then
			ply.Patches = ply.Patches + 10
			ply:Notify(1, 5, "Please wait another "..math.ceil(ply.Patches-CurTime()).." before asking again.")
			return
		end
	end

	-- Create the vote:
	VoteCreate({
	question = ply:Nick().." wants to activate '"..puzzle_patches[p].name.."', because '"..str.."'\n\nDo you want to active it?",
	default = false,
	callback = function(results)
		if results.passed then
			NotifyAll(0, 5, "Applying patch...")

			-- Apply the patch:
			puzzle_patches[p].callback()

			-- Allow them to vote again:
			if ply:IsValid() then
				ply.Patches = nil
			end
		else
			NotifyAll(1, 5, "The patch vote failed.")

			-- Spam protection:
			if ply:IsValid() then
				ply.Patches = CurTime()+60
			end
		end
	end
	})

	-- Stop more votes:
	ply.Patches = -1
end)
