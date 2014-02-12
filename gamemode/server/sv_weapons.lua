-- Over right the give function:
local meta = FindMetaTable("Player")
meta.OldGive = meta.OldGive or meta.Give
function meta:Give(wep)
	-- Stop spam pickup:
	self.Has[wep] = true
	
	timer.Simple(1, function()
		if IsValid(self) then
			self.Has[wep] = nil
		end
	end)
	
	local ent = self:OldGive(wep)
	ent.Given = self
	
	-- Ensure no respawn:
	ent.NoRespawn = true
	if ent:IsValid() and (not ent:IsWeapon()) then
		-- Worth the effort to remove:
		timer.Simple(0.1, function()
			if ent:IsValid() then
				ent:Remove()
			end
		end)
	end
end

-- When an ent is created:
function GM:OnEntityCreated(ent)
	timer.Simple(0,function()
		if ent:IsValid() then
			ent.SpawnPos = ent.SpawnPos or ent:GetPos()
			ent.SpawnAng = ent.SpawnAng or ent:GetAngles()
			ent.SpawnTime = CurTime()
		end
	end)
end

-- Repspawn the item:
local function Item_Respawn(wep, pos, ang, move)
	local ent = ents.Create(wep)
	ent.Respawned = true
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:Spawn()
	ent.SpawnPos = pos
	ent.SpawnAng = ang
end

-- Can a player pickup a given item:
function GM:PlayerCanPickupItem(ply, wep)
	-- Allow the player to pickup given ents:
	if wep.Given and wep.Given == ply then return true end
	
	-- Respawn Controller:
	if not wep.Taken then
		--  Auto respawn after 5 seconds:
		if not wep.NoRespawn and (wep.Respawned or CurTime()>(wep.SpawnTime or 0)+0.3) then
			local sp = wep.SpawnPos or wep:GetPos()
			local sa = wep.SpawnAng or wep:GetAngles()
			local cl = wep:GetClass()
			
			timer.Simple(5,function()
				-- Do not respawn if old exists:
				if not wep:IsValid() then
					-- Respawn new one:
					Item_Respawn(cl, sp, sa)
				end
			end)
			wep.Taken = true
		end
	end
	
	-- Allow the player to take the item:
	return true
end

-- Can a player pickup a given weapon:
function GM:PlayerCanPickupWeapon(ply, wep)
	-- Allow the player to pickup given ents:
	if wep.Given then
		if wep.Given == ply then
			return true
		end
	elseif (not wep.Respawned) and ((not wep.SpawnTime) or CurTime()<=(wep.SpawnTime or 0)+0.3) then
		return true
	end
	
	-- Grab the class of the weapon:
	local class = wep:GetClass()
	
	-- Ensure the player doesn't have the weapon:
	if(ply.Has[class] or ply:HasWeapon(class)) then
		-- Create ammo thingo:
		wep.NextAmmo = wep.NextAmmo or {}
		
		-- Give them ammo:
		if wep.NextAmmo[ply] and wep.NextAmmo[ply] > CurTime() then
			return false
		end
		
		-- Put a cap on it:
		wep.NextAmmo[ply] = CurTime()+30
		
		local ammotype = wep:GetPrimaryAmmoType()
		
		-- If it takes ammo:
		if ammotype ~= -1 then
			-- Grab the clip:
			local clip = wep:Clip1()
			if clip <= 0 then
				clip = 1
			end
			
			-- Give ammo:
			ply:GiveAmmo(clip, wep:GetPrimaryAmmoType())
		end
		
		return false
	else
		-- Give the weapon to the player:
		ply:Give(class)
	end
	
	-- Repspawn the weapon:
	if not wep.NoRespawn then
		local sp = wep.SpawnPos or wep:GetPos()
		local sa = wep.SpawnAng or wep:GetAngles()
		timer.Simple(5,function()
			Item_Respawn(class, sp, sa)
		end)
	end
	
	-- Remove the weapon:
	wep:Remove()
	
	-- Stop the player from taking it::
	return false
end

-- Stops NPCs weapons from respawning:
function GM:OnNPCKilled(victim,killer,weapon)
	local wep = victim:GetActiveWeapon()
	if wep:IsValid() then
		wep.NoRespawn = true
	end
end
