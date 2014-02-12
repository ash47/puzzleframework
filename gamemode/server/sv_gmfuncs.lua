--[[
server/sv_gmfuncs.lua

 - Gamemode Functions that don't fit anywhere else
]]--

function GM:Initialize()
	-- Coop spawn patch:
	scripted_ents.Register({
		Type = "anim",
		KeyValue = function(self, name, value)
			if name:lower() == "startdisabled" then
				if value == "1" or value == true then
					local new = ents.Create("info_player_coop_disabled")
					new:SetPos(self:GetPos())
					new:SetAngles(self:GetAngles())
					new:Spawn()
					new:SetName(self:GetName())
					self:Remove()
				end
			end
		end,
		AcceptInput = function(self, name, activator, caller, data)
			if name:lower() == "disable" then
				local new = ents.Create("info_player_coop_disabled")
				new:SetPos(self:GetPos())
				new:SetAngles(self:GetAngles())
				new:Spawn()
				new:SetName(self:GetName())
				self:Remove()
				return true
			end
			
			return false
		end
	}, "info_player_coop")
	
	-- Equipment fixer:
	scripted_ents.Register({
		Type = "anim",
		Initialize = function()
			self.Items = self.Items or {}
		end,
		KeyValue = function(self, name, value)
			if name:lower() == "targetname" then
				self:SetName(value)
			elseif name:lower() == "spawnflags" then
				-- Error checking:
				if tostring(value) ~= "1" then
					print("game_player_equip - SPAWN FLAG is set to an UNKNOWN STATE: "..tostring(value))
					self:Remove()
					return
				end
			elseif name:lower() == "origin" or name:lower() == "classname" then
				-- Nothing
			else
				-- Make sure it is a valid ent:
				local ent = ents.Create(name)
				if ent:IsValid() then
					-- Cleanup:
					ent:Remove()
					
					-- Store it:
					self.Items = self.Items or {}
					table.insert(self.Items, name)
				end
			end
		end,
		AcceptInput = function(self, name, activator, caller, data)
			if name:lower() == "use" or name:lower() == "equipactivator" then
				if not activator:IsValid() then return end
				if not self.Items then return end
				
				for k,v in pairs(self.Items) do
					activator:Give(v)
				end
				
				return true
			end
			
			return false
		end
	}, "game_player_equip")
end

function GM:InitPostEntity()
	-- local filter = {}
	local _, entt, wep
	
	-- Reset spawn weapons:
	puzzle_spawn_weapons = {}
	table.insert(puzzle_spawn_weapons,"weapon_physcannon")
	
	-- For timers:
	hud_timer = 0
	hud_text = ""
	
	-- Do patches:
	Patches()
	
	-- We have loaded the game:
	GameLoaded = true
end

-- Disable Fall Damage:
function GM:GetFallDamage(ply, vel)
	return 0
end

-- F1->F4
function GM:ShowHelp(ply)
	ply:Menu(1)
end

function GM:ShowTeam(ply)
	ply:Menu(2)
end

function GM:ShowSpare1(ply)
	ply:Menu(3)
end

function GM:ShowSpare2(ply)
	ply:Menu(4)
end
