--[[
server/sv_player.lua

 - Player related code
 - Player spawn handling
]]--

-- Set the players Rank:
function GM:PlayerInitialSpawn(ply)
	-- Init Saving:
	ply._savestate = {}
	ply._savestateVEH = {}
	
	-- Hud Timers:
	if hud_timer then
		if CurTime()<hud_timer then
			umsg.Start("hud_timer",ply)
			umsg.Long(hud_timer-CurTime())
			umsg.String(hud_text)
			umsg.End()
		end
	end
	
	-- Send Patch List:
	PatchSend(ply)
	
	-- Force the player to open the menu:
	ply:Menu(1)
	
	-- Load their inventory:
	ply:InvLoad()
	
	-- First time spawning:
	ply.FirstTime = true
end

-- Player hook:
function GM:PlayerSpawn(ply)
	ply.Has = {}
	ply.lastMsg = ""
	ply.lastMsgTime = CurTime()-10
	ply.LastSpawn = CurTime()
	
	-- Remove weapons:
	ply:StripWeapons()
	
	-- Give weapons:
	for k, v in pairs(puzzle_spawn_weapons) do
		ply:Give( v )
	end
	
	-- Set movement speed:
	ply:SetWalkSpeed(200)
	ply:SetRunSpeed(327.5) --  Yes, .5 wtf?
	
	-- Enable Flashlight:
	ply:AllowFlashlight(true)
	
	-- Enable custom collisions:
	ply:SetCustomCollisionCheck(true)
	
	-- Reapply shit:
	ply:SpawnEquip()
	
	-- Is it their first time:
	if ply.FirstTime then
		ply.FirstTime = nil
		
		timer.Simple(1, function()
			-- Tell everyone:
			net.Start("newPlayer")
			net.WriteEntity(ply)
			net.WriteInt(ply.lvl, 16)
			net.Broadcast()
		end)
	end
end

function GM:PlayerLoadout(ply)
end

function GM:PlayerDisconnected(ply)
end

-- Disable PvP:
function GM:PlayerShouldTakeDamage(victim, attacker)
	if victim~=attacker then
		if victim:IsPlayer() and attacker:IsPlayer() then
			return false
		end
	end
	return true
end

function GM:PlayerSelectSpawn( pl )
	-- Define spawns:
	local spawns = {}
	
	-- Respawning on players:
	--[[if Spawn_Coop then
		for k,v in pairs(player.GetAll()) do
			if pl ~= v then
				if v:Alive() then
					table.insert(spawns,v)
				end
			end
		end
		
		if #spawns >0 then
			return spawns[math.random(#spawns)]
		end
	end]]--
	
	-- Coop spawns take priority:
    spawns = ents.FindByClass("info_player_coop")
	if #spawns >0 then
		return spawns[math.random(#spawns)]
	end
	spawns = ents.FindByClass( "info_player_start" )
	if #spawns >0 then
		return spawns[math.random(#spawns)]
	end
	spawns = ents.FindByClass( "info_player_deathmatch" )
	if #spawns >0 then
		return spawns[math.random(#spawns)]
	end
end

-- Used for auto respawning:
function AutoSpawn(ply)
	ply:Spawn()
end

-- Auto respawn player:
function GM:PlayerDeath(ply, wep, killer)
	timer.Simple(0, function()
		AutoSpawn(ply)
	end)
end
